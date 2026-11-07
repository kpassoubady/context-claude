# Industry Research: Session 4 — Context Quality and Iteration

**Course:** Context Engineering for Claude Code (4-Hour AM/PM)
**Day / Session:** Day 1, Session 4 (`04-context-quality-and-iteration`)
**Scheduled Duration:** 25 minutes (Concept & Demo)
**Reviewed Against Documentation:** 2026-11-06

---

## 1. Scope & Alignment with Course Outline

- **Core Thesis:** Context changes (`CLAUDE.md` edits, new `.claude/rules/`, compaction strategies, tool output filters) should be evaluated with the same rigor as code changes using a **repeatable before-and-after methodology**.
- **Five Common Context Hazards:**
  1. **Verbose Tool Results:** Unbounded test logs, full-file dumps, or un-ignored generated directories filling the context window.
  2. **Stale Assumptions:** Outdated documentation, old migration notes in `CLAUDE.md`, or unverified claims carried over from earlier turns.
  3. **Redundant Rules:** Repeating the same instructions across root `CLAUDE.md`, `.claude/rules/`, and prompt templates—or over-specifying generic advice ("write clean code") that dilutes critical project-specific invariants.
  4. **Context Dilution:** Mixing rules and files from unrelated modules so the model's attention is split across irrelevant constraints.
  5. **Conflicting Instructions:** Root `CLAUDE.md` saying one thing (e.g., "use `requests` and `unittest`") while a path-scoped rule or module README says another ("use `httpx` and `pytest`").
- **Evidence-Based Evaluation Hierarchy:**
  - **Primary Quality Checks (Must Pass First):**
    1. **Task Correctness:** Do unit, integration, and acceptance tests pass? Does the implementation solve the problem without regressions?
    2. **Instruction Adherence:** Did the solution obey architectural invariants, naming conventions, error handling rules, and security boundaries?
  - **Supporting Efficiency Measures (Secondary):**
    3. **Context & Usage Cost (`/context`, `/cost`):** Active context window utilization, total input/output tokens, and cache efficiency.
    4. **Turn Count / Tool-Call Loops:** Number of agent turns and redundant tool invocations required to reach a verified solution.
- **Critical Currency Guardrail:** Explicitly teach why **fewer tokens or fewer turns alone do not prove a result is better**. A 1-turn edit that consumes 60% fewer tokens by skipping tests or ignoring an edge-case rule is a worse outcome, not an optimization.

---

## 2. Latest Technical Mechanics & Diagnostic Tooling

### Native Claude Code Telemetry Commands
- **`/context`:** Displays a visual breakdown of the current context window capacity (e.g., 200K tokens), categorizing usage across System Prompt, Memory files (`CLAUDE.md`, `.claude/rules/`, `MEMORY.md`), MCP tools, Skills, and Messages/Tool results. Ideal for diagnosing baseline startup bloat vs. mid-session tool bloat.
- **`/cost`:** Inspect whatever session usage/cost information the classroom CLI and account expose; availability and billing interpretation vary. Record unavailable values as `N/A`, not zero.
- **`/usage`:** Inspect plan usage or rate-limit information where supported. Do not treat it as interchangeable with per-session token accounting or an exact dollar-cost report.
- **Controlled Before/After Evaluation Protocol:**
  To evaluate whether a context change actually improved performance:
  1. **Pin the Baseline Task & Starting Commit:** Use an identical git commit and task prompt for both runs.
  2. **Define Objective Acceptance Criteria:** Automated test suite pass rate + an explicit checklist of non-inferable project rules (e.g., structured audit logging, specific exception subclass, zero forbidden imports).
  3. **Record Both Quality and Cost Metrics:**
     - `Task Pass (Tests)`: Pass / Fail (and count)
     - `Instruction Adherence`: `X / Y` mandatory project rules followed
     - `Observed Context (/context)`: Values captured at defined checkpoints; do not call a few snapshots a true peak
     - `Total Cost (/cost)` & `Turns`: Supporting efficiency indicators
  4. **Apply the Decision Rule:** Require all mandatory acceptance, instruction, and safety gates to pass before comparing efficiency. Being no worse than a failing baseline is insufficient.

