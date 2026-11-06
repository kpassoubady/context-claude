# Context Engineering for Claude Code

This course introduces context engineering as the practice of shaping the information available to an AI coding assistant, not as a replacement for prompt design. Using Claude Code, participants examine how project instructions, retrieved files, tool results, memory, and task history affect an agent's work.

Through demonstrations and hands-on exercises, participants learn to provide relevant context progressively, manage long-running tasks, and evaluate changes against task correctness as well as context and usage costs. The course distinguishes Claude Code guidance from permission controls and treats retrieval-augmented generation (RAG) as an option for external knowledge sources, not as a substitute for ordinary project-file search.

## Audience

This course is ideal for:

- Developers working in AI-assisted coding environments

## Prerequisites

To get the most out of this session, participants should have:

- Familiarity with core LLM concepts and prompt-engineering terminology
- Basic experience using Claude Code or a comparable AI coding assistant
- Working knowledge of terminal commands, Git, and project navigation

## Learning Objectives

After this course, participants will be able to:

- Explain how context engineering extends prompt design across instructions, files, tools, and memory.
- Describe how Claude Code combines startup context with information retrieved on demand.
- Configure concise project guidance and select appropriate retrieval, memory, and delegation strategies for a task.
- Manage long-running work with compaction, durable handoffs, and isolated subagents while checking for lost context.
- Evaluate context changes using task correctness, instruction adherence, and context or usage cost.

## Duration

4 hours

## Outline

### From Prompt Engineering to Context Engineering

- How context engineering extends, rather than replaces, prompt design
- Context as a working set in iterative agent loops
- How excessive or irrelevant context can reduce recall and focus, and why this does not imply a guaranteed hallucination

### How Claude Code Manages Context

- Project guidance with `CLAUDE.md` or `AGENTS.md`, and path-scoped rules in `.claude/rules/`
- On-demand retrieval with Claude Code's file-search tools, Skills, and MCP tool discovery
- Auto memory and context inspection with `/context`
- Structured task requests and concise, relevant tool outputs
- The distinction between model-facing instructions and enforced permissions or hooks

### Maintaining Coherence Across Long Tasks

- Automatic and focused compaction, including what may not survive a summary
- Durable task notes and fresh-session handoffs
- Subagents as isolated contexts that return findings to the parent session
- When RAG is appropriate for external corpora versus direct project-file retrieval

### Context Quality and Iteration

- Noise, stale assumptions, redundant instructions, context dilution, and oversized tool results
- Repeatable evaluation using acceptance tests, instruction adherence, and context or usage cost
- Why token reduction alone is not evidence of better task performance

## Documentation Currency

Reviewed against Anthropic documentation on 2026-11-05. Claude Code changes over time; the instructor should verify command names and feature behavior against the current documentation before each delivery. This course avoids pinning a Claude Code version unless a lab depends on a specific release.

- [Claude Code memory and project instructions](https://code.claude.com/docs/en/memory)
- [Claude Code context window](https://code.claude.com/docs/en/context-window)
- [Claude Code features overview](https://code.claude.com/docs/en/features-overview)
- [Claude Code permissions](https://code.claude.com/docs/en/permissions)
- [Anthropic: Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
