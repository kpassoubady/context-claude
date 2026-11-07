# Industry Research: Session 1 — From Prompt Engineering to Context Engineering

**Course:** Context Engineering for Claude Code (4-Hour AM/PM)
**Day / Session:** Day 1, Session 1 (`01-from-prompt-engineering-to-context-engineering`)
**Scheduled Duration:** 30 minutes (Concept & Demo)
**Reviewed Against Documentation:** 2026-11-06

---

## 1. Scope & Alignment with Course Outline

- **Core Thesis:** Context engineering extends—rather than replaces—prompt design across the entire information environment available to an agentic coding assistant (system instructions, project files, tool definitions, tool results, memory, and conversation history).
- **Agentic Loop Dynamics:** Unlike single-turn chat completions, Claude Code operates in an iterative loop (`gather context -> take action -> verify results`). Every file read, grep search, test execution, and compiler trace appends tokens to the active working context.
- **Context Rot & Recall Nuance:** As the active context window fills with noisy, irrelevant, or repetitive outputs, model attention is diluted ("context rot"), which can degrade recall of earlier constraints, instruction adherence, and reasoning focus. **Critical currency guardrail:** Do not claim that larger context *inevitably* or *uniquely* causes hallucinations; frame it accurately as reduced recall, diluted focus, and higher latency/token cost when signal-to-noise drops.

---

## 2. Latest Technical Mechanics & Industry Frameworks

### Anthropic's "Effective Context Engineering for AI Agents" Framework
- **The Attention Budget:** Low-signal context can compete with task-relevant instructions and evidence. Dense self-attention has quadratic pairwise interactions in the textbook formulation, but this is not evidence of Claude's internal architecture, runtime cost, or a particular context limit. Record the model and available window used for delivery instead of pinning this concept to named model releases.
- **Smallest High-Signal Token Set:** The goal of context engineering is not zero tokens—it is curating the smallest set of high-signal tokens that fully specifies the task, architectural invariants, and verification criteria.
- **Prompt Design vs. Context Engineering:**

  | Dimension | Prompt Engineering | Context Engineering |
  | :--- | :--- | :--- |
  | **Scope** | Single-turn or static system + user prompt wording | Full runtime state across multi-turn agent loops |
  | **Primary Inputs** | Task phrasing, few-shot examples, formatting directives | `CLAUDE.md`, `.claude/rules/`, retrieved files, tool schemas, tool outputs, memory, compaction state |
  | **Failure Mode** | Ambiguous phrasing or missing task specification | Context bloat, noisy tool outputs, stale assumptions, competing rules |
  | **Optimization Unit** | Words and clauses in a prompt | What enters, stays in, or leaves the context window at each turn |

### Tool Output Bloat in Agentic Coding
- In real-world Claude Code usage, **unfiltered tool results** (e.g., dumping an entire `package-lock.json`, printing 5,000 lines of debug test logs, or reading unmined directory trees) account for the fastest spikes in context growth.
- Large volumes of unrelated traces may make project conventions harder to follow; neither a particular token count nor distance from an instruction establishes a universal failure threshold. Measure adherence on the actual task rather than treating the example as a benchmark.

---

## 3. Illustrative Industry Scenarios

These are constructed teaching scenarios, not sourced customer case studies. All counts, token totals, and outcomes below are illustrative; do not present them as measured industry results.

### Case Study 1: FinTech Payment Gateway Service (High-Noise vs. Focused Context)
- **Scenario:** A backend engineering team working on a multi-service payment reconciliation repo asked their coding agent to fix a currency rounding bug in the settlement module.
- **Anti-Pattern (Context Stuffing):** Developers piped full verbose test suite logs (`pytest -vv --tb=long` across 400 tests), dumped three entire service directories into context, and pasted a 300-line legacy wiki page into the prompt. The context window jumped to 95K tokens in two turns. The agent fixed the arithmetic bug but violated the repository's idempotency key requirement and used deprecated float serialization that had been warned against in the project rules.
- **Engineered Context Pattern:** The developer pointed Claude Code to the specific failing test (`pytest tests/settlement/test_rounding.py -q`), allowed targeted retrieval of `src/settlement/currency.py`, and relied on a concise 40-line `CLAUDE.md` specifying `Decimal` quantization and idempotency invariants. Context stayed under 8K tokens, and all architectural constraints were respected on the first pass.

### Case Study 2: SaaS Telemetry Ingestion Pipeline (Iterative Loop Pollution)
- **Scenario:** During a 15-turn debugging loop on an event ingestion worker, five failed hypotheses left behind thousands of lines of `grep` matches across `node_modules/` and build artifacts (`dist/`).
- **Impact:** Subsequent edits started referencing compiled `.d.ts` definitions in `dist/` instead of source files in `src/`, illustrating how stale or un-excluded tool outputs pollute downstream reasoning.

---

