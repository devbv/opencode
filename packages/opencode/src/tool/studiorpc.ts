import z from "zod"
import net from "net"
import readline from "readline"
import { Tool } from "./tool"
import DESCRIPTION from "./studiorpc.txt"
import { rpcMethods, formatMethodDocs } from "./studiorpc-methods"

const DEFAULT_HOST = "localhost"
const DEFAULT_PORT = 9100
const TIMEOUT = 30_000

interface JsonRpcResponse {
  jsonrpc: string
  id: number
  result?: unknown
  error?: { code: number; message: string; data?: unknown }
}

let nextId = 1

function call(
  method: string,
  params?: Record<string, unknown>,
): Promise<unknown> {
  const host = process.env.STUDIO_HOST || DEFAULT_HOST
  const port = Number(process.env.STUDIO_PORT) || DEFAULT_PORT

  return new Promise((resolve, reject) => {
    const id = nextId++
    const request = {
      jsonrpc: "2.0",
      id,
      method,
      ...(params !== undefined && { params }),
    }

    const socket = net.createConnection({ host, port }, () => {
      socket.write(JSON.stringify(request) + "\n")
    })

    const rl = readline.createInterface({ input: socket })

    const timer = setTimeout(() => {
      cleanup()
      reject(new Error(`Studio RPC timed out after ${TIMEOUT}ms`))
    }, TIMEOUT)

    function cleanup() {
      clearTimeout(timer)
      rl.close()
      socket.destroy()
    }

    rl.once("line", (line) => {
      cleanup()
      try {
        const response = JSON.parse(line) as JsonRpcResponse
        if (response.error) {
          reject(
            new Error(
              `Studio RPC error [${response.error.code}]: ${response.error.message}`,
            ),
          )
        } else {
          resolve(response.result)
        }
      } catch (e) {
        reject(new Error(`Failed to parse Studio response: ${line}`))
      }
    })

    socket.on("error", (err) => {
      cleanup()
      reject(
        new Error(`Studio connection error: ${err.message}`),
      )
    })
  })
}

const methodNames = Object.keys(rpcMethods) as [string, ...string[]]

export const StudioRpcTool = Tool.define("studiorpc", async () => {
  const methodDocs = formatMethodDocs()
  const description = DESCRIPTION.replace("${methods}", methodDocs)

  return {
    description,
    parameters: z.object({
      method: z.enum(methodNames).describe("JSON-RPC method name"),
      params: z
        .record(z.string(), z.any())
        .optional()
        .describe("Method parameters"),
    }),
    async execute(args, ctx) {
      // Runtime validation of params against method schema
      const methodDef = rpcMethods[args.method as keyof typeof rpcMethods]
      if (methodDef && args.params) {
        methodDef.params.parse(args.params)
      }

      await ctx.ask({
        permission: "studiorpc",
        patterns: [args.method],
        always: ["*"],
        metadata: {
          method: args.method,
          params: args.params,
        },
      })

      const result = await call(args.method, args.params)
      const output =
        typeof result === "string" ? result : JSON.stringify(result, null, 2)

      return {
        title: `studiorpc: ${args.method}`,
        metadata: {
          method: args.method,
        },
        output,
      }
    },
  }
})
