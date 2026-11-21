# Demo Evaluation: Day 1 (Context Engineering for Claude Code), Demos 1 to 8

## Final Result
- Calculated score (day mean of per-demo calculated scores): 63/100
- Applied cap: per-demo hardcoded-showcase cap (39) on 4 demos; day-level caps 69 (practical stack use promised, only simulations delivered) and 69 (matching slide materially inaccurate for demo 5; unstated working directory) are cleared by the lower mean
- Final score: 54/100 (mean of per-demo final scores below)
- Rating: Ineffective (0 to 59)
- Evidence confidence: high. Catalog, all 4 decks, all 8 scripts, and the companion lab fixtures were read, and all 8 scripts were run. Live Claude Code behavior (`/context`, hooks, `/compact`, subagents) was not exercised, which is the gap the findings turn on.
- Delivery recommendation: redesign demos 2, 4, 5, 6; revise demos 1, 3, 7, 8
- Strongest evidence: demo 1 runs a real AST check and `exec` of candidate patches against stated invariants.
- Greatest classroom risk: demo 5's narration claims verification "against git status and pytest" and a lost "rejected lock approach"; the script runs neither and the real output differs from the narration.
- First correction: replace the simulated Claude Code mechanisms in demos 4 and 5 with real ones (a `settings.json` plus hook script exercised by subprocess; a real fixture repo with `git` and `pytest`).

Per-demo results:

| # | Demo | Role | Calculated | Cap | Final |
|:-:|:---|:---|---:|:---|---:|
| 1 | demo-noisy-vs-focused-context.py | Comparison | 75 | none | 75 |
| 2 | demo-agent-loop-context-growth.py | Conceptual | 55 | 39 hardcoded showcase | 39 |
| 3 | demo-context-lifecycle-inspector.py | Practical (claimed) | 68.5 | none | 68 |
| 4 | demo-instructions-vs-permissions-hooks.py | Comparison | 60.5 | 39 hardcoded showcase | 39 |
| 5 | demo-compaction-and-handoff-verifier.py | Failure and repair | 48 | 39 hardcoded showcase | 39 |
| 6 | demo-subagent-isolation-vs-inline-search.py | Comparison | 60 | 39 hardcoded showcase | 39 |
| 7 | demo-context-hazard-linter.py | Practical (claimed) | 72.5 | none | 72 |
| 8 | demo-context-ab-evaluator.py | Integration | 63.5 | none | 63 |
| | Day mean | | | | 54 |

## Evidence Reviewed
| Artifact | Path | Role | Verification status |
|:---|:---|:---|:---|
| Outline | `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md` | Authority for objectives and timing (30/30/30/25 min per topic) | Read |
| Decks 01 to 04 | `day1/slides/0[1-4]-*.md` (demo slides at 01:382, 01:504, 02:251, 02:362, 03:167, 03:304, 04:116, 04:281) | Preparation and demo slides | Read |
| 8 demo scripts + README | `/Users/kangs/code/github/context-claude-companion/day1/demos/` | Targets | Read and run, exit 0 |
| Lab fixtures | companion `day1/lab2_1/solution/.claude/rules/orders.md`, `day1/lab3_1/start/{HANDOFF.md,task_queue/,tests/,session_history/}` | Real fixtures available for reuse; duplication check | Read |
| Standards | `.claude/docs/courseware/technology-grounded-activity-standards.md`, `demo-standards.md` | Rubric basis | Read |
| Prior report | `llm-context/issues/20261112-v1-day1-demo-evaluator-report.md` | Comparison | Read |

Missing reference: the skill names `docs/review/evaluation-records.md` as the store definition. It does not exist in this repo, so the skill's default path `llm-context/evaluations/courseware/<subject>/` is used. Earlier reports live in `llm-context/issues/`.

