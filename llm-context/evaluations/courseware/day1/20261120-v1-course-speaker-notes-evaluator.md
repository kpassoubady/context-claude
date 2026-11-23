# Speaker Notes Evaluation: Day 1 (Topics 1 to 4)

Scope: all four Marp decks in `day1/slides/`, scored together as one day. Format: Marp (`marp: true` front matter in each deck). Audience: developers working in AI-assisted coding environments, intermediate level (from the catalog). Finding IDs carry a deck prefix (`D1` to `D4`) because the scope spans four decks.

## Final Result
- Calculated score: 82.0/100
- Applied cap: none. Considered and not applied: the "invented or wrong fact" cap, for D4-S06 ("missing directories") and D4-S15 ("fastest turns", "unit tests"). These are wording errors. Every figure in every note matches the demo output or the source it cites.
- Final score: 82.0/100
- Result: Mostly in sync: targeted updates
- Drift index: 74 of 101 slides in sync
- Evidence confidence: high. All four decks, the outline, all eight demos, both labs and every cited link were checked. Diagram layouts were only partly checked (see Link and Fact Checks).
- Recommendation: update-flagged-slides

Drift index: 74 of 101 is 73%, just above the 70% line. Above that line the notes-sync cap does not apply, but the margin is small. Twenty-seven slides carry at least one finding.

Decision needed from the user (does not block the update pass): the notes in D1-S28, D2-S28 and D3-S23 promise question time that the outline does not contain. The creator default is to match the outline. Say if the outline should gain a Q&A row instead.

## Evidence Reviewed

| Artifact | Path | Role | Verification status |
| :--- | :--- | :--- | :--- |
| Deck 1 | `day1/slides/01-from-prompt-engineering-to-context-engineering.md` | Evaluated | Verified: read in full, 29 slides |
| Deck 2 | `day1/slides/02-how-claude-code-manages-context.md` | Evaluated | Verified: read in full, 29 slides |
| Deck 3 | `day1/slides/03-maintaining-coherence-across-long-tasks.md` | Evaluated | Verified: read in full, 24 slides |
| Deck 4 | `day1/slides/04-context-quality-and-iteration.md` | Evaluated | Verified: read in full, 20 slides |
| Outline | `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md` | Objectives, timing, sequence | Verified: session breakdown totals 4 h |
| Demos (8) | `/Users/kangs/code/github/context-claude-companion/day1/demos/` | Numbers and observation signals | Verified: each run once with exit 0; output in the scratchpad |
| Lab 2.1 | `/Users/kangs/code/github/context-claude-companion/labs/day1/lab2_1/` (README, `start/`) | Steps, constraints, checks | Verified: verifier run on a scratch copy, 5 failing checks, 10 issues |
| Lab 3.1 | `/Users/kangs/code/github/context-claude-companion/labs/day1/lab3_1/` (README, `start/`) | Steps, constraints, checks | Verified: verifier run on a scratch copy, 2 issues; `setup_repo.sh` read |
| Diagrams | `day1/diagrams/*.svg` (8), `01-path-scoped-rule-activation.png` | Visual claims in notes | Partly verified: labels read from 6 SVGs; layouts and the PNG not rendered |
| Format standard | `.claude/docs/courseware/slide-format-marp.md` (symlink) | Note placement rules | Verified: read |
| Evaluation store | `docs/review/evaluation-records.md` | Record path and rules | Read from the claude-personal-helper repo; this repo does not contain it |
| Prior record | `llm-context/evaluations/courseware/day1/` | Re-evaluation | None for speaker notes; first record for this scope |
| Link targets (10) | Anthropic, Claude Code docs, OWASP, arXiv, jsDelivr theme | Fact checks | Verified: all HTTP 200; claims checked against page text |

## Scorecard

