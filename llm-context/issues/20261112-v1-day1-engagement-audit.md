# Course Engagement Audit: Day 1 (Context Engineering for Claude Code)

- **Date:** 2026-11-12
- **Scope:** Day 1 (Whole 4-Hour Course)
- **Primary Repository:** `/Users/kangs/code/github/context-claude`
- **Companion Repository:** `/Users/kangs/code/github/context-claude-companion`
- **Auditor:** course-engagement-auditor

## Executive Summary

The course features a strong hands-on backbone anchored by two 25-minute breakout labs (Lab 2.1 and Lab 3.1) and a 12-question Kahoot quiz. However, the 8 instructor demonstrations across the 4 sessions are currently delivered in a largely passive observation format ("Run `python3 ...`"). Upgrading key demonstrations into **Predict, Commit, Observe, Explain (PCOE)** sequences and adding a targeted retrieval checkpoint in Session 4 will balance cognitive engagement without exceeding session time limits.

## Engagement Inventory Ledger

| Session | Location | Concept | Activity Type | Current Mode | Proposed Action | Estimated Time |
|:---|:---|:---|:---|:---|:---|:---|
| 1 | Deck 01, S3-S6 | Learner Background & Experience | Chat Waterfall & Beyond Work | Active / Constructive | **Keep** (Intro sequence) | 5-7 min |
| 1 | Deck 01, S15 | Noisy vs. Focused Context | Instructor Demo | Passive Observation | **Upgrade** to Predict-Commit-Observe-Explain | +3 min |
| 1 | Deck 01, S18 | Agent Loop Context Growth | Instructor Demo | Passive Observation | **Keep** as rapid visual demo | 3 min |
| 2 | Deck 02, S14 | Context Lifecycle Inspector | Instructor Demo | Passive Observation | **Keep** as visual inspector | 3 min |
| 2 | Deck 02, S18 | Instructions vs. Permissions/Hooks | Instructor Demo | Passive Observation | **Upgrade** to Predict-Commit-Observe-Explain | +3 min |
| 2 | Deck 02, S20-S24 | Breakout Lab 2.1 | Hands-on Pair Breakout | Constructive / Interactive | **Keep** (Evaluated 10/10) | 25 min |
| 3 | Deck 03, S11 | Compaction and Handoff Verifier | Instructor Demo | Passive Observation | **Upgrade** to Predict-Commit-Observe-Explain | +3 min |
| 3 | Deck 03, S17 | Subagent Isolation vs. Inline Search | Instructor Demo | Passive Observation | **Keep** as comparison demo | 4 min |
| 3 | Deck 03, S19-S23 | Breakout Lab 3.1 | Hands-on Pair Breakout | Constructive / Interactive | **Keep** (Evaluated 10/10) | 25 min |
| 3 | Kahoot 1 | Fundamental Context Knowledge | 12-Question Quiz | Active Competitive | **Keep** (Evaluated & Approved) | 15 min |
| 4 | Deck 04, S9 | Context Hazard Linter | Instructor Demo | Passive Observation | **Keep** as tooling demo | 3 min |
| 4 | Deck 04, S13 | Token Reduction vs Quality Tradeoff | Static slide | Passive Lecture | **Upgrade** with Structured Chat Check | 3 min |
| 4 | Deck 04, S18 | Context A/B Evaluator | Instructor Demo | Passive Observation | **Keep** as synthesis demo | 4 min |
| 4 | Deck 04, S22 | Course Wrap-up | Lecture | Passive | **Upgrade** with If-Then Transfer Plan | 3 min |

## Audit Dimensions Analysis

1. **Objective Alignment:** All activities directly map to catalog outcomes (prompt vs. context, lifecycle loading, compaction handoffs, quality evaluation).
2. **Cognitive Depth:** Currently 60% passive observation during lecture blocks, transitioning to constructive in labs. Implementing PCOE demo sequences elevates lecture blocks to active prediction and reasoning.
3. **Spacing and Rhythm:**
   - Session 1: Intro waterfall -> Core concept -> Demo PCOE -> Loop demo.
   - Session 2: Lifecycle rules -> Demo PCOE (hooks) -> 25 min Lab 2.1 -> Bio break.
   - Session 3: Compaction -> Demo PCOE (compaction loss) -> Subagents -> 25 min Lab 3.1 -> Kahoot Quiz 1 -> Bio break.
   - Session 4: Hazards -> Linter demo -> Evaluation Chat Check -> A/B demo -> Transfer plan -> Wrap-up.
4. **Retrieval Distribution:** Kahoot 1 covers Sessions 1-3. The proposed Session 4 Chat Check adds delayed retrieval on token tradeoffs.
5. **Participation Equity:** Waterfall and chat checks allow 100% simultaneous private commitment without volunteer bias.
6. **Feedback & Closure:** Breakouts feature executable test suites; chat checks include immediate debrief slides.

## Proposed Engagement Implementation Plan

1. **Demo Engagement Injection (`course-demo-engagement-injector`):**
   - Inject Predict-Commit slide before Demo 1 (`demo-noisy-vs-focused-context.py`) in Deck 01.
   - Inject Predict-Commit slide before Demo 4 (`demo-instructions-vs-permissions-hooks.py`) in Deck 02.
   - Inject Predict-Commit slide before Demo 5 (`demo-compaction-and-handoff-verifier.py`) in Deck 03.
2. **Interactive Checkpoint Injection (`course-engagement-injector`):**
   - Inject a structured Chat Check + Answer slide in Deck 04 on "The Token Economy Trap" (why cutting tokens alone is not a quality win).
   - Inject a 60-second "If-Then Context Engineering Transfer Plan" in Deck 04 wrap-up.