## Catalog to Demo Traceability
| Concept or promise | Catalog evidence | Slide preparation | Demo operation | Observable evidence | Status |
|:---|:---|:---|:---|:---|:---|
| Noisy vs focused context | S1 T1: "compares a broad, noisy context with a focused set" | Deck 01 predict poll before demo | Token proxy, AST + `exec` of two patches | 7,504 vs 222 est. tokens, 2.5% vs 100% signal, invariants True/False | partial: patch drift is hand-written, not produced by noise |
| Tool output accumulates per agent turn | S1 T1: "each step may add useful or distracting information" | Deck 01 agent-loop slides | Multiplies file line counts by hardcoded factors | 3,099 vs 58 lines | partial: result is set by the factors |
| Startup vs on-demand loading, path-scoped rules, `/context` | S2 T2: core demo uses `CLAUDE.md`, `.claude/rules/`, `/context` | Deck 02 lifecycle slides | Own frontmatter parser and `fnmatch` over embedded strings | 6 / 10 / 6 guidance lines | partial: no real `.claude/rules` file, no `/context` |
| Guidance vs permissions and hooks | S2 T2: "permissions and hooks enforce tool-use constraints" | Deck 02 guidance vs enforcement | `fnmatch` against a deny list in the script | BLOCKED / ALLOWED lines | missing: no Claude Code permission or hook is run |
| Compaction limits, focused `/compact`, handoff | S3 T3 | Deck 03 compaction slides | Substring checks on three string constants vs a dict | Table of True/False | missing: no compaction, `git`, or `pytest` is run |
| Subagent isolation, local search vs RAG | S3 T3 | Deck 03 | Same loop run twice; prints a three-row table | 3,532 vs 53 parent tokens | missing: no subagent or search; RAG half is printed text |
| Context hazards: stale paths, conflicts, dilution, verbose output | S4 T4 | Deck 04 hazard slides | Regex and substring checks on embedded strings | 2 stale, 2 conflicts, 1 unscoped, 1 duplicate | partial: fixture-keyed, no file system |
| Evaluate context change on tests, adherence, then cost | S4 T4: compare before/after with acceptance tests | Deck 04 decision rule | Gate logic over a synthetic table | Verdict per variant | partial: inputs are invented, rule is real |

Forward references: none found; every demo follows its concept slides.

## Technology Execution Map
| Input | Target technology | Operation | Actual evidence | Showcase test |
|:---|:---|:---|:---|:---|
| Candidate patches (strings) | Python `ast`, `exec` | Parse, walk nodes, run function | Invariant booleans from real execution | Pass for the invariant check; the noise-to-drift link is asserted by labels |
| Hardcoded line-count dict | None (arithmetic) | `len(splitlines()) * factor` | Cumulative lines | Fail: reduction % is set by factors 0.1 / 0.25 / 0.15 / 0.2 |
| Embedded rule strings | Own parser, `fnmatch` | Parse `paths:` and match | Loaded-guidance lines | Partial: real parsing, but not Claude Code and not files on disk |
| Tool call + deny list in script | Claude Code permissions/hooks (absent) | `fnmatch` on a string | "BLOCKED" text | Fail: no hook, no `settings.json`, no exit code 2 |
| Summary strings + `ACTUAL_REPO_STATE` dict | `/compact`, `git`, `pytest` (absent) | `in` checks | True/False table | Fail: both sides are constants |
| 12 constant "modules" | Claude Code subagents, Grep (absent) | Sum of `len//4` in two functions | Token table | Fail: subagent mode is the same loop plus a string |
| Embedded markdown + constant path set | Regex | Find backticked paths, phrases | Hazard counts | Partial: real checks, fixture-keyed |
| Synthetic variant table | Decision rule in Python | `all()` gates, `min()` over eligible | Verdicts, winner | Pass for the rule; the evidence is invented and labeled so |

## Scorecard
Ratings are 0 to 5 per dimension. Weights: alignment 15, fidelity 20, authentic 15, executable 20, observability 10, slide/readiness 10, portfolio 10.