| Dimension | Rating | Weight | Points | Evidence summary |
| :--- | ---: | ---: | ---: | :--- |
| Coverage | 4.5 | 15 | 13.5 | 100 of 101 slides that need a note have one. Missing: D2-S11 (diagram-only slide). The References slide (D4-S19) is exempt. |
| Sync with slides, demos, and labs | 3.5 | 30 | 21.0 | 3 Major findings: D3-S20 (lab setup step omitted), D1-S28, D3-S23 (question and break time contradict the outline). No stale or bridge drift found. Every demo figure in a note matches its run. Lab check counts match. |
| Added value beyond the slide | 4.5 | 20 | 18.0 | Most notes give the reason, the trade-off or the consequence (D1-S09, D1-S25, D2-S17, D4-S12). Four Key Takeaways notes paraphrase their bullets (D1-S27, D2-S27, D3-S22, D4-S17). |
| Examples and facts | 4.5 | 15 | 13.5 | About 31 of 101 notes carry an example, about 30%, and each is labeled illustrative or hypothetical. All 10 link targets return HTTP 200, and the cited claims were checked on the pages. One claim is unconfirmed, and it sits on a slide, not in a note. |
| Spoken delivery and timing | 4.0 | 10 | 8.0 | Notes read aloud cleanly, and paths use "dot" and "slash". Three notes promise time that the outline does not allocate. Eleven content notes fall outside 60 to 150 words. `data-duration-minutes` is absent from every deck, so that part of the LENGTH check does not apply. |
| Format and style | 4.0 | 10 | 8.0 | Front matter is correct in all four decks. One note per slide, except D1-S03 and D1-S05, where a non-directive workflow comment is exported as a second presenter note. No directive-key notes. No `--` inside notes. Labels consistent. |
| Total | | 100 | 82.0 | |

## Slide Ledger
Status: `in-sync`, `update`, `rewrite`, or `add`. Note words count the speaker note only. Type `interactive` covers chat checks, waterfalls and discussions. Length findings apply to content and lab slides only.

### Deck 1: `01-from-prompt-engineering-to-context-engineering.md`

| Slide | Title | Type | Note words | Status | Codes |
| :---: | :--- | :--- | ---: | :--- | :--- |
| 01 | Context Engineering | title | 63 | in-sync | |
| 02 | Prerequisites | content | 68 | in-sync | |
| 03 | Introduce Yourself | interactive | 52 | rewrite | FORMAT |
| 04 | A Little Beyond Work | content | 55 | update | LENGTH |
| 05 | Your Context Engineering Experience | interactive | 46 | rewrite | FORMAT |
| 06 | Your Context Engineering Experience: What We Learned | interactive | 57 | in-sync | |
| 07 | What We'll Cover | content | 53 | update | LENGTH, OUTLINE |
| 08 | Extending Prompt Design | divider | 29 | in-sync | |
| 09 | Prompt Design Remains the Foundation | content | 119 | in-sync | |
| 10 | Prompt Engineering vs. Context Engineering | content | 82 | in-sync | |
| 11 | Prompt vs. Context Engineering (Fintech) | content | 97 | in-sync | |
| 12 | Prompt vs. Context Engineering (Media / Entertainment) | content | 69 | in-sync | |
| 13 | From Single-Turn Prompts to Agentic Context | content | 83 | in-sync | |
| 14 | The Agentic Context Loop | divider | 19 | in-sync | |
| 15 | How Claude Code Builds Working Context | content | 107 | in-sync | |
| 16 | The Iterative Context Loop | content | 68 | in-sync | |
| 17 | Unfiltered Tool Outputs Cause Bloat | content | 122 | in-sync | |
| 18 | Predict: Tool Output Context Bloat | interactive | 53 | in-sync | |
| 19 | Demo: Noisy vs. Focused Context Payloads | demo | 91 | update | DEMO |
| 20 | Explain: Output Signal vs. Bloat | interactive | 69 | rewrite | FACT |
| 21 | Context Rot, Recall, and Trust | divider | 27 | in-sync | |
| 22 | Understanding Context Rot Accurately | content | 88 | in-sync | |
| 23 | Quick Check: Diagnosing a Missed Rule | interactive | 51 | in-sync | |
| 24 | Quick Check: Answer and Reasoning | content | 70 | in-sync | |
| 25 | Trust Boundaries in Retrieved Content | content | 121 | in-sync | |
| 26 | Demo: Multi-Turn Agent Loop Context Growth | demo | 87 | in-sync | |
| 27 | Key Takeaways | content | 69 | rewrite | RESTATE |
| 28 | Questions? | closing | 54 | rewrite | OUTLINE |
| 29 | Let's Connect | closing | 20 | in-sync | |

### Deck 2: `02-how-claude-code-manages-context.md`

