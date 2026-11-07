# Industry Research: Session 3 — Maintaining Coherence Across Long Tasks

**Course:** Context Engineering for Claude Code (4-Hour AM/PM)
**Day / Session:** Day 1, Session 3 (`03-maintaining-coherence-across-long-tasks`)
**Scheduled Duration:** 30 minutes (Concept & Demo) + 25 minutes (Breakout Lab 3.1)
**Reviewed Against Documentation:** 2026-11-06

---

## 1. Scope & Alignment with Course Outline

- **Extended Workflow Challenge:** Multi-step debugging, cross-module refactoring, and feature implementation quickly accumulate investigation dead ends, verbose tool logs, and intermediate diffs.
- **Compaction Mechanics & Honest Limits:**
  - Claude Code performs **automatic compaction** when approaching the context limit and supports on-demand **focused compaction** via `/compact [focus instructions]`.
  - **Critical currency guardrail:** Compaction is **lossy summarization** of conversation history. While root `CLAUDE.md` and Auto Memory are re-injected/reloaded, specific file line numbers, subtle error codes, rejected edge cases, or exact test outputs from earlier turns **can be lost** in a summary. Never teach compaction as a lossless state prune; teach students to inspect the summary, re-read critical files, and re-run tests.
- **Durable Task Notes & Fresh-Session Handoffs:**
  - Writing a structured handoff file (e.g., `HANDOFF.md` or `llm-context/handoff.md`) capturing the **Goal, Current State, Constraints, Relevant Files, Failed Approaches (and why they failed), and Next Verification Steps**, followed by `/clear` (or a fresh session), gives clean context control without relying solely on an opaque summary.
- **Subagents for Isolated Exploration:**
  - Subagents run in their own isolated context windows. Heavy directory scans, log scraping, or dependency audits happen inside the subagent's window, returning only a synthesized finding to the parent session. Subagents are **isolated workers**, not automatic persistent memory.
- **Direct Project-File Retrieval vs. RAG:**
  - Distinguish Claude Code's built-in just-in-time file retrieval (`Glob`, `Grep`, `Read` over local repository files) from **Retrieval-Augmented Generation (RAG)** (vector/hybrid search over large external corpora like multi-repo enterprise documentation, RFC archives, or support tickets exposed via MCP).

---

## 2. Latest Technical Mechanics & Industry Frameworks

### Anthropic's "Harness Design for Long-Running Application Development"
- **Why Single-Session Loops Degrade Over Time:**
  - Exploratory debugging can leave history dominated by *what did not work*. There is no established 30-50-call failure threshold; the amount and relevance of tool output matter. Even after `/compact`, summaries may omit critical nuances such as the exact deadlock error code.
- **Complementary State-Preservation Strategies:**

  | Strategy | How It Works in Claude Code | Strengths | Limitations / Risks |
  | :--- | :--- | :--- | :--- |
  | **Automatic Compaction** | Runs as available context becomes constrained; the threshold depends on the CLI/model/configuration | Helps manage context capacity without a manual request | Not a guarantee against every overflow or service failure; summaries may drop error strings, line numbers, or negative constraints |
  | **Focused `/compact <focus>`** | User specifies what the summary must prioritize (e.g., `/compact focus on failing auth tests and rejected token-cache fix`) | Guides the summarizer toward task-relevant state | Still a natural-language summary; requires post-compaction verification against disk and tests |
  | **Durable Handoff + `/clear`** | Write structured `HANDOFF.md` on disk, run `/clear`, start fresh reading `CLAUDE.md` + `HANDOFF.md` | Explicit, auditable, git-diffable artifact; resets history bloat completely | Requires discipline to verify that `HANDOFF.md` matches actual working tree (`git status`, `pytest`) |
  | **Isolated Subagent** | Delegate broad search or verification to a subagent | Keeps intermediate exploration out of the parent conversation; findings still consume parent context | Additional model work has its own cost; context isolation does not imply filesystem, credential, or security isolation |

### Direct File Search (`Glob`/`Grep`) vs. External RAG
- **When Direct File Search Wins (Local Repo):** Source code is structured, exact symbols matter (`def calculate_retry_backoff`), and files change minute-by-minute in the working tree. `Glob` + `Grep` + `Read` require zero indexing lag and return exact current code.
- **When External Retrieval May Help:** Large external incident, specification, or ADR collections may benefit from semantic/hybrid retrieval. RAG is not necessarily vector-based, and MCP is an optional integration interface, not a required retrieval engine. Compare against ordinary authorized search before adding an index.