| Demo | Align | Fidelity | Authentic | Executable | Observ. | Slide | Portfolio | Points |
|:---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---:|
| 1 noisy-vs-focused | 4 | 3 | 4 | 4 | 4 | 4 | 3.5 | 75 |
| 2 agent-loop | 3.5 | 1.5 | 2.5 | 3.5 | 2.5 | 3.5 | 2.5 | 55 |
| 3 lifecycle-inspector | 4 | 2 | 3.5 | 4 | 4 | 4 | 3 | 68.5 |
| 4 instructions-vs-hooks | 3.5 | 1.5 | 3 | 4 | 3.5 | 3 | 3 | 60.5 |
| 5 compaction-verifier | 3 | 1 | 3 | 3 | 3 | 2.5 | 1.5 | 48 |
| 6 subagent-vs-inline | 3.5 | 1.5 | 2.5 | 4 | 3.5 | 3.5 | 3 | 60 |
| 7 hazard-linter | 4 | 3 | 3.5 | 4 | 4 | 3.5 | 3.5 | 72.5 |
| 8 ab-evaluator | 3.5 | 2 | 3 | 4 | 4 | 3 | 3 | 63.5 |

Evidence summary: executable ratings are high because all 8 run deterministically offline with exit 0. Fidelity is the weak dimension because none of the 8 invokes Claude Code or a real repo fixture.

## Technical Verification
| Command or check | Expected | Actual | Result |
|:---|:---|:---|:---|
| `python3 day1/demos/<each>.py` from companion repo root | Runs, deterministic | All 8 exit 0 | Pass |
| Same command from this repo root (where decks live) | Runs | `No such file or directory`; demos moved to the companion repo | Fail for instructor in this repo; decks do not state the repo or working directory |
| Demo 1 numbers vs deck 01 narration (7,500 / 2.5% / 7,400 / 220 / 125) | Match | 7,504 / 2.5% / 7,407 / 222 / 125 | Pass |
| Demo 6 numbers vs deck 03 narration (about 3,500 / about 50 / slightly higher) | Match | 3,532 / 53 / 3,585 vs 3,532 | Pass |
| Demo 8 numbers vs deck 04 narration (24,800 to 11,400, B rejected) | Match | Match | Pass |
| Demo 5 output vs deck 03 narration | Unfocused omits a rejected fix and claims a helper file edited; script "catches the drift" | Unfocused omits both rejections (0/2) and the failing test; the focused summary also shows "YES (drift!)" and Signature False; narration does not mention these | Fail (narration inaccurate) |
| Demo 2 output readability | Bounded column shows bounded pollution | The `[Unbounded read ...]` note (from the unbounded run) is printed beside the bounded action text, e.g. turn 2 "Targeted Glob in src/ and tests/ only [Unbounded read dist/..., node_modules/...]" | Fail (misleading) |
| Live `/context`, hooks, `/compact`, subagent | Paired live per slide notes | Not exercised and no live steps are written in the decks | Unverified |

## Classroom Run of Show
| Phase | Estimated time | Instructor action | Learner observation or response |
|:---|:---:|:---|:---|
| T1 demo 1 | 4 min | Poll (deck 01), run, point at signal % and constraint distance | Compare payloads, read invariant results |
| T1 demo 2 | 3 min | Run, read the table | Watch line counts diverge (misread risk from the mislabelled note) |
| T2 demo 3 | 3 min (timeboxed) | Run, change nothing | Match scenarios 1 to 3 to loaded files |
| T2 demo 4 | 4 min | Predict poll, run | Read BLOCKED/ALLOWED |
| T3 demo 5 | 4 min | Poll, run, narrate | Narration mismatches the table |
| T3 demo 6 | 4 min | Run, read table | Compare parent vs total tokens |
| T4 demo 7 | 4 min | Run | Read hazard report |
| T4 demo 8 | 4 min | Run | Read verdicts |

Only topic 2 states a timebox; the rest rely on topic allocations (30/30/30/25 min). Time is not the binding constraint.