| Slide | Title | Type | Note words | Status | Codes |
| :---: | :--- | :--- | ---: | :--- | :--- |
| 01 | Context Engineering | title | 62 | in-sync | |
| 02 | What We'll Cover | content | 67 | in-sync | |
| 03 | The Context Lifecycle | divider | 27 | in-sync | |
| 04 | Startup vs. On-Demand Context | content | 73 | in-sync | |
| 05 | Claude Code Context Lifecycle | content | 75 | in-sync | |
| 06 | Inspecting Active Context with `/context` | content | 76 | in-sync | |
| 07 | Structuring Task Requests | content | 81 | in-sync | |
| 08 | Project Instructions & Scoped Rules | divider | 22 | in-sync | |
| 09 | What Belongs in Root `CLAUDE.md` | content | 144 | in-sync | |
| 10 | Path-Scoped Rules in `.claude/rules/` | content | 89 | in-sync | |
| 11 | Path-Scoped Rule Activation | content | 0 | add | MISSING |
| 12 | Path-Scoped Rules (Fintech) | content | 75 | in-sync | |
| 13 | Path-Scoped Rules (Media / Entertainment) | content | 50 | update | LENGTH |
| 14 | Demo: Context Lifecycle Inspector | demo | 80 | in-sync | |
| 15 | Memory, Skills, MCP & Controls | divider | 30 | in-sync | |
| 16 | Auto Memory, Skills, and MCP Discovery | content | 110 | update | FACT |
| 17 | Guidance vs. Deterministic Enforcement | content | 157 | rewrite | LENGTH |
| 18 | Guidance and Execution Controls | content | 74 | in-sync | |
| 19 | Predict: Enforcing Security Policies | interactive | 52 | in-sync | |
| 20 | Demo: Instructions vs. Permissions and Hooks | demo | 70 | in-sync | |
| 21 | Explain: Advisory Prose vs. Deterministic Gates | interactive | 60 | in-sync | |
| 22 | Breakout Lab 2.1 | divider | 31 | in-sync | |
| 23 | Breakout Lab 2.1: Structuring Project Context | lab | 81 | in-sync | |
| 24 | Lab 2.1 Architecture: Scoped Rule Activation | content | 54 | update | LENGTH |
| 25 | Lab 2.1: Tasks & Workflow Checkpoints | lab | 106 | in-sync | |
| 26 | Lab 2.1: Constraints & Definition of Done | lab | 66 | in-sync | |
| 27 | Key Takeaways | content | 64 | rewrite | RESTATE |
| 28 | Questions? | closing | 50 | rewrite | OUTLINE |
| 29 | Let's Connect | closing | 18 | in-sync | |

### Deck 3: `03-maintaining-coherence-across-long-tasks.md`

| Slide | Title | Type | Note words | Status | Codes |
| :---: | :--- | :--- | ---: | :--- | :--- |
| 01 | Context Engineering | title | 66 | in-sync | |
| 02 | What We'll Cover | content | 65 | in-sync | |
| 03 | Compaction & Durable Handoffs | divider | 23 | in-sync | |
| 04 | Automatic vs. Focused Compaction | content | 154 | rewrite | LENGTH |
| 05 | Durable Handoffs and Fresh Sessions | content | 92 | in-sync | |
| 06 | Compaction and Handoff Verification Flow | content | 79 | in-sync | |
| 07 | Predict: Compaction Summary Vulnerability | interactive | 53 | in-sync | |
| 08 | Demo: Compaction and Handoff Verifier | demo | 88 | in-sync | |
| 09 | Explain: Information Loss in Summarization | interactive | 65 | in-sync | |
| 10 | Subagents & Retrieval Patterns | divider | 24 | in-sync | |
| 11 | Isolated Subagents for Exploration | content | 80 | in-sync | |
| 12 | Isolated Subagents (Fintech) | content | 79 | in-sync | |
| 13 | Isolated Subagents (Media / Entertainment) | content | 53 | update | LENGTH |
| 14 | Direct File Search vs. External RAG | content | 146 | in-sync | |
| 15 | Subagent Isolation and Retrieval Architecture | content | 64 | in-sync | |
| 16 | Demo: Subagent Isolation vs. Inline Search | demo | 110 | rewrite | FACT |
| 17 | Breakout Lab 3.1 | divider | 29 | in-sync | |
| 18 | Breakout Lab 3.1: Compaction & Handoffs | lab | 76 | in-sync | |
| 19 | Lab 3.1 Architecture: Compaction vs. Handoff | content | 48 | update | LENGTH |
| 20 | Lab 3.1: Tasks & Workflow Checkpoints | lab | 96 | rewrite | LAB |
| 21 | Lab 3.1: Constraints & Definition of Done | lab | 75 | in-sync | |
| 22 | Key Takeaways | content | 60 | rewrite | RESTATE |
| 23 | Questions? | closing | 55 | rewrite | OUTLINE |
| 24 | Let's Connect | closing | 16 | in-sync | |

