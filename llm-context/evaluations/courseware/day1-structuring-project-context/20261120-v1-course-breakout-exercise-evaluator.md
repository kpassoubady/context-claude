# Breakout Evaluation: Lab 2.1, Structuring Project Context with `CLAUDE.md`

## Final Result
- Calculated score: 72/100
- Applied cap: none (no cap condition is met; see Critical Conditions and Caps)
- Final score: 72/100
- Rating: Partially effective (70 to 79)
- Evidence confidence: medium. The catalog, slides, README, `start/`, `solution/`, both verifiers, and the demo and prior reports were inspected, and the Python checks were run. Live Claude Code behavior (`/context`, path-scoped rule loading, file-search tools) was not exercised, and the lab's central claim depends on it.
- Delivery recommendation: revise
- Strongest aspect: a realistic, deterministic Python scenario with a real prompt-injection trap (`pricing.py:4-6`), a starter that fails exactly as documented, and a solution that passes.
- Greatest learner risk: a learner can reach `ALL LAB 2.1 CHECKS PASSED!` without using Claude Code, without scoping the rule correctly, and without removing the conflicting guidance, so the lab does not prove its own objective.
- First correction: make `verify_lab.py` test the context configuration itself (parse `paths:`, `fnmatch` the globs against the start files, assert the conflicting lines are gone), then require one live `/context` observation at Basic.

## Evidence Reviewed

| Artifact | Path | Role | Verification status |
|:---|:---|:---|:---|
| Outline | `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md` (Lab 2.1, lines 69-73; table line 100) | Authority for objectives, outcome, 25 min | Read |
| Teaching deck | `day1/slides/02-how-claude-code-manages-context.md` (lifecycle 58-262, enforcement 318, launch slides 396-480) | Preparation and launch slides | Read |
| Earlier deck | `day1/slides/01-from-prompt-engineering-to-context-engineering.md:492` | Teaches OWASP LLM01 before the lab | Read |
| Student README | `/Users/kangs/code/github/context-claude-companion/labs/day1/lab2_1/README.md` | Student exercise | Read |
| Starter | `labs/day1/lab2_1/start/` (`CLAUDE.md`, `AGENTS.md`, `.claude/rules/orders.md`, `services/`, `scripts/`, `tests/`, `verify_lab.py`, `context_comparison.md`) | Learner starting state | Read and run |
| Solution | `labs/day1/lab2_1/solution/` (same tree) | Reference | Read and run |
| Aliases | `day1/lab2_1`, `day1/lab2_1_structuring_project_context` | Symlinks to `labs/day1/lab2_1` | Confirmed identical target; no ambiguity |
| Companion README | `context-claude-companion/README.md` | Environment claims | Read |
| Demo and research | `day1/demos/demo-instructions-vs-permissions-hooks.py` scope, `llm-context/research/day1/02-*-research.md:33-53` | Rule-loading semantics, duplication | Read |
| Prior records | `llm-context/issues/20261112-v1-lab2_1-breakout-exercise-evaluator-report.md`, `llm-context/evaluations/courseware/day1/20261120-v1-course-demo-evaluator.md` | Comparison | Read |
| Standards | `.claude/docs/courseware/technology-grounded-activity-standards.md`, `engagement-standards.md` | Rubric basis | Read |

Missing reference: `docs/review/evaluation-records.md` (named by the skill) does not exist in this repo. The skill's default store path is used.

## Catalog to Exercise Traceability