## Critical Conditions and Caps
| Condition | Triggered | Evidence |
|:---|:---|:---|
| Prints prepared output without running the target mechanism (cap 39) | Demos 2, 4, 5, 6 | Hardcoded factors (agent-loop:49-71); deny list `fnmatch` in place of Claude Code (hooks:21-32); `ACTUAL_REPO_STATE` dict and substring checks (compaction:14-54); `run_subagent_exploration` repeats the inline loop (subagent:35-70) |
| Removing target technology leaves the same result (cap 39) | Same four | Claude Code permissions, hooks, `/compact`, and subagents are not present in any of the four |
| Documented demo cannot run (cap 49) | Cleared | Runs from companion root. Working directory unstated on decks (see Major 5) |
| No observable evidence proves the claimed behavior (cap 59) | Demos 5 (goal claims verification against actual repo and tests) | No `git` or `pytest` is run. Not applied separately because the 39 cap already binds |
| Unapproved technology or unprepared concept (cap 59) | Cleared | Pure Python, taught concepts |
| Practical stack use promised but only simulated demos (cap 69, session) | Triggered at day level | Catalog S2 core demo uses `CLAUDE.md`, `.claude/rules/`, `/context`; Day 1 has no demo that runs Claude Code. Not binding (mean 54) |
| Matching slide materially inaccurate (cap 69) | Demo 5 narration; minor in 2, 4, 8 | Not binding |
| Cannot fit allocation or needs unstated setup (cap 69) | Cleared on time; working directory unstated | Not binding |

## Findings
### Blockers
1. **Demo 4 does not run Claude Code permissions or hooks** (`demo-instructions-vs-permissions-hooks.py:21-45`; deck 02:362). `evaluate_pre_tool_use` is an `fnmatch` over a list in the script, which is the "scripted security verdict" the standards name as a weak showcase. The `Bash(rm -rf *)` pattern is never exercised. Impact: learners see a verdict the script wrote, not an enforcement point. Smallest fix: ship a fixture project with `.claude/settings.json` deny rules and a real PreToolUse hook script, then have the demo invoke the hook by subprocess with a JSON tool call on stdin and print the exit code (2 blocks) and stderr. Keep the PostToolUse check the same way.
2. **Demo 5 audits constants, not a repo** (`demo-compaction-and-handoff-verifier.py:14-54`; deck 03:167-181). The goal says it verifies claims "against actual repository state and test execution", and the slide says `HANDOFF.md` is confirmed against `git status` and `pytest`; neither runs. Detection is `in`/`split()[0]` substring matching on three hand-written strings. Smallest fix: audit the companion `lab3_1` fixture (`task_queue/`, `tests/`, `session_history/auto_compact_summary.md`) by running `git status --porcelain` and `pytest -q tests/test_lease.py` and comparing claims to the results. Note the duplication in Major 3.
3. **Demo 2 result is set by hardcoded factors** (`demo-agent-loop-context-growth.py:49-71`). The 98.1% reduction is `int(len(lines) * factor)` with factors 1.0 / 0.5 / 0.1 / 0.25 / 0.15 / 0.2 chosen per step. A "broad file listing" adds half of every file's lines. Smallest fix: build a small real tree on disk (temp dir), run real `glob`, `grep` (subprocess `rg`), and `pytest -v` vs `-q` over it, and count the actual bytes or lines each returns.
4. **Demo 6 compares a function with itself** (`demo-subagent-isolation-vs-inline-search.py:35-70`). The subagent total is the inline sum plus a string; the RAG section prints three strings with unused `source_type` and `is_local`. The inline mode also reads all 12 modules in full, which a real `Grep` would not, so the 3,532 vs 53 contrast overstates the benefit. Smallest fix: model inline as the `Grep` plus several full `Read` calls actually needed, count real output, and either run a real subagent (`claude -p` with a bounded task, labeled live) or state clearly that the parent-window numbers are a model of information flow.

