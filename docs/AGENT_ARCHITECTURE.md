# OpenCode Agent System Architecture

이 문서는 OpenCode의 Agent 시스템 전체 아키텍처를 설명합니다.

## 목차

1. [시스템 개요](#1-시스템-개요)
2. [핵심 컴포넌트](#2-핵심-컴포넌트)
3. [메인 루프 (Agent Loop)](#3-메인-루프-agent-loop)
4. [Session 시스템](#4-session-시스템)
5. [Message 시스템](#5-message-시스템)
6. [Tool 시스템](#6-tool-시스템)
7. [Provider 시스템](#7-provider-시스템)
8. [MCP 시스템](#8-mcp-시스템)
9. [인터페이스 레이어](#9-인터페이스-레이어)
10. [이벤트 시스템](#10-이벤트-시스템)
11. [파일 구조](#11-파일-구조)

---

## 1. 시스템 개요

OpenCode Agent 시스템은 LLM(Large Language Model)을 활용하여 코드 작성, 편집, 실행 등의 작업을 자동화하는 AI 에이전트입니다.

### 전체 아키텍처 다이어그램

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Interface Layer                                  │
│            (클라이언트별 인터페이스 - Core에 직접 연결)                    │
│                                                                         │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────┐ │
│  │   CLI / TUI     │  │  Desktop App    │  │   ACP Server            │ │
│  │                 │  │                 │  │  (외부 클라이언트용)      │ │
│  │  Server.listen  │  │  Server.listen  │  │  opencode acp 명령      │ │
│  │  + HTTP SDK     │  │  + HTTP SDK     │  │  + stdio JSON-RPC       │ │
│  └────────┬────────┘  └────────┬────────┘  └───────────┬─────────────┘ │
│           │                    │                       │               │
│           │         HTTP       │         HTTP          │  stdio        │
│           └────────────────────┼───────────────────────┘               │
│                                │                                       │
└────────────────────────────────┼───────────────────────────────────────┘
                                 ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         Core SDK Layer                                  │
│                   (packages/opencode/src/session/)                      │
│                                                                         │
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │                    SessionPrompt.loop()                          │  │
│  │                   [Main Agent Loop]                              │  │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │  │
│  │  │  Message   │  │  Tools     │  │ Processor  │  │   LLM      │ │  │
│  │  │  Handler   │  │  Resolver  │  │  (Stream)  │  │  Stream    │ │  │
│  │  └────────────┘  └────────────┘  └────────────┘  └────────────┘ │  │
│  └──────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐   │
│  │ Session     │  │ MessageV2   │  │ Permission  │  │ Compaction  │   │
│  │ Manager     │  │ Storage     │  │ System      │  │ System      │   │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘   │
└───────────────────────────────┬─────────────────────────────────────────┘
                                │
                ┌───────────────┼───────────────┐
                ▼               ▼               ▼
┌───────────────────┐ ┌─────────────────┐ ┌─────────────────────────────┐
│   Tool System     │ │ Provider System │ │     MCP System              │
│  (src/tool/)      │ │ (src/provider/) │ │    (src/mcp/)               │
│                   │ │                 │ │                             │
│ ┌───────────────┐ │ │ ┌─────────────┐ │ │ ┌─────────────────────────┐ │
│ │ ToolRegistry  │ │ │ │ Anthropic   │ │ │ │ Local MCP Servers       │ │
│ │ - bash        │ │ │ │ OpenAI      │ │ │ │ (stdio transport)       │ │
│ │ - read/write  │ │ │ │ Google      │ │ │ └─────────────────────────┘ │
│ │ - edit        │ │ │ │ Azure       │ │ │ ┌─────────────────────────┐ │
│ │ - glob/grep   │ │ │ │ Bedrock     │ │ │ │ Remote MCP Servers      │ │
│ │ - task        │ │ │ │ 20+ more    │ │ │ │ (HTTP/SSE transport)    │ │
│ │ - webfetch    │ │ │ └─────────────┘ │ │ └─────────────────────────┘ │
│ └───────────────┘ │ │                 │ │                             │
└───────────────────┘ └─────────────────┘ └─────────────────────────────┘
```

### 인터페이스 레이어 비교

| 인터페이스 | 사용처 | 프로토콜 | 시작 방법 |
|-----------|--------|----------|-----------|
| **CLI/TUI** | 터미널 직접 사용 | HTTP (내부 서버) | `opencode` |
| **Desktop** | 데스크톱 앱 | HTTP (내부 서버) | 앱 실행 |
| **ACP** | 외부 클라이언트 (Zed 등) | stdio JSON-RPC | `opencode acp` |

모든 인터페이스는 동일한 Core SDK Layer를 사용합니다. ACP는 외부 클라이언트와의 호환성을 위한 추가 인터페이스 레이어입니다.

---

## 2. 핵심 컴포넌트

### 2.1 컴포넌트 의존성

```
┌──────────────────────────────────────────────────────────────────┐
│                      Entry Points                                │
│  CLI (tui/) | Desktop (desktop/) | ACP Server (acp/)            │
└──────────────────────────────┬───────────────────────────────────┘
                               ▼
┌──────────────────────────────────────────────────────────────────┐
│                      Session Layer                               │
│  Session.create() → SessionPrompt.prompt() → SessionPrompt.loop()│
└──────────────────────────────┬───────────────────────────────────┘
                               ▼
┌──────────────────────────────────────────────────────────────────┐
│                    Processing Layer                              │
│  SessionProcessor.process() → LLM.stream() → Tool.execute()     │
└──────────────────────────────┬───────────────────────────────────┘
                               ▼
┌──────────────────────────────────────────────────────────────────┐
│                     Storage Layer                                │
│  Storage.write() | Storage.read() | Bus.publish()               │
└──────────────────────────────────────────────────────────────────┘
```

### 2.2 주요 모듈 역할

| 모듈 | 경로 | 역할 |
|------|------|------|
| **Session** | `src/session/index.ts` | 세션 생명주기 관리 |
| **SessionPrompt** | `src/session/prompt.ts` | 프롬프트 처리 및 메인 루프 |
| **SessionProcessor** | `src/session/processor.ts` | LLM 스트림 처리 |
| **LLM** | `src/session/llm.ts` | LLM 호출 추상화 |
| **MessageV2** | `src/session/message-v2.ts` | 메시지 및 Part 관리 |
| **Tool** | `src/tool/tool.ts` | Tool 정의 및 실행 |
| **ToolRegistry** | `src/tool/registry.ts` | Tool 등록 및 조회 |
| **Provider** | `src/provider/provider.ts` | LLM 제공자 추상화 |
| **MCP** | `src/mcp/index.ts` | MCP 클라이언트 관리 |
| **ACP** | `src/acp/agent.ts` | ACP 서버 프로토콜 |

---

## 3. 메인 루프 (Agent Loop)

Agent의 핵심은 `SessionPrompt.loop()` 함수입니다. 이 함수가 LLM 호출과 Tool 실행을 반복합니다.

### 3.1 루프 흐름도

```
SessionPrompt.loop(sessionID)
         │
         ▼
    ┌────────────────────────────────────────────┐
    │            while (true)                    │
    │  ┌──────────────────────────────────────┐  │
    │  │ 1. 메시지 조회 및 필터링              │  │
    │  │    MessageV2.filterCompacted()       │  │
    │  └──────────────────────────────────────┘  │
    │                    │                       │
    │                    ▼                       │
    │  ┌──────────────────────────────────────┐  │
    │  │ 2. 종료 조건 확인                     │  │
    │  │    - lastAssistant.finish 체크       │  │
    │  │    - "end_turn", "stop" → break      │  │
    │  └──────────────────────────────────────┘  │
    │                    │                       │
    │                    ▼                       │
    │  ┌──────────────────────────────────────┐  │
    │  │ 3. 분기 처리                          │  │
    │  │    ├─ Subtask → TaskTool 실행        │  │
    │  │    ├─ Compaction → 컨텍스트 압축     │  │
    │  │    └─ Normal → LLM 호출              │  │
    │  └──────────────────────────────────────┘  │
    │                    │                       │
    │                    ▼                       │
    │  ┌──────────────────────────────────────┐  │
    │  │ 4. resolveTools()                    │  │
    │  │    - ToolRegistry에서 도구 수집      │  │
    │  │    - MCP에서 외부 도구 수집          │  │
    │  │    - AI SDK Tool 형식으로 변환       │  │
    │  └──────────────────────────────────────┘  │
    │                    │                       │
    │                    ▼                       │
    │  ┌──────────────────────────────────────┐  │
    │  │ 5. SessionProcessor.process()        │  │
    │  │    ├─ LLM.stream() 호출              │  │
    │  │    ├─ for await (stream.fullStream)  │  │
    │  │    │   ├─ text-delta → TextPart      │  │
    │  │    │   ├─ tool-call → Tool 실행      │  │
    │  │    │   └─ tool-result → 결과 저장    │  │
    │  │    └─ return "continue"|"stop"|"compact"│
    │  └──────────────────────────────────────┘  │
    │                    │                       │
    │                    ▼                       │
    │          result에 따라 continue/break      │
    └────────────────────────────────────────────┘
         │
         ▼
    마지막 Assistant Message 반환
```

### 3.2 핵심 코드 위치

| 기능 | 파일 | 라인 |
|------|------|------|
| 메인 루프 | `src/session/prompt.ts` | 257-632 |
| Tool 해결 | `src/session/prompt.ts` | 641-802 |
| LLM 스트리밍 | `src/session/llm.ts` | 46-223 |
| 스트림 처리 | `src/session/processor.ts` | 45-402 |

### 3.3 루프 종료 조건

```typescript
// prompt.ts:611-621
if (
  lastAssistant?.finish &&
  !["tool-calls", "unknown"].includes(lastAssistant.finish) &&
  lastUser.id < lastAssistant.id
) {
  break  // 루프 종료
}
```

---

## 4. Session 시스템

### 4.1 Session 생명주기

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   create()  │ ──▶ │   prompt()  │ ──▶ │   loop()    │
└─────────────┘     └─────────────┘     └─────────────┘
       │                   │                   │
       ▼                   ▼                   ▼
 Session.Info 생성    User Message 생성   Assistant Message 생성
       │                   │                   │
       ▼                   ▼                   ▼
 Storage에 저장       Parts 저장           Parts 저장
       │                   │                   │
       ▼                   ▼                   ▼
 Bus.publish          Bus.publish          Bus.publish
 (Created)            (PartUpdated)        (PartUpdated)
```

### 4.2 Session.Info 구조

```typescript
// src/session/index.ts
interface Session.Info {
  id: string                           // ses_xxxxx
  projectID: string                    // 프로젝트 ID
  directory: string                    // 작업 디렉토리
  parentID?: string                    // 부모 세션 (fork)
  title: string                        // 세션 제목
  version: string                      // OpenCode 버전
  time: {
    created: number                    // 생성 시간
    updated: number                    // 마지막 업데이트
    compacting?: number                // 압축 중 시간
    archived?: number                  // 아카이브 시간
  }
  permission?: PermissionNext.Ruleset  // 권한 규칙
  summary?: {                          // 변경 요약
    additions: number
    deletions: number
    files: number
    diffs: FileDiff[]
  }
  share?: { url: string }              // 공유 URL
}
```

### 4.3 세션 상태 (SessionStatus)

```typescript
// src/session/status.ts
type SessionStatus.Info =
  | { type: "idle" }                              // 유휴 상태
  | { type: "busy" }                              // 처리 중
  | { type: "retry"                               // 재시도 중
      attempt: number
      message: string
      next: number
    }
```

---

## 5. Message 시스템

### 5.1 메시지 타입

```
┌─────────────────────────────────────────────────────────────────┐
│                      MessageV2.Info                             │
│  ┌─────────────────────────┬─────────────────────────────────┐ │
│  │      User Message       │     Assistant Message           │ │
│  ├─────────────────────────┼─────────────────────────────────┤ │
│  │ role: "user"            │ role: "assistant"               │ │
│  │ agent: string           │ agent: string                   │ │
│  │ model: {providerID,     │ parentID: string                │ │
│  │         modelID}        │ modelID, providerID             │ │
│  │ tools?: Record<...>     │ cost: number                    │ │
│  │ system?: string         │ tokens: {input, output, ...}    │ │
│  │                         │ finish?: string                 │ │
│  │                         │ error?: Error                   │ │
│  └─────────────────────────┴─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### 5.2 Part 타입

메시지는 여러 Part로 구성됩니다:

```
MessageV2.Part (12가지 타입)
├── TextPart         # 텍스트 응답
├── ReasoningPart    # 추론 과정 (Claude 3.7+)
├── ToolPart         # Tool 호출 및 결과
├── FilePart         # 파일 첨부
├── AgentPart        # Agent 참조
├── SubtaskPart      # 서브태스크 정의
├── SnapshotPart     # 스냅샷
├── PatchPart        # 파일 변경사항
├── StepStartPart    # 단계 시작
├── StepFinishPart   # 단계 완료
├── RetryPart        # 재시도 정보
└── CompactionPart   # 컨텍스트 압축 표시
```

### 5.3 ToolPart 상태 머신

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   pending   │ ──▶ │   running   │ ──▶ │  completed  │
└─────────────┘     └─────────────┘     └─────────────┘
                          │
                          ▼
                    ┌─────────────┐
                    │    error    │
                    └─────────────┘

상태 전이:
- pending:   LLM이 tool 호출 요청 (입력만 있음)
- running:   Tool 실행 시작
- completed: Tool 실행 완료 (출력 포함)
- error:     Tool 실행 실패
```

### 5.4 저장 구조

```
Storage 경로:
├── ["session", projectID, sessionID]     → Session.Info
├── ["message", sessionID, messageID]     → MessageV2.Info
└── ["part", messageID, partID]           → MessageV2.Part
```

---

## 6. Tool 시스템

### 6.1 Tool 정의 구조

```typescript
// src/tool/tool.ts
interface Tool.Info<P extends z.ZodType, M extends Metadata> {
  id: string
  init: (ctx?: InitContext) => Promise<{
    description: string
    parameters: P                              // Zod 스키마
    execute(
      args: z.infer<P>,
      ctx: Tool.Context
    ): Promise<{
      title: string
      metadata: M
      output: string
      attachments?: FilePart[]
    }>
    formatValidationError?(error: z.ZodError): string
  }>
}

// Tool Context
interface Tool.Context {
  sessionID: string
  messageID: string
  agent: string
  abort: AbortSignal
  callID?: string
  metadata(input: { title?: string; metadata?: M }): void
  ask(permission: PermissionRequest): Promise<void>
}
```

### 6.2 내장 Tool 목록

| Tool ID | 설명 | 파일 |
|---------|------|------|
| `bash` | 셸 명령 실행 | `bash.ts` |
| `read` | 파일 읽기 | `read.ts` |
| `write` | 파일 작성 | `write.ts` |
| `edit` | 파일 수정 | `edit.ts` |
| `multiedit` | 다중 편집 | `multiedit.ts` |
| `patch` | 패치 적용 | `patch.ts` |
| `glob` | 파일 패턴 매칭 | `glob.ts` |
| `grep` | 텍스트 검색 | `grep.ts` |
| `list` | 디렉토리 목록 | `ls.ts` |
| `question` | 사용자 질문 | `question.ts` |
| `task` | 서브에이전트 | `task.ts` |
| `batch` | 병렬 실행 | `batch.ts` |
| `webfetch` | URL 가져오기 | `webfetch.ts` |
| `websearch` | 웹 검색 | `websearch.ts` |
| `codesearch` | 코드 검색 | `codesearch.ts` |
| `skill` | 스킬 로드 | `skill.ts` |
| `todoread` | Todo 읽기 | `todo.ts` |
| `todowrite` | Todo 작성 | `todo.ts` |
| `lsp` | LSP 작업 | `lsp.ts` |

### 6.3 Tool 실행 흐름

```
┌─────────────────────────────────────────────────────────────────┐
│                    Tool 실행 흐름                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. LLM Response                                                │
│     └─▶ tool-call 이벤트 (toolName, args)                       │
│                                                                 │
│  2. resolveTools()에서 정의된 execute 콜백                       │
│     ├─▶ ctx.ask() - 권한 확인                                   │
│     │   └─▶ PermissionNext.evaluate()                          │
│     │       ├─ allow → 계속                                     │
│     │       ├─ deny → 에러                                      │
│     │       └─ ask → 사용자에게 질문                            │
│     │                                                           │
│     └─▶ tool.execute(args, ctx) - 실제 실행                     │
│                                                                 │
│  3. 결과 반환                                                    │
│     └─▶ { title, output, metadata, attachments }                │
│                                                                 │
│  4. ToolPart 업데이트                                            │
│     └─▶ Session.updatePart() → Bus.publish(PartUpdated)        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 6.4 ToolRegistry

```typescript
// src/tool/registry.ts
namespace ToolRegistry {
  // 모든 Tool 조회
  async function all(): Promise<Tool.Info[]>

  // Provider/Agent별 Tool 초기화
  async function tools(
    providerID: string,
    agent?: Agent.Info
  ): Promise<Record<string, InitializedTool>>

  // Tool 등록
  async function register(tool: Tool.Info): Promise<void>
}
```

---

## 7. Provider 시스템

### 7.1 지원 Provider 목록

```
┌──────────────────────────────────────────────────────────────────┐
│                    BUNDLED_PROVIDERS                             │
├──────────────────────────────────────────────────────────────────┤
│ Provider          │ Package                    │ Models          │
├───────────────────┼────────────────────────────┼─────────────────┤
│ Anthropic         │ @ai-sdk/anthropic          │ Claude 3.5/4    │
│ OpenAI            │ @ai-sdk/openai             │ GPT-4/5         │
│ Google            │ @ai-sdk/google             │ Gemini          │
│ Azure             │ @ai-sdk/azure              │ Azure OpenAI    │
│ Amazon Bedrock    │ @ai-sdk/amazon-bedrock     │ Claude, Nova    │
│ Google Vertex     │ @ai-sdk/google-vertex      │ Gemini, Claude  │
│ Mistral           │ @ai-sdk/mistral            │ Mistral         │
│ Groq              │ @ai-sdk/groq               │ Llama, Mixtral  │
│ Cohere            │ @ai-sdk/cohere             │ Command         │
│ xAI               │ @ai-sdk/xai                │ Grok            │
│ OpenRouter        │ @openrouter/ai-sdk-provider│ Multi-model     │
│ Together AI       │ @ai-sdk/togetherai         │ Various         │
│ Perplexity        │ @ai-sdk/perplexity         │ pplx            │
│ GitHub Copilot    │ custom                     │ GPT             │
│ Cerebras          │ @ai-sdk/cerebras           │ Cerebras        │
│ DeepInfra         │ @ai-sdk/deepinfra          │ Various         │
│ Vercel            │ @ai-sdk/vercel             │ v0              │
│ Gateway           │ @ai-sdk/gateway            │ Proxy           │
└──────────────────────────────────────────────────────────────────┘
```

### 7.2 Provider 인터페이스

```typescript
// src/provider/provider.ts
interface Provider.Info {
  id: string                           // anthropic, openai, ...
  name: string                         // 표시 이름
  source: "env" | "config" | "api"     // 설정 출처
  env: string[]                        // 환경 변수 키
  key?: string                         // API 키
  options: Record<string, any>         // Provider 옵션
  models: Record<string, Model>        // 사용 가능 모델
}

interface Provider.Model {
  id: string
  providerID: string
  api: { id, url, npm }
  name: string
  capabilities: {
    temperature: boolean
    reasoning: boolean
    toolcall: boolean
    attachment: boolean
    input: { text, audio, image, video, pdf }
    output: { text, audio, image, video, pdf }
    interleaved: boolean
  }
  cost: { input, output, cache: { read, write } }
  limit: { context, output }
  status: "alpha" | "beta" | "active" | "deprecated"
}
```

### 7.3 LLM 호출 흐름

```
┌─────────────────────────────────────────────────────────────────┐
│                    LLM.stream() 호출 흐름                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. Provider.getLanguage(model)                                 │
│     ├─▶ getSDK(model) - SDK 인스턴스 획득/캐싱                  │
│     └─▶ sdk.languageModel(model.api.id)                         │
│                                                                 │
│  2. System Prompt 구성                                          │
│     ├─▶ SystemPrompt.header(providerID)                         │
│     ├─▶ SystemPrompt.provider(model)                            │
│     ├─▶ SystemPrompt.environment()                              │
│     └─▶ SystemPrompt.custom()                                   │
│                                                                 │
│  3. wrapLanguageModel() - 미들웨어 적용                          │
│     ├─▶ ProviderTransform.message() - 메시지 정규화             │
│     └─▶ extractReasoningMiddleware() - 추론 추출                │
│                                                                 │
│  4. streamText() - AI SDK 호출                                  │
│     ├─▶ model, messages, tools                                  │
│     ├─▶ temperature, topP, topK                                 │
│     └─▶ maxOutputTokens, abortSignal                            │
│                                                                 │
│  5. 스트림 반환                                                  │
│     └─▶ StreamTextResult<ToolSet>                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 8. MCP 시스템

### 8.1 MCP (Model Context Protocol)

MCP는 외부 서버의 도구, 리소스, 프롬프트를 OpenCode Agent에 통합합니다.

```
┌─────────────────────────────────────────────────────────────────┐
│                      MCP Architecture                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  OpenCode Agent                                                 │
│       │                                                         │
│       ▼                                                         │
│  ┌─────────────┐                                                │
│  │ MCP Manager │                                                │
│  │ (src/mcp/)  │                                                │
│  └──────┬──────┘                                                │
│         │                                                        │
│    ┌────┴────┐                                                  │
│    ▼         ▼                                                  │
│  Local     Remote                                               │
│  Server    Server                                               │
│    │         │                                                  │
│    ▼         ▼                                                  │
│  ┌─────┐  ┌─────────┐                                           │
│  │Stdio│  │HTTP/SSE │                                           │
│  └─────┘  └─────────┘                                           │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 8.2 MCP 설정

```typescript
// Local MCP Server
{
  type: "local"
  command: ["npx", "-y", "@mcp/weather"]
  environment?: { API_KEY: "xxx" }
  timeout?: 30000
}

// Remote MCP Server
{
  type: "remote"
  url: "https://mcp.example.com/api"
  headers?: { Authorization: "Bearer xxx" }
  oauth?: { ... }
  timeout?: 30000
}
```

### 8.3 MCP Tool 변환

```typescript
// src/mcp/index.ts
async function convertMcpTool(
  mcpTool: MCPToolDef,
  client: MCPClient
): Promise<Tool> {
  return dynamicTool({
    description: mcpTool.description,
    inputSchema: jsonSchema(mcpTool.inputSchema),
    execute: async (args) => {
      return client.callTool({
        name: mcpTool.name,
        arguments: args
      })
    }
  })
}
```

---

## 9. 인터페이스 레이어

OpenCode는 여러 인터페이스 레이어를 통해 Core SDK에 접근할 수 있습니다. 모든 인터페이스는 동일한 Core를 사용하며, 클라이언트 유형에 따라 적절한 인터페이스를 선택합니다.

### 9.1 인터페이스 비교

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Interface Layer 비교                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │ CLI / TUI (일반 사용)                                            │   │
│  │                                                                   │   │
│  │   Terminal ──▶ Server.listen() ──HTTP──▶ Core SDK               │   │
│  │                (내부 서버)                                        │   │
│  │                                                                   │   │
│  │   시작: opencode                                                  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │ Desktop App                                                       │   │
│  │                                                                   │   │
│  │   Electron ──▶ Server.listen() ──HTTP──▶ Core SDK               │   │
│  │                (내부 서버)                                        │   │
│  │                                                                   │   │
│  │   시작: 앱 실행                                                    │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │ ACP (외부 클라이언트용)                                           │   │
│  │                                                                   │   │
│  │   Zed Editor ──stdio──▶ ACP Server ──HTTP──▶ Core SDK           │   │
│  │              JSON-RPC   (프로토콜 변환)                            │   │
│  │                                                                   │   │
│  │   시작: opencode acp                                              │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 9.2 ACP (Agent Control Protocol)

ACP는 **외부 클라이언트와의 호환성**을 위한 인터페이스 레이어입니다. Zed Editor 같은 외부 애플리케이션이 OpenCode를 Agent로 사용할 때 필요합니다.

**CLI로 직접 사용할 때는 ACP를 거치지 않습니다.**

```
ACP가 필요한 경우:
- Zed Editor에서 OpenCode를 Agent로 사용
- 외부 IDE/에디터 통합
- ACP 프로토콜을 지원하는 클라이언트

ACP가 필요 없는 경우:
- 터미널에서 opencode 직접 실행
- Desktop 앱 사용
- 프로그래밍 방식으로 SDK 직접 호출
```

### 9.3 ACP 메서드 (참고용)

ACP 프로토콜을 사용하는 외부 클라이언트 개발자를 위한 참고 정보입니다.

```typescript
// src/acp/agent.ts
interface ACPAgent {
  // 초기화
  initialize(): Promise<{
    capabilities: AgentCapabilities
  }>

  // 세션 관리
  newSession(cwd, mcpServers): Promise<SessionInfo>
  loadSession(sessionId): Promise<SessionInfo>

  // 프롬프트 처리
  prompt(sessionId, parts): Promise<void>

  // 설정
  setSessionModel(sessionId, model): Promise<void>
  setSessionMode(sessionId, modeId): Promise<void>

  // 권한
  resolvePermission(sessionId, requestId, resolution): Promise<void>
}
```

### 9.4 ACP 이벤트 (참고용)

```typescript
// 이벤트 구독
setupEventSubscriptions(session) {
  // 권한 요청
  Bus.subscribe("permission.asked", (event) => {
    connection.requestPermission(event)
  })

  // 메시지 업데이트
  Bus.subscribe("message.part.updated", (event) => {
    // Tool 호출 상태
    if (part.type === "tool") {
      connection.sessionUpdate({
        kind: "tool_call",
        status: part.state.status,
        tool: part.tool,
        input: part.state.input,
        output: part.state.output
      })
    }
    // 텍스트 응답
    if (part.type === "text") {
      connection.sessionUpdate({
        kind: "agent_message_chunk",
        content: delta
      })
    }
  })
}
```

---

## 10. 이벤트 시스템

### 10.1 Bus 이벤트

```typescript
// src/bus/index.ts
namespace Bus {
  // 이벤트 발행
  publish<T>(event: BusEvent<T>, payload: T): void

  // 이벤트 구독
  subscribe<T>(event: BusEvent<T>, callback: (payload: T) => void): () => void

  // 일회성 구독
  once<T>(event: BusEvent<T>, callback: (payload: T) => void): void
}
```

### 10.2 주요 이벤트

```
Session Events:
├── session.created     - 세션 생성됨
├── session.updated     - 세션 업데이트됨
├── session.deleted     - 세션 삭제됨
├── session.diff        - 파일 변경사항
├── session.error       - 에러 발생
└── session.status      - 상태 변경 (idle/busy/retry)

Message Events:
├── message.updated     - 메시지 업데이트됨
├── message.removed     - 메시지 삭제됨
├── message.part.updated - Part 업데이트됨
└── message.part.removed - Part 삭제됨

Permission Events:
├── permission.asked    - 권한 요청됨
├── permission.allow    - 권한 허용됨
└── permission.deny     - 권한 거부됨

Tool Events:
├── todo.updated        - Todo 업데이트됨
└── file.updated        - 파일 변경됨
```

---

## 11. 파일 구조

```
packages/opencode/src/
├── session/                      # 세션 관리
│   ├── index.ts                  # Session 생명주기
│   ├── prompt.ts                 # 메인 루프 (loop, resolveTools)
│   ├── processor.ts              # LLM 스트림 처리
│   ├── llm.ts                    # LLM 호출 추상화
│   ├── message-v2.ts             # 메시지/Part 정의
│   ├── status.ts                 # 세션 상태 관리
│   ├── system.ts                 # 시스템 프롬프트
│   ├── compaction.ts             # 컨텍스트 압축
│   └── retry.ts                  # 재시도 로직
│
├── tool/                         # 도구 시스템
│   ├── tool.ts                   # Tool 인터페이스
│   ├── registry.ts               # Tool 등록/관리
│   ├── bash.ts                   # Bash 실행
│   ├── read.ts                   # 파일 읽기
│   ├── write.ts                  # 파일 쓰기
│   ├── edit.ts                   # 파일 편집
│   ├── glob.ts                   # 파일 검색
│   ├── grep.ts                   # 텍스트 검색
│   ├── task.ts                   # 서브에이전트
│   └── ...                       # 기타 도구
│
├── provider/                     # LLM 제공자
│   ├── provider.ts               # Provider 추상화
│   ├── models.ts                 # 모델 메타데이터
│   ├── transform.ts              # 메시지 변환
│   └── auth.ts                   # 인증 관리
│
├── mcp/                          # MCP 클라이언트
│   ├── index.ts                  # MCP 관리자
│   ├── oauth-provider.ts         # OAuth 인증
│   ├── oauth-callback.ts         # OAuth 콜백
│   └── auth.ts                   # 토큰 저장소
│
├── acp/                          # ACP 서버
│   ├── agent.ts                  # ACP 프로토콜
│   ├── session.ts                # ACP 세션 관리
│   └── types.ts                  # 타입 정의
│
├── agent/                        # Agent 정의
│   ├── agent.ts                  # Agent 인터페이스
│   └── index.ts                  # 기본 Agent들
│
├── permission/                   # 권한 시스템
│   ├── permission-next.ts        # 권한 평가
│   └── index.ts                  # 권한 관리
│
├── bus/                          # 이벤트 시스템
│   └── index.ts                  # Bus 발행/구독
│
├── storage/                      # 저장소
│   └── storage.ts                # 파일 기반 저장
│
└── config/                       # 설정
    └── config.ts                 # 설정 스키마
```

---

## 부록: 데이터 흐름 요약

```
User Input
     │
     ▼
┌─────────────────┐
│ Session.prompt()│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Create User     │
│ Message + Parts │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│SessionPrompt    │
│    .loop()      │◀──────────────────────┐
└────────┬────────┘                       │
         │                                │
         ▼                                │
┌─────────────────┐                       │
│ resolveTools()  │                       │
│ - ToolRegistry  │                       │
│ - MCP Tools     │                       │
└────────┬────────┘                       │
         │                                │
         ▼                                │
┌─────────────────┐                       │
│SessionProcessor │                       │
│   .process()    │                       │
└────────┬────────┘                       │
         │                                │
         ▼                                │
┌─────────────────┐                       │
│  LLM.stream()   │                       │
│ - Provider SDK  │                       │
│ - streamText()  │                       │
└────────┬────────┘                       │
         │                                │
         ▼                                │
┌─────────────────┐     ┌─────────────┐   │
│ Stream Events   │────▶│ Tool        │   │
│ - text-delta    │     │ Execution   │   │
│ - tool-call     │     └──────┬──────┘   │
│ - tool-result   │            │          │
│ - finish-step   │            ▼          │
└────────┬────────┘     ┌─────────────┐   │
         │              │ Permission  │   │
         │              │ Check       │   │
         │              └──────┬──────┘   │
         │                     │          │
         ▼                     ▼          │
┌─────────────────┐     ┌─────────────┐   │
│ Update Parts    │     │ Tool Result │   │
│ - TextPart      │     │ - output    │   │
│ - ToolPart      │     │ - metadata  │   │
│ - ReasoningPart │     └─────────────┘   │
└────────┬────────┘                       │
         │                                │
         ▼                                │
┌─────────────────┐                       │
│ Bus.publish()   │                       │
│ (PartUpdated)   │                       │
└────────┬────────┘                       │
         │                                │
         ▼                                │
┌─────────────────┐                       │
│ Check Continue  │                       │
│ - tool-calls?   │───── continue ───────▶│
│ - end_turn?     │                       │
│ - stop?         │                       │
└────────┬────────┘
         │ stop
         ▼
┌─────────────────┐
│ Return Final    │
│ Assistant Msg   │
└─────────────────┘
```

---

이 문서는 OpenCode Agent 시스템의 전체 아키텍처를 설명합니다. 각 컴포넌트의 상세 구현은 해당 소스 파일을 참조하세요.
