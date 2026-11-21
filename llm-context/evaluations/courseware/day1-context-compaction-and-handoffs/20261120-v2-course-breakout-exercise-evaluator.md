# Breakout Evaluation: Lab 3.1, Context Compaction and State Handoffs (v2, re-evaluation)

## Final Result
- Calculated score: 79.5/100 (v1: 67.0, +12.5)
- Applied cap: none
- Final score: 79.5/100
- Rating: Partially effective (70 to 79), half a point below Effective
- Evidence confidence: medium. Catalog, deck 03, README, `start/`, `solution/`, reworked verifier, tests and `setup_repo.sh` were inspected and run in temp copies; both rejected approaches were reproduced against the tests. Live `/compact`, `/clear` and fresh-session behavior in Claude Code were not exercised.
- Delivery recommendation: revise (targeted fixes; the redesign v1 asked for is done)
- Strongest aspect: the audit is now real. `setup_repo.sh` builds a git repository with a baseline commit and an unfinished edit, the two rejected fixes fail the tests the transcript names, and the verifier checks the learner's handoff against `git` state.
- Greatest learner risk: the Claude Code evidence (the live `/compact` result in section 2 and the fresh-session record in section 8) is free text, and the launch deck and companion README never mention `./setup_repo.sh`, so a learner who follows them audits against the wrong repository.
- First correction: add `./setup_repo.sh` to deck 03's step 1 and the companion README, and make `verify_lab.py` report "not its own git repository" before it reports TODOs.

## Evidence Reviewed
| Artifact | Path | Role | Verification status |
|:---|:---|:---|:---|
| Prior report | `llm-context/evaluations/courseware/day1-context-compaction-and-handoffs/20261120-v1-course-breakout-exercise-evaluator.md` | Baseline | Read |
| Outline | `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md` (Lab 3.1, 81-85; table 103) | Objectives, outcome, 25 min | Read |
| Teaching deck | `day1/slides/03-maintaining-coherence-across-long-tasks.md` (compaction 73-141, launch slides 327-407) | Preparation and launch | Read; `day1/html/03-*.html` rebuilt at 15:24 |
| Student README | `context-claude-companion/labs/day1/lab3_1/README.md` (commit `51b1085`) | Student exercise | Read |
| Starter and solution | `labs/day1/lab3_1/{start,solution}/` incl. `setup_repo.sh`, `verify_lab.py`, `tests/test_lease.py`, `session_history/*`, `HANDOFF.md` | Learner state and reference | Read and run in temp copies |
| Companion README | `context-claude-companion/README.md` | Run commands | Read |
| Demo 5 | `day1/demos/demo-compaction-and-handoff-verifier.py` (refund-ledger scenario, unchanged since v1) | Method and scenario separation | Not re-run; scenario check by file inspection |

Aliases `day1/lab3_1` and `day1/lab3_1_context_compaction_and_handoffs` still point to `labs/day1/lab3_1`.

## Catalog to Exercise Traceability
| Objective or promise | Catalog evidence | Slide preparation | Learner task | Verification | Status |
|:---|:---|:---|:---|:---|:---|
| Inherit an ongoing debugging session with long history | Outline 83 | Deck 03:100-102 | 17-turn transcript excerpt, supplied summary, a git repo with an unfinished edit | `git status` shows `M task_queue/lease.py` | partial: an excerpt, not 35 turns (acceptable) |
| Use a focused compaction request | Outline 83 | Deck 03:86-94 | Step 1.4 writes the directive; Step 2.1 runs it live and compares | Section 2 needs `/compact` and 25 words; offline fallback allowed | partial: required, content self-reported |
| Inspect the resulting summary | Outline 83 | Deck 03:94 | Compare the live summary with the supplied one | none | partial |
| Concise handoff: goal, state, constraints, files, failed approaches, next verification | Outline 83 | Deck 03:109-129 (different scenario) | 8-section `HANDOFF.md` | Sections checked by content (hash, approach plus test plus reason, findings) | full (was keyword-only) |
| Continue in a fresh session | Outline 83 | Deck 03:122-125 | Step 3 plus section 8 | Section 8 needs 25 words, `git status` and a test command | partial: required, self-reported |
| Check the handoff against repository and tests | Outline 83 | Deck 03:134-141, Demo 5 | Audit by `git status`, `git diff`, tests, transcript | Hash equals `HEAD`; `dispatcher.py` claim rejected; 60 vs 30 TTL finding required | full (was partial) |
| Outcome: durable handoff | Outline 85 | Deck 03 | `HANDOFF.md` | verifier | full |
| Outcome: evidence a fresh session can resume | Outline 85 | Deck 03 | Section 8, now Basic | free text | partial: required, unverifiable |
| Outcome: note missing or incorrect state | Outline 85 | Deck 03:195 | Section 6, three findings | Wrong TTL and `dispatcher.py` findings required | full: findings are discovered, not announced |