### Major
1. **No demo runs the course technology (Claude Code).** The catalog's session 2 core demo is `CLAUDE.md`, `.claude/rules/`, `/context`, and file-search tools; Day 1 has only offline Python simulations, and decks 01 and 02 say "pair with `/context`" without writing the live steps. Fix: add one live Claude Code demo per topic (instructor script in the slide notes: command, expected output signal, fallback), keeping the scripts as the conceptual layer.
2. **Demos 3 and 7 use embedded copies instead of real files** (`lifecycle-inspector.py:16-60`; `hazard-linter.py:16-38`). The companion repo already ships `day1/lab2_1/solution/.claude/rules/orders.md` and `day1/lab3_1/`. Reading those from disk (and `os.path.exists` for stale paths in demo 7) turns both into practical demos. In demo 7, conflict detection (`:51`, `:53`) and the 2,400-line figure (`:38`, `:104`) are literals, so the linter only finds this fixture's hazards.
3. **Demo 5 pre-solves Lab 3.1.** The same unfocused summary, dispatcher stale claim, and two rejected fixes are the lab's audit answers (`lab3_1/start/HANDOFF.md` section 6). Signatures also disagree: demo `LeaseManager.renew(worker_id, lease_id, observed_seq)` vs lab `renew_lease(lease_id, worker_id, expected_seq)`. Fix: move the demo to a different bug, or demo the audit method on a non-lab fixture.
4. **Demo 5 narration is wrong against its own output** (deck 03:181). It says the automated summary "omitted a rejected lock approach"; the table shows both rejections omitted (0/2) and the failing test missing. The focused `/compact` row also reads "YES (drift!)" and Signature False, undiscussed. Fix the narration or fix the fixture so the focused summary is clean.
5. **Working directory is unstated.** All 8 slide commands use `python3 day1/demos/...`, which resolves only in the companion repo. Add "from `context-claude-companion`" to each demo slide or to the deck 01 setup slide.

### Moderate
1. **Demo 2 note placement misleads** (`demo-agent-loop-context-growth.py:85-87`): the unbounded pollution list is printed beside the bounded action. The slide also says "token consumption" and "mislead later edits"; the demo counts lines and shows no misled edit. Fixture says "Edit TypeScript sources" while `src/` holds `.py` files (`:19`).
2. **Demo 1 drift is asserted, not produced** (`demo-noisy-vs-focused-context.py:46-51`). Labeled "followed noisy issue hint", the float patch is hand-written. Signal % depends on hand-set `is_high_signal` booleans. Say so on the slide, or run a live Claude Code prompt on both payloads and compare. `exec` of candidate code is safe here (constants) but worth a one-line note.
3. **Demo 4 slide says "formatting drift"**; the PostToolUse check is a `float(` lint (`:40`). Align wording.
4. **Demo 8 slide and script wording** (deck 04:281): slide lists Variant A as "failed rule adherence", but the verdict reports only the first failed gate, "failed acceptance tests" (`:74`); B's safety failure is also hidden by the first-failure reason, while the closing line (`:118`) claims both. Print all failed gates. `/context` and `/cost` column headers sit over invented numbers (labeled synthetic, fine; N/A cost column adds noise).
5. **Demos 1 and 2 overlap** (both: tokens/lines vs noise); keep demo 1, rebuild demo 2 as the real measurement in Blocker 3.

### Minor
1. Demo 3 output columns misalign when the reason string is long (`:117`).
2. Demo 3's glob helper (`:73-79`) drops `**/` and relies on `fnmatch` where `*` crosses `/`; fine for the fixture, but do not present it as Claude Code's matcher.
3. Demo 7 slide says "non-existent directories"; the paths are files.
4. Demo 5 `required_constraint` has a spacing typo: `lease_id,observed_seq` (`:23`).
5. Only deck 02 states a demo timebox; add one per demo.

## What Works
- All 8 scripts run offline, deterministically, with exit 0, and numbers match the slide narration for demos 1, 6, 8.
- Demo 1's AST plus `exec` invariant check is real execution and a good model for the rest.
- Demo 8 labels its evidence as synthetic and applies a real quality-first rule; the "fewest tokens but rejected" message is the right lesson.
- Demos 3 and 7 parse and check real text, and the file-level docstrings follow the demo standards (one goal, Run line, Takeaway).
- Predict polls precede several demos (decks 01, 02, 03), which suits the engagement handoff.