| Objective or promise | Catalog evidence | Slide preparation | Learner task | Verification | Status |
|:---|:---|:---|:---|:---|:---|
| Inspect a multi-component codebase with ambiguous guidance and conventions that apply to selected files | Outline 71 | Deck 02 "Designing `CLAUDE.md` and `.claude/rules/`" (153-196) | README Step 1: audit `CLAUDE.md` (3 components, 12 legacy columns, 2 checklists, conflicting test commands) | `verify_lab.py:11-26` | full |
| Create or refine a concise project-level `CLAUDE.md` | Outline 71 | Deck 02 lifecycle and structured-request slides | README Step 1.2; `<60` lines, keep `@AGENTS.md`, verify command | Line count, `@AGENTS.md`, `verify_lab.py` string, legacy rule string absent | full (conflict removal unverified, see Major 1) |
| Add a path-scoped rule for one component | Outline 71 | Deck 02:185-196 (near-identical `orders.md` example), diagram `01-path-scoped-rule-activation` | README Step 1.3 | `verify_lab.py:29-56` string checks only | partial: structure checked, scope never tested |
| Use Claude Code file-search tools to retrieve relevant files | Outline 71 | Deck 02 retrieval slides, structured-request slide (142) | README Step 2.1 (narrative, "Use Glob, Grep, Read") | none | partial: no required output |
| Inspect `/context` to see what guidance is available | Outline 71 | Deck 02:114-121 | README §7 Basic: reading "or `N/A (offline transcript)`" | none | partial: optional at Basic |
| Outcome: tested guidance configuration with verification commands | Outline 73 | Deck 02 | `CLAUDE.md` verification commands; pricing tests | `verify_lab.py` all 5 checks | full |
| Outcome: evidence the relevant instructions are available for a repeatable task | Outline 73 | Deck 02:258-262 ("verify actual loading with `/context`") | Stretch only (README §7) | none | missing at Basic |
| Outcome: before-and-after record of task results and context use; token reduction measured when observed | Outline 73 | Deck 02:114-121 | `context_comparison.md` | `verify_lab.py:70-77` (only rejects `\| TODO` or `: TODO`) | partial: table is pre-filled, one baseline value is wrong |

Tasks not traced to the outline: the integer-cent pricing fix with idempotency validation is a useful vehicle for the "repeatable task" the outcome mentions. Rejecting the untrusted comment in `pricing.py` is a useful extension, prepared by deck 01:492 and deck 02:318. Driver and Navigator pairing is a delivery choice. None is unnecessary scope.

## Scorecard

| Dimension | Rating | Weight | Points | Evidence summary |
|:---|---:|---:|---:|:---|
| Catalog alignment and completeness | 3.5 | 15 | 10.5 | Every outline activity has a README step; the `/context` and before/after evidence are optional or pre-filled at Basic |
| Slide grounding and learning progression | 4 | 15 | 12.0 | Deck 02 teaches startup vs on-demand, `paths:` syntax, `/context`, bounded requests; deck 01 teaches OWASP LLM01; launch slides and diagram exist. The deck shows the answer file almost verbatim |
| Technology fidelity and relevance | 3 | 15 | 9.0 | Real `CLAUDE.md`, `@AGENTS.md`, `.claude/rules/*.md` frontmatter and Python stdlib. Claude Code itself is optional: the whole Basic path runs in any editor |
| Authentic hands-on problem solving | 4 | 15 | 12.0 | One coherent e-commerce problem with contradictory commands, legacy float guidance and an injected source comment. The "before" experiment is asserted, not run |
| Executable contract and technical correctness | 3 | 15 | 9.0 | Pricing tests are strong and deterministic; the guidance checks are string checks that accept wrong configurations |
| Engagement, collaboration, and feedback | 3.5 | 10 | 7.0 | Pair roles, private read, judgment checkpoint, share-out prompts; no individual commitment before pairing, no instructor closure step |
| Scaffolding, timing, and participation access | 4 | 10 | 8.0 | Minute table, fallback at minute 19, three completion tiers, troubleshooting, offline path. Basic fits 25 min; Intermediate and Stretch do not |
| Developer workflow and technical judgment | 4.5 | 5 | 4.5 | Bounded prompts name files, signature, prohibitions, acceptance criteria and require verification; repair prompt uses exact failure text |
| **Total** | | **100** | **72.0** | |

## Critical Conditions and Caps

