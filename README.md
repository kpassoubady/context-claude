# Context Engineering for Claude Code

This is the primary (internal) course repository for **Context Engineering for Claude Code**. This repository is instructor-facing and holds the catalog, session outlines, slide decks, diagrams, live demos, and LLM research notes. Exported artifacts (such as slide PDFs) may be distributed to students; this repository itself is not shared directly with students.

## Course Overview

This course introduces context engineering principles specific to Claude Code. Participants will learn to recognize how context quality affects agent behavior and understand strategies for managing it across tasks of varying complexity.

### Audience

This course is ideal for:
- Developers working in AI-assisted coding environments

### Prerequisites

To get the most out of this session, participants should have:
- Familiarity with LLM concepts and terminology
- Basic experience with Claude Code or a comparable AI development tool

### Learning Objectives

After this course, participants will be able to:
- Distinguish context engineering from prompt engineering in the context of Claude Code
- Describe how Claude Code retrieves and manages context at runtime
- Recognize how context decisions affect output reliability and system performance

### Duration

4 hours

---

## Course Outline

### 1. From Prompt Engineering to Context Engineering
- Why prompt engineering alone falls short in agentic systems
- Context rot and agent reliability
- How Claude Code manages context differently than general-purpose LLM tools

### 2. How Claude Code Manages Context
- `CLAUDE.md` as an upfront context signal
- Just-in-time retrieval using glob and grep
- Structured inputs and outputs

### 3. Maintaining Coherence Across Long Tasks
- RAG as an external context source
- Compaction and when to apply it
- Structured note-taking as persistent memory
- Sub-agent architectures for parallel exploration

### 4. Context Quality and Iteration
- Noise, staleness, and context dilution
- Measuring whether context decisions are working

---

## Repository Structure

| Directory | Contents |
| :--- | :--- |
| `catalog/` | Course outlines, delivery schedules, and scoping resources |
| `slides/` | Marp slide decks for each course module |
| `diagrams/` | Mermaid (`.mmd`) and visual architecture diagrams |
| `demos/` | Self-contained instructor live-coding demonstrations |
| `llm-context/` | Background research, context notes, and agent guidelines |
| `scripts/` | Slide and diagram export and validation helpers |

## Related Repositories

- [context-engineering-for-claude-code-companion](https://github.com/kpassoubady/context-engineering-for-claude-code-companion) — Student-facing breakout exercises, starter code, and reference solutions.
- [context-engineering-for-claude-code-setup](https://github.com/kpassoubady/context-engineering-for-claude-code-setup) — Standalone pre-class setup guides and environment verification.