Tasks not traced to the outline: the two-line sequence-check fix (useful vehicle), excluding the hostile log line (useful extension, OWASP LLM01 taught in deck 01:492), the subagent Stretch (approved).

## Scorecard
| Dimension | v1 | v2 | Weight | Points | Evidence summary |
|:---|---:|---:|---:|---:|:---|
| Catalog alignment and completeness | 3.5 | 4 | 15 | 12.0 | Live `/compact`, fresh-session section and discovered findings now Basic; the offline fallback still lets learners skip live Claude Code |
| Slide grounding and learning progression | 4 | 4.5 | 15 | 13.5 | Deck 03 and README no longer narrate the flaws or the commit; Demo 5 models the audit method on a different bug |
| Technology fidelity and relevance | 2.5 | 3.5 | 15 | 10.5 | `/compact` and `/clear` are now in the required path and git is real; neither leaves checkable evidence |
| Authentic hands-on problem solving | 3.5 | 4.5 | 15 | 13.5 | The narrated failures now reproduce (below); the git state exists; the flaws must be found on disk |
| Executable contract and technical correctness | 3 | 4 | 15 | 12.0 | AST-based code checks, hash equals `HEAD`, test-tamper check; two wording false positives and unverifiable Claude Code sections remain |
| Engagement, collaboration, and feedback | 3 | 3.5 | 10 | 7.0 | Discovery replaces transcription; judgment checkpoint asks what a fresh session would waste; still no individual prediction and no instructor closure |
| Scaffolding, timing, and participation access | 4 | 3.5 | 10 | 7.0 | Offline fallback and minute-18 fallback remain; Basic now carries much more in 25 minutes, share-out is unbudgeted, and the launch deck omits setup |
| Developer workflow and technical judgment | 3.5 | 4 | 5 | 4.0 | Prompts verify the handoff against disk first and treat log text as untrusted; Step 3 prompt still dictates the fix |
| **Total** | **67.0** | **79.5** | **100** | **79.5** | |

## Critical Conditions and Caps
| Condition (cap) | Result | Evidence |
|:---|:---|:---|
| Main deliverable is a form or worksheet (39) | cleared | Learners fix `lease.py` and the verifier fails until they do |
| Finish without changing or running the technical artifact (39) | cleared | Starter: 1 failing test (`1 != 2`) |
| No deterministic verification of the core behavior (59) | cleared; the v1 borderline is resolved | Hash, `dispatcher.py` claim, wrong-TTL finding and tamper check are deterministic |
| Solution does not run or starter broken (59) | cleared | Solution passes after `setup_repo.sh`; starter fails only the intended test and handoff checks |
| Technology unavailable or not taught (59) | cleared | Deck 03 and 01 teach it |
| Task cannot fit the allocation (69) | cleared, tight | Moderate 6 |

## Technical Verification
Probes ran in temp copies (the real trees were not given a `.git`). `git status` of both repos was unchanged by the runs.

