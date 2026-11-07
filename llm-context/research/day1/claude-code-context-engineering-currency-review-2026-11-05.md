# Claude Code Context Engineering Currency Review

Reviewed: 2026-11-05

Historical review: the findings below describe the outlines before their
subsequent update, not their current state. See the evaluator follow-up dated
2026-11-06 for current alignment and remaining delivery constraints.

## Scope and verdict

Compared `catalog/Context-Engineering-for-Claude-Code-Outline.md` with
`catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md` and
current Anthropic documentation and engineering guidance.

The course's core ideas remain sound: treat context as a limited resource,
retrieve project information as needed, preserve useful state across long
tasks, and evaluate results rather than relying on prompt wording alone. The
delivery outline is not fully current as a description of Claude Code's
context lifecycle, however. Update a few claims and add the newer context
mechanisms before using it as the definitive client-facing course source. A
full redesign is not needed.

## Findings

### 1. Correct the description of compaction

The delivery outline says compaction prunes discarded hypotheses and redundant
logs while retaining important decisions, and describes a structured
compaction pass as if it reliably preserves selected state. Claude Code
summarizes conversation history; details can be lost. Some items, including
project-root `CLAUDE.md` and auto memory, are re-injected or reloaded, while
other information may not survive. `/compact` accepts focus instructions, but
the result still needs verification.

Teach compaction, external notes, and a fresh-session handoff as complementary
strategies. Have students inspect the summary, re-read critical files, and
rerun tests rather than assume nothing was lost.

Relevant outline locations: delivery outline lines 78-84.

### 2. Expand the Claude Code context lifecycle

The catalog currently treats `CLAUDE.md` as the main upfront context signal
and glob/grep as just-in-time retrieval. Those remain useful, but current
Claude Code guidance also describes:

- `AGENTS.md` as an alternative project instruction file, and `.claude/rules/`
  for path-scoped instructions.
- Auto memory, which records learnings across sessions.
- Skills, whose descriptions are available at startup while their full
  instructions load when used.
- `/context` for examining context use, and `/clear` for switching to unrelated
  tasks.
- MCP tool names at startup with full tool schemas loaded on demand.

Add a practical context-lifecycle walkthrough, prioritizing the mechanisms
students will use in the course. Avoid claiming that `CLAUDE.md` avoids
context-window cost: loaded instruction content itself occupies context.
Clarify that project instructions guide Claude but do not enforce policy;
reliable blocking requires permissions or hooks.

Relevant outline locations: original catalog lines 37-41; delivery outline
lines 66-72.

### 3. Avoid overstating context rot and hallucination

Anthropic describes context rot as reduced recall/accuracy as context grows.
The delivery outline's claim that unmanaged output causes context rot that
"induces hallucinations" is too causal and specific. Teach that irrelevant or
excessive context can make retrieval, focus, and task performance worse; do
not present hallucination as a guaranteed or uniquely caused outcome.

Relevant outline locations: delivery outline lines 24 and 60.

### 4. Restore or explicitly retire the RAG topic

The original catalog explicitly includes "RAG as an external context source"
(line 45), but the delivery outline does not teach it. Decide whether to keep
it as a short comparison: when direct project search and just-in-time file
retrieval are sufficient, versus when an external corpus and a retrieval
pipeline are appropriate. Make clear that RAG is an architecture choice, not
a built-in synonym for Claude Code's `Glob`/`Grep` tools. Otherwise, remove it
from the source catalog so the catalog and delivery outline agree.

### 5. Make the evaluation lab evidence-based

The outline proposes token ratios, turns, and instruction compliance, and
promises reduced retrieval-token overhead and completion without human
corrections. These are not reliable outcomes without a controlled comparison.
Use the same task and repository before and after a context change, and record
task success (including test/acceptance results), instruction adherence, and
context or usage cost. Treat token reduction as a measured result, not a
guarantee; token efficiency alone does not establish quality.

Relevant outline locations: delivery outline lines 70-72 and 90.

### 6. Soften the prompt-engineering contrast

Keep the distinction as a teaching device, but frame context engineering as
extending prompt design to the complete information environment: instructions,
files, tool outputs, retrieval, and memory. Avoid implying that prompt
engineering is obsolete or that agent reliability depends on context curation
instead of prompt quality.

Relevant outline locations: original catalog lines 31-35; delivery outline
lines 24 and 60.

## Suggested minimum course update

1. In the context-management module, show what is loaded versus retrieved on
   demand, using `/context` and a small project with scoped instructions.
   Mention auto memory and Skills, even if they are not full lab objectives.
2. In the long-task module, distinguish compaction from writing durable notes
   and starting a fresh session. Use a focused `/compact`, then verify the
   handoff with file inspection and tests. Explain subagents as isolated
   contexts that return findings, not as automatic persistent memory.
3. Preserve the current 4-hour schedule, but add a short RAG-versus-file-search
   comparison or update the original catalog to remove RAG.