| Condition (cap) | Result | Evidence |
|:---|:---|:---|
| Main deliverable is a form or worksheet when technical practice is promised (39) | cleared | Learners edit `CLAUDE.md`, a rule file with frontmatter, and `pricing.py`, then run tests. `context_comparison.md` is supporting |
| Learners can finish without changing or running the relevant technical artifact (39) | cleared | `verify_lab.py` fails until `pricing.py` and the rule file change (starter: 8 issues) |
| No deterministic verification exists for the core behavior (59) | cleared, borderline | Pricing behavior and file structure are verified deterministically. Rule scope and conflict removal are not (Major 1). The cap would apply if the core behavior were read as "rule loads only for matching paths" |
| Solution does not run or starter broken by unrelated failures (59) | cleared | Solution exits 0; starter fails only the intended checks |
| Required technology unavailable or not taught before use (59) | cleared | Deck 02 and deck 01 teach every concept before the lab. Python 3.12.12 available; stdlib only |
| Documented task cannot fit the allocation (69) | cleared at Basic | See Learner Workflow. The Intermediate and Stretch tiers would not fit |

## Technical Verification
Runs used `PYTHONDONTWRITEBYTECODE=1` and `-p no:cacheprovider`. A scratch-copy command was denied, so every run was in place with no cache writes. `git status labs` is clean afterward.

| Command or check | Expected | Actual | Result |
|:---|:---|:---|:---|
| `python3 --version` | 3.10+ (companion README) | 3.12.12 | pass |
| `cd labs/day1/lab2_1/start && python3 verify_lab.py` | 5 checks FAIL, 8 issues (README §4, deck 02:449) | 5 FAIL; 8 issues; `CLAUDE.md has 74 lines`; 4 of 5 tests fail (float result type, no `ValueError` for a blank key, none for a bad subtotal or bps, `249.875 != 250`); notifications test passes | pass (matches). The `float` AST error is printed twice, so "8 issues" counts a duplicate |
| `cd labs/day1/lab2_1/solution && python3 verify_lab.py` | all pass, exit 0 | 5 PASS, `ALL LAB 2.1 CHECKS PASSED!`, exit 0 | pass |
| `python3 -m pytest -q -p no:cacheprovider` in `solution/` | 5 passed | 5 passed | pass |
| `python3 -m unittest discover -s tests -p "test_*.py"` in `solution/` | 5 OK | 5 OK | pass |
| `pytest -q` in `start/` | 4 failed, 1 passed (README §4) | 4 failed, 1 passed | pass |
| Start vs solution parity | same tree, differing in 4 files | `diff -rq` differs in only `CLAUDE.md`, `.claude/rules/orders.md`, `context_comparison.md`, `services/orders/pricing.py` | pass |
| Starter `CLAUDE.md` length | 95 lines (README §1; `context_comparison.md:12`) | 74 lines as the verifier counts them (75 per `wc -l`, which includes a trailing blank line) | fail: documented baseline is wrong |
| Solution `CLAUDE.md` length | 22 lines (solution `context_comparison.md:12`) | 18 lines | fail: solution record is wrong |
| In-memory probe A: `CLAUDE.md` of two lines (`@AGENTS.md`, `verify_lab.py`) | should the guide stay useful? | passes `check_root_claude_md` | gap (acceptable minimalism, but nothing checks the guide is useful) |
| Probe B: 8-line `CLAUDE.md` keeping "never require `idempotency_key`", float discount prose, `nosetests`, noise | should fail | passes | gap |
| Probe C: rule scoped to `"**/*"` with the two path strings in a comment | should fail | passes (`verify_lab.py:52` is a substring test on the frontmatter text) | gap |
| Probe C2: rule omitting the half-up rounding invariant | should fail | passes (`:54` checks only `idempotency_key` and `int`) | gap |
| Probe D: judgment notes and CLI version left as `** TODO` | should fail | passes (`:75` matches `\| TODO` and `: TODO` only; `:** TODO` slips through) | gap |
| Probe E: comparison table filled with `x` | should fail | passes | gap |
| Pricing test mutation reasoning | tests reject float, missing key, bad range, wrong rounding | each of the 4 pricing tests fails against the starter; each maps to an acceptance criterion in README §6 Step 2 | pass |
| Live `/context`, path-rule loading, `Glob`/`Grep` retrieval in Claude Code | rule absent for `services/notifications/`, present for `services/orders/` | not run (no interactive Claude Code session) | unverified |

