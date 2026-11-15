# Day 1 Citation Audit (v1)

Date: 2026-11-14. Scope: Day 1 teaching decks (Marp), sessions 1 to 4. Status: report only. No deck has been edited. Ledgers written to `llm-context/research/day1/*-sources.md`.

## Per Deck

| Deck | Content slides (approx.) | Existing citations | Budget (target / max) | Proposed |
|:-----|:-------------------------|:-------------------|:----------------------|:---------|
| 01 From Prompt Engineering to Context Engineering | ~15 | None (no `data-cite`, no visible author-year) | 2 / 3 | 2 |
| 02 How Claude Code Manages Context | ~12 | None | 2 / 2 | 1 |
| 03 Maintaining Coherence Across Long Tasks | ~9 | None | 2 / 2 | 2 |
| 04 Context Quality and Iteration | ~8 | None | 1 / 1 | 0 |

Retrofit: not needed. No visible citations exist in any deck. Industry case studies appear as named-company slides with no sourcing.

## Proposal Table

| Deck | Slide title | Current claim | Corrected claim | Form | Source | URL | Support |
|:-----|:------------|:--------------|:----------------|:-----|:-------|:----|:--------|
| 01 | Understanding Context Rot Accurately | Reduced recall: Earlier conventions become harder to retrieve reliably | Reduced recall: relevant information placed mid-context is recalled less reliably | inline (Liu et al., 2023) | Liu et al., Lost in the Middle (arXiv:2307.03172) | https://arxiv.org/abs/2307.03172 | direct |
| 01 | Trust Boundaries in Retrieved Content | Prompt injection risk: Retrieved comments must not override system rules | Prompt injection risk: retrieved content can carry instructions that try to override system rules | footer | OWASP, LLM01:2025 Prompt Injection | https://genai.owasp.org/llmrisk/llm01-prompt-injection/ | direct |
| 02 | Guidance vs. Deterministic Enforcement | Pre-action blocking: Permissions and PreToolUse hooks stop disallowed tool calls | Pre-action blocking: a PreToolUse hook can block a tool call before it runs | footer | Anthropic, Hooks reference (Claude Code docs) | https://code.claude.com/docs/en/hooks | direct |
| 03 | Automatic vs. Focused Compaction | Automatic compaction: Summarizes older turns as the window approaches capacity | Compaction summarizes the conversation history to fit the context window; root CLAUDE.md and auto memory are re-injected from disk | footer | Anthropic, Explore the context window (Claude Code docs) | https://code.claude.com/docs/en/context-window | direct |
| 03 | Isolated Subagents for Exploration | Separate window: Intermediate Grep and Read calls stay in the worker context | Each subagent runs in its own context window and returns only a summary to the parent | footer | Anthropic, Create custom subagents (Claude Code docs) | https://code.claude.com/docs/en/sub-agents | direct |

Footers on Deck 01 and Deck 03 add one line each. Check the length limit before applying.

## Bibliographic Rows (instructor to confirm)

None. Every proposed source was fetched.

## Rejected Candidates

All eight named-company case studies fail. Searches found no supporting source for the named company's claim, and the specific figures are unsupported.

| Deck | Slide | Named claim | Reason |
|:-----|:------|:------------|:-------|
| 01 | Prompt vs. Context Engineering (Fintech) | Stripe ledger and dispute agents; bounded retrieval | No source. Stripe posts found cover compliance agents and Kai, not this claim |
| 01 | Prompt vs. Context Engineering (Media), SKIP | Netflix glossary and character-bible agent across 20 languages | No source. Netflix AI subtitle use is confirmed, but not the pipeline or the 20-language figure |
| 02 | Path-Scoped Rules (Fintech) | Brex ISO 4217 and zero-float rules bound to ledger paths | No source. Results were ISO 4217 pages only |
| 02 | Path-Scoped Rules (Media), SKIP | Spotify DRM and royalty rules scoped to audio ingest | No source. Results were third-party guides |
| 03 | Isolated Subagents (Fintech) | Robinhood subagents audit ledgers | No source. Results were a FinCrimes case study and job postings |
| 03 | Isolated Subagents (Media), SKIP | Disney+ subagents extract catalog metadata | No source. Results were scraping vendors |
| 04 | Controlled Context Evaluation (Fintech) | Adyen: 38% token reduction with 100% PCI-DSS adherence | No source. The 38% figure was not found anywhere |
| 04 | Controlled Context Evaluation (Media), SKIP | Warner Bros. Discovery: 20% savings, 45% more retries | No source. Results were general metadata coverage |

