# Interactive Diagrams: Day1

Scope: no scope file found (`llm-context/todos/day1-interactive-diagrams.md` absent). Treated as all four slides in `day1/slides/`, no priority list.
Companion: /Users/kangs/code/github/context-claude-companion
Status legend: [pending] to build, [built] rendered and embedded, [blocked: reason], [rejected], [none-needed]
Cap: 2 per day and per topic (existing: 0; pending: 0)

## Diagrams (build order)
None queued. Status: none-needed. Every candidate duplicates an existing Mermaid or Excalidraw visual, or is text, a quiz, or a schedule that bullets already show.

## Rejected and none-needed
- Path-scoped rule activation (02, "Path-Scoped Rules in `.claude/rules/`"): the only candidate with a real gate (glob match) and branching. Rejected because it is already briefed as Excalidraw (`llm-context/research/day1/excalidraw-overview-brief.md`). Its files already exist at `day1/diagrams/01-path-scoped-rule-activation.{excalidraw,svg,png}`. Reconsider only if the Excalidraw item is dropped.
- Startup vs. on-demand table and lifecycle (02): duplicates `claude-code-context-lifecycle.mmd`.
- Guidance vs. enforcement (02): duplicates `guidance-vs-enforcement.mmd`.
- Auto memory, Skills, MCP (02): covered by the "Loaded On Demand" group in `claude-code-context-lifecycle.mmd`.
- Prompt vs. context engineering table (01): duplicates `prompt-vs-context-engineering.mmd`.
- Agent loop, "How Claude Code Builds Working Context" (01): duplicates `agentic-context-loop.mmd`.
- Automatic vs. focused compaction (03) and durable handoff template (03): duplicate `compaction-vs-handoff.mmd`. The template is a code block, not a flow.
- Lease-bug compaction story (03): the anecdote appears only in speaker notes; slide text is bullets, and the flow overlaps `compaction-vs-handoff.mmd`.
- Isolated subagents and direct search vs. RAG table (03): duplicates `subagent-and-retrieval-patterns.mmd`.
- Five context hazards and remediation (04): duplicates `context-hazards-map.mmd`.
- Evaluation tiers and false-economy gate (04): duplicates `context-evaluation-pipeline.mmd`.
- Lab 2.1 and Lab 3.1 task checkpoints (02, 03): timed pacing lists. Bullets read as well; no run trace or dated events.
- Context rot and trust boundaries (01); industry scenarios (01–04): prose or anecdote. Drawing them would invent structure.
- If-Then transfer plan (04): action list, not a mechanism.
- Predict, Explain, Check, and Quick Check slides; demo slides: quizzes and scripts, not diagrams.