4. Replace guarantees about hallucinations, no human corrections, and token
   savings with observable, repeatable evaluation criteria.
5. Add a "Reviewed against official documentation" date and source links to
   the catalog. Avoid brittle CLI-version claims unless a specific feature in
   a lab requires a minimum version.

## Structural check

The session-breakdown durations sum to 240 minutes. The four main topics and
two breakout labs are represented in the delivery outline. RAG is the
identified source-to-delivery topic omission.

## Evaluator follow-up: 2026-11-06

This follow-up evaluates the current local outlines and four existing Day 1
session research files. It does not repeat the original online currency
review; new framework reference links have not been live-validated.

### Current alignment and evidence status

The current catalog and delivery outline already address the original
recommendations on lossy compaction, on-demand context, RAG versus local
retrieval, prompt-design continuity, and correctness-first evaluation. The
session breakdown still totals 240 minutes per cohort, with two 25-minute
labs; the afternoon repeats the morning rather than adding another course
day. Earlier line references and the RAG-omission finding are historical.

The four session research files have been augmented in place. Their industry
stories and numerical outcomes lack supporting case-study or benchmark
evidence and are now labeled illustrative. Proposed demos, lab paths, and
`verify_lab.py` checks are specifications, not runnable artifacts: neither
the primary nor companion repository currently contains those implementations.
The setup repository also has no delivered installation/verification guide
beyond its scaffold documentation. Do not declare classroom readiness until
the independent starters, solutions, setup checks, and fallbacks are built
and rehearsed.

### Industry frameworks and architectural boundaries

- OWASP Top 10 for LLM Applications 2025 supplies the relevant risk vocabulary:
  prompt injection, sensitive information disclosure, improper output
  handling, excessive agency, and vector/embedding weaknesses. Use inert
  fixtures and synthetic data; these mappings are not a compliance claim.
- NIST AI RMF 1.0 connects task risk, ownership, measurement, and management.
  NIST SSDF connects guidance and generated changes to reviewed revisions,
  automated tests, and the normal secure development process.
- NIST Zero Trust principles explain why scoped guidance is not resource
  authorization. Identity-aware tools, least-privilege credentials,
  managed settings, and execution isolation belong to the platform boundary;
  source/tenant authorization belongs before external content enters context.

Do not expand the course into API authentication, Kubernetes operations,
gateway deployment, or vector-database construction. Gateways may enforce
configured routing, budgets, and access, but they neither manage all local
context nor verify the correctness of a generated change.

### Remaining corrections to carry into downstream materials

1. Use `CLAUDE.md` as the explicit Claude Code entry point. Where shared
   guidance lives in `AGENTS.md`, import it through `@AGENTS.md` and verify
   the installed CLI behavior; the outlines' bare "or `AGENTS.md`" wording
   should not be taught as guaranteed native support.
2. Separate blocking pre-action controls from post-action checks:
   `PostToolUse` cannot prevent an action that already happened.
   Permissions/hooks depend on configuration and tool-path coverage, not
   an unconditional guarantee of safety or zero token overhead.
3. Never equate isolated subagent context with filesystem or credential
   isolation, or smaller parent context with lower total model usage.
   Re-check handoff assertions against revision, dirty-file state, and tests.
4. Keep each lab to 25 minutes using independent `labs/.../start/` and
   `solution/` snapshots, supplied templates, installed dependencies, and
   one tiny code correction. Do not ask students to create hooks, an MCP
   server, a retrieval pipeline, or a distributed concurrency primitive.
5. Keep actual Claude Code interaction central. Offline fixtures explain
   information flow; only live/captured runtime evidence can establish
   observed rule behavior or usage. Record unavailable telemetry as `N/A`,
   and distinguish `/usage` plan limits from `/cost` session information.
6. Accept an optimization only after every mandatory correctness,
   instruction, and safety gate passes. A single A/B pair is illustrative;
   repeat controlled tasks outside class before claiming a measured gain.

The existing per-session addenda contain the specific lab timing, evidence
requirements, fallback cuts, and enterprise responsibilities. This pass
changes research only; it does not modify the outlines or certify lab
execution, current command availability, or external-link reachability.

## Sources

- [Claude Code: How Claude remembers your project](https://code.claude.com/docs/en/memory)
- [Claude Code: Explore the context window](https://code.claude.com/docs/en/context-window)
- [Claude Code: Extend Claude Code](https://code.claude.com/docs/en/features-overview)
- [Claude Code: Extend Claude with skills](https://code.claude.com/docs/en/skills)
- [Claude Code: How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works)
- [Claude Code: Best practices](https://code.claude.com/docs/en/best-practices)
- [Anthropic: Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Anthropic: Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [OWASP: Top 10 for Large Language Model Applications](https://genai.owasp.org/llm-top-10/)
- [NIST: AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework)
- [NIST: Secure Software Development Framework](https://csrc.nist.gov/projects/ssdf)
- [NIST SP 800-207: Zero Trust Architecture](https://csrc.nist.gov/pubs/sp/800/207/final)