### Deck 4: `04-context-quality-and-iteration.md`

| Slide | Title | Type | Note words | Status | Codes |
| :---: | :--- | :--- | ---: | :--- | :--- |
| 01 | Context Engineering | title | 64 | in-sync | |
| 02 | What We'll Cover | content | 70 | in-sync | |
| 03 | Diagnosing Context Hazards | divider | 19 | in-sync | |
| 04 | Five Common Context Hazards | content | 139 | in-sync | |
| 05 | Mapping Context Hazards to Remediation | content | 69 | in-sync | |
| 06 | Demo: Context Hazard Linter | demo | 66 | rewrite | FACT |
| 07 | Evidence-Based Evaluation | divider | 26 | in-sync | |
| 08 | Controlled Before-and-After Evaluation | content | 82 | in-sync | |
| 09 | Controlled Context Evaluation (Fintech) | content | 84 | in-sync | |
| 10 | Controlled Context Evaluation (Media / Entertainment) | content | 47 | update | LENGTH |
| 11 | The Context Evaluation Pipeline | content | 57 | update | LENGTH |
| 12 | Why Fewer Tokens Alone Do Not Prove Quality | content | 134 | in-sync | |
| 13 | Check: The False Economy of Context Trimming | interactive | 54 | in-sync | |
| 14 | Debrief: Quality Gates Precede Token Savings | interactive | 56 | in-sync | |
| 15 | Demo: Context A/B/C Scorecard Evaluator | demo | 78 | rewrite | FACT, DEMO |
| 16 | If-Then Context Engineering Transfer Plan | interactive | 86 | in-sync | |
| 17 | Key Takeaways | content | 56 | rewrite | RESTATE, LENGTH |
| 18 | Questions? | closing | 46 | in-sync | |
| 19 | References | references | n/a | exempt | |
| 20 | Let's Connect | closing | 24 | in-sync | |

Totals: 101 slides need notes. 74 in-sync, 27 flagged (add 1, rewrite 16, update 10). In the hand-off, `update` means `enrich`.

Deck totals: Deck 1, 21 of 29 in sync. Deck 2, 22 of 29. Deck 3, 17 of 24. Deck 4, 14 of 19.

## Findings
Each finding gives the slide, the code, the evidence and the smallest correction. The correction goes to the note unless it says otherwise.

### Blockers
None. No note gives a command, path or number that fails against the current artifact, and no note states a wrong figure.

