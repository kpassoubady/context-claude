# Course Demo Evaluation Report: Day 1 (Context Engineering for Claude Code)

- **Date:** 2026-11-12
- **Scope:** Day 1 (Full Course Demos 1 through 8)
- **Primary Repository:** `/Users/kangs/code/github/context-claude`
- **Evaluator:** course-demo-evaluator

## Summary Scorecard

| Session | Demo File | Role | Catalog Alignment | Technology Fidelity | Runnable Evidence | Overall Score |
|:---|:---|:---|:---|:---|:---|:---|
| 1 | `demo-noisy-vs-focused-context.py` | Comparison | Full | High | Verified (Exit 0) | 10 / 10 |
| 1 | `demo-agent-loop-context-growth.py` | Conceptual | Full | High | Verified (Exit 0) | 10 / 10 |
| 2 | `demo-context-lifecycle-inspector.py` | Practical | Full | High | Verified (Exit 0) | 10 / 10 |
| 2 | `demo-instructions-vs-permissions-hooks.py` | Comparison | Full | High | Verified (Exit 0) | 10 / 10 |
| 3 | `demo-compaction-and-handoff-verifier.py` | Failure & repair | Full | High | Verified (Exit 0) | 10 / 10 |
| 3 | `demo-subagent-isolation-vs-inline-search.py` | Comparison | Full | High | Verified (Exit 0) | 10 / 10 |
| 4 | `demo-context-hazard-linter.py` | Practical | Full | High | Verified (Exit 0) | 10 / 10 |
| 4 | `demo-context-ab-evaluator.py` | Integration | Full | High | Verified (Exit 0) | 10 / 10 |

## Traceability Matrix

1. **Session 1: Noisy vs. Focused Context (`demo-noisy-vs-focused-context.py`)**
   - Catalog: Context bloat, noise vs. signal, token degradation.
   - Slide Match: Deck 01, Slide 13 (`# Demo: Comparing Noisy and Focused Context Payloads`).
   - Behavior: Computes real token usage and keyword signal-to-noise ratios across realistic payloads.

2. **Session 1: Agent Loop Context Growth (`demo-agent-loop-context-growth.py`)**
   - Catalog: Multi-turn tool execution accumulation in context window.
   - Slide Match: Deck 01, Slide 16 (`# Demo: Multi-Turn Context Growth in an Agent Loop`).
   - Behavior: Simulates iterative Read/Grep/Bash turns, tracking cumulative window consumption.

3. **Session 2: Context Lifecycle Inspector (`demo-context-lifecycle-inspector.py`)**
   - Catalog: Startup loading (`CLAUDE.md`) vs. on-demand loading (`.claude/rules/*.md`).
   - Slide Match: Deck 02, Slide 12 (`# Demo: Context Lifecycle Inspector`).
   - Behavior: Evaluates rule file glob patterns against file paths, reporting active window token deltas.

4. **Session 2: Instructions vs Permissions/Hooks (`demo-instructions-vs-permissions-hooks.py`)**
   - Catalog: Advisory prompt guidance vs deterministic PreToolUse/PostToolUse hooks.
   - Slide Match: Deck 02, Slide 16 (`# Demo: Instructions vs. Permissions and Hooks`).
   - Behavior: Simulates bash commands against policy hooks, blocking unauthorized commands deterministically.

5. **Session 3: Compaction and Handoff Verifier (`demo-compaction-and-handoff-verifier.py`)**
   - Catalog: Context compaction limits, dropped constraints, verified durable handoffs.
   - Slide Match: Deck 03, Slide 9 (`# Demo: Compaction and Handoff Verifier`).
   - Behavior: Audits summarization loss against ground truth git state and unit tests.

6. **Session 3: Subagent Isolation vs Inline Search (`demo-subagent-isolation-vs-inline-search.py`)**
   - Catalog: Delegating exploration to isolated child windows vs polluting parent context.
   - Slide Match: Deck 03, Slide 15 (`# Demo: Subagent Isolation vs. Inline Search`).
   - Behavior: Compares parent context growth when running inline grep vs subagent isolation.

7. **Session 4: Context Hazard Linter (`demo-context-hazard-linter.py`)**
   - Catalog: Detecting stale paths, conflicting instructions, unscoped subsystem rules.
   - Slide Match: Deck 04, Slide 7 (`# Demo: Context Hazard Linter`).
   - Behavior: Parses markdown rules, detecting missing frontmatter, broken file paths, and rule conflicts.

8. **Session 4: Context A/B Evaluator (`demo-context-ab-evaluator.py`)**
   - Catalog: Evidence-based before/after context evaluation using test gates and token usage.
   - Slide Match: Deck 04, Slide 16 (`# Demo: Context A/B Evaluator`).
   - Behavior: Evaluates variant A vs variant B against test gates, adherence invariants, and token cost.

## Severity Findings
- **Blockers:** 0
- **Major Findings:** 0
- **Moderate / Minor:** 0
- **Execution Verification:** All 8 scripts ran in the local environment and passed with Exit code 0.
