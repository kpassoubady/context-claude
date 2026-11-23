---
marp: true
theme: default
style: '@import url("https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/blue-theme.css");'
paginate: true
header: 'Context Engineering for Claude Code'
footer: 'Day 1 - Topic 3: Maintaining Coherence Across Long Tasks'
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

**Day 1 - Topic 3**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: Welcome to Topic 3. In this block, we tackle the hardest engineering problem in agentic workflows: keeping an agent coherent across long, complex tasks. We will look at what happens when context fills up, how compaction actually works, how to write durable handoffs, and when to delegate work to isolated subagents.

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
What to say: Here is our roadmap for Topic 3. We will examine the strengths and limits of automatic and focused compaction, demonstrate how to author durable handoff notes, and compare local file search with external retrieval. Then we will run two demonstrations and put these patterns into practice in Breakout Lab 3.1.

Teaching focus: Establish Topic 3 goals for state preservation and context isolation.
-->

---

<!-- _class: divider -->

# Compaction & Durable Handoffs

## Carrying verified state across long workflows

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: Let us begin with compaction and handoffs, the two primary mechanisms for carrying verified state forward as your task grows.
-->

---

# Automatic vs. Focused Compaction

- **Automatic compaction:** Summarizes the conversation history to fit the context window
- **Focused `/compact`:** Accepts instructions on what state the summary should keep
- **Reloaded context:** Root `CLAUDE.md` and auto memory are re-injected from disk
- **Lossy nature:** Exact line numbers, error codes, or rejected fixes can drop out

<div class="gfm-alert gfm-warning">
<div class="gfm-alert-title">Warning</div>
<p>Never assume a summary preserved every negative constraint; verify against disk and tests.</p>
</div>

<p class="source" data-cite="anthropic-context-window-2026">Source: <a href="https://code.claude.com/docs/en/context-window">Anthropic, Explore the context window (Claude Code docs)</a>.</p>

<!--
What to say: Claude Code compacts conversation history automatically near the context limit, and you can trigger a focused compaction with slash compact plus specific instructions. The critical rule: compaction is lossy natural language summarization. It re-injects root CLAUDE dot md and memory, but subtle details like error strings, line numbers, and rejected fix attempts can disappear.

Illustrative example: Imagine a long session on a flaky report exporter where an engineer rejects two fixes, each because a specific test fails. An automatic summary that keeps one rejected fix and drops the other lets a fresh session re-propose it, and a summary can just as easily state a file change or setting that never happened. You will audit exactly this kind of summary in the lab. This is a constructed scenario, not a reported incident.

Teaching focus: Emphasize that compaction is lossy and requires verification against disk and tests.
-->

---

# Durable Handoffs and Fresh Sessions

<div class="trick-badge">TRICK OF THE TRADE</div>

