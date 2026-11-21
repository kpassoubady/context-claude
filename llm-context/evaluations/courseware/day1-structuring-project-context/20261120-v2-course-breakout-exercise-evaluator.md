# Breakout Evaluation: Lab 2.1, Structuring Project Context with `CLAUDE.md` (v2, re-evaluation)

## Final Result
- Calculated score: 78.0/100 (v1: 72.0, +6.0)
- Applied cap: none
- Final score: 78.0/100
- Rating: Partially effective (70 to 79)
- Evidence confidence: medium. Catalog, deck 02, README, `start/`, `solution/`, the rewritten verifier and the v1 report were inspected; the verifier was run and probed. Live Claude Code behavior (`/context`, path-scoped rule loading) was not exercised, and the lab's central claim depends on it.
- Delivery recommendation: revise (small targeted fixes; no redesign)
- Strongest aspect: the verifier now tests the configuration itself (glob matching against real paths, conflicting guidance, line counts against `wc -l`), so a wrong scope no longer passes.
- Greatest learner risk: the two things that prove the objective, a live `/context` reading and the scoped rule actually loading, are free-text cells the verifier cannot check, and no one has recorded the expected output from a real session.
- First correction: run the lab once in a real Claude Code session, record the actual `/context` lines and CLI version in the solution's `context_comparison.md`, then encode a consistency check on them.

## Evidence Reviewed
| Artifact | Path | Role | Verification status |
|:---|:---|:---|:---|
| Prior report | `llm-context/evaluations/courseware/day1-structuring-project-context/20261120-v1-course-breakout-exercise-evaluator.md` | Baseline for comparison | Read |
| Outline | `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md` (Lab 2.1, 69-73; table 100) | Objectives, outcome, 25 min | Read |
| Teaching deck | `day1/slides/02-how-claude-code-manages-context.md` (rule example 185-196, launch slides 396-480) | Preparation and launch slides | Read; `day1/html/02-*.html` is newer than the `.md` (15:24 vs 15:20) |
| Student README | `context-claude-companion/labs/day1/lab2_1/README.md` (rewritten in commit `2ae4836`) | Student exercise | Read |
| Starter and solution | `labs/day1/lab2_1/{start,solution}/` incl. `verify_lab.py`, `context_comparison.md`, `.claude/rules/orders.md` | Learner state and reference | Read and run |
| Companion README | `context-claude-companion/README.md` | Run commands | Read |

Aliases `day1/lab2_1` and `day1/lab2_1_structuring_project_context` still point to `labs/day1/lab2_1`. `docs/review/evaluation-records.md` is still absent; the skill's default store path is used.

## Catalog to Exercise Traceability
| Objective or promise | Catalog evidence | Slide preparation | Learner task | Verification | Status |
|:---|:---|:---|:---|:---|:---|
| Inspect a codebase with ambiguous guidance and conventions for selected files | Outline 71 | Deck 02:153-196 | README Step 1: audit `CLAUDE.md` | `verify_lab.py` conflict-guidance check | full |
| Create or refine a concise `CLAUDE.md` | Outline 71 | Deck 02 lifecycle slides | Step 1.2 (<60 lines, `@AGENTS.md`, layout, command) | Line count, imports, layout, conflicting strings | full (see Moderate 2) |
| Add a path-scoped rule for one component | Outline 71 | Deck 02:185-196 | Step 1.3: derive globs from the tree and tests | `paths:` parsed and matched against 2 must-match and 2 must-not-match files; body must hold the three invariants | full (was partial in v1) |
| Use file-search tools to retrieve relevant files | Outline 71 | Deck 02 retrieval slides | Step 2.1 narrative | none | partial: no required output |
| Inspect `/context` to see what guidance is available | Outline 71 | Deck 02:114-121 | Run of show min 0-5 and 19-23; Basic requires live or `shared` reading, `N/A` rejected | Cell length and non-placeholder only | partial: required, not verifiable |
| Outcome: tested guidance configuration with verification commands | Outline 73 | Deck 02 | `CLAUDE.md` plus rule plus tests | All 5 checks | full |
| Outcome: evidence instructions are available for a repeatable task | Outline 73 | Deck 02:258-262 | After-column `/context` reading | none | partial: Basic now requires it (was missing) |
| Outcome: before-and-after record, tokens when observed | Outline 73 | Deck 02:114-121 | `context_comparison.md`, no cell pre-filled | Prediction length, line count equals 75 and `wc -l`, non-placeholder cells | full structure; contents self-reported |

Tasks not traced to the outline: integer-cent pricing fix (useful vehicle), rejecting the untrusted comment (useful extension, taught in deck 01:492 and 02:318). None is unnecessary scope.

