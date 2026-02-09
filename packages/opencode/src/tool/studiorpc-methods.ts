import z from "zod"

export const rpcMethods = {
  "level.browse": {
    description: "Browse the level instance tree. Returns instances with guid, name, class, and children.",
    params: z.object({}),
  },
  "script.add": {
    description: "Add a script under a parent instance.",
    params: z.object({
      class: z.enum(["LocalScript", "Script", "ModuleScript"]),
      parentGuid: z.string().describe("GUID of the parent instance (use level.browse to find)"),
      name: z.string(),
      source: z.string().describe("Luau source code"),
    }),
  },
  "script.delete": {
    description: "Delete a script instance.",
    params: z.object({
      targetGuid: z.string().describe("GUID of the script to delete"),
    }),
  },
  "script.get": {
    description: "Get script source code.",
    params: z.object({
      targetGuid: z.string(),
    }),
  },
  "instance.part.add": {
    description: "Add a Part or RemoteEvent instance under a parent.",
    params: z.object({
      class: z.enum(["Part", "RemoteEvent"]),
      parentGuid: z.string().describe("GUID of the parent instance"),
      name: z.string(),
      properties: z
        .object({
          Shape: z.enum(["Enum.Block", "Enum.Ball", "Enum.Cylinder"]).optional(),
          CFrame: z
            .object({
              Position: z.object({ x: z.number(), y: z.number(), z: z.number() }),
              Orientation: z.object({ x: z.number(), y: z.number(), z: z.number() }),
            })
            .optional(),
          Size: z
            .object({ x: z.number(), y: z.number(), z: z.number() })
            .optional()
            .describe("units in cm"),
        })
        .optional()
        .describe("Part properties (Part only)"),
    }),
  },
  "instance.delete": {
    description: "Delete any instance by GUID.",
    params: z.object({
      targetGuid: z.string(),
    }),
  },
} as const satisfies Record<string, { description: string; params: z.ZodType }>

export type RpcMethodName = keyof typeof rpcMethods

type ZodDef = { type: string; innerType?: z.ZodType; entries?: Record<string, string> }

function defOf(schema: z.ZodType): ZodDef {
  return (schema as any)._zod.def
}

function unwrap(schema: z.ZodType): z.ZodType {
  const def = defOf(schema)
  if (def.type === "optional" || def.type === "nullable") {
    return unwrap(def.innerType!)
  }
  return schema
}

function isOptional(schema: z.ZodType): boolean {
  const def = defOf(schema)
  return def.type === "optional" || def.type === "nullable"
}

function getDescription(schema: z.ZodType): string {
  if (schema.description) return schema.description
  const def = defOf(schema)
  if ((def.type === "optional" || def.type === "nullable") && def.innerType) {
    return def.innerType.description ?? ""
  }
  return ""
}

function getTypeName(schema: z.ZodType): string {
  const inner = unwrap(schema)
  const def = defOf(inner)

  switch (def.type) {
    case "string":
      return "string"
    case "number":
    case "int":
      return "number"
    case "boolean":
      return "boolean"
    case "enum": {
      const entries = def.entries as Record<string, string>
      return Object.values(entries).map((v) => `"${v}"`).join(" | ")
    }
    case "object":
      return "object"
    default:
      return "any"
  }
}

function formatZodShape(schema: z.ZodType, indent: number = 3): string {
  const inner = unwrap(schema)
  if (defOf(inner).type !== "object") return ""

  const shape = (inner as z.ZodObject).shape as Record<string, z.ZodType>
  const lines: string[] = []
  for (const [key, field] of Object.entries(shape)) {
    lines.push(formatField(key, field, indent))
  }
  return lines.join("\n")
}

function formatField(name: string, schema: z.ZodType, indent: number): string {
  const pad = "  ".repeat(indent)
  const desc = getDescription(schema)
  const type = getTypeName(schema)
  const opt = isOptional(schema)
  const suffix = [type, opt ? "optional" : "", desc].filter(Boolean).join(", ")
  const line = `${pad}${name}: ${suffix}`

  const inner = unwrap(schema)
  if (defOf(inner).type === "object") {
    return line + "\n" + formatZodShape(inner, indent + 1)
  }

  return line
}

export function formatMethodDocs(): string {
  const lines: string[] = []

  for (const [method, def] of Object.entries(rpcMethods)) {
    lines.push(`  - ${method}: ${def.description}`)

    const paramsShape = (def.params as z.ZodObject).shape as Record<string, z.ZodType>
    if (Object.keys(paramsShape).length > 0) {
      lines.push("    params:")
      lines.push(formatZodShape(def.params, 3))
    } else {
      lines.push("    No params required.")
    }

    lines.push("")
  }

  return lines.join("\n").trimEnd()
}
