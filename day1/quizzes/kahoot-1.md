# Kahoot Quiz 1: Context Engineering Fundamentals

Covering Day 1 Sessions 1 through 3:
- Session 1: From Prompt Engineering to Context Engineering
- Session 2: How Claude Code Manages Context & Structuring Project Guidance
- Session 3: Maintaining Coherence Across Long Tasks & Compaction Handoffs

---

## Q1 (MCQ)
How does context engineering differ from prompt engineering in an agentic coding workflow?

- A) It shapes the entire runtime information environment across multi-turn tasks
- B) It replaces prompt wording with automated system commands
- C) It eliminates the need for instructions in root configuration files
- D) It strictly forces the model to ignore tool execution results

**Correct Answer:** A
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

- A) Retrieval recall degrades and the model may lose focus on key instructions
- B) The agent immediately raises a syntax compilation error
- C) Claude Code revokes local repository git permissions
- D) Token costs drop as the context window becomes fully saturated

**Correct Answer:** A
**Rationale:** Context bloat dilutes attention, degrades retrieval precision, and can cause the model to ignore critical instructions.

---

## Q4 (MCQ)
When does Claude Code load the root CLAUDE.md file into session context?

- A) At session startup, occupying context space from turn 1
- B) Only after a relevant test failure occurs in the workspace
- C) On demand when the user invokes the /context slash command
- D) Only when a subagent is explicitly launched by the user

**Correct Answer:** A
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

- A) Through system permissions and PreToolUse or PostToolUse hooks
- B) By relying exclusively on polite reminders in CLAUDE.md
- C) By deleting unauthorized source files from the working tree
- D) By automatically disabling the local terminal shell session

**Correct Answer:** A
**Rationale:** Permissions and hooks enforce hard constraints out-of-band deterministically, without relying on model compliance.

---

## Q7 (MCQ)
What is the main purpose of running the /context command in Claude Code?

- A) To inspect token usage across system prompt, tools, memory, and turns
- B) To permanently wipe all committed changes in the Git working tree
- C) To reset Claude Code's model weights to base training configuration
- D) To automatically compress all project files into a zip archive

**Correct Answer:** A
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

- A) Exact file paths, line numbers, and intermediate failed test outputs
- B) The foundational system instructions of Claude Code
- C) Git commit history stored in the repository object database
- D) The active model family assigned to the session

**Correct Answer:** A
**Rationale:** Summarization collapses details, which frequently drops line numbers, specific error traces, and exact code fragments.

---

## Q10 (MCQ)
Why write a durable handoff file like HANDOFF.md when hitting long-task context limits?

- A) It transfers verified state, open questions, and next steps to a new session
- B) It prevents any future compaction from occurring in subsequent sessions
- C) It bypasses the need for running verification commands before committing
- D) It automatically executes all pending unit tests in the background

**Correct Answer:** A
**Rationale:** A structured handoff documents completed tasks, verified facts, and pending items for a clean fresh session.

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
- B) When querying hundreds of archived external legal compliance PDFs
- C) Only when the local repository has fewer than ten total lines of code
- D) When search must run strictly on an external cloud embedding cluster

**Correct Answer:** A
**Rationale:** Local tools provide immediate zero-latency matching on current code without synchronization delays.
