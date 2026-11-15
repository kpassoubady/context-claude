# Timing Gap Analysis: Context Engineering for Claude Code (Day 1)

**Honest assessment of whether the slide decks fit the allocated time.**

- **Date:** 2026-11-14
- **Version:** v1 (versions restart on a new date; the previous report is `20261112-v2`)
- **Scope:** Day 1, whole 4-hour course (4 decks, 2 breakout labs, 1 Kahoot)
- **Catalog:** `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md`
- **Analyzer:** course-timing-gap-analyzer

## Headline

The 11-12 v2 report concluded 236.0 min active against 240 min (4.0 min buffer). **That conclusion was an arithmetic error.** The v2 schedule table's own rows sum to 246.0 min, and its per-block gaps sum to +6.0 min, not -4.0 min. This re-analysis finds **246.5 min active against 240 min: +6.5 min over (2.7%)**. C5 is not met.

## Methodology

Mid-range estimates from the skill's slide-type table, applied to the current decks. `SKIP` and `REFERENCE ONLY` slides count 0 active minutes. `references` and `connect` slides count 0. Lab blocks are taken at the catalog's 25 min each, covering launch slides plus hands-on work. Presenter notes add no time. Estimates carry roughly +/-2 min per deck, so the two decks within 1 min of their allocation are effectively on budget.

Key rates used: divider 0.5, content 1.5 to 2.0, diagram 2.0 to 2.5, demo 4.0, predict-demo-explain (PCOE) sequence 7.5, chat-check pair 3.0 to 4.0, waterfall sequence 5.0, transfer plan 4.0, takeaways 1.5, closing "Questions?" 0.5.

## Day 1 (240 min allocated)

### Slide Inventory

| Deck | Slides | SKIP | REFERENCE ONLY | Trick of the Trade | Gross | Excluded | Active |
|:---|---:|---:|---:|---:|---:|---:|---:|
| 01 From Prompt to Context Engineering (incl. intro) | 28 | 1 | 0 | 1 | 47.0 | 1.5 | 45.5 |
| 02 How Claude Code Manages Context (lab slides excluded) | 27 | 1 | 1 | 1 | 36.0 | 3.0 | 33.0 |
| 03 Maintaining Coherence (lab slides excluded) | 23 | 1 | 0 | 1 | 30.0 | 1.5 | 28.5 |
| 04 Context Quality and Iteration | 19 | 1 | 1 | 0 | 33.0 | 3.5 | 29.5 |
| **Total** | **97** | **4** | **2** | **3** | **146.0** | **9.5** | **136.5** |

Marker inventory is unchanged from v2: 4 SKIP, 2 REFERENCE ONLY, 3 Trick of the Trade. All markers are well-formed and none sits on a protected slide. Slide counts differ from v2 because the connect slide was added to each deck, a references slide to Deck 04, and some content was renumbered. Slide numbers cited in the 11-12 engagement audit are stale.

### Schedule vs Catalog

| Block | Catalog | Gross | Excluded | Active | Gap |
|:---|---:|---:|---:|---:|---:|
| Welcome, Intro & Setup + Session 1 (Deck 01) | 45 | 47.0 | 1.5 | 45.5 | +0.5 |
| Session 2 Concept & Demos (Deck 02) | 30 | 36.0 | 3.0 | 33.0 | +3.0 |
| Breakout Lab 2.1 | 25 | 25.0 | 0 | 25.0 | 0 |
| Bio Break | 15 | 15.0 | 0 | 15.0 | 0 |
| Session 3 Concept & Demos (Deck 03) | 30 | 30.0 | 1.5 | 28.5 | -1.5 |
| Breakout Lab 3.1 | 25 | 25.0 | 0 | 25.0 | 0 |
| Kahoot Quiz 1 | 15 | 15.0 | 0 | 15.0 | 0 |
| Bio Break | 10 | 10.0 | 0 | 10.0 | 0 |
| Mandatory Course Survey | 5 | 5.0 | 0 | 5.0 | 0 |
| Session 4 Concept & Demos (Deck 04) | 25 | 33.0 | 3.5 | 29.5 | +4.5 |
| Course Wrap-up | 15 | 15.0 | 0 | 15.0 | 0 |
| **Total** | **240** | **256.0** | **9.5** | **246.5** | **+6.5** |

Breaks, quizzes, survey, and wrap-up are fixed-length, so they cannot absorb overage from teaching blocks. Only Deck 03's 1.5 min of slack is transferable, and it nets against the overage above.