---

## 3. Illustrative Industry Scenario

The queue-debugging story and its counts are constructed classroom material, not a sourced incident report.

### Case Study: Distributed Job Queue Retry Bug (Multi-Hour Debugging Session)
- **Scenario:** An engineer used Claude Code for 45 turns to debug a duplicate-job execution bug in a task queue worker (`worker/dispatcher.py` and `worker/lease_manager.py`).
- **What Went Wrong with Unverified Compaction:** Two hypotheses were already tested and disproved (increasing lease TTL broke heartbeat tests; adding a global lock broke concurrency). When auto-compaction fired, the summary noted *"investigated lease TTL and locking in lease_manager.py"* without recording that global locking failed the concurrency SLA test. Ten minutes later, the agent re-proposed the exact same global lock fix.
- **Remediation via Focused Compaction + Verified Handoff:**
  1. Used `/compact preserve the root cause in worker/lease_manager.py, the two rejected fixes (TTL bump and global lock), and the failing test test_concurrent_lease_renewal`.
  2. Wrote a structured `HANDOFF.md` explicitly listing **Failed Approaches** and **Verification Commands**.
  3. Resumed in a fresh session that first ran `git diff` and `pytest` to validate the handoff state against reality—catching one stale claim in the notes before implementing the atomic compare-and-swap lease fix.

---

## 4. Demo & Breakout Lab 3.1 Practicality Evaluation

### Demos for Session 3 (`day1/demos/`)
1. **`01_compaction_and_handoff_verifier.py`:** Compares an unfocused auto-compaction summary, a focused `/compact` summary, and a structured `HANDOFF.md` against the actual repository state (`git status` + test suite results), demonstrating how unverified summaries can drop negative constraints (rejected approaches) and how a verification script detects drift between a handoff note and the working tree.
2. **`02_subagent_isolation_vs_inline_search.py`:** Simulates an exploratory root-cause search across a 12-module repository—comparing inline `Grep`/`Read` in the main session (polluting parent context with 18K tokens of intermediate file reads) versus delegating to an isolated subagent that returns a 350-token structured finding, plus a clear decision matrix for Local File Search vs. External RAG.

### Breakout Lab 3.1 (`day1/lab3_1_context_compaction_and_handoffs/` in Companion Repo)
- **25-Minute Classroom Feasibility:** Conditional on supplied state, a bounded summary audit, and a very small code fix. No lab artifacts currently exist in the companion repository; the following files and verification scripts are proposed deliverables.
  - A long investigation transcript (`session_history/debugging_transcript.md`) with 30+ turns of noisy logs, two failed fix attempts, and a partially diagnosed bug in `task_queue/lease.py`.
  - An auto-generated compaction summary (`session_history/auto_compact_summary.md`) that subtly omitted one constraint and misstated the status of a modified helper file.
  - Partially modified working code and a failing test suite (`tests/test_lease.py`).
- **Student Tasks:**
  1. Formulate a focused `/compact` directive and audit the existing `auto_compact_summary.md` against the actual repository files and test output to identify what was lost or misstated.
  2. Author a complete, durable `HANDOFF.md` containing all required sections: **Goal**, **Current State**, **Constraints**, **Relevant Files**, **Failed Approaches**, and **Next Verification Steps** (plus **Audit Findings** documenting what the raw summary missed).
  3. Resume from `HANDOFF.md` (as a fresh session would), complete the targeted fix in `task_queue/lease.py` without repeating the rejected approaches, and pass `pytest` + `python3 verify_lab.py`.

### Evaluator Addendum: Frameworks for State and Retrieved Knowledge

Evaluator review: 2026-11-06, local-document review; added reference links are not live-validated.