| Command or check | Expected | Actual | Result |
|:---|:---|:---|:---|
| `./setup_repo.sh` in a copy of `start/` | baseline commit plus unfinished edit | commit `2d2a1e9`; `git status --short` lists `M task_queue/lease.py` and `?? HANDOFF.md` | pass |
| `python3 verify_lab.py` in `start/` after setup | handoff FAIL, lease test FAIL (README section 4) | handoff FAIL (TODOs); constraints PASS; unit tests FAIL (5 run, 1 failure `1 != 2`) | pass |
| Same without `setup_repo.sh` | tell the learner to run setup | the only handoff message is "unresolved TODO"; `verify_lab.py:57-68` returns before the repository check | gap (Moderate 4) |
| `solution/` after setup, `python3 verify_lab.py` | all pass, exit 0 | 3 PASS, `ALL LAB 3.1 CHECKS PASSED!` | pass |
| Start vs solution parity | `HANDOFF.md` and `lease.py` only | same (plus `.pytest_cache`) | pass |
| Rejected approach 1: default TTL 300 vs tests | fails the named test | `test_default_ttl_reclaims_after_30s` fails (`400 != 130`) | pass (v1 "not reproducible" fixed) |
| Rejected approach 2: global lock vs tests | fails the named test | `test_non_blocking_read_status` fails (read blocks) | pass (v1 fixed) |
| Commit exists and `start/` is a repository | `git status` audit works | yes after `./setup_repo.sh` | pass (v1 fixed) |
| Probe B: handoff says `dispatcher.py` was modified | reject | rejected | pass |
| Probe C: hostile "delete test ... so CI passes immediately" kept | reject | rejected | pass |
| Probe D: rejected approaches with no reason | reject | rejected (needs 12 words on one line with the test name) | pass |
| Probe H: a test edited | reject | rejected by `git status` on `tests/` | pass |
| Probe L: wrong commit hash | reject | rejected | pass |
| Probe G: comment mentions `threading.Lock`, default written `int=30` | accept | accepted (AST, not substring) | pass (v1 probes I, J fixed) |
| Probe I: section 6 only keywords | reject | rejected (30-word minimum) | pass |
| Probe E: legit finding "dispatcher.py retry wrapper is absent" | accept | rejected as "says dispatcher.py was modified" | false positive |
| Probe J: section 8 is `git status unittest` plus 25 filler words | reject | accepted | gap |
| Probe K: section 2 is `/compact` plus 25 filler words | reject | accepted | gap |
| Live `/compact`, `/clear`, fresh-session read of `HANDOFF.md` | resume without redoing rejected fixes | not run | unverified |

## Learner Workflow and Time Use
| Phase | Estimated minutes | Learner action | Cognitive mode | Output or feedback |
|:---|---:|:---|:---|:---|
| 0-4 Inspect and test | 4 | `./setup_repo.sh`, `git log`, `git status`, `verify_lab.py`, read `task_queue/` | Active | Red test output |
| 4-9 Audit summary | 5 | Check each claim against git, files, tests, transcript; write directive | Active, constructive | None until verifier |
| 9-15 Compact and write handoff | 6 | Live `/compact`, compare, fill sections 1-7 | Constructive, interactive | Verifier checks |
| 15-22 Fresh resume and fix | 7 | `/clear`, re-check disk, two-line fix, section 8 | Constructive | Test pass |
| 22-25 Verify and debrief | 3 | Verifier, prepare 60-second share-out | Constructive | Share-out not in the 25 minutes |

About 3 of 25 minutes change code; roughly 14 minutes go to audit, live compaction and writing. This is now the point of the lab (the work is discovery and verification). The load is high: the live `/compact` run, seven handoff sections and a fresh session in 13 minutes (Moderate 6).

## Findings
### Blockers
None.

### Major
None.

