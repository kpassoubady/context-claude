# Kahoot Quiz Evaluation: Day 1 Quiz 1 (v1)

- **Date:** 2026-11-14
- **File:** `day1/quizzes/kahoot-1.md` (12 questions: 8 MCQ, 4 True/False)
- **Scope:** Sessions 1 to 3 (Decks 01 to 03)
- **Evaluator:** kahoot-quiz-evaluator
- **Status:** Fixed in place. Zero open findings.

## Findings and Fixes

| Dimension | Result before | Fix |
|:---|:---|:---|
| Content grounding | Pass. Every tested fact traced to a slide in Decks 01 to 03. No forward references. | None |
| Bare artifact references | Pass. No lab numbers or demo class names. | None |
| Distractor quality | Fail. About 20 of 24 MCQ distractors were eliminable by absurdity alone (zip archive, reset model weights, revoke git permissions, delete source files). | Rewrote the distractors in Q1, Q3, Q4, Q6, Q7, Q9, Q10, Q12 as real misconceptions from the decks (for example `/context` vs `/clear` vs `/compact`, guidance vs enforcement, RAG vs local search). |
| Answer position bias | Fail. All 8 MCQs had **A** as the correct answer. | Shuffled to C, D, B, A, C, B, D, A for Q1, Q3, Q4, Q6, Q7, Q9, Q10, Q12. Two per letter. |
| True/False soundness | Pass. Q2, Q5, Q8, Q11 are unambiguous with no compound claims. | None |
| Length compliance | Fail. Q1 and Q10 option A were 76 characters (limit 75). | Both options were replaced as part of the distractor rewrite. A Q12 option written during the rewrite hit 77 characters and was trimmed. Re-check shows zero violations. |

## Grounding Evidence

| Question | Source slide |
|:---|:---|
| Q4, Q5 | Deck 02, "Startup vs. On-Demand Context" |
| Q6 | Deck 02, out-of-band row and "Guidance vs. Deterministic Enforcement" |
| Q7 | Deck 02, "Inspecting Active Context with `/context`" |
| Q9 | Deck 03, "Automatic vs. Focused Compaction" (lossy nature, reloaded context) |
| Q10 | Deck 03, `HANDOFF.md` handoff slides |
| Q11 | Deck 03, "Isolated Subagents for Exploration" |
| Q12 | Deck 03, "Direct File Search vs. External RAG" |

## Left for Instructor

- Q9 distractors A and C ("never reloaded", "cleared on every compaction") rest on the Deck 03 claim that root `CLAUDE.md` and auto memory are re-injected from disk. If that behavior changes in Claude Code, re-check them.
- Q2, Q5, and Q11 are True and Q8 is False. That split is acceptable for four T/F items.