## Scorecard
| Dimension | v1 | v2 | Weight | Points | Evidence summary |
|:---|---:|---:|---:|---:|:---|
| Catalog alignment and completeness | 3.5 | 4 | 15 | 12.0 | `/context` and before/after record now required at Basic with `N/A` rejected; Glob/Grep retrieval still leaves no evidence |
| Slide grounding and learning progression | 4 | 4 | 15 | 12.0 | Concepts taught beforehand; but launch slide 02:452 still lists both globs that the README now asks learners to derive, and the deck omits the prediction and `/context` steps |
| Technology fidelity and relevance | 3 | 3.5 | 15 | 10.5 | Two controlled Claude Code sessions are in the required path; a `shared` reading is accepted and cannot be told from a live one |
| Authentic hands-on problem solving | 4 | 4 | 15 | 12.0 | Same coherent e-commerce problem; Before column is now observed, not pre-filled |
| Executable contract and technical correctness | 3 | 4 | 15 | 12.0 | Glob matching, conflict removal and formula checks reject the v1 bad configurations; free text and some wording variants still pass (below) |
| Engagement, collaboration, and feedback | 3.5 | 4 | 10 | 8.0 | Written prediction before any run; share-out is budgeted as two volunteer pairs in minutes 23-25; no scripted instructor debrief |
| Scaffolding, timing, and participation access | 4 | 3.5 | 10 | 7.0 | Basic now needs two fresh sessions plus two `/context` reads inside 25 minutes; the minute-19 fallback covers only `pricing.py` |
| Developer workflow and technical judgment | 4.5 | 4.5 | 5 | 4.5 | Bounded prompts, repair prompt with exact failure text, human judgment checkpoint |
| **Total** | **72.0** | **78.0** | **100** | **78.0** | |

## Critical Conditions and Caps
| Condition (cap) | Result | Evidence |
|:---|:---|:---|
| Main deliverable is a form or worksheet (39) | cleared | Learners edit `CLAUDE.md`, a rule file and `pricing.py`; the record is supporting |
| Finish without changing or running the technical artifact (39) | cleared | Starter fails all 5 checks (10 issues, as documented) |
| No deterministic verification of the core behavior (59) | cleared, and no longer borderline | Rule scope is now verified by glob matching (probes C, C1, C3 rejected) |
| Solution does not run or starter broken (59) | cleared | Solution exits 0; starter fails only intended checks |
| Technology unavailable or not taught (59) | cleared | Decks 01 and 02 teach it before the lab |
| Task cannot fit the allocation (69) | cleared, tight | See Learner Workflow and Moderate 5 |

## Technical Verification
Runs used `PYTHONDONTWRITEBYTECODE=1` in place for the real trees, and temp copies for probes. Both repos' `git status` were unchanged by the runs.

| Command or check | Expected | Actual | Result |
|:---|:---|:---|:---|
| `cd start && python3 verify_lab.py` | 5 FAIL, 10 issues (README section 4) | 5 FAIL, 10 issues; `CLAUDE.md has 75 lines`; the `float` error now prints once | pass (v1 duplicate-count defect fixed) |
| `cd solution && python3 verify_lab.py` | all pass, exit 0 | 5 PASS, `ALL LAB 2.1 CHECKS PASSED!` | pass |
| `pytest -q` in `start/` and `solution/` | 4 failed 1 passed; 5 passed | same | pass |
| Start vs solution parity | 4 files differ | `CLAUDE.md`, `.claude/rules/orders.md`, `context_comparison.md`, `services/orders/pricing.py` | pass |
| Documented line counts | start 75, solution 18 | `wc -l`: 75 and 18 (README, verifier constant and solution record agree) | pass (v1 stale 95/22 fixed) |
| Probe C: rule `paths: "**/*"` | reject | rejected | pass (v1 gap closed) |
| Probe C1: only `services/orders/**/*.py` (no tests glob) | reject | rejected | pass |
| Probe C3: real path `services/**`, correct globs only in a YAML comment | reject | rejected | pass |
| Probe C2: rule without the half-up formula | reject | rejected | pass (v1 gap closed) |
| Probe G: a test renamed so it does not run | reject | rejected (fewer than 5 tests) | pass |
| Probe H: After line count wrong | reject | rejected | pass |
| Probe C4: rule body says "use float freely" | reject | passes (check is on keywords `float`, `cents`) | gap, minor |
| Probe B: `CLAUDE.md` adds "Legacy callers may ignore idempotency_key and use float totals." | reject | passes (the check matches fixed strings only) | gap |
| Probe I: `CLAUDE.md` adds "Do not use nosetests." | accept (good guidance) | rejected: substring `nosetests` | false positive |
| Probe D: Instruction Adherence cell `xxx` | reject | passes (`PLACEHOLDERS` has `x`, `xx` but not `xxx`) | gap |
| Probe E: judgment note is 40 letters `a` | reject | passes (length only) | gap |
| Probe E2: `/context` Before cell `asdfasdfasdfasdf` | reject | passes (length at least 15) | gap |
| Live `/context`, rule loading, `Glob`/`Grep` in Claude Code | rule absent for `notifier.py`, present for orders files | not run | unverified |

