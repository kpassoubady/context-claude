# Sources: Maintaining Coherence Across Long Tasks (Day 1)

## Sources

| Key | Reference entry | URL | Type | Status | Support | Accessed |
|:----|:----------------|:----|:-----|:-------|:--------|:---------|
| anthropic-context-window-2026 | Anthropic (2026). Explore the context window. Claude Code Documentation. code.claude.com/docs/en/context-window | https://code.claude.com/docs/en/context-window | online | verified | direct | 2026-11-14 |
| anthropic-subagents-2026 | Anthropic (2026). Create custom subagents. Claude Code Documentation. code.claude.com/docs/en/sub-agents | https://code.claude.com/docs/en/sub-agents | online | verified | direct | 2026-11-14 |
| anthropic-context-engineering-2025 | Anthropic (2025). Effective context engineering for AI agents. Anthropic Engineering. anthropic.com/engineering/effective-context-engineering-for-ai-agents | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | online | verified | direct | 2026-11-20 |
| robinhood-subagents-2026 | No source found. The closest results describe a FinCrimes agent and job postings, not subagents auditing ledger reconciliation. | - | - | rejected | - | 2026-11-14 |
| disney-ingest-2026 | No source found. Searches returned scraping vendors and Gracenote and Reelgood material, with nothing on Disney+ subagents. | - | - | rejected | - | 2026-11-14 |

Note: the Anthropic engineering post returned an empty page on two fetch attempts on 2026-11-14. It was fetched and read on 2026-11-20 (published Sep 29, 2025) and supports the presenter-note provenance below. The `/research/` URL returns the same page; `/engineering/` is the canonical path.

## Claims

| Slide (title) | Claim as written on slide | Key | Form |
|:--------------|:--------------------------|:----|:-----|
| Automatic vs. Focused Compaction | Compaction summarizes the conversation history to fit the context window; root CLAUDE.md and auto memory are re-injected from disk | anthropic-context-window-2026 | footer |
| Isolated Subagents for Exploration | Each subagent runs in its own context window and returns only a summary to the parent | anthropic-subagents-2026 | footer |
| Direct File Search vs. External RAG | Presenter note: Claude Code is a hybrid agent; CLAUDE.md loads up front while glob and grep fetch files just in time | anthropic-context-engineering-2025 | presenter-note provenance |