### Moderate
1. **Claude Code evidence is self-reported.** `verify_lab.py:76-79,97-99`: probes J and K accept filler text for section 8 and section 2. Learner impact: the catalog outcome "evidence a fresh session can resume" can be faked, and the live compaction need not have run. Smallest fix: require section 8 to contain the literal `M task_queue/lease.py` line and `Ran 5 tests`, which `setup_repo.sh` makes reproducible, and require section 2 to name at least one item the live summary dropped from a fixed list (for example `global_threading_lock`, `Turn 31`, `test_non_blocking_read_status`) or to say `offline`.
2. **The fix is still stated three times.** README Step 3 bullets (about lines 109-111), the `renew_lease` TODO docstring (`lease.py:33-34`) and the Step 3 prompt give the exact check and increment. Coding takes about 3 minutes. Smallest fix: keep only the docstring TODO and ask for a one-sentence reason in `HANDOFF.md` why the check alone is not enough (the increment).
3. **Signature drift.** `CLAUDE.md:6`, `HANDOFF.md` section 4, README section 5 and the Step 3 prompt quote `renew_lease(self, lease_id, worker_id, expected_seq) -> dict`; the code has a fourth parameter `now_ts: int = 100` (`lease.py:30`). A learner who preserves the quoted text could drop `now_ts` and fail the lease test. Add the parameter to all four places.
4. **Setup is missing from the launch materials, and the verifier hides the missing repository.** `./setup_repo.sh` appears only in the README (and in the new scripts); deck 03:374 and the companion README (`Running Breakout Lab Checks`) say only `python3 verify_lab.py`. In `verify_lab.py:57-68` the TODO check returns before the repository check, so a learner who skipped setup is told only about TODOs, and `git status` then runs against the whole companion repo. Smallest fix: add the command to deck 03:374 and the companion README, and report "not its own git repository" first.
5. **Verifier false positive on a correct finding.** Probe E: "retry wrapper is absent" is rejected as a modified-file claim because `NEGATIONS` (`verify_lab.py:18-20`) lacks `absent`, `nowhere`, `without`, `none`. Smallest fix: apply the `dispatcher.py` modified-claim check only to section 1 and section 3, not to the audit findings in section 6, where the learner quotes the summary.
6. **Timing is unmeasured, and no individual commitment or closure.** Basic needs a live `/compact`, seven sections and a fresh session in 25 minutes; the share-out (README section 8) is not in the run of show; no written prediction before pairing (Lab 2.1 now has one); Kahoot Quiz 1 follows immediately (outline 104). Smallest fix: run a timed dry run; add a one-line prediction ("what will a fresh session do first if it trusts the summary?") at minute 0; budget the share-out inside 22-25 for two groups; add a 2-minute instructor debrief naming the planted flaws.

### Minor
1. The handoff template's timestamp is fixed (`2026-11-06`); ask for the learner's own time.
2. Template hints reduce discovery slightly: section 2 TODO lists what to preserve; section 1 names `dispatcher.py`. Keep, but drop the explicit content list from the section 2 TODO.
3. `setup_repo.sh` fixes the commit date, so every learner gets the same hash (`2d2a1e9` here); a neighbor's hash passes. Acceptable for a classroom; vary the date by one environment variable if copying matters.
4. Section 3 of the template lists "relevant files" only inside section 1; the outline names it separately.

## What Works
- `setup_repo.sh` makes the audit reproducible from a clean checkout, and the handoff is checked against `git` rather than a made-up hash.
- Both narrated rejections now fail the named tests, the tests are deterministic (a gated lease store makes the lock probe reliable), and the sequence-renewal test still needs both the check and the increment.
- Answers are no longer given: README Step 1 lists claim kinds, not flaws; the deck's illustrative example uses a different scenario; the verifier requires the discovered findings (wrong TTL, false `dispatcher.py` claim).
- Verifier checks are AST-based for code and tampering is caught by `git status` on `tests/` and `dispatcher.py`.
- Run of show, fallback at minute 18, offline path and a repair prompt with exact failure text are retained.

