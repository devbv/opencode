import z from "zod"
import crypto from "crypto"
import { readFile } from "fs/promises"
import { Tool } from "./tool"
import { Config } from "../config/config"
import DESCRIPTION from "./overdaresearch.txt"

const PROJECT_ID = "1064250348922"
const LOCATION = "us-east4"
const RAG_CORPUS = "projects/migaloo-web3-369008/locations/us-east4/ragCorpora/4206925001917464576"
const TOP_K = 20
const THRESHOLD = 0.5
const RANKER_MODEL = "semantic-ranker-default@latest"
const TIMEOUT = 30_000
const TOKEN_URL = "https://oauth2.googleapis.com/token"
const SCOPE = "https://www.googleapis.com/auth/cloud-platform"

interface ServiceAccount {
  client_email: string
  private_key: string
}

interface RagContext {
  text: string
}

interface RetrieveResponse {
  contexts?: {
    contexts?: Array<{ text?: string }>
  }
}

// JWT → OAuth2 access token (no external deps)
let cachedToken: { token: string; expiresAt: number } | null = null

async function loadServiceAccount(saPath?: string): Promise<ServiceAccount> {
  // 1) env: VERTEX_SA_JSON (서비스 계정 JSON 문자열 또는 base64)
  const envVal = process.env.VERTEX_SA_JSON
  if (envVal) {
    try {
      return JSON.parse(envVal) as ServiceAccount
    } catch {
      return JSON.parse(Buffer.from(envVal, "base64").toString("utf-8")) as ServiceAccount
    }
  }

  // 2) config: vertexServiceAccountPath (파일 경로)
  if (saPath) {
    const raw = await readFile(saPath, "utf-8")
    return JSON.parse(raw) as ServiceAccount
  }

  throw new Error(
    "Vertex AI 인증 정보가 없습니다. VERTEX_SA_JSON 환경변수 또는 overdare.vertexServiceAccountPath 설정을 확인하세요.",
  )
}

async function getAccessToken(saPath?: string): Promise<string> {
  if (cachedToken && Date.now() < cachedToken.expiresAt - 60_000) {
    return cachedToken.token
  }

  const sa = await loadServiceAccount(saPath)

  const now = Math.floor(Date.now() / 1000)
  const header = Buffer.from(JSON.stringify({ alg: "RS256", typ: "JWT" })).toString("base64url")
  const payload = Buffer.from(
    JSON.stringify({
      iss: sa.client_email,
      scope: SCOPE,
      aud: TOKEN_URL,
      iat: now,
      exp: now + 3600,
    }),
  ).toString("base64url")

  const signature = crypto
    .createSign("RSA-SHA256")
    .update(`${header}.${payload}`)
    .sign(sa.private_key, "base64url")

  const jwt = `${header}.${payload}.${signature}`

  const resp = await fetch(TOKEN_URL, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=${jwt}`,
  })

  if (!resp.ok) {
    const err = await resp.text()
    throw new Error(`OAuth2 토큰 발급 실패 (HTTP ${resp.status}): ${err.substring(0, 200)}`)
  }

  const data = (await resp.json()) as { access_token: string; expires_in: number }
  cachedToken = {
    token: data.access_token,
    expiresAt: Date.now() + data.expires_in * 1000,
  }
  return cachedToken.token
}

export const OverdareSearchTool = Tool.define("overdaresearch", {
  description: DESCRIPTION,
  parameters: z.object({
    query: z.string().describe("OVERDARE 관련 검색 쿼리 (영어로 전처리된 형태 권장)"),
  }),
  async execute(args, ctx) {
    await ctx.ask({
      permission: "overdaresearch",
      patterns: [args.query],
      always: ["*"],
      metadata: {
        query: args.query,
      },
    })

    const config = await Config.get()
    const saPath = config.overdare?.vertexServiceAccountPath
    const accessToken = await getAccessToken(saPath)

    const url = `https://${LOCATION}-aiplatform.googleapis.com/v1/projects/${PROJECT_ID}/locations/${LOCATION}:retrieveContexts`

    const body = {
      vertexRagStore: {
        ragResources: [{ ragCorpus: RAG_CORPUS }],
      },
      query: {
        text: `${args.query} | Include the URL from the top of retrieved data files in your response.`,
        ragRetrievalConfig: {
          topK: TOP_K,
          filter: {
            vectorDistanceThreshold: THRESHOLD,
          },
          ranking: {
            rankService: { modelName: RANKER_MODEL },
          },
        },
      },
    }

    const controller = new AbortController()
    const timer = setTimeout(() => controller.abort(), TIMEOUT)

    try {
      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${accessToken}`,
        },
        body: JSON.stringify(body),
        signal: controller.signal,
      })

      if (!response.ok) {
        const errText = await response.text()
        let errMsg = errText.substring(0, 200)
        try {
          const errJson = JSON.parse(errText) as { error?: { message?: string } }
          if (errJson?.error?.message) errMsg = errJson.error.message.substring(0, 200)
        } catch {}
        throw new Error(`Vertex AI RAG 검색 실패 (HTTP ${response.status}): ${errMsg}`)
      }

      const data = (await response.json()) as RetrieveResponse
      const contexts: RagContext[] = (data?.contexts?.contexts ?? [])
        .map((chunk) => ({ text: chunk.text || "" }))
        .filter((c) => c.text.length > 0)

      const output = contexts.length
        ? contexts.map((c, i) => `[${i + 1}]\n${c.text}`).join("\n\n---\n\n")
        : "No results found."

      return {
        title: `overdaresearch: ${contexts.length} result(s)`,
        metadata: {
          resultCount: contexts.length,
        },
        output,
      }
    } catch (err) {
      if (err instanceof Error && err.name === "AbortError") {
        throw new Error("Vertex AI RAG search timed out")
      }
      throw err
    } finally {
      clearTimeout(timer)
    }
  },
})