---

## 3. Illustrative Industry Scenarios

These scenarios and all numerical outcomes are synthetic teaching fixtures, not measured customer benchmarks or evidence of regulatory compliance.

### Case Study 1: Enterprise Platform Team — Resolving Conflicting & Redundant Rules
- **Scenario:** A platform engineering team noticed Claude Code intermittently writing synchronous `requests.post()` calls inside an async FastAPI microservice, despite a rule in `CLAUDE.md` stating *"Use async httpx for all outbound HTTP calls."*
- **Context Hazard Audit:**
  - Root `CLAUDE.md` was 410 lines long and contained an older "Legacy Services" section at line 290 that showed a synchronous `requests.Session()` snippet as the "standard HTTP retry template."
  - In addition, an un-scoped `.claude/rules/http-client.md` repeated 80 lines of generic REST principles without specifying `httpx.AsyncClient`.
- **Iteration & Illustrative Outcome:**
  - Removed the conflicting `requests` snippet from root `CLAUDE.md`, deleted the redundant generic REST prose, and added a 15-line path-scoped rule `.claude/rules/fastapi-async.md` (`paths: ["services/api/**/*.py"]`) requiring `httpx.AsyncClient`.
  - Across 5 benchmark tasks on the API service:
    - Acceptance tests: `3/5 -> 5/5` passing on first run.
    - Instruction adherence (`httpx.AsyncClient` + timeout config): `60% -> 100%`.
    - Baseline startup context (`/context`): Reduced by `3,400 tokens` per session.

### Case Study 2: The "False Economy" Trap (Token Reduction That Broke Compliance)
- **Scenario:** A team aggressively trimmed their `CLAUDE.md` down to 5 lines ("Run `npm test`") and told developers to prompt *"Fix in 1 turn without reading extra files"* to cut token spend.
- **Illustrative Result:** The fixture assumes token usage drops by 55% and turns fall from 6 to 2 while CI regressions increase after tenant-isolation checks are omitted. Use this to discuss a false optimization, not as empirical proof of a causal effect.

---

## 4. Demo Practicality Evaluation

### Demos for Session 4 (`day1/demos/`)
1. **`01_context_hazard_linter.py`:** A runnable diagnostic script that audits a sample repository's context configuration (`CLAUDE.md`, `.claude/rules/*.md`, and sample tool outputs) to automatically detect and report the 5 classic hazards: (1) oversized root `CLAUDE.md`, (2) conflicting directives across rule files (`unittest` vs `pytest`, `float` vs `Decimal`), (3) stale file path references that no longer exist on disk, (4) un-scoped component rules missing `paths:` frontmatter, and (5) verbose tool output hotspots.
2. **`02_context_ab_evaluator.py`:** Proposed scorecard walkthrough comparing three context variants on the same task. The following outcomes are synthetic fixture values, not runtime measurements:
   - **Variant A (Bloated & Conflicting Baseline):** High tokens, 6 turns, fails instruction adherence due to conflicting rules.
   - **Variant B (Over-Trimmed "Token Miser"):** Lowest tokens and 2 turns, *but* fails acceptance tests and security rules (illustrating why token savings alone do not prove quality).
   - **Variant C (Engineered Context):** Passes 100% of acceptance tests and instruction adherence checks while reducing peak context by 48% and turns from 6 to 3.

### Evaluator Addendum: Framework-Aligned Quality Gates

Evaluator review: 2026-11-06, local-document review; added reference links are not live-validated.

| Framework | Evaluation requirement | Concrete classroom evidence |
| --- | --- | --- |
| NIST AI RMF 1.0 | Measure against defined risks and intended use; manage failures before optimizing cost. | A fixed task, acceptance rubric, known limitations, and a retained result record. |
| NIST SSDF (SP 800-218) | Verify generated changes through the existing secure development process. | Unit/regression tests, diff review, and project-specific invariant checks; no change merges solely because a model reports success. |
| OWASP LLM01 Prompt Injection; LLM05 Improper Output Handling; LLM06 Excessive Agency (2025) | Include hostile-source, unsafe-output, and unauthorized-action cases alongside happy paths. | One inert injected-comment fixture, one boundary test, and review of any generated shell/SQL rather than automatic execution. Never use real secrets or destructive payloads. |

