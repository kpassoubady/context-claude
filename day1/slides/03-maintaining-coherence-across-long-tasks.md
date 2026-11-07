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
</style>

<!-- _class: lead -->
<!-- _paginate: false -->

# Context Engineering
## Maintaining Coherence Across Long Tasks

**Day 1 - Session 3**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# What We'll Cover

1. Automatic versus focused compaction and summary limits
2. Durable task notes (`HANDOFF.md`) and fresh-session handoffs
3. Isolated subagents and direct file search versus RAG
4. Demo: Auditing compaction summaries and handoff state
5. Breakout Lab 3.1: Context Compaction and State Handoffs

---

<!-- _class: divider -->

# Compaction & Durable Handoffs

## Carrying verified state across long workflows

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

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

---

# Durable Handoffs and Fresh Sessions

```markdown
# Task Handoff: Worker Lease Renewal
- Revision: commit 8f4a12c (modified: task_queue/lease.py)
- Goal: Prevent duplicate job execution on lease renewal
- Constraints: Keep LeaseManager signature; no external lock service
- Failed Approaches: Global mutex (failed test_concurrent_lease_renewal)
- Next Verification: Run pytest tests/test_lease.py -q
```

> Writing `HANDOFF.md` and running `/clear` resets history bloat while keeping explicit provenance.

---

# Compaction and Handoff Verification Flow

<img src="../diagrams/compaction-vs-handoff.svg" alt="Flowchart comparing in-session compaction and fresh-session handoffs leading into a mandatory disk and test verification gate" style="display:block; margin:0 auto; max-height:420px;" />

---

<!-- _class: demo -->

# Demo: Compaction and Handoff Verifier

Run `python3 day1/demos/demo-compaction-and-handoff-verifier.py`.

- **Summary audit:** Compare an unfocused summary against actual repo files and tests
- **Dropped constraints:** Spot where a rejected fix was omitted from the summary
- **Drift detection:** Catch a stale file-state claim before editing code
- **Verified handoff:** Confirm `HANDOFF.md` aligns with `git status` and `pytest`

> Demonstrates why post-compaction and fresh-session work must re-verify repository state.

---

<!-- _class: divider -->

# Subagents & Retrieval Patterns

## Isolating exploration and choosing retrieval tools

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Isolated Subagents for Exploration

- **Separate window:** Intermediate `Grep` and `Read` calls stay in the worker context
- **Synthesized return:** Parent session receives only the summarized findings and paths
- **Cost reality:** Total model usage spans both parent and subagent windows
- **Security boundary:** Context isolation is not filesystem or credential isolation

---

# Direct File Search vs. External RAG

| Retrieval Need | Local File Search (`Glob`, `Grep`, `Read`) | External RAG (via MCP / Service) |
| :--- | :--- | :--- |
| **Target source** | Active codebase and working tree | Large external docs, ADRs, or tickets |
| **Freshness** | Immediate; zero indexing lag | Depends on index sync schedule |
| **Precision** | Exact symbol and line matching | Semantic or hybrid chunk retrieval |
| **Access control** | Local repo permissions | Must enforce tenant ACLs before context |

---

# Subagent Isolation and Retrieval Architecture

<img src="../diagrams/subagent-and-retrieval-patterns.svg" alt="Diagram showing parent session delegating heavy exploration to an isolated subagent and comparing local file search with external RAG" style="display:block; margin:0 auto; max-height:420px;" />

---

<!-- _class: demo -->

# Demo: Subagent Isolation vs. Inline Search

Run `python3 day1/demos/demo-subagent-isolation-vs-inline-search.py`.

- **Inline exploration:** Measure parent window growth across twelve module reads
- **Subagent delegation:** Observe how returning a synthesis keeps parent context lean
- **Total usage accounting:** Compare parent window size against combined token work
- **Retrieval selector:** Evaluate when local `Grep` beats an external RAG index

> Illustrates information flow between parent and subagent windows; not a sandbox test.

---

# Lab 3.1: Context Compaction and State Handoffs

Open `labs/day1/lab3_1/` in the `context-claude-companion` repo.

**Goal:** Audit a lossy compaction summary, write a verified `HANDOFF.md`, and complete the lease fix in a fresh session.

1. Run `pytest` and compare `session_history/auto_compact_summary.md` against the repo
2. Complete `HANDOFF.md` with goal, state, failed approaches, and verification steps
3. Resume from `HANDOFF.md`, fix `task_queue/lease.py`, and run `python3 verify_lab.py`

> Stretch goal: Add provenance metadata and write a focused `/compact` prompt for the next milestone.

---

# Key Takeaways

1. Automatic and focused `/compact` summaries are lossy and must be checked against files and tests.
2. Durable handoff notes paired with `/clear` let a fresh session resume without history bloat.
3. Subagents isolate intermediate search noise from the parent window but do not sandbox credentials.
4. Direct `Glob` and `Grep` fit local codebases, whereas RAG serves large access-controlled external corpora.

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

**Next up: Kahoot Quiz 1, Break, and Session 4**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