Day verdict: over by 6.5 min. The complete PDF is 9.5 min longer than the live path (256.0 gross vs 246.5 active).

## Hotspots

1. **Deck 04 (Session 4): +4.5 min.** 19 slides, 2 marked, 30 min of content around 2 demos, a chat-check pair, and a transfer plan against a 25 min allocation. Gross 33.0, excluded 3.5, active 29.5.
2. **Deck 02 (Session 2): +3.0 min.** 27 slides excluding lab, 2 marked. Gross 36.0, excluded 3.0, active 33.0 against 30.
3. **Deck 01 (Intro + Session 1): +0.5 min.** Effectively on budget. The welcome block runs about 3.5 min short of its 15 min, which offsets Session 1's +4.0 only if the instructor flows straight through.

## Recommendations

### Quick fixes (not already marked; each needs instructor approval before marking)

| # | Candidate | Basis | Saves |
|:--|:---|:---|---:|
| 1 | Deck 04, "Why Fewer Tokens Alone Do Not Prove Quality" to REFERENCE ONLY | The following "False Economy" chat-check and debrief teach the same point actively | 1.5 |
| 2 | Deck 02, "Guidance and Execution Controls" diagram to REFERENCE ONLY | Restates the (already reference-only) guidance-vs-enforcement list; the PCOE sequence that follows covers it | 2.0 |
| 3 | Deck 04, "Mapping Context Hazards to Remediation" diagram to REFERENCE ONLY | Repeats the hazards list one slide earlier and the linter demo that follows | 2.5 |
| 4 | Deck 02, tighten the Context Lifecycle Inspector demo from 4 to 3 min (delivery guidance, no badge) | Observation-only demo | 1.0 |

Items 1 to 4 total 7.0 min and bring the course to 239.5 min, a 0.5 min buffer. All four target non-engagement slides. None touches a PCOE sequence, chat check, or Trick of the Trade slide, so C3 should hold; re-run the engagement auditor after marking to confirm.

### Structural fixes

- The welcome slides (Deck 01, slides 1 to 6) run about 11.5 min against a 15 min welcome block. If setup verification uses that slack, Session 1 starts late and the +0.5 grows to about +4.0.
- Shorten Kahoot Quiz 1 from 15 to 12 min if a 3 min safety margin is wanted. 12 questions at about 30 s each plus transitions fits.

### If you must stay at 240 min

Apply items 1 to 3 (6.0 min saved, 240.5 min) plus any 0.5 min of trimming, or apply all four.

## Honest Bottom Line

Gross content is 256.0 min, excluded reference time is 9.5 min, and active delivery is 246.5 min against 240: **2.7% over**. The v2 "4.0 min buffer" was a summation error and should not be relied on. The active plan does not fit as marked. It fits with the four candidate cuts above, leaving only a 0.5 min buffer, so a lighter touch on Session 4 is advisable. The complete PDF is longer than the live delivery path.

## Corrections to Prior Report

| Item | v2 (11-12) | This report |
|:---|:---|:---|
| Sum of schedule table rows | Claimed 236.0 | Rows actually sum to 246.0 |
| Sum of per-block gaps | Claimed -4.0 | Rows actually sum to +6.0 |
| Status | Feasible & Verified | Over by +6.5 |

## Decision Applied

Instructor approved items 1 to 4 (7.0 min) and accepted up to 10 min of overage, since some slides need less explanation than others.

| # | Change | File |
|:--|:---|:---|
| 1 | "Why Fewer Tokens Alone Do Not Prove Quality" marked REFERENCE ONLY | `day1/slides/04-context-quality-and-iteration.md` |
| 2 | "Guidance and Execution Controls" marked REFERENCE ONLY | `day1/slides/02-how-claude-code-manages-context.md` |
| 3 | "Mapping Context Hazards to Remediation" marked REFERENCE ONLY | `day1/slides/04-context-quality-and-iteration.md` |
| 4 | "Demo: Context Lifecycle Inspector" timeboxed to 3 min (speaker note only, no badge) | `day1/slides/02-how-claude-code-manages-context.md` |

HTML rebuilt with `scripts/build-slides-html.sh -p day1`; only decks 02 and 04 changed. Expected active total: 239.5 min. Not yet re-run: the engagement auditor to confirm no prediction, chat-check or Trick of the Trade slide was affected.