## Learner Workflow and Time Use
| Phase | Estimated minutes | Learner action | Cognitive mode | Output or feedback |
|:---|---:|:---|:---|:---|
| 0-5 Baseline | 5 | Write prediction, run verifier, read `CLAUDE.md`, open a controlled session, `/context`, fill Before | Active, then constructive (individual commitment) | Red verifier output; live `/context` |
| 5-11 Refactor guidance | 6 | Trim `CLAUDE.md`, derive globs, write three invariants | Constructive, interactive | Verifier checks 1-2 |
| 11-19 Scoped fix | 8 | Retrieve `pricing.py`, prompt, review, complete TODOs, role swap | Constructive, interactive | Test results, repair prompt |
| 19-23 Verify and compare | 4 | Run verifier, fresh session, `/context`, fill After and notes | Constructive | `ALL LAB 2.1 CHECKS PASSED!` |
| 23-25 Share-out | 2 | Two pairs report 1 minute each; others finish the record | Interactive | Peer comparison; no instructor closure |

About 14 of 25 minutes change and run the artifacts. The window is feasible only if a controlled session starts in under a minute; two session starts plus two `/context` reads is the new risk (Moderate 5).

## Findings
### Blockers
None.

### Major
None.

### Moderate
1. **Launch slides are stale and still give away the globs.** `day1/slides/02-how-claude-code-manages-context.md:452` lists `services/orders/**/*.py` and `tests/orders/**/*.py`, and `:190` shows the first one in the rule example, while README Step 1.3 now asks learners to derive them. Slides 421-424 and 449-456 omit the prediction, the two `/context` readings and the controlled session. Learner impact: the derivation step collapses to copying, and the deck contradicts the README. Smallest fix (slide-remediable): replace the glob line with "derive the globs from the directory tree and the failing tests", and add the prediction and `/context` readings to the pacing and task slides.
2. **Verifier rejects good guidance and misses reworded bad guidance.** `verify_lab.py:23-31` matches fixed substrings: "Do not use nosetests." is rejected (probe I), and "Legacy callers may ignore idempotency_key and use float totals." passes (probe B). Learner impact: a correct negative instruction is punished with a misleading error, and a reworded legacy line survives. Smallest fix: evaluate line by line; flag a line only if it contains a legacy marker and no negation (`not`, `never`, `don't`, `avoid`), and add `ignore idempotency_key`, `float totals`, `nosetests` as markers.
3. **Free-text evidence accepts junk.** `verify_lab.py:154-162,224-226`: `xxx` (probe D), 40 repeated letters (probe E) and gibberish `/context` text (probe E2) pass. Learner impact: the record the catalog calls the lab outcome is not checked for content. Smallest fix: add `xxx`-style repetition to `_real` (reject a value with fewer than 3 distinct characters), require judgment notes to contain a keyword (`untrusted` or `LLM01`; `permission`, `sandbox` or `load`), and, once the live output is known (Moderate 4), require the After `/context` cell to mention `CLAUDE.md`.
4. **The expected live behavior was never recorded from a real session.** `solution/context_comparison.md` reads "Model / CLI Version: Claude Code (record the output of `claude --version`)" and quotes expected `/context` lines that were written, not observed; the same is true of the Stretch claim that `orders.md` stays unloaded until an orders file is read. Learner impact: if the real output differs (version-dependent), learners compare against a wrong reference and the instructor cannot say so. Smallest fix: one timed run in a real session, paste the real lines and version into the solution record, and note the version the lab was validated on.
5. **Timing is unmeasured and the fallback covers one step.** The Basic path now has two fresh `claude` launches, two `/context` reads, a prediction, a refactor, a code fix and the record in 25 minutes. The minute-19 fallback (copy `pricing.py`) does not help if minutes 0-11 overrun. Smallest fix: run it once with a stopwatch; if it overruns, move the After reading to a single combined step or allow a transcript-based Before reading, and extend the fallback to "copy `solution/.claude/rules/orders.md` at minute 11".
6. **File-search retrieval still leaves no evidence.** README Step 2.1 tells learners to use `Glob`, `Grep`, `Read`; nothing records that they did. Catalog line 71 promises it. Smallest fix: add one row to `context_comparison.md` ("which tool found `pricing.py`, and the query used"), checked as non-placeholder.