| Framework | Specific implication for this session |
| --- | --- |
| NIST AI RMF 1.0 | Treat a handoff as an assertion set with provenance: author, timestamp, repository revision, dirty-file state, commands executed, results, and unresolved uncertainties. Verify assertions before resuming work. |
| OWASP LLM01 Prompt Injection and LLM02 Sensitive Information Disclosure (2025) | Summaries and memory can preserve malicious instructions or sensitive data across sessions. Preserve factual evidence without promoting quoted source instructions into trusted guidance; keep credentials and customer data out of handoffs. |
| OWASP LLM08 Vector and Embedding Weaknesses (2025) | For an indexed external corpus, enforce source/tenant authorization during retrieval and address stale or poisoned documents. Relevance ranking is not an authorization check. |

### Evaluator Addendum: A Bounded Compaction and Handoff Lab

- **Prepare an independent snapshot:** Use proposed companion paths `labs/day1/lab3_1/start/` and `solution/`. Supply a short indexed transcript excerpt, a deliberately flawed summary labeled as a fixture, a handoff skeleton, and tests that fail on one stale-state claim and one rejected approach. Keep the longer transcript available as reference rather than required reading.
- **Do not manufacture a long session:** Pasting a transcript does not restore Claude's original conversation/tool state. Have learners load the short task brief and inspect critical files in a real session, then issue a focused `/compact`. Compare available post-compaction state to disk; do not wait for an automatic threshold or promise an inspectable full internal summary.
- **Bound the debugging:** Supply the root-cause explanation and candidate patch; learners verify or apply a tiny lease-condition correction. Implementing a distributed lock, queue broker, database CAS protocol, or concurrency benchmark from scratch is out of scope. The learning objective is verified continuity, not distributed-systems design.
- **Minimum handoff evidence:** Include goal, state, constraints, files, failed approaches with failure evidence, next checks, timestamp, commit, changed paths, and last test command/result. Record observed facts separately from hypotheses. Avoid raw logs and secrets.

| Minutes | Required activity |
| --- | --- |
| 0-4 | Inspect revision/working-tree state and run the focused failing test. |
| 4-9 | Audit the supplied flawed summary against files and test evidence; try focused `/compact`. |
| 9-15 | Complete the handoff skeleton, including the stale claim and rejected approach. |
| 15-22 | Open a fresh session, read the handoff, re-check disk, and verify/apply the candidate fix. |
| 22-25 | Run focused tests and the handoff check; record missing or corrected state. |

If live compaction is unavailable, compare the clearly labeled captured summaries and still perform the disk/test audit; record that compaction was not observed live. If coding runs long, provide the patch at minute 18 and retain fresh-session verification. The static checker validates sections and known fixture facts, not the general truth of arbitrary prose.

Subagent and RAG demonstrations stay within the existing 30-minute concept block. An offline subagent simulator illustrates information flow only; it cannot establish actual token savings or isolation. A genuine subagent demonstration must return paths, findings, and verification limits, and distinguish parent-context reduction from total model usage. Do not install a vector database, build embeddings, or configure a production connector in either lab.

### Evaluator Addendum: Enterprise Resumption and Retrieval

Production work state belongs in version control, review systems, issue tracking, and an access-controlled artifact store, not solely in a personal auto-memory file. A resumed worker should re-check repository revision, uncommitted changes, test results, and current permissions. A handoff is not an executable checkpoint, and a summary cannot restore expired credentials or transaction state. Do not clear participants' files or reset their working trees to make the exercise match its notes.

For external knowledge, use `authenticated caller -> ACL/tenant-filtered retrieval service -> source/version-tagged excerpts -> model -> verified proposal`. Enforce access before document content enters model context, propagate identity through connectors, expire stale indexed material, and treat retrieved instructions as untrusted. MCP exposes tools/resources but does not by itself provide corpus authorization, freshness, or injection protection.

Subagent context separation is not a sandbox: workers may share a filesystem and available credentials. Partition writable work, minimize tool grants, and independently verify returned findings. Use isolated execution environments and protected review/CI gates when actions require a stronger security boundary.

---

## 5. Sources & References

- [Anthropic Engineering: Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [Anthropic Engineering: Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Claude Code Documentation: Explore the context window (`/compact`, `/clear`, subagents)](https://code.claude.com/docs/en/context-window)
- [Claude Code Documentation: Best practices for long sessions](https://code.claude.com/docs/en/best-practices)
- [Claude Code Documentation: Create custom subagents](https://code.claude.com/docs/en/sub-agents)
- [NIST: AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework)
- [OWASP: Top 10 for Large Language Model Applications](https://genai.owasp.org/llm-top-10/)
