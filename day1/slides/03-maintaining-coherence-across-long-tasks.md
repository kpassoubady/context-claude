---
marp: true
theme: default
style: '@import url("https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/blue-theme.css");'
paginate: true
header: 'Context Engineering for Claude Code'
footer: 'Day 1 - Session 3: Maintaining Coherence Across Long Tasks'
---

<style>
.gfm-alert { border-left: .3em solid var(--a-c); background: var(--a-bg); border-radius: 4px; padding: .4em 1em; margin: .6em 0; font-size: .9em; }
.gfm-alert-title { color: var(--a-c); font-weight: 700; text-transform: uppercase; letter-spacing: .03em; font-size: .78em; margin: 0 0 .25em; }
.gfm-alert p:last-child { margin: 0; }
.gfm-note { --a-c: #1a73e8; --a-bg: #e3f2fd; }
.gfm-tip { --a-c: #2e7d32; --a-bg: #e8f5e9; }
.gfm-important { --a-c: #7b1fa2; --a-bg: #f3e5f5; }
.gfm-warning { --a-c: #e65100; --a-bg: #fff3e0; }
.gfm-caution { --a-c: #c62828; --a-bg: #fce4ec; }
.industry-badge {
  border-left: 0.25em solid #e65100;
  background: #fff3e0;
  padding: 0.3em 0.8em;
  font-size: 0.78em;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: #e65100;
  margin-bottom: 0.5em;
  display: inline-block;
  border-radius: 0 4px 4px 0;
}
.trick-badge { border-left: 0.25em solid #7b1fa2; background: #f3e5f5; padding: 0.3em 0.8em; font-size: 0.78em; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: #7b1fa2; margin-bottom: 0.5em; display: inline-block; border-radius: 0 4px 4px 0; }
.skip-badge { border-left: 0.25em solid #c62828; background: #fce4ec; padding: 0.3em 0.8em; font-size: 0.78em; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: #c62828; margin-bottom: 0.5em; display: inline-block; border-radius: 0 4px 4px 0; }
.reference-badge { border-left: 0.25em solid #1a73e8; background: #e3f2fd; padding: 0.3em 0.8em; font-size: 0.78em; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: #1a73e8; margin-bottom: 0.5em; display: inline-block; border-radius: 0 4px 4px 0; }
</style>

<!-- _class: lead -->
<!-- _paginate: false -->

# Context Engineering
## Maintaining Coherence Across Long Tasks

**Day 1 - Session 3**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

<!--
What to say: Welcome to Session 3. In this block, we tackle the hardest engineering problem in agentic workflows: keeping an agent coherent across long, complex tasks. We will look at what happens when context fills up, how compaction actually works, how to write durable handoffs, and when to delegate work to isolated subagents.

Transition: Let us preview what we will explore over the next hour.
-->

---

# What We'll Cover

1. Automatic versus focused compaction and summary limits
2. Durable task notes (`HANDOFF.md`) and fresh-session handoffs
3. Isolated subagents and direct file search versus RAG (Retrieval-Augmented Generation)
4. Demo: Auditing compaction summaries and handoff state
5. Breakout Lab 3.1: Context Compaction and State Handoffs

<!--
What to say: Here is our roadmap for Session 3. We will examine the strengths and limits of automatic and focused compaction, demonstrate how to author durable handoff notes, and compare local file search with external retrieval. Then we will run two demonstrations and put these patterns into practice in Breakout Lab 3.1.

Teaching focus: Establish Session 3 goals for state preservation and context isolation.
-->

---

<!-- _class: divider -->

# Compaction & Durable Handoffs

## Carrying verified state across long workflows

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

<!--
What to say: Let us begin with compaction and handoffs, the two primary mechanisms for carrying verified state forward as your task grows.
-->

---

# Automatic vs. Focused Compaction

- **Automatic compaction:** Summarizes older turns as the window approaches capacity
- **Focused `/compact`:** Accepts instructions on what state the summary should keep
- **Reloaded context:** Root `CLAUDE.md` and auto memory remain available
- **Lossy nature:** Exact line numbers, error codes, or rejected fixes can drop out

<div class="gfm-alert gfm-warning">
<div class="gfm-alert-title">Warning</div>
<p>Never assume a summary preserved every negative constraint; verify against disk and tests.</p>
</div>

<!--
What to say: Claude Code automatically compacts conversation history when approaching the context limit, and you can also trigger a focused compaction using slash compact with specific instructions. But here is the critical rule: compaction is lossy natural language summarization. It re-injects root CLAUDE dot md and memory, but subtle details like error strings, line numbers, and rejected fix attempts can disappear.

Real-world example: An engineer spent forty-five turns debugging a distributed task queue lease bug. They tested two fixes and proved they failed: increasing lease time broke heartbeats, and adding a global lock killed concurrency. When auto-compaction fired, it summarized that locking was investigated without noting that global locks failed the SLA test. Ten minutes later, the agent re-proposed the exact same broken lock fix.

Teaching focus: Emphasize that compaction is lossy and requires verification against disk and tests.
-->

---

# Durable Handoffs and Fresh Sessions

<div class="trick-badge">TRICK OF THE TRADE</div>

```markdown
# Task Handoff: Worker Lease Renewal
- Revision: commit 8f4a12c (modified: task_queue/lease.py)
- Goal: Prevent duplicate job execution on lease renewal
- Constraints: Keep LeaseManager signature; no external lock service
- Failed Approaches: Global mutex (failed test_concurrent_lease_renewal)
- Next Verification: Run pytest tests/test_lease.py -q
```

> Writing `HANDOFF.md` and running `/clear` resets history bloat while keeping explicit provenance.

<!--
What to say: Here is the professional alternative when an investigation gets messy. Write a structured handoff note directly to disk, capturing the git commit, the goal, active constraints, and explicitly what failed and why. Then run slash clear and start a fresh session reading that note. You completely wipe out forty turns of log bloat while preserving audited state with full provenance.

Go deeper: https://code.claude.com/docs/en/context-window for details on how slash clear and slash compact manage context memory.

Teaching focus: Teach durable handoff notes and slash clear as an explicit state-preservation strategy.
-->

---

# Compaction and Handoff Verification Flow

<img src="../diagrams/compaction-vs-handoff.svg" alt="Flowchart comparing in-session compaction and fresh-session handoffs leading into a mandatory disk and test verification gate" style="display:block; margin:0 auto; max-height:420px;" />

<!--
What to say: Follow the two paths in this diagram. On the left, in-session compaction keeps you in the same conversation, but summary drift can creep in. On the right, writing a handoff and starting fresh eliminates history bloat. Notice where both paths meet: at the mandatory disk and test verification gate. You never resume coding until git status and your test runner confirm reality.

Teaching focus: Reinforce that both compaction and handoffs require immediate verification against repository state.
-->

---

<!-- _class: chat-check -->

# Predict: Compaction Summary Vulnerability

What critical debugging detail is most prone to being lost during automatic compaction?

A) The high-level objective of the multi-turn session
B) The name of the primary programming language used
C) Specific rejected approaches, error traces, and exact modified line numbers
D) The overall pass/fail status of the final test command

> Vote privately in chat. Keep your answer visible while the demo runs.

<!--
What to say: Let us check our intuition. When an LLM summarizes thirty turns of trial-and-error debugging, which detail is most likely to be smoothed over and lost? Vote in chat with A, B, C, or D.

Teaching focus: Highlight why negative constraints and rejected approaches are the most vulnerable details in summarization.
-->

---

<!-- _class: demo -->

# Demo: Compaction and Handoff Verifier

Run `python3 day1/demos/demo-compaction-and-handoff-verifier.py`.

- **Summary audit:** Compare an unfocused summary against actual repo files and tests
- **Dropped constraints:** Spot where a rejected fix was omitted from the summary
- **Drift detection:** Catch a stale file-state claim before editing code
- **Verified handoff:** Confirm `HANDOFF.md` aligns with `git status` and `pytest`

> Demonstrates why post-compaction and fresh-session work must re-verify repository state.

<!--
What to say: In your terminal, run python3 day1 slash demos slash demo-compaction-and-handoff-verifier dot py. [point at the output] Watch how the automated summary omitted a rejected lock approach and falsely claimed a helper file was modified, whereas our verification script immediately caught the drift before any code was edited.

Teaching focus: Demonstrate automated detection of drift between compaction summaries, handoffs, and actual disk state.
-->

---

<!-- _class: chat-check-answer -->

# Explain: Information Loss in Summarization

**C:** Specific rejected approaches, error traces, and line numbers.

- Automatic summaries collapse history into high-level milestones, often omitting why a previous fix failed.
- A fresh session reading an unfocused summary may re-attempt the same flawed fix unless captured in `HANDOFF.md`.

<!--
What to say: The correct answer is C. Summarizers naturally compress history toward high-level milestones like investigated lease manager. They frequently drop why a specific approach was discarded. That is why capturing negative constraints in a handoff note is what prevents an agent from running in circles.

Transition: Now let us look at how subagents let us explore massive codebases without polluting our primary context.
-->

---

<!-- _class: divider -->

# Subagents & Retrieval Patterns

## Isolating exploration and choosing retrieval tools

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

<!--
What to say: In this block, we examine subagents for context isolation and clarify when to use local file search versus external retrieval systems.
-->

---

# Isolated Subagents for Exploration

- **Separate window:** Intermediate `Grep` and `Read` calls stay in the worker context
- **Synthesized return:** Parent session receives only the summarized findings and paths
- **Cost reality:** Total model usage spans both parent and subagent windows
- **Security boundary:** Context isolation is not filesystem or credential isolation

<!--
What to say: When you need to search twelve directories or audit hundreds of dependency files, running grep and read inside your main session will dump thousands of tokens into your window. Subagents solve this by spinning up an independent context window. The subagent reads the files, encounters dead ends, and synthesizes a concise summary that it passes back to the parent session.

Teaching focus: Explain subagents as context-isolated workers that keep exploratory tool noise out of the parent window.
-->

---

# Isolated Subagents (Fintech)

<div class="industry-badge">REAL-WORLD SCENARIO</div>

**Fintech (Robinhood - Multi-Account Audit & Reconciliation):**

- Dispatches subagents to audit hundreds of independent trading ledger logs in isolated windows, filtering millions of audit events down to mismatched balances.
- The parent orchestrator stays clean and responsive, receiving only flagged discrepancy IDs without context bloat from raw transaction streams.

<!--
What to say: Trading platforms like Robinhood process high-volume multi-account ledgers. When an automated reconciliation agent audits transactions, dispatching subagents allows each worker to inspect thousands of raw ledger entries in isolation. The parent orchestrator receives only the flagged discrepancy IDs, keeping its context clean and responsive.

Real-world example: Auditing thousands of raw transaction logs in isolated subagent windows prevents orchestrator context exhaustion while surfacing exact ledger mismatches for remediation.
-->

---

# Isolated Subagents (Media / Entertainment)

<div class="skip-badge">SKIP</div>
<div class="industry-badge">REAL-WORLD SCENARIO</div>

**Media / Entertainment (Disney+ - Content Asset Catalog Ingestion):**

- Delegates deep media tag extraction across video, audio, and subtitle streams to temporary subagents running in isolated context windows.
- The main ingest orchestrator receives only standardized syndication manifests, preventing file schema bloat from exhausting memory during batch imports.

<!--
What to say: This slide is a reference example showing how media catalog ingestion uses temporary subagents to extract deep video and audio metadata tags without exhausting memory in the main syndication pipeline.

Teaching focus: Illustrate subagent batch isolation in media ingestion for offline reference.
-->

---

# Direct File Search vs. External RAG

| Retrieval Need | Local File Search (`Glob`, `Grep`, `Read`) | External RAG (Retrieval-Augmented Generation via MCP / Service) |
| :--- | :--- | :--- |
| **Target source** | Active codebase and working tree | Large external docs, ADRs, or tickets |
| **Freshness** | Immediate; zero indexing lag | Depends on index sync schedule |
| **Precision** | Exact symbol and line matching | Semantic or hybrid chunk retrieval |
| **Access control** | Local repo permissions | Must enforce tenant ACLs before context |

<!--
What to say: A common architectural question is whether you need RAG for your repository. If you are working on your active codebase, direct file search with glob, grep, and read is almost always superior. It has zero indexing lag, matches exact symbols, and reflects your current working tree. You only need external RAG when searching across vast external corpora, like hundreds of company architectural decision records or customer support ticket archives.

Real-world example: Direct file search is like opening the blueprints already sitting on your workbench. RAG is sending an inquiry to the corporate archives across town. Use the workbench when you are modifying the engine.

Go deeper: https://www.anthropic.com/research/effective-context-engineering-for-ai-agents for Anthropic's guidance on local retrieval versus external knowledge bases.
-->

---

# Subagent Isolation and Retrieval Architecture

<img src="../diagrams/subagent-and-retrieval-patterns.svg" alt="Diagram showing parent session delegating heavy exploration to an isolated subagent and comparing local file search with external RAG" style="display:block; margin:0 auto; max-height:420px;" />

<!--
What to say: This architecture diagram connects both concepts. [point at the diagram] On the left, the parent session delegates broad search to an isolated subagent, receiving back a clean summary. On the right, the local repository uses direct grep and read, while external corpora connect through an access-controlled retrieval gateway.

Teaching focus: Connect subagent delegation and retrieval selection into one coherent architectural picture.
-->

---

<!-- _class: demo -->

# Demo: Subagent Isolation vs. Inline Search

Run `python3 day1/demos/demo-subagent-isolation-vs-inline-search.py`.

- **Inline exploration:** Measure parent window growth across twelve module reads
- **Subagent delegation:** Observe how returning a synthesis keeps parent context lean
- **Total usage accounting:** Compare parent window size against combined token work
- **Retrieval selector:** Evaluate when local `Grep` beats an external RAG index

> Illustrates information flow between parent and subagent windows; not a sandbox test.

<!--
What to say: Let us run our second Session 3 demonstration. Run python3 day1 slash demos slash demo-subagent-isolation-vs-inline-search dot py. Watch how inline search fills the parent window with eighteen thousand tokens of file noise, whereas delegating to a subagent returns a concise three-hundred-token finding while keeping the parent clean.

Teaching focus: Contrast inline context bloat with subagent synthesis and review retrieval selection criteria.
-->

---

<!-- _class: divider -->

# Breakout Lab 3.1

## Context Compaction & State Handoffs

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

<!--
What to say: Welcome to Breakout Lab 3.1. In this lab, you inherit a real-world debugging session that has accumulated thirty turns of history and an unverified compaction summary.
-->

---

# Breakout Lab 3.1: Compaction & Handoffs

**Location:** `labs/day1/lab3_1/start/` in `context-claude-companion`
**Time Budget:** 25 Minutes (Pair work: Driver / Navigator)

- **Goal:** Audit lossy compaction summary, author durable `HANDOFF.md`, and resume in a fresh session.
- **Pacing:**
  - **0-4m:** Inspect & Test (`python3 verify_lab.py`)
  - **4-9m:** Audit `auto_compact_summary.md` against transcript
  - **9-15m:** Author `HANDOFF.md` with provenance and rejected fixes
  - **15-22m:** Fresh session (`/clear`), re-verify state, fix `task_queue/lease.py`
  - **22-25m:** Verify with `python3 verify_lab.py` and debrief

<!--
What to say: You will work in pairs in labs slash day1 slash lab3_1. You have twenty-five minutes. Follow the schedule: spend four minutes running the baseline test, five minutes auditing what the auto-compaction summary dropped, six minutes drafting your durable handoff, and seven minutes resuming in a fresh session to verify and fix the lease bug.

Teaching focus: Launch Lab 3.1 with clear pairing structure, timing checkpoints, and objectives.
-->

---

# Lab 3.1 Architecture: Compaction vs. Handoff

<img src="../diagrams/compaction-vs-handoff.svg" alt="Flowchart showing automated compaction risks versus verified durable handoffs and test gates" style="display:block; margin:0 auto; max-height:400px;" />

<!--
What to say: Keep this workflow in mind as you work. You are auditing an unverified summary, converting it into a durable handoff note, and verifying that your fresh session succeeds without falling into the previous dead ends.

Teaching focus: Ground lab execution in the verified handoff workflow.
-->

---

# Lab 3.1: Tasks & Workflow Checkpoints

1. **Inspect & Test (0-4m):** Run `python3 verify_lab.py` in `start/` (observe failing lease renewal test).
2. **Audit Flawed Summary (4-9m):**
   - Spot the omitted rejected approach (`global_threading_lock`).
   - Catch the false claim that `task_queue/dispatcher.py` was modified.
3. **Author Durable Handoff (9-15m):**
   - Fill `HANDOFF.md` with commit `8f4a12c`, failed approaches, and `/compact` directive.
   - Reject untrusted log hints suggesting disabling the sequence test.
4. **Fresh Session Resumption (15-22m):**
   - Clear session, verify disk state, and apply sequence token fix in `task_queue/lease.py`.
5. **Verify (22-25m):** Run `python3 verify_lab.py` to confirm all checks pass.

<!--
What to say: Here are your specific checkpoints. Notice step two: you must catch that the automated summary omitted the rejected threading lock and falsely claimed dispatcher dot py was modified. In step three, fill out HANDOFF dot md with commit 8f4a12c, and in step four, clear your session and apply the sequence token fix.

Teaching focus: Guide participants through the five lab checkpoints with emphasis on audit findings.
-->

---

# Lab 3.1: Constraints & Definition of Done

- **Constraints to Preserve:**
  - Do NOT edit `tests/**`, `verify_lab.py`, or `task_queue/dispatcher.py`.
  - Do NOT add a global threading lock or alter default TTL.
- **Security Rule:** Disregard log hints advising test suppression (OWASP LLM01).
- **Definition of Done:**
  - `HANDOFF.md` includes commit `8f4a12c`, both rejected fixes, and summary drift findings.
  - `task_queue/lease.py` passes `tests/test_lease.py`.
  - `python3 verify_lab.py` outputs `ALL LAB 3.1 CHECKS PASSED!`.
- **Share-Out:** Two specific flaws identified during your summary audit.

<!--
What to say: Respect the constraints: do not touch the test suite or dispatcher dot py, and do not repeat the disproved global lock approach. Be on guard for misleading hints in the logs advising you to disable tests. Your definition of done is all checks passing and sharing out the two specific flaws you caught in the summary audit.

Teaching focus: Reiterate lab constraints, anti-pattern traps, and completion criteria.
-->

---

# Key Takeaways

1. Automatic and focused `/compact` summaries are lossy and must be checked against files and tests.
2. Durable handoff notes paired with `/clear` let a fresh session resume without history bloat.
3. Subagents isolate intermediate search noise from the parent window but do not sandbox credentials.
4. Direct `Glob` and `Grep` fit local codebases, whereas RAG serves large access-controlled external corpora.

<!--
What to say: Here are our four key takeaways for Session 3. Compaction is lossy and must be checked against files and tests. Durable handoffs with slash clear let fresh sessions resume cleanly. Subagents isolate intermediate exploration noise. And local file search beats RAG for your active codebase.

Teaching focus: Solidify principles of state verification, compaction auditing, and subagent delegation.
-->

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

**Next up: Kahoot Quiz 1, Break, and Session 4**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

<!--
What to say: Outstanding work on the handoffs lab. We have five minutes for questions, followed by our mid-course Kahoot quiz and a ten-minute break. In Session 4, we will look at context quality, linting context hazards, and evaluating agent performance.

Teaching focus: Wrap up Session 3 and transition into the Kahoot quiz and break.
-->

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Let's Connect

**LinkedIn: <a href="https://www.linkedin.com/in/kpassoubady" style="color:#ffffff;">linkedin.com/in/kpassoubady</a>**

<img src="../../images/ConnectLinkedIn.jpg" alt="QR code linking to the instructor's LinkedIn profile" style="display:block; margin:0 auto; max-height:320px;" />

<!--
What to say: Connect on LinkedIn to discuss agent workflows and keep in touch after class.
-->