Apply these as selected risk/verification practices, not as a claim that a four-hour course implements or certifies any framework. Security gates remain mandatory even if an optimization improves the average pass rate.

### Evaluator Addendum: Reproducible Evidence, Not Scripted Wins

- **Artifact status:** The two proposed Python demos are not implemented. Precomputed A/B/C values, including the 48% reduction, must be labeled `synthetic`; they do not show that Claude produced those outcomes. A live run or captured run needs its actual prompt, outputs, model/CLI metadata, and test results.
- **Control the comparison:** Prepare two independent copies from the same starter revision, differing only in the intended context treatment. Keep task prompt, available tools, permissions, user/project guidance, memory policy, model, and test commands constant. Start fresh sessions and record cache state, run order, and any uncontrolled differences. Do not reset a participant's dirty checkout.
- **Repeat outside class:** A single pair is an illustration, not a statistically reliable performance claim. For instructor validation, repeat a small fixed task suite across fresh sessions, alternate run order, and report failures and spread as well as central values. Do not compare a cached run against a cold run without noting that difference.
- **Separate metrics:** `/context` describes a working-window snapshot; cumulative billed usage includes repeated inputs, outputs, caching, and possibly delegated work. Record wall time, human interventions, and subagent usage where available. Do not derive dollars from character counts or infer total savings from a smaller parent context.
- **Respect linter limits:** Static checks can find missing paths, explicit contradictory fixture phrases, or unscoped files. They cannot generally prove semantic consistency, correct rule activation, or safe agent behavior; retain human review and runtime evidence.

Use this minimum scorecard for captured or live comparisons:

| Field | Recording rule |
| --- | --- |
| Provenance | Task ID, starter revision, context-treatment diff, prompt, model/CLI, account mode, and memory/tool settings. |
| Task quality | Test command, exit status, passing/total tests, and observed regressions. |
| Required adherence | Each required invariant with its check and pass/fail evidence; do not hide a failed security gate in an average. |
| Safety | Unauthorized-action and injected-source handling results; `not tested` where evidence is absent. |
| Efficiency | Context at named checkpoints, available usage/cache figures, elapsed time, turns, and human interventions; `N/A` for unavailable metrics. |
| Evidence type and verdict | `live`, `captured`, or `synthetic`; accept only when all required gates pass, then compare efficiency. |

### Evaluator Addendum: Fit the Existing 25-Minute Block

This is a concept/demo block, not a third breakout lab. Prepare captured results and runnable local acceptance checks before class. Use 0-5 minutes to identify hazards, 5-13 to inspect A/B/C evidence and run one focused test, 13-20 to fill the scorecard and reject the over-trimmed variant, and 20-25 to discuss limitations and enterprise ownership. Do not build a generic semantic linter, telemetry collector, benchmark harness, or dashboard live.

### Evaluator Addendum: Enterprise Evaluation and Observability

Version project guidance alongside application code. Run invariant/regression checks in CI, protect the merge path, and require owner review for changes to hooks, Skills, tools, or external-data connectors. Platform teams can aggregate model usage and audit metadata through approved telemetry paths; avoid exporting full prompts, source, customer data, or secrets by default. Define retention and access controls before collecting transcripts.

Separate application correctness from gateway-enforced quotas, rate limits, approved endpoint routing, and egress policy. A gateway can bound configured access or spend but cannot establish instruction adherence or replace task tests. Roll back a failing context/configuration change through a reviewed revision, not by dropping the failed acceptance criterion.

---

## 5. Sources & References

- [Claude Code Documentation: Explore the context window (`/context`)](https://code.claude.com/docs/en/context-window)
- [Claude Code Documentation: Manage costs effectively (`/cost`)](https://code.claude.com/docs/en/costs)
- [Claude Code Documentation: Best practices](https://code.claude.com/docs/en/best-practices)
- [Anthropic Engineering: Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [NIST: AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework)
- [NIST: Secure Software Development Framework](https://csrc.nist.gov/projects/ssdf)
- [OWASP: Top 10 for Large Language Model Applications](https://genai.owasp.org/llm-top-10/)