### Major
- **D3-S20-LAB** (slide 20, Lab 3.1 tasks, step 1). Evidence: the slide says "Run `python3 verify_lab.py` in `start/`". The lab README's 0 to 4 minute row says "Run `./setup_repo.sh` and `python3 verify_lab.py`". `setup_repo.sh` creates the git baseline the audit runs against, and it refuses to run if `.git` exists. Correction: the note adds "run `./setup_repo.sh` in `start/` once, before the verifier". The slide body needs the same step, which is outside note scope. The deck owner should make that edit. (ANSWER: Validate the lab in companinon repo, and then update the slide and notes to match)
- **D3-S23-OUTLINE** (slide 23, closing). Evidence: "five minutes for questions, followed by our mid-course Kahoot quiz and a ten-minute break." The outline lists Kahoot Quiz 1 at 10 minutes and a 15-minute Bio Break, with no Q&A row. Correction: "followed by our Kahoot quiz and a fifteen-minute bio break". Drop the five-minute Q&A, or add a Q&A row to the outline. (ANWSER: Drop the five-minute Q&A)
- **D1-S28-OUTLINE** (slide 28, closing). Evidence: "We have ten minutes for questions and discussion." The outline gives Topic 1 30 minutes for concept and demo, and the breakdown totals 4 hours with no Q&A row. Correction: remove the ten-minute figure, or add a Q&A row to the outline. The note cannot promise time the breakdown does not contain. (ANSWER: Course Wrap up has 15 mins, we'll use 10 mins for Q&A)

### Moderate
- **D1-S03-FORMAT** (slide 03, Introduce Yourself). Evidence: `<!-- 🌊 WATERFALL STRATEGY INJECTION -->` sits before the heading. It is not a directive, so Marp exports it as a second presenter note (4 words, plus the 52-word speech note). Correction: delete the injection comment. Keep the speech comment.
- **D1-S05-FORMAT** (slide 05, Your Context Engineering Experience). Same pattern as D1-S03 (4 words, plus the 46-word speech note). Correction: delete the injection comment.
- **D1-S20-FACT** (slide 20, Explain: Output Signal vs. Bloat). Evidence: "Claude Code does not automatically clear context without your instruction." Deck 2 and deck 3 teach that automatic compaction runs as the window fills, and the context-window doc describes it. The sentence is misleading as written. Correction: "Claude Code does not run `/clear` on its own. Automatic compaction can summarize older turns as the window fills, which is a different thing."
- **D2-S11-MISSING** (slide 11, Path-Scoped Rule Activation, diagram only). No note. The slide sits between the rule-syntax slide (10) and the fintech example (12). Correction: add 60 to 120 words. Describe what the diagram shows: root CLAUDE.md always loads, each read or edit is checked against the `paths:` globs, and a match loads the rule. End with a bridge to slide 12. View `01-path-scoped-rule-activation.png` before writing.
- **D2-S28-OUTLINE** (slide 28, closing). Evidence: "five minutes for questions and then a fifteen-minute bio break." The break matches the outline. The five-minute Q&A has no row in the Topic 2 block. Correction: remove the Q&A time, or add it to the outline.
- **D3-S16-FACT** (slide 16, Demo: Subagent Isolation vs. Inline Search). Evidence: the note says delegating "leaves about 70 tokens in the parent" as if measured. The demo output labels that row "(modeled)", and the slide blockquote says the subagent is not launched. Correction: "the modeled subagent row leaves about 70 tokens in the parent. No subagent runs in this demo."

### Minor
- **D1-S04-LENGTH** (slide 04, A Little Beyond Work). 55 words, below 60. Correction: add one beat on why the prompt helps the room settle in.
- **D1-S07-LENGTH** (slide 07, What We'll Cover). 53 words. Correction: add one sentence on what each topic answers.
- **D1-S07-OUTLINE** (slide 07). Evidence: "run two interactive simulations" inside a 30-minute block. The outline describes one Topic 1 demo. The second demo (D1-S26) is not in the outline. Correction: state how long each demo takes inside the 30 minutes.
- **D1-S19-DEMO** (slide 19, Demo: Noisy vs. Focused). The run line lacks the companion-repo location, which D1-S26 states. Correction: "From `context-claude-companion`, run `python3 day1/demos/demo-noisy-vs-focused-context.py`."
- **D1-S27-RESTATE** (slide 27, Key Takeaways). The note paraphrases the four bullets one for one. Correction: add the reason each takeaway matters in the labs.
- **D2-S13-LENGTH** (slide 13, Media / Entertainment, SKIP slide). 50 words. Correction: add one beat.
- **D2-S16-FACT** (slide 16). Evidence: "loads the first two hundred lines at startup." The memory doc says "the first 200 lines or 25KB of MEMORY.md, whichever comes first." Correction: add "or 25KB, whichever comes first."
- **D2-S17-LENGTH** (slide 17). 157 words. Correction: trim about 10 words. Keep the PreToolUse and PostToolUse contrast.
- **D2-S24-LENGTH** (slide 24, Lab 2.1 architecture). 54 words. Correction: add one beat on which path triggers the orders rule.
- **D2-S27-RESTATE** (slide 27). Same pattern as D1-S27.
- **D3-S04-LENGTH** (slide 04). 154 words. Correction: trim to 150 or fewer.
- **D3-S13-LENGTH** (slide 13, Media / Entertainment, SKIP slide). 53 words. Correction: add one beat.
- **D3-S19-LENGTH** (slide 19, Lab 3.1 architecture). 48 words. Correction: add one beat on what changes between the two columns of the diagram.
- **D3-S22-RESTATE** (slide 22). Same pattern as D1-S27. Note is 60 words; add reasoning, not just length.
- **D4-S06-FACT** (slide 06, Context Hazard Linter). Evidence: "detect missing directories." The linter reports two missing files: `docs/legacy_v1/architecture.md` and `scripts/old_deploy.sh`. Correction: "missing files".
- **D4-S10-LENGTH** (slide 10, Media / Entertainment, SKIP slide). 47 words. Correction: add one beat.
- **D4-S11-LENGTH** (slide 11, Evaluation Pipeline). 57 words. Correction: add one beat on why the reject step comes before the efficiency compare.
- **D4-S15-FACT** (slide 15, A/B/C scorecard). Evidence: "Variant B has the lowest token count and fastest turns" and "it failed unit tests." The demo reports the fewest turns (2) and measures no time. The demo says Variant B failed acceptance tests (3 of 5) and the safety gate. Correction: "fewest turns" and "failed the acceptance tests and the safety gate."
- **D4-S15-DEMO** (slide 15). The run line lacks the companion-repo location (same as D1-S19). Correction: add "From `context-claude-companion`".
- **D4-S17-RESTATE** (slide 17, Key Takeaways). Same pattern as D1-S27.
- **D4-S17-LENGTH** (slide 17). 56 words. Correction: reach 60 or more while adding the reason in D4-S17-RESTATE.

## Link and Fact Checks

| Slide | Claim or link | Check | Result |
| :--- | :--- | :--- | :--- |
| D1-S22 | Liu et al., 2023, "Lost in the Middle" | arXiv 2307.03172 fetched: title and authors match | Passed |
| D1-S22 | `code.claude.com/docs/en/context-window` (Go deeper) | HTTP 200; page covers `/context` and monitoring | Passed |
| D1-S25 | `genai.owasp.org/llmrisk/llm01-prompt-injection/` (Go deeper and the indirect-injection claim) | HTTP 200; page covers indirect prompt injection | Passed |
| D1-S19 | 7,500 tokens; 2.5%; about 7,400 away; about 220; about 125 | Demo run: 7,504; 2.5%; 7,407; 222; 125 | Passed |
| D1-S26 | About 1,660 lines and 31,000 tokens; about 130 lines and 700 tokens | Demo run: 1,660 lines and 30,942 tokens; 127 lines and 711 tokens | Passed |
| D1-S20 | "does not automatically clear context" | Context-window doc: `/clear` is manual; auto-compaction runs as the window fills | Wording is misleading (D1-S20-FACT) |
| D2-S09 | Docs target under 200 lines per CLAUDE.md | Memory doc: "target under 200 lines per CLAUDE.md file" | Passed |
| D2-S14 | 7 of 18 lines; 6-line orders rule | Demo run: "7 of 18"; `orders-service.md` 6 lines | Passed |
| D2-S16 | Auto memory loads first 200 lines | Memory doc: "first 200 lines or 25KB" | Passed; note omits 25KB (D2-S16-FACT) |
| D2-S17 | Hooks link; PreToolUse exit 2 blocks | HTTP 200; hooks doc: exit 2 blocks PreToolUse | Passed |
| D2-S17 | Permissions link | HTTP 200 | Passed |
| D2-S20 | `permissions.deny` listed, not evaluated | Demo output says the same | Passed |
| D2-S25, D2-S26 | Lab 2.1 facts: 5 checks, 10 issues, `@AGENTS.md`, under 60 lines | Verifier run: 5 `[FAIL]` checks, 10 issues; `start/CLAUDE.md` is 75 lines and imports `@AGENTS.md` | Passed |
| D3-S04 | Compaction re-injects root CLAUDE.md and auto memory | Context-window doc table: "Re-injected from disk" | Passed |
| D3-S08 | Verifier results (0 of 2 rejected fixes; failing test dropped; `webhook.py` named) | Demo run matches | Passed |
| D3-S11 | Subagent has its own context window | Sub-agents doc: "Each subagent runs in its own context window" | Passed |
| D3-S14 | Claude Code as hybrid agent (CLAUDE.md up front; glob and grep just in time) | Anthropic engineering post: "Claude Code is an agent that employs this hybrid model" | Passed |
| D3-S16 | About 800, 4,400, 70 tokens | Demo run: 823; 4,404; 67 (modeled) | Passed, with modeling caveat (D3-S16-FACT) |
| D3-S18 to D3-S21 | 35-turn session; failing lease renewal test; "ALL LAB 3.1 CHECKS PASSED!" | README; verifier run shows the failing unit suite; string present in `verify_lab.py` | Passed |
| D4-S06 | Linter findings (2 stale paths, 2 conflicts, 1 unscoped rule, 1 duplicate, 2,399-line log) | Demo run matches | Passed; "missing directories" wording (D4-S06-FACT) |
| D4-S09 | `code.claude.com/docs/en/costs` | HTTP 200; page documents `/usage` | Passed |
| D4-S15 | 24,800 to 11,400 tokens; Variant B 6,200 tokens and 2 turns | Demo run matches | Passed |
| D4-S03, D4-S12 (slide text, outside notes) | "`/usage` (alias `/cost`)" | Costs page documents `/usage`; no alias statement in its prose | Not confirmed. Deck owner to check the current command list |
| D4-S19 (slide text, outside notes) | References list | The costs page cited in D4-S09 is not listed | Missing from References (deck owner) |
| D1-S02 | `test_setup.py` | Exists in `context-claude-setup/quickstart-project/` | Passed |
| Theme | `cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/blue-theme.css` | HTTP 200; latest tag via `git ls-remote` is `v19` | Passed |
| D1-S16, D2-S05, D3-S06, D4-S11 | Diagram labels and flow described in notes | Labels read from SVG text: agentic loop, lifecycle, compaction vs. handoff, evaluation pipeline | Passed |
| D1-S13, D3-S15, D4-S05 | Left and right placement in notes | Labels read; layout not rendered | Not verified |
| D2-S18 | "CI gates" in the right-hand panel | CI does not appear in the extracted labels | Not verified |
| D2-S11 | `01-path-scoped-rule-activation.png` | File exists; not viewed | Not verified (view before writing the new note) |

## What Works
- **Demo notes with numbers.** D1-S19, D1-S26, D2-S14, D2-S20, D3-S08, D3-S16 and D4-S15 name what the observer will see, and every figure matches the run. They also tell the instructor what to point at.
- **Context-rot framing.** D1-S22 and D1-S25 treat rot as attention dilution and treat retrieved text as untrusted data. The OWASP link and its claim were checked.
- **Answer notes.** D2-S21, D3-S09 and D4-S14 explain why the right answer is right and why the others are not.
- **Provenance on documented claims.** D2-S16 and D3-S02 cite the doc that supports the claim, and the claim matches it.
- **Lab pacing.** The Lab 2.1 pacing notes (D2-S25) match the README's minute ranges. The Lab 3.1 notes match except for the setup step (D3-S20).
- **Transitions.** Every bridge I checked points at the correct next slide. Examples: D1-S20 to D1-S21, D3-S09 to D3-S10, D4-S14 to D4-S15.

## Prior Record Comparison
Not applicable: first record for this scope.

## Creator Hand-off

Written for the next `course-speaker-notes-creator` pass. Only the slides in each table change. Rebuild `day1/html/` after editing `day1/slides/` (`scripts/build-slides-html.sh`), as the repo CLAUDE.md requires.

Decision needed from the user before D1-S28, D2-S28 and D3-S23 are edited: keep question time and add a Q&A row to the outline, or match the outline and drop the Q&A time. Default if no answer: match the outline.

Model for the update pass (researched 2026-11-22): Claude Sonnet 5.5 is enough. Every correction is enumerated above and the edits are bounded text changes inside Marp comment notes. Use Claude Opus 5.5 if the run should carry the strongest fact precision on the rewrite rows; it leads maintainer-merge repository editing (FrontierCode 2.0: Opus 5.5 46.4%, Gemini 4 Argon about 26%) and matches Argon at the top of the Arena creative-writing board. Gemini 4 Argon also works, but it is Google's efficiency-tier reasoning model and its main advantage, a 1M-token context for long-horizon tasks, is not needed for 101 slides. Argon's introductory price ends 2026-11-30; after that it costs the same as Opus 5.5 while scoring lower on repository editing.

### Deck 1: `day1/slides/01-from-prompt-engineering-to-context-engineering.md`
Format: marp. Audience: developers in AI-assisted coding environments (catalog). Sources of truth: `catalog/context-engineering-for-claude-code-4-hour-am-pm-outline.md`; `/Users/kangs/code/github/context-claude-companion/day1/demos/`.

| Slide | Mode | What to change | Source to match |
| :--- | :--- | :--- | :--- |
| 03 | rewrite | Format only: delete the `WATERFALL STRATEGY INJECTION` comment. Keep the speech. | `slide-format-marp.md`, one note per slide |
| 04 | enrich | Add one beat (55 words). | Slide 04 |
| 05 | rewrite | Format only, as for 03. | As for 03 |
| 07 | enrich | Add one beat (53 words). Say how long each demo takes inside the 30-minute block. | Outline Topic 1 (30 min); companion demos |
| 19 | enrich | Add "From `context-claude-companion`". | `day1/demos/demo-noisy-vs-focused-context.py` |
| 20 | rewrite | Replace "does not automatically clear context" with the manual `/clear` versus automatic compaction wording. | Context-window doc; slide 03 |
| 27 | rewrite | Replace the paraphrase with the reason each takeaway matters in the labs. | Slide 27; Lab 2.1 and 3.1 READMEs |
| 28 | rewrite | Q&A time per the decision above; default: remove "ten minutes". | Outline session breakdown |

Keep as is: 01, 02, 06, 08 to 18, 21 to 26, 29.

### Deck 2: `day1/slides/02-how-claude-code-manages-context.md`
Format: marp. Audience: as above. Sources: as above, plus `labs/day1/lab2_1/README.md` and `/Users/kangs/code/github/context-claude-companion/labs/day1/lab2_1/`.

| Slide | Mode | What to change | Source to match |
| :--- | :--- | :--- | :--- |
| 11 | add | No note. Describe the diagram: root CLAUDE.md always loads; each read or edit is checked against `paths:` globs; a match loads the rule. Bridge to slide 12. View the PNG first. | `day1/diagrams/01-path-scoped-rule-activation.png` |
| 13 | enrich | Add one beat (50 words). | Slide 13 |
| 16 | enrich | Add "or 25KB, whichever comes first". | Memory doc |
| 17 | rewrite | Trim to 150 words. Drop "CI gates" unless the diagram shows it. | Slide 17; `day1/diagrams/guidance-vs-enforcement.svg` |
| 24 | enrich | Add one beat (54 words) on which path triggers the orders rule. | Lab 2.1 README |
| 27 | rewrite | Replace the paraphrase with reasoning. | Slide 27 |
| 28 | rewrite | Q&A time per the decision above. | Outline Topic 2 block |

Keep as is: 01 to 10, 12, 14, 15, 18 to 23, 25, 26, 29.

### Deck 3: `day1/slides/03-maintaining-coherence-across-long-tasks.md`
Format: marp. Audience: as above. Sources: `labs/day1/lab3_1/README.md`, `labs/day1/lab3_1/start/setup_repo.sh`, companion `day1/demos/demo-compaction-and-handoff-verifier.py` and `demo-subagent-isolation-vs-inline-search.py`, and the outline.

| Slide | Mode | What to change | Source to match |
| :--- | :--- | :--- | :--- |
| 04 | rewrite | Trim to 150 words (154). | Slide 04 |
| 13 | enrich | Add one beat (53 words). | Slide 13 |
| 16 | rewrite | Say the subagent row is modeled. Say that no subagent runs in the demo. | Demo output "(modeled)"; slide blockquote |
| 19 | enrich | Add one beat (48 words) on what changes between the two columns. | `day1/diagrams/compaction-vs-handoff.svg` |
| 20 | rewrite | Step 1: add "run `./setup_repo.sh` in `start/` once, before the verifier". The slide body needs the same step (deck owner). | Lab 3.1 README pacing 0 to 4 min; `setup_repo.sh` |
| 22 | rewrite | Replace the paraphrase with reasoning; reach at least 60 words. | Slide 22 |
| 23 | rewrite | Break is 15 minutes; Q&A time per the decision above. Drop "ten-minute break". | Outline session breakdown |

Keep as is: 01 to 03, 05 to 12, 14, 15, 17, 18, 21, 24.

### Deck 4: `day1/slides/04-context-quality-and-iteration.md`
Format: marp. Audience: as above. Sources: companion `day1/demos/demo-context-hazard-linter.py` and `demo-context-ab-evaluator.py`; the outline.

| Slide | Mode | What to change | Source to match |
| :--- | :--- | :--- | :--- |
| 06 | rewrite | "missing directories" becomes "missing files". | Demo output (two missing files) |
| 10 | enrich | Add one beat (47 words). | Slide 10 |
| 11 | enrich | Add one beat (57 words). | `day1/diagrams/context-evaluation-pipeline.svg` |
| 15 | rewrite | "fastest turns" becomes "fewest turns (2)". "unit tests" becomes "acceptance tests and the safety gate". Add "From `context-claude-companion`". | Demo output |
| 17 | rewrite | Add reasoning; reach at least 60 words. | Slide 17 |

Keep as is: 01 to 05, 07 to 09, 12 to 14, 16, 18, 20.

Outside note scope, for the deck owner: D1-S19 and D4-S15 slide run lines lack the companion location; D3-S20 step 1 lacks the setup step; D4-S19 References lacks the costs link cited in D4-S09; the `/usage (alias /cost)` slide claim (D4-S03 and D4-S12) needs checking against the current command list.