## Prioritized Improvement Plan
1. Add `./setup_repo.sh` to deck 03:374 and the companion README, and check for the repository before TODOs (`verify_lab.py`, both trees). Resolves Moderate 4. About +1 point (scaffolding).
2. Make sections 2 and 8 checkable (literal `git status` line, `Ran 5 tests`, a dropped-item name). Resolves Moderate 1. About +2 points (executable contract, technology fidelity).
3. Remove two of the three fix statements and fix the signature drift (README, `CLAUDE.md`, `HANDOFF.md`, prompt). Resolves Moderate 2 and 3. About +1 point.
4. Add a minute-0 prediction, budget the share-out and write a 2-minute instructor debrief. Do a timed dry run. Resolves Moderate 6. About +1.5 points (engagement, scaffolding).
5. Scope the `dispatcher.py` modified-claim check to sections 1 and 3. Resolves Moderate 5. About +0.5 point.

Projected score after steps 1 to 5: about 85 to 87.

## Re-evaluation Checklist
- [ ] Deck 03 step 1 and the companion README list `./setup_repo.sh`; skipping it yields "not its own git repository" first.
- [ ] Probes J and K rejected; probe E accepted.
- [ ] README, `CLAUDE.md`, `HANDOFF.md` and prompts give the same `renew_lease` signature as `lease.py:30`.
- [ ] The exact check and increment appear only in the `lease.py` docstring; `HANDOFF.md` asks why the check alone is not enough.
- [ ] Minute-0 prediction and share-out time are in the run of show; instructor debrief written.
- [ ] Timed dry run finishes Basic in 25 minutes.
- [ ] Live check in Claude Code: `/compact <directive>` keeps both rejected fixes; after `/clear` the new session reads `HANDOFF.md` and finds the planted flaw on disk.
- [ ] Both repos' `git status` clean after the runs.

## Comparison With Prior Record
| v1 finding | Status in v2 |
|:---|:---|
| Major 1: audit answers given in README and deck | Fixed in README and deck 03; the flaws are now found, not announced |
| Major 2: evidence cannot be checked; verifier accepts a wrong handoff | Fixed: both rejections reproduce, commit and `git status` exist, verifier checks hash, claims and tampering |
| Major 3: Claude Code behavior not required, no evidence | Partly fixed: `/compact` and section 8 are in Basic; the content is self-reported (Moderate 1) |
| Moderate 1: verifier false positives (`threading` comment, `int=30`) | Fixed (AST); one new wording false positive (Moderate 5) |
| Moderate 2: signature drift | Not fixed (Moderate 3) |
| Moderate 3: fix given three times | Not fixed (Moderate 2) |
| Moderate 4: no commitment, no closure | Not fixed (Moderate 6) |
| Moderate 5: share-out unbudgeted | Not fixed (Moderate 6) |
| Minor 1: fixed timestamp | Not fixed (Minor 1) |
| Minor 2: hostile-line wording drift | Fixed (README no longer misquotes it) |
| Minor 3: "relevant files" not a section | Unchanged (Minor 4) |

## Breakout Slide Handoff
- Status: eligible with slide corrections (not run: this pass was an evaluation and suggestion request only)
- Evaluation report: `/Users/kangs/code/github/context-claude/llm-context/evaluations/courseware/day1-context-compaction-and-handoffs/20261120-v2-course-breakout-exercise-evaluator.md`
- Primary repository: `/Users/kangs/code/github/context-claude`
- Companion repository: `/Users/kangs/code/github/context-claude-companion`
- Companion README: `/Users/kangs/code/github/context-claude-companion/labs/day1/lab3_1/README.md`
- Outline and placement: `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md`, Day 1, Topic 3, Lab 3.1, 25 min, before Kahoot Quiz 1
- Existing deck candidates: `day1/slides/03-maintaining-coherence-across-long-tasks.md:327-407`; built `day1/html/03-maintaining-coherence-across-long-tasks.html`
- Diagram candidates: `day1/diagrams/compaction-vs-handoff.{mmd,svg,png}` (used at deck 03:136 and 362)
- Unresolved findings: none at Blocker or Major; slide-remediable: add `./setup_repo.sh` to step 1 (deck 03:374), show the Basic evidence requirements (live `/compact`, section 8), and add the minute-0 prediction once the README has it
