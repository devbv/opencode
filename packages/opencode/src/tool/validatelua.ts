import z from "zod"
import { execFile } from "child_process"
import { promisify } from "util"
import { existsSync } from "fs"
import { writeFile, unlink, access } from "fs/promises"
import { tmpdir } from "os"
import path, { join } from "path"
import { Tool } from "./tool"
import { Config } from "../config/config"
import DESCRIPTION from "./validatelua.txt"

const execFileAsync = promisify(execFile)

export const ValidateLuaTool = Tool.define("validatelua", {
  description: DESCRIPTION,
  parameters: z.object({
    source: z.string().describe("검증할 Luau 소스 코드"),
  }),
  async execute(args, ctx) {
    await ctx.ask({
      permission: "validatelua",
      patterns: [],
      always: ["*"],
      metadata: {},
    })

    const cfg = await Config.get()

    // Resolve default paths relative to the binary directory (process.execPath)
    const binDir = path.dirname(process.execPath)
    const luauLspBin = process.platform === "win32" ? "luau-lsp.exe" : "luau-lsp"
    const defaultLuauLspPath = path.join(binDir, luauLspBin)
    const defaultTypesPath = path.join(binDir, "overdare-types.d.lua")

    const luauLspPath = cfg.overdare?.luauLspPath
      || (existsSync(defaultLuauLspPath) ? defaultLuauLspPath : "luau-lsp")
    const typesPath = cfg.overdare?.typesPath
      || (existsSync(defaultTypesPath) ? defaultTypesPath : undefined)

    // Verify luau-lsp exists
    try {
      await execFileAsync(luauLspPath, ["--version"])
    } catch {
      throw new Error(
        `luau-lsp를 찾을 수 없습니다. overdare.luauLspPath 설정을 확인하거나 luau-lsp를 설치하세요. ` +
          `다운로드: https://github.com/JohnnyMorganz/luau-lsp/releases`,
      )
    }

    // Verify type definitions file exists
    if (typesPath) {
      try {
        await access(typesPath)
      } catch {
        throw new Error(
          `타입 정의 파일을 찾을 수 없습니다: ${typesPath}. overdare.typesPath 설정을 확인하세요.`,
        )
      }
    }

    // Create temp files
    const tempId = `validate-${Date.now()}-${Math.random().toString(36).slice(2)}`
    const tempFilePath = join(tmpdir(), `${tempId}.lua`)
    const tempLuaurcPath = join(tmpdir(), `${tempId}.luaurc`)

    try {
      await writeFile(tempFilePath, args.source, "utf-8")
      await writeFile(tempLuaurcPath, JSON.stringify({ languageMode: "strict" }), "utf-8")

      // Build luau-lsp analyze args
      const analyzeArgs = ["analyze", "--base-luaurc", tempLuaurcPath]
      if (typesPath) {
        analyzeArgs.push("--definitions", typesPath)
      }
      analyzeArgs.push(tempFilePath)

      // Run luau-lsp analyze
      const { stdout, stderr } = await execFileAsync(luauLspPath, analyzeArgs).catch(
        (error: { stdout?: string; stderr?: string }) => {
          return { stdout: error.stdout || "", stderr: error.stderr || "" }
        },
      )

      const output = [stdout, stderr].filter(Boolean).join("\n").trim()

      return {
        title: "validatelua",
        metadata: {},
        output: output || "No issues found. Code is valid.",
      }
    } finally {
      await Promise.all([
        unlink(tempFilePath).catch(() => {}),
        unlink(tempLuaurcPath).catch(() => {}),
      ])
    }
  },
})