## Prior Report Comparison
The 2026-11-12 v1 report scored all 8 demos 10/10 with no findings, based on exit codes and the demos' self-descriptions ("simulates", "audits against ground truth"). This evaluation applies the hardcoded showcase test, the practical-demo requirement, narration-to-output checks, and lab duplication checks; those were not applied before. The scripts' last change (commit `c36838c`) is a telemetry relabel, so the difference comes from the rubric, not from regressions.

## Prioritized Improvement Plan
1. Demo 4: real `settings.json` deny rule and hook script, invoked by subprocess; print exit code and stderr. Files: `demo-instructions-vs-permissions-hooks.py` plus a new fixture dir; deck 02 slide 362 signals. Clears Blocker 1.
2. Demo 5: audit the real `lab3_1` (or a new non-lab) fixture with `git` and `pytest`; fix narration; resolve duplication with Lab 3.1. Clears Blocker 2, Major 3 and 4.
3. Demo 2: real glob/grep/pytest over a temp tree; move the pollution note to the correct column. Clears Blocker 3, Moderate 1 and 5.
4. Demo 6: measure real Grep vs full Reads, run or clearly model the subagent, and replace the RAG print with a labeled decision table. Clears Blocker 4.
5. Add live Claude Code steps (`/context` before and after a scoped read; one `/compact` with focus; one subagent call) to the topic 2 and 3 demo slide notes. Clears Major 1.
6. Demos 3 and 7: read the lab fixtures from disk. Clears Major 2.
7. Add the companion working directory to every demo slide; fix Moderate 3 and 4 and Minor wording.

## Re-evaluation Checklist
- Each of demos 2, 4, 5, 6 passes the showcase test: removing the target technology changes the printed result.
- Demo 4 prints a real hook exit code of 2 and a stderr message for the locked-file case.
- Demo 5 output comes from `git status` and `pytest` run on a fixture; the slide narration matches the table line for line.
- Demo 6 counts real tool output for inline vs subagent paths.
- Demos 3 and 7 read files from disk; changing a fixture file changes the output.
- Every demo slide names the working directory; all 8 run from it with exit 0 twice with identical output.
- At least one live Claude Code demo step per topic is written in the slide notes, with a fallback.
- Demo narration numbers in decks 01 to 04 still match script output after changes.

## Remediation Status (2026-11-20)
Changes are uncommitted in both repos. Scores above are not re-computed; a re-evaluation is still needed.

| Finding | Status | Change |
|:---|:---|:---|
| Blocker 1 (demo 4) | Fixed | Runs real hook scripts from `fixtures/hooks_repo/.claude/settings.json` by subprocess; prints exit codes, stderr, file hash. `permissions.deny` is listed, not evaluated |
| Blocker 2 (demo 5) | Fixed | Runs `git status`, `pytest`, and `ast` on `fixtures/compaction_repo` (refund-ledger bug, not the Lab 3.1 lease bug); narration matches output (Major 3, 4 cleared) |
| Blocker 3 (demo 2) | Fixed | Real `ls`, `grep`, `cat`, `pytest`, `git diff` on a temp project; pollution counted per row (Moderate 1, 5 cleared) |
| Blocker 4 (demo 6) | Fixed | Measured grep/cat output for targeted inline, broad inline, and modeled subagent; retrieval checks run on a temp git repo. Subagent row is still a model |
| Major 2 (demos 3, 7) | Fixed | Both read fixture files from disk; stale paths use `Path.exists()`; conflicts derived, not literal |
| Major 5 (working directory) | Fixed | Demo slides 2 to 7 name `context-claude-companion` |
| Moderate 3 | Fixed | Deck 02 wording now says `float()` |
| Major 1 (live Claude Code steps) | Open | No `/context`, `/compact`, or subagent steps added to slide notes |
| Moderate 2 (demo 1), Moderate 4 (demo 8), Minor 5 | Open | Demos 1 and 8 and the deck 04 demo 8 slide untouched; timeboxes not added. Minor 1 to 4 resolved by the rewrites |