## Learner Workflow and Time Use

| Phase | Estimated minutes | Learner action | Cognitive mode | Output or feedback |
|:---|---:|:---|:---|:---|
| 0-4 Baseline and audit | 4 (2 private read, 2 run and record) | Read `CLAUDE.md` and `pricing.py`, run `verify_lab.py`, fill baseline cells | Active, then constructive | Red verifier output (immediate) |
| 4-11 Refactor guidance | 7 | Cut 74 lines to under 60, write frontmatter and three invariants (all stated in README §6 Step 1) | Constructive, interactive (pair) | Verifier checks 1-2; Checkpoint 1 discussion |
| 11-19 Scoped fix | 8 | Retrieve `pricing.py`, prompt Claude Code, review generated change, complete `TODO 1` and `TODO 2` | Constructive, interactive; role swap | Test results; targeted repair prompt |
| 19-23 Verify and compare | 4 | Run verifier, fill the after column and two judgment notes | Constructive | `ALL LAB 2.1 CHECKS PASSED!` |
| 23-25 Share-out prep | 2 | Prepare a 60-second report | Constructive | Share-out itself is not in the 25 minutes (see Moderate 4) |

Roughly 15 of 25 minutes go to changing and running course artifacts, about 6 to reading and setup, and about 4 to evidence and record keeping. The practice window is well used. A live `/context` reading before and after (Intermediate) needs two Claude Code sessions, which is roughly 3 to 5 extra minutes and does not fit alongside the pricing fix.

## Findings
### Blockers
None.

### Major
1. **The verifier does not test the context configuration it exists to teach.** `verify_lab.py:11-26` and `:29-56`. Evidence: probes B, C and C2. A rule scoped to `"**/*"`, a `CLAUDE.md` that keeps "Never require `idempotency_key`" and the float prose, and a rule that omits the half-up formula all print `ALL LAB 2.1 CHECKS PASSED!` for those checks. The legacy-rule check keys on `LEGACY_FLOAT_DISCOUNT_RULE` and the exact string `use float(subtotal_cents)`, which the starter itself writes with backticks. Learner impact: a wrong or over-broad scope is rewarded, so the lab cannot show the learner that scoping worked. Smallest fix: parse the `paths:` list, `fnmatch` each glob against `services/orders/pricing.py` (must match), `tests/orders/test_pricing.py` (must match) and `services/notifications/notifier.py` (must not match); assert `CLAUDE.md` contains none of `nosetests`, `skip idempotency`, `float(subtotal_cents)`; require the half-up formula in the rule body.
2. **The Claude Code mechanism is optional at Basic, and the before-and-after record is mostly pre-filled.** README §7 line 140 allows `N/A (offline transcript)` for `/context`; the rule-stays-unloaded observation is Stretch only (line 142); `context_comparison.md:12-17` ships the Before column already filled ("95 lines", "FAIL (followed legacy float pattern)", "All rules loaded at startup"), so nobody observes the effect. The catalog outcome (outline 73) promises evidence that instructions are available and a before-and-after record of task results and context use. Learner impact: the whole Basic path runs in a text editor, and the lab teaches Python more than context engineering. Smallest fix: require one live observation at Basic (read the memory-file and rule section of `/context` in `start/` and again after the edit, paste two lines), provide a transcript fallback that carries a question whose answer is only in the transcript, and have learners fill the Before column from their own run.