Decision needed for these eight slides. Options: (a) remove the named company and figures, keeping the lesson uncited; (b) replace with a verified case study; (c) keep them as labeled illustrative examples. Option (c) is not allowed under "No source, no citation" unless the slide says it is illustrative.

Unnamed anecdotes in presenter notes (the platform team, e-commerce team, and similar) are not cited in the standards. Flagging them so the instructor can label them as composites.

## Unverified

- Anthropic, Effective context engineering for AI agents: fetch returned an empty page on two attempts. Not proposed. Retry in a browser, or send a web-fetch agent, before citing it for the Direct File Search vs. RAG slide.

## Decisions (2026-11-14)

1. Five proposals approved and applied.
2. Eight named-company case studies: option (a). Company names and figures removed. Each slide's badge changed from REAL-WORLD SCENARIO to ILLUSTRATIVE SCENARIO, with the bullets and presenter notes reworded to match. SKIP badges kept.
3. Presenter-note provenance approved. Applied as a `Provenance:` sentence with a `data-cite` marker in the auto memory slide notes (deck 02).
4. Source years approved as the 2026 access year.

## Applied

| Deck | Slide | Change | Key | Form |
|:-----|:------|:-------|:----|:-----|
| 01 | Understanding Context Rot Accurately | Reworded to the verified claim | liu-2023 | inline |
| 01 | Trust Boundaries in Retrieved Content | Reworded; source footer added | owasp-llm01-2025 | footer |
| 02 | Guidance vs. Deterministic Enforcement | Reworded to hooks claim; source footer added | anthropic-hooks-2026 | footer |
| 02 | Auto Memory, Skills, and MCP Discovery | Provenance sentence added to presenter notes | anthropic-memory-2026 | presenter-note provenance |
| 03 | Automatic vs. Focused Compaction | Reworded to the verified claim; source footer added | anthropic-context-window-2026 | footer |
| 03 | Isolated Subagents for Exploration | Reworded to the verified claim; source footer added | anthropic-subagents-2026 | footer |
| 01 | Prompt vs. Context Engineering (Fintech) | Rewritten as illustrative; company and figures removed; notes reworded | none | none |
| 01 | Prompt vs. Context Engineering (Media), SKIP | Rewritten as illustrative; notes reworded | none | none |
| 02 | Path-Scoped Rules (Fintech) | Rewritten as illustrative; notes reworded | none | none |
| 02 | Path-Scoped Rules (Media), SKIP | Rewritten as illustrative; notes reworded | none | none |
| 03 | Isolated Subagents (Fintech) | Rewritten as illustrative; notes reworded | none | none |
| 03 | Isolated Subagents (Media), SKIP | Rewritten as illustrative; notes reworded | none | none |
| 04 | Controlled Context Evaluation (Fintech) | Rewritten as illustrative; notes reworded | none | none |
| 04 | Controlled Context Evaluation (Media), SKIP | Rewritten as illustrative; notes reworded | none | none |

Citation density: deck 01 has 2 citations (max 3), deck 02 has 2 (max 2), deck 03 has 2 (max 2), deck 04 has 0.

Not changed: unnamed anecdotes in presenter notes (for example, the platform team and e-commerce team). They are uncited and not named. The instructor may still want to label them as composites.

Open: the Anthropic engineering post remains `unverified` and is not cited.