### Minor
1. The `Control Read` row accepts any three-character value, since only `_real` is applied; a stricter rule is `N/A` or a non-placeholder of at least 15 characters.
2. No scripted instructor debrief that compares predictions with the `/context` result; the share-out is learner-led.
3. `Observation Source: live` cannot be distinguished from `shared`; fine for a classroom, worth one sentence in the instructor notes.

## What Works
- A rule scoped wrongly, too broadly or without tests no longer passes; the glob matcher handles `**/` and `*` correctly and was probe-tested with four mutations.
- The starter fails exactly as documented (10 issues), the solution passes, and the trees differ in exactly four files.
- The Before column is observed, not pre-filled; a written prediction comes first, so there is an individual commitment before pairing.
- Numbers are consistent across README, verifier and records (75, 18, under 60, 10 issues, Python 3.10+).
- Bounded prompts, an exact-failure repair prompt and a human judgment checkpoint are retained.

## Prioritized Improvement Plan
1. Record one real Claude Code run (`/context` lines, CLI version, stopwatch), put it in the solution record and the deck notes. Resolves Moderate 4 and 5; makes Moderate 3's content check possible. About +1 to +2 points (technology fidelity, scaffolding).
2. Make the verifier line-based and keyword-aware for conflicting guidance and free text (`verify_lab.py`, both trees). Resolves Moderate 2 and 3. About +1.5 points (executable contract 4 to 4.5).
3. Update deck 02 launch slides to match the README (derive the globs, add prediction and `/context` steps, rebuild `day1/html/`). Resolves Moderate 1. About +1.5 points (slide grounding 4 to 4.5).
4. Add the retrieval-evidence row. About +0.5 point.

Projected score after steps 1 to 4: about 83 to 85.

## Re-evaluation Checklist
- [ ] `solution/context_comparison.md` holds `/context` lines and a CLI version copied from a real session.
- [ ] A timed dry run finishes Basic inside 25 minutes.
- [ ] Probe I accepted ("Do not use nosetests."); probes B, D, E and E2 rejected.
- [ ] Deck 02 slide 452 no longer lists the globs; the pacing slide mentions the prediction and `/context` readings.
- [ ] `context_comparison.md` has a retrieval-evidence row and the verifier checks it.
- [ ] `pytest -q` and `python3 verify_lab.py` still agree in `start/` and `solution/`; `git status` clean after the runs.

## Comparison With Prior Record
v1 (72.0) findings and what happened:
| v1 finding | Status in v2 |
|:---|:---|
| Major 1: verifier does not test the configuration | Fixed: glob matching, conflict removal, formula (probes C, C1, C2, C3) |
| Major 2: `/context` optional, Before column pre-filled | Fixed in README and records; live behavior still unverified (Moderate 4) |
| Moderate 1: stale numbers (95, 22, `<=60`, `under 50`, Python 3.11, `fnmatch`) | Fixed |
| Moderate 2: answers supplied before the learner decides | Partly fixed in README (globs derived); still in deck 02:190, 452 (Moderate 1) |
| Moderate 3: no individual commitment | Fixed (written prediction); instructor closure still absent (Minor 2) |
| Moderate 4: share-out unbudgeted | Fixed (two volunteer pairs, minutes 23-25) |
| Moderate 5: comparison check loose (`** TODO`) | Fixed for `TODO`; junk values still pass (Moderate 3) |
| Minor 1: duplicate `float` error counted in "8 issues" | Fixed (10 issues, once) |
| Minor 2: "controlled session" undefined | Fixed (README section 4) |
| Minor 3: deck lists one glob | Fixed in the deck's task slide, but now conflicts with Moderate 1 |

## Breakout Slide Handoff
- Status: eligible with slide corrections (not run: this pass was an evaluation and suggestion request only)
- Evaluation report: `/Users/kangs/code/github/context-claude/llm-context/evaluations/courseware/day1-structuring-project-context/20261120-v2-course-breakout-exercise-evaluator.md`
- Primary repository: `/Users/kangs/code/github/context-claude`
- Companion repository: `/Users/kangs/code/github/context-claude-companion`
- Companion README: `/Users/kangs/code/github/context-claude-companion/labs/day1/lab2_1/README.md`
- Outline and placement: `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md`, Day 1, Topic 2, Lab 2.1, 25 min
- Existing deck candidates: `day1/slides/02-how-claude-code-manages-context.md:396-480`; built `day1/html/02-how-claude-code-manages-context.html`
- Diagram candidates: `day1/diagrams/01-path-scoped-rule-activation.{excalidraw,svg,png}`
- Unresolved findings: none at Blocker or Major; Moderate 1 is slide-remediable and is the correction to pass to the slide creator
