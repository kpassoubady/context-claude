# Kahoot Quiz 1: Context Engineering Fundamentals

Covering Day 1 Sessions 1 through 3:
- Session 1: From Prompt Engineering to Context Engineering
- Session 2: How Claude Code Manages Context & Structuring Project Guidance
- Session 3: Maintaining Coherence Across Long Tasks & Compaction Handoffs

---

## Q1 (MCQ)
How does context engineering differ from prompt engineering in an agentic coding workflow?

- A) It tunes the wording of a single prompt for a better one-shot answer
- B) It selects which model version answers each turn of the task
- C) It manages everything the model sees across a multi-turn task
- D) It moves every instruction out of CLAUDE.md into the first user prompt

**Correct Answer:** C
**Rationale:** Context engineering controls what enters, stays in, and exits the model context window across an entire multi-turn workflow.

---

## Q2 (True/False)
Every tool execution result returned in Claude Code is automatically appended to the active working context.

- A) True
- B) False

**Correct Answer:** True
**Rationale:** The iterative agent loop automatically adds tool outputs to the context window, accumulating working state.

---

## Q3 (MCQ)
What is a primary risk of accumulating excessive tool outputs and file dumps in context?

- A) Outputs are silently discarded once the file count passes a fixed limit
- B) Claude Code blocks further tool calls until the user runs /clear
- C) Only the cost changes, and answer quality stays the same at any size
- D) Recall degrades and the model may lose focus on key instructions

**Correct Answer:** D
**Rationale:** Context bloat dilutes attention, degrades retrieval precision, and can cause the model to ignore critical instructions.

---

## Q4 (MCQ)
When does Claude Code load the root CLAUDE.md file into session context?

- A) When Claude first reads a file in the same directory
- B) At session startup, occupying context space from turn 1
- C) On demand when the user runs the /context command
- D) Only after the first /compact reloads it from disk

**Correct Answer:** B
**Rationale:** Root guidance files load unconditionally at session startup and consume context tokens from the very first turn.

---

## Q5 (True/False)
Rules in .claude/rules/ with file path globs load conditionally when a matching file is accessed.

- A) True
- B) False

**Correct Answer:** True
**Rationale:** Path-scoped rules load conditionally into context only when targeted paths match the active work.

---

## Q6 (MCQ)
How does Claude Code enforce security and operational policy outside model prose guidance?

- A) Through permissions and PreToolUse or PostToolUse hooks
- B) Through a firmly worded rule at the top of the root CLAUDE.md
- C) Through a longer system prompt that the model reads on every turn
- D) Through a path-scoped rule that loads when matching files are read

**Correct Answer:** A
**Rationale:** Permissions and hooks enforce hard constraints out-of-band deterministically, without relying on model compliance.

---

## Q7 (MCQ)
What is the main purpose of running the /context command in Claude Code?

- A) To summarize the conversation and free up window space
- B) To reset the session history and start with a clean window
- C) To inspect token usage across system prompt, tools, memory, and turns
- D) To list which files in the repository were edited this session

**Correct Answer:** C
**Rationale:** `/context` provides visibility into token consumption broken down by system instructions, memory, tools, and conversation history.

---

## Q8 (True/False)
Claude Code auto memory permanently persists full terminal command output transcripts across sessions.

- A) True
- B) False

**Correct Answer:** False
**Rationale:** Auto memory captures distilled user preferences and project facts into `MEMORY.md`, not raw command execution streams.

---

## Q9 (MCQ)
What critical information is most at risk of being lost during automatic context compaction?

- A) Root CLAUDE.md instructions, which are never reloaded after compaction
- B) Exact line numbers, error codes, and rejected fixes
- C) Auto memory notes, which are cleared on every compaction
- D) Git commit history that the repository stores on disk

**Correct Answer:** B
**Rationale:** Summarization collapses details, which frequently drops line numbers, specific error traces, and rejected fixes. Root CLAUDE.md and auto memory are re-injected from disk.

---

## Q10 (MCQ)
Why write a durable handoff file like HANDOFF.md when hitting long-task context limits?

- A) It keeps the next session from ever needing compaction
- B) It lets the next session skip re-checking the repo and test results
- C) It stores the full chat transcript so nothing is lost
- D) It carries verified state, open questions, and next steps to a new session

**Correct Answer:** D
**Rationale:** A structured handoff documents completed tasks, verified facts, and pending items for a clean fresh session, which still verifies them against disk and tests.

---

## Q11 (True/False)
Running a subagent isolates intermediate tool outputs from bloating the parent session context window.

- A) True
- B) False

**Correct Answer:** True
**Rationale:** Subagents conduct exploration and reading in a separate context window, returning only synthesized findings to the parent.

---

## Q12 (MCQ)
When is local file search (Grep/Glob) preferred over an external RAG index in Claude Code?

- A) For active codebase search with zero indexing lag and exact symbol matches
- B) When searching hundreds of archived external compliance documents
- C) When results must come from semantic similarity rather than exact names
- D) When results need tenant-level access controls before reaching context

**Correct Answer:** A
**Rationale:** Local tools provide immediate zero-latency matching on current code without synchronization delays. External RAG suits large external corpora, semantic retrieval, and ACL-gated sources.
