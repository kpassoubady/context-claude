# Excalidraw Overview Brief: Day1

Scope: no scope file found (`llm-context/todos/day1-excalidraw-overview-diagrams.md` is absent). Treated as all four slides in `day1/slides/`, no priority list.
Status legend: [ ] pending, [x] built and rendered

Coverage note: every mechanism slide in Day 1 already has a Mermaid diagram embedded. The only gap found is below.

## Diagrams (build order)
- [x] **01-path-scoped-rule-activation**: a path-scoped rule loads only when a matching file is touched; other files leave it unloaded
  - Slide: `day1/slides/02-how-claude-code-manages-context.md`, after "Path-Scoped Rules in `.claude/rules/`" (before "Path-Scoped Rules (Fintech)")
  - Elements:
    - Root `CLAUDE.md` (always loaded at session start; "Occupies space from turn 1")
    - File read or edit (input)
    - Decision: "Matches `paths:` glob?" (for example `services/orders/**/*.py`)
    - Yes: "Rule loads into context" (`.claude/rules/*.md`, "Loads when matching file is read")
    - No: "Rule stays unloaded" ("avoid loading compliance rule overhead")
    - Unrelated file (general task)
    - Active working context (output)
  - Arrows: file read → decision; decision Yes → rule loads → active context; decision No → rule stays unloaded; root CLAUDE.md → active context (always, no decision)
  - Palette: root CLAUDE.md blue; file read gray; decision yellow; rule loads blue; rule stays unloaded green; active context green
  - Alt text: "Flowchart of path-scoped rules: root CLAUDE.md always loads, while a file read or edit is checked against the paths glob; a match loads the rule into context, and a non-match leaves it unloaded."
  - Outputs: `day1/diagrams/01-path-scoped-rule-activation.{excalidraw,svg,png}`

## Rejected
- Prompt vs. context engineering table (`01-from-prompt-engineering-to-context-engineering.md`, "Prompt Engineering vs. Context Engineering"): duplicates `prompt-vs-context-engineering`.
- "How Claude Code Builds Working Context" (01, four steps): duplicates `agentic-context-loop`, embedded on the next slide.
- Context rot (01, "Understanding Context Rot Accurately"): the position-based mechanism (a rule pushed away from the active edit) appears only in speaker notes. Reconsider if that claim is added to slide text.
- Trust boundaries (01, "Trust Boundaries in Retrieved Content"): four bullets and a caution box already explain it; no flow to show.
- Stripe fintech case (01, "Prompt vs. Context Engineering (Fintech)"): a single-company anecdote described only in prose; a diagram would invent its system's structure.
- Startup vs. on-demand table (02, "Startup vs. On-Demand Context"): duplicates `claude-code-context-lifecycle`, embedded on the next slide.
- Guidance vs. deterministic enforcement (02): duplicates `guidance-vs-enforcement`.
- Auto memory, Skills, MCP progressive disclosure (02): covered by the "Loaded On Demand" group in `claude-code-context-lifecycle`.
- Automatic vs. focused compaction (03) and durable handoff template (03): duplicate `compaction-vs-handoff`.
- Isolated subagents (03) and direct file search vs. external RAG (03): duplicate `subagent-and-retrieval-patterns`.
- Five context hazards (04, "Five Common Context Hazards"): covered by `context-hazards-map`, which folds the five into three nodes but names all five.
- Evaluation tier table and "Why Fewer Tokens Alone Do Not Prove Quality" (04): covered by `context-evaluation-pipeline`.
- If-Then transfer plan (04): a participant action list, not a mechanism.
- Predict / Explain / Check / Quick Check slides (01–04): question slides, not diagram candidates.
- Interactive archify duplicate check: `context-claude-companion/day1/diagrams/interactive/` does not exist, so nothing to compare against.