## 4. Demo & Classroom Practicality Evaluation

- **Demo 1 (Offline / Deterministic Simulator — Python):**
  - Build a self-contained, zero-API-key Python script (`day1/demos/01_noisy_vs_focused_context.py`) that inspects a realistic agent transcript / context payload for a payment settlement bug fix.
  - It compares two context snapshots side-by-side:
    1. **Noisy Context Snapshot:** Verbose test runner dump, un-ignored build artifacts, sprawling prompt instructions, and unfocused file reads — calculating token footprint, signal-to-noise ratio, and constraint distance (how many thousands of tokens separate the active edit from the architectural constraints).
    2. **Engineered Context Snapshot:** Scoped `CLAUDE.md`, targeted file slice, concise test failure output — showing the high-signal token distribution and verification checklist.
- **Demo 2 (Claude Code Prompt & Context Inspection Walkthrough — Python / CLI):**
  - A runnable script (`day1/demos/02_agent_loop_context_growth.py`) modeling multi-turn agentic loop accumulation across 6 turns (`Read`, `Grep`, `Bash`, `Edit`) and demonstrating how unfiltered tool outputs compound across turns versus bounded tool queries (`--max-count`, targeted paths, `-q` test flags).
- **Classroom Timing Fit:** Proposed scripts have not been implemented or timed. A short runtime would not include explanation, prediction, or discussion; use the delivery budget below.

### Evaluator Addendum: Industry Frameworks and Trust Boundaries

Evaluator review: 2026-11-06, based on local research and outlines. Added reference links are not live-validated in this pass.

| Framework | Relevant principle | Specific teaching application |
| --- | --- | --- |
| OWASP Top 10 for LLM Applications 2025 | LLM01 Prompt Injection; LLM02 Sensitive Information Disclosure | A retrieved README, issue comment, or test log is evidence, not authority to change the task or reveal secrets. Use synthetic payment records and redact identifiers before tool output enters model context. |
| NIST AI Risk Management Framework (AI RMF 1.0) | Govern, Map, Measure, Manage | Identify the task owner and unacceptable outcomes, map the context sources, measure tests and adherence, then retain or revise the context strategy. This is a governance mapping, not a compliance certification. |

Do not add unrelated CNCF, Twelve-Factor App, or API-security implementation requirements merely to name frameworks. This block teaches context selection, not deployment or authentication engineering.

### Evaluator Addendum: Deliverable and Demo Boundaries

- **Artifact status:** The proposed `day1/demos/*.py` files are design recommendations, not existing runnable demos. No demo implementation was found in the primary repository during this review.
- **Authentic tool evidence:** Make the primary demonstration an actual Claude Code session on a tiny fixture: inspect `/context`, retrieve one relevant source file, and run one focused acceptance test. Use a captured instructor transcript if authentication, connectivity, or quota prevents the live run; do not require new accounts during class.
- **Offline fallback:** Label Python output as an illustrative context-payload analysis, not a reproduction of Claude's attention, rule loading, or decision-making. If no model tokenizer is available, report bytes/lines or explicitly estimated tokens. Manually labeled signal-to-noise and constraint distance are explanatory proxies, not validated predictors of correctness.
- **Bounded output:** Show the failing assertion and exit status with a concise test command. Keep the complete sanitized log as a local artifact for follow-up; truncation must not discard the only useful failure evidence.

| Minutes | Activity |
| --- | --- |
| 0-10 | Explain prompt design, the agent loop, and task-relevant context. |
| 10-18 | Predict and inspect the noisy/focused fixture with one real tool interaction. |
| 18-25 | Compare acceptance-test and instruction-adherence evidence; discuss the trust boundary. |
| 25-30 | Debrief limits and transition to context configuration. |

### Evaluator Addendum: Local Context to Enterprise Architecture

In an enterprise, the context path is `approved source -> access-controlled retrieval/tool -> minimized result -> model context -> proposed change -> CI and human review`. Source authorization belongs in the repository/document service and tool credentials; model-facing prose cannot grant or revoke access. A `.gitignore` or focused search reduces noise but is not a confidentiality boundary.

Central platform controls may manage approved model endpoints, egress, retention, and usage budgets. Application owners still define invariants and tests; repository protections and CI gate changes. A model gateway can enforce configured quotas or routing, but it does not automatically manage Claude Code's local context or prove an edit correct. Never send production payment data or real credentials to the classroom model account.

---

## 5. Sources & References

- [Anthropic Engineering: Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Anthropic Engineering: Writing effective tools for agents](https://www.anthropic.com/engineering/writing-tools-for-agents)
- [Claude Code Documentation: Explore the context window](https://code.claude.com/docs/en/context-window)
- [Claude Code Documentation: How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works)
- [OWASP: Top 10 for Large Language Model Applications](https://genai.owasp.org/llm-top-10/)
- [NIST: AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework)