```markdown
# Task Handoff: Report Export Timeouts
- Revision: commit <short-hash> (modified: exporter/batch.py)
- Goal: Stop large exports timing out without raising the request limit
- Constraints: Keep export_report signature; no new queue service
- Failed Approaches: Retry with backoff (still timed out in test_export_large_batch)
- Next Verification: Run pytest tests/test_export.py -q
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

From `context-claude-companion`, run `python3 day1/demos/demo-compaction-and-handoff-verifier.py`.

- **Summary audit:** Compare each summary against `git status`, `pytest`, and the parsed signature
- **Dropped constraints:** Spot the rejected fixes and failing test the unfocused summary omitted
- **Drift detection:** Catch a next step that names a file git shows untouched
- **Verified handoff:** Confirm `HANDOFF.md` matches what `git status` and `pytest` report

> Demonstrates why post-compaction and fresh-session work must re-verify repository state.

<!--
What to say: In your terminal, run python3 day1 slash demos slash demo-compaction-and-handoff-verifier dot py. [point at the output] The script runs git status and pytest on a fixture repo first. Watch the first row: the automated summary kept zero of two rejected fixes, dropped the failing test and the signature, and named webhook dot py as work, a file git shows untouched. The focused summary and the handoff both pass every check.

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

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: In this block, we examine subagents for context isolation and clarify when to use local file search versus external retrieval systems.
-->

---

# Isolated Subagents for Exploration

- **Separate window:** Each subagent runs in its own context window, so intermediate `Grep` and `Read` calls stay out of the parent
- **Synthesized return:** Parent session receives only the summarized findings and paths
- **Cost reality:** Total model usage spans both parent and subagent windows
- **Security boundary:** Context isolation is not filesystem or credential isolation

<p class="source" data-cite="anthropic-subagents-2026">Source: <a href="https://code.claude.com/docs/en/sub-agents">Anthropic, Create custom subagents (Claude Code docs)</a>.</p>

<!--
What to say: When you need to search twelve directories or audit hundreds of dependency files, running grep and read inside your main session will dump thousands of tokens into your window. Subagents solve this by spinning up an independent context window. The subagent reads the files, encounters dead ends, and synthesizes a concise summary that it passes back to the parent session.

Teaching focus: Explain subagents as context-isolated workers that keep exploratory tool noise out of the parent window.
-->

---

# Isolated Subagents (Fintech)

<div class="industry-badge">ILLUSTRATIVE SCENARIO</div>

**Fintech (Multi-Account Reconciliation):**

- A reconciliation agent can give independent ledger batches to subagents, each reviewing its batch in an isolated window.
- The parent orchestrator receives only the flagged discrepancy IDs, not the raw transaction stream.

<!--
What to say: Trading and payments platforms process high-volume multi-account ledgers. When an automated reconciliation agent audits transactions, subagents can each inspect a batch of raw ledger entries in isolation. The parent orchestrator receives only the flagged discrepancy IDs, keeping its context clean. This is an illustrative scenario, not a description of a named company's system.

Illustrative example: auditing raw transaction logs in isolated subagent windows keeps them out of the orchestrator's context while still surfacing exact ledger mismatches.
-->

---

# Isolated Subagents (Media / Entertainment)

<div class="skip-badge">SKIP</div>
<div class="industry-badge">ILLUSTRATIVE SCENARIO</div>

**Media / Entertainment (Catalog Ingestion):**

- A catalog ingest can hand tag extraction across video, audio, and subtitle files to temporary subagents.
- The main ingest step receives standardized manifests, not raw file contents.

<!--
What to say: This slide is a reference example of how a media catalog team might use temporary subagents to extract metadata without filling the main pipeline's memory. It is an illustrative scenario, not a description of a named company's system. Notice what the main step gets back: manifests, not raw files. That is the whole value of delegation wherever the raw material is large and the answer is small. If you skip this slide, carry that one sentence forward.

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

Provenance: <span data-cite="anthropic-context-engineering-2025">Anthropic's context engineering post</span> describes Claude Code as a hybrid agent: CLAUDE.md files load up front, while glob and grep fetch files just in time.

Go deeper: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents for Anthropic's discussion of just-in-time retrieval alongside up-front retrieval.
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

From `context-claude-companion`, run `python3 day1/demos/demo-subagent-isolation-vs-inline-search.py`.

- **Inline exploration:** Measure parent window tokens for a targeted grep and for a broad read of every matching module
- **Subagent delegation:** Observe how returning a short report keeps the parent window lean
- **Total usage accounting:** Compare parent window size against combined token work
- **Retrieval selector:** Check grep against an index built before an edit

> Token counts come from real grep and cat output; the subagent row models information flow and launches no subagent.

<!--
What to say: Let us run our second Topic 3 demonstration. Run python3 day1 slash demos slash demo-subagent-isolation-vs-inline-search dot py. Watch the three rows. A targeted grep inline costs about 800 tokens, which is already cheap. The broad inline exploration puts about 4,400 tokens in the parent window, whereas the modeled subagent row leaves about 70 tokens in the parent. No subagent runs in this demo, so that row models the information flow. Total model work is slightly higher with the subagent, because its own window holds the same 4,400 tokens. Then read the retrieval checks: the index built before the edit misses the uncommitted change, grep finds it.

Teaching focus: Contrast inline context bloat with subagent synthesis and review retrieval selection criteria.
-->

---

<!-- _class: divider -->

# Breakout Lab 3.1

## Context Compaction & State Handoffs

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: Welcome to Breakout Lab 3.1. In this lab, you inherit a real-world debugging session that has accumulated thirty-five turns of history and an unverified compaction summary.
-->

---

# Breakout Lab 3.1: Compaction & Handoffs

**Location:** `labs/day1/lab3_1/start/` in `context-claude-companion`
**Time Budget:** 25 Minutes (Pair work: Driver / Navigator)

- **Goal:** Audit lossy compaction summary, author durable `HANDOFF.md`, and resume in a fresh session.
- **Pacing:**
  - **0-4m:** Inspect & Test (`./setup_repo.sh`, then `python3 verify_lab.py`)
  - **4-9m:** Audit `auto_compact_summary.md` against transcript
  - **9-15m:** Author `HANDOFF.md` with provenance and rejected fixes
  - **15-22m:** Fresh session (`/clear`), re-verify state, fix `task_queue/lease.py`
  - **22-25m:** Verify with `python3 verify_lab.py` and debrief

<!--
What to say: You will work in pairs in labs slash day1 slash lab3_1. You have twenty-five minutes. Follow the schedule: spend four minutes running the setup script and the baseline test, five minutes auditing every claim in the auto-compaction summary, six minutes running your own compaction and drafting your durable handoff, and seven minutes resuming in a fresh session to verify and fix the lease bug.

Teaching focus: Launch Lab 3.1 with clear pairing structure, timing checkpoints, and objectives.
-->

---

# Lab 3.1 Architecture: Compaction vs. Handoff

<img src="../diagrams/compaction-vs-handoff.svg" alt="Flowchart showing automated compaction risks versus verified durable handoffs and test gates" style="display:block; margin:0 auto; max-height:400px;" />

<!--
What to say: Keep this workflow in mind as you work. Compare the two columns. [point at the diagram] In-session compaction keeps you in the same conversation with a lossy summary. A handoff writes state to disk and clears the window. In this lab you audit the first and build the second, and both end at the same verification gate. You are auditing an unverified summary, converting it into a durable handoff note, and verifying that your fresh session succeeds without falling into the previous dead ends.

Teaching focus: Ground lab execution in the verified handoff workflow.
-->

---

# Lab 3.1: Tasks & Workflow Checkpoints

1. **Inspect & Test (0-4m):** Run `./setup_repo.sh` in `start/` once, then `python3 verify_lab.py` (observe failing lease renewal test).
2. **Audit Flawed Summary (4-9m):**
   - Check every claim in the summary against `git status`, the files, the tests, and the transcript.
   - Write down each discrepancy with its evidence.
3. **Author Durable Handoff (9-15m):**
   - Run your own `/compact` directive and compare its output with the supplied summary.
   - Fill `HANDOFF.md` with the real commit hash, failed approaches, and audit findings.
   - Reject untrusted log hints suggesting disabling tests.
4. **Fresh Session Resumption (15-22m):**
   - Clear session, verify disk state, and apply sequence token fix in `task_queue/lease.py`.
5. **Verify (22-25m):** Run `python3 verify_lab.py` to confirm all checks pass.

<!--
What to say: Here are your specific checkpoints. In step one, run setup repo dot sh in the start folder, once. It creates the local git repository the audit runs against, and it refuses to run if a dot git folder already exists. Then run verify lab dot py and look at the failing lease renewal test. Notice step two: the automated summary is a claim list, not a fact list. Check every claim against git status, the files, the tests, and the transcript, and write down each one that does not hold. In step three, run your own compaction, compare it with the supplied summary, and fill out HANDOFF dot md with the commit hash from git log. In step four, clear your session and apply the sequence token fix.

Teaching focus: Guide participants through the five lab checkpoints with emphasis on audit findings.
-->

---

# Lab 3.1: Constraints & Definition of Done

- **Constraints to Preserve:**
  - Do NOT edit `tests/**`, `verify_lab.py`, or `task_queue/dispatcher.py`.
  - Do NOT add a global threading lock or alter default TTL.
- **Security Rule:** Disregard log hints advising test suppression (OWASP LLM01).
- **Definition of Done:**
  - `HANDOFF.md` includes the real commit hash, the rejected fixes with the test each broke, your audit findings, and fresh-session evidence.
  - `task_queue/lease.py` passes `tests/test_lease.py`.
  - `python3 verify_lab.py` outputs `ALL LAB 3.1 CHECKS PASSED!`.
- **Share-Out:** The discrepancies you found in the summary and the evidence for each.

<!--
What to say: Respect the constraints: do not touch the test suite or dispatcher dot py, and do not repeat an approach the transcript shows was disproved. Be on guard for misleading hints in the logs advising you to disable tests. Your definition of done is all checks passing and sharing out the discrepancies you caught in the summary audit, with the evidence for each.

Teaching focus: Reiterate lab constraints, anti-pattern traps, and completion criteria.
-->

---

# Key Takeaways

1. Automatic and focused `/compact` summaries are lossy and must be checked against files and tests.
2. Durable handoff notes paired with `/clear` let a fresh session resume without history bloat.
3. Subagents isolate intermediate search noise from the parent window but do not sandbox credentials.
4. Direct `Glob` and `Grep` fit local codebases, whereas RAG serves large access-controlled external corpora.

<!--
What to say: Four takeaways, and each one maps to something you just did. Compaction is lossy, which is why you audited every claim in the summary against git status and the tests instead of trusting it. A handoff note plus slash clear works because the state lives on disk with a real commit hash, not in the model's memory of the conversation. Subagents keep search noise out of the parent window, but they share your filesystem and credentials, so the isolation is about tokens, not security. And for your own codebase, grep and read beat RAG because they are fresh and exact.

Teaching focus: Solidify principles of state verification, compaction auditing, and subagent delegation.
-->

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

**Next up: Kahoot Quiz 1, Break, and Topic 4**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: Outstanding work on the handoffs lab. Take a moment to flag any quick questions, and save the bigger ones for the course wrap-up. Then we run our mid-course Kahoot quiz and take a fifteen-minute bio break. In Topic 4, we will look at context quality, linting context hazards, and evaluating agent performance.

Teaching focus: Wrap up Topic 3 and transition into the Kahoot quiz and break.
-->

---

<!-- _class: connect -->
<!-- _paginate: false -->

# Let's Connect

<p class="connect-subtitle">Scan the QR code or click the link below to stay in touch</p>

<div class="connect-card">
<img src="../../images/ConnectLinkedIn.jpg" alt="Kangeyan Passoubady's LinkedIn contact card and QR code" />
<a class="connect-btn" href="https://www.linkedin.com/in/kpassoubady">linkedin.com/in/kpassoubady</a>
<span class="connect-hint">Point your phone camera at the QR code</span>
</div>

<!--
What to say: Connect on LinkedIn to discuss agent workflows and keep in touch after class.
-->