### Moderate
1. **Stale or contradictory documented values.** Starter `CLAUDE.md` is 74 lines (`verify_lab.py` prints 74), not 95 (`README.md:5`, `context_comparison.md:12`); solution `CLAUDE.md` is 18 lines, its record says 22; the limit is `<60` (README, slide) but the check allows `<= 60` (`verify_lab.py:18`) and the Step 1 prompt asks for `under 50` (README:85); the prompt says `Python 3.11+` (README:82) while the setup says `3.10+`; the companion README claims `fnmatch` (README:13) that no verifier imports. Learner impact: the first number learners record is visibly wrong, which undercuts the "observe, do not assume" message. Smallest fix: correct each value once, and add the `fnmatch` check from Major 1 (which makes the claim true).
2. **Most answers are supplied before the learner decides.** The three invariants, both globs, and the formula appear in README §6 Step 1, in `pricing.py:16-21`, in start `CLAUDE.md:45-47`, and as a near-complete rule file at deck 02:185-196. The remaining real judgment is what to cut from `CLAUDE.md`. Smallest fix: keep the TODO scaffold but remove the glob and formula from the README text, and ask learners to derive the glob from the directory tree and the failing tests.
3. **No individual commitment before the pair works, and no instructor closure.** The 2-minute private read is silent and produces no artifact. There is no prediction ("which of these rules loads when Claude reads `notifier.py`?"), and the plan ends with a student-prepared share-out and a deck "Questions?" slide. Smallest fix: one written prediction before minute 4, and a 3-minute instructor debrief that compares predictions to the `/context` result.
4. **Share-out time is not budgeted.** README §3 ends at minute 25 with preparation only; §8 asks each group for a 1-minute share-out. The outline allows 25 minutes for the lab. Smallest fix: state who shares, in what window, or cut the share-out to two volunteers.
5. **`context_comparison.md` verification is loose.** `verify_lab.py:75` matches only `| TODO` and `: TODO`; `**Why ...:** TODO` and `Version:** TODO` pass (probe D) and any text passes (probe E). Smallest fix: require non-empty cells and a numeric line count that matches `wc -l CLAUDE.md`.

### Minor
1. `verify_lab.py:64-66` reports the `float` error once per `float` Name node, so the starter prints it twice and "8 issues" (README §4, deck 02:449) counts a duplicate. Report once, or update both counts together.
2. README Step 2 says "Open a controlled session" without defining it (fresh `claude` in `start/`, no memory).
3. Deck 02:452 lists only `services/orders/**/*.py`, while the verifier and README require `tests/orders/**/*.py` too.

## What Works
- Real, deterministic, stdlib-only checks: `unittest` and `pytest` agree (5 tests), starter fails 8 issues as documented, solution passes, and the two trees differ in exactly four files.
- The four pricing tests map one-to-one to the acceptance criteria and reject float output, blank keys, out-of-range inputs, and wrong rounding.
- The injected comment at `pricing.py:4-6` is a credible indirect-prompt-injection trap, prepared by deck 01:492 and deck 02:318.
- Constraints are explicit and enforceable by reading: do not edit `tests/**` or `verify_lab.py`; preserve the signature; no float.
- Bounded prompts follow the deck's "goal, files, exact command, bounded output" pattern, and the repair prompt carries the exact failure line.
- Timing is mapped minute by minute with a concrete fallback at minute 19 and an offline path.

## Prioritized Improvement Plan
1. Strengthen `verify_lab.py` (`labs/day1/lab2_1/{start,solution}/verify_lab.py`): parse `paths:`, `fnmatch` against three files, assert conflicting guidance removed, require the half-up formula in the rule, tighten the comparison check. Expected effect: executable contract 3 to 4.5; the borderline cap is cleared on evidence. About +2.5 points.
2. Require one live `/context` observation at Basic, fill the Before column from the learner's own run, and add a transcript fallback with a question (`README.md` §7, `context_comparison.md`). Expected effect: technology fidelity 3 to 4, catalog 3.5 to 4.5. About +4 points.
3. Correct stale numbers and prompts (95 vs 74, 22 vs 18, `<60` vs `<=60` vs `<50`, Python 3.10 vs 3.11, `fnmatch`). About +1 point and removes visible credibility errors.
4. Move the answers out of the README text: keep the TODOs, remove the glob and formula from prose, add a written prediction before minute 4. Expected effect: engagement 3.5 to 4.5, authentic problem 4 to 4.5. About +2 points.
5. Budget the share-out inside 25 minutes or move it to the debrief. Re-resolve the slide discrepancies listed in the handoff below.

## Re-evaluation Checklist
- [ ] `verify_lab.py` rejects: rule scoped to `**/*`; `CLAUDE.md` with the idempotency-skip line; rule without the half-up formula; comparison with `** TODO`.
- [ ] Starter output still reports its documented issue count, with the `float` error reported once.
- [ ] Documented baseline line count equals `wc -l start/CLAUDE.md`; solution record equals `wc -l solution/CLAUDE.md`.
- [ ] A learner can name two live `/context` lines (before and after) from their own run.
- [ ] `pytest -q` and `python3 verify_lab.py` agree in `start/` and `solution/`.
- [ ] Live check in Claude Code: with the rule saved, reading `services/orders/pricing.py` loads it and reading `services/notifications/notifier.py` does not (record the observed version).
- [ ] `git status labs` clean after the runs.

## Comparison With Prior Record
The 2026-11-12 report (`llm-context/issues/20261112-v1-lab2_1-breakout-exercise-evaluator-report.md`) scored every category 10/10 on exit codes and the starter-fails, solution-passes check and had no findings except a slide sync. This evaluation reproduces those two runs and finds the same behavior. The lower score comes from checks that report did not apply: verifier mutation probes, the documented-versus-actual baseline values, whether Claude Code is required to complete Basic, and the answer-leakage and duplication tests. The 2026-11-20 companion commit `64507fd` (requirement tiers) is in the evidence; its Basic tier is the source of Major 2.

## Breakout Slide Handoff
- Status: blocked pending exercise repair
- Evaluation report: `/Users/kangs/code/github/context-claude/llm-context/evaluations/courseware/day1-structuring-project-context/20261120-v1-course-breakout-exercise-evaluator.md`
- Primary repository: `/Users/kangs/code/github/context-claude`
- Companion repository: `/Users/kangs/code/github/context-claude-companion`
- Companion README: `/Users/kangs/code/github/context-claude-companion/labs/day1/lab2_1/README.md`
- Outline and placement: `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md`, Day 1, Session 1, Topic 2 (Lab 2.1, 25 min, after Topic 2 concept and demo)
- Existing deck candidates: `day1/slides/02-how-claude-code-manages-context.md:396-480` (divider, overview, architecture, tasks, constraints slides); built `day1/html/02-how-claude-code-manages-context.html`
- Diagram candidates: `day1/diagrams/01-path-scoped-rule-activation.{excalidraw,svg,png}` (already used at deck 02:435); `day1/diagrams/claude-code-context-lifecycle.svg`
- Unresolved findings: Major, `labs/day1/lab2_1/{start,solution}/verify_lab.py:11-56` (Major 1); Major, `labs/day1/lab2_1/README.md:140-142` and `start/context_comparison.md:12-17` (Major 2)
- Slide-remediable items to pass on after repair: add a completion-levels slide (Basic, Intermediate, Stretch); show both globs (deck 02:452); state the required live `/context` observation; align the `<60` and `Python` wording with the repaired README. The existing launch sequence is otherwise current and consistent with the README (pacing, 5 checks and 8 issues, constraints).
- Action taken: no slide creator was run. The two Major findings sit in the README and the tests, outside the deck, so the gate blocks the handoff. Re-run this evaluator after repairs, then hand off from the new version.
