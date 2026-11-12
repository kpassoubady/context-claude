---
marp: true
theme: default
style: '@import url("https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/blue-theme.css");'
paginate: true
header: 'Context Engineering for Claude Code'
footer: 'Day 1 - Session 4: Context Quality and Iteration'
---

<style>
.gfm-alert { border-left: .3em solid var(--a-c); background: var(--a-bg); border-radius: 4px; padding: .4em 1em; margin: .6em 0; font-size: .9em; }
.gfm-alert-title { color: var(--a-c); font-weight: 700; text-transform: uppercase; letter-spacing: .03em; font-size: .78em; margin: 0 0 .25em; }
.gfm-alert p:last-child { margin: 0; }
.gfm-note { --a-c: #1a73e8; --a-bg: #e3f2fd; }
.gfm-tip { --a-c: #2e7d32; --a-bg: #e8f5e9; }
.gfm-important { --a-c: #7b1fa2; --a-bg: #f3e5f5; }
.gfm-warning { --a-c: #e65100; --a-bg: #fff3e0; }
.gfm-caution { --a-c: #c62828; --a-bg: #fce4ec; }
.industry-badge {
  border-left: 0.25em solid #e65100;
  background: #fff3e0;
  padding: 0.3em 0.8em;
  font-size: 0.78em;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: #e65100;
  margin-bottom: 0.5em;
  display: inline-block;
  border-radius: 0 4px 4px 0;
}
.skip-badge { border-left: 0.25em solid #c62828; background: #fce4ec; padding: 0.3em 0.8em; font-size: 0.78em; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: #c62828; margin-bottom: 0.5em; display: inline-block; border-radius: 0 4px 4px 0; }
.reference-badge { border-left: 0.25em solid #1a73e8; background: #e3f2fd; padding: 0.3em 0.8em; font-size: 0.78em; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: #1a73e8; margin-bottom: 0.5em; display: inline-block; border-radius: 0 4px 4px 0; }
</style>

<!-- _class: lead -->
<!-- _paginate: false -->

# Context Engineering
## Context Quality and Iteration

**Day 1 - Session 4**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# What We'll Cover

1. Identifying the five common context hazards
2. Repeatable before-and-after evaluation hierarchy
3. Using `/context`, `/cost`, and `/usage` accurately
4. Demo: Auditing a repository for context hazards
5. Demo: Scoring context variants across quality and cost

---

<!-- _class: divider -->

# Diagnosing Context Hazards

## What degrades instruction adherence over time

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Five Common Context Hazards

1. **Verbose tool results:** Unbounded logs and full-file dumps crowding the window
2. **Stale assumptions:** References to deleted paths or superseded migration steps
3. **Redundant rules:** Generic or duplicated prose obscuring specific invariants
4. **Context dilution:** Unscoped subsystem rules loading on every startup
5. **Conflicting instructions:** Root `CLAUDE.md` contradicting module rules or tests

---

# Mapping Context Hazards to Remediation

<img src="../diagrams/context-hazards-map.svg" alt="Flowchart mapping the five context hazards to runtime failure modes and engineered remediation steps" style="display:block; margin:0 auto; max-height:420px;" />

---

<!-- _class: demo -->

# Demo: Context Hazard Linter

Run `python3 day1/demos/demo-context-hazard-linter.py`.

- **Stale path check:** Detect references to non-existent directories in `CLAUDE.md`
- **Conflict detection:** Flag opposing test-runner and HTTP-client directives
- **Scoping audit:** Identify subsystem rule files missing `paths:` frontmatter
- **Remediation report:** Review concrete fixes before running evaluation tasks

> Static checks catch explicit fixture hazards; pair with human review and runtime tests.

---

<!-- _class: divider -->

# Evidence-Based Evaluation

## Quality gates first, efficiency metrics second

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Controlled Before-and-After Evaluation

<div class="reference-badge">REFERENCE ONLY</div>

| Evaluation Tier | Metric | Acceptance Requirement |
| :--- | :--- | :--- |
| **1. Correctness gate** | Automated test suite | 100% of unit and acceptance tests pass |
| **2. Adherence gate** | Project invariant checklist | All mandatory rules followed in the diff |
| **3. Safety gate** | Boundary and injection checks | Zero unauthorized actions or leaks |
| **4. Efficiency measure** | `/context`, `/cost`, turns | Compare only when gates 1 to 3 pass |

---

# Controlled Context Evaluation (Fintech)

<div class="industry-badge">REAL-WORLD SCENARIO</div>

**Fintech (Adyen - Payment Processing Evaluation):**

- Evaluates agent context modifications using strict merchant transaction test suites as the primary gate before comparing token savings.
- Proves that pruning verbose API definitions reduced session token usage by 38% while maintaining 100% adherence to PCI-DSS data-handling rules.

---

# Controlled Context Evaluation (Media / Entertainment)

<div class="skip-badge">SKIP</div>
<div class="industry-badge">REAL-WORLD SCENARIO</div>

**Media / Entertainment (Warner Bros. Discovery - Streaming Metadata Pipeline):**

- Validates context optimizations against catalog syndication schemas, verifying all genre tags and rating guidelines pass before measuring turn counts.
- Discovered that cutting too much schema context saved 20% in tokens but increased downstream ingestion re-tries by 45%.

---

# The Context Evaluation Pipeline

<img src="../diagrams/context-evaluation-pipeline.svg" alt="Flowchart showing a controlled baseline, context change, mandatory quality and safety gates, and efficiency comparison" style="display:block; margin:0 auto; max-height:420px;" />

---

# Why Fewer Tokens Alone Do Not Prove Quality

- **The false economy trap:** Stripping rules cuts tokens but increases regressions
- **Skipped verification:** Fewer turns may mean the agent skipped running tests
- **Telemetry precision:** Distinguish `/context` window state from `/cost` session usage
- **Honest reporting:** Record unavailable account metrics as `N/A`, never zero

<div class="gfm-alert gfm-important">
<div class="gfm-alert-title">Important</div>
<p>Reject any context optimization that fails a correctness, adherence, or security gate.</p>
</div>

---

<!-- _class: chat-check -->

# Check: The False Economy of Context Trimming

If Variant B cuts context tokens by 40% but introduces a 5% unit test regression:

A) Adopt Variant B immediately because token reduction is the primary KPI
B) Reject Variant B; efficiency gains are invalid if correctness gates fail
C) Increase the prompt temperature to compensate for missing test context
D) Remove the failing unit tests so the pipeline reports 100% adherence

> Vote privately in chat. What principle governs this decision?

---

<!-- _class: chat-check-answer -->

# Debrief: Quality Gates Precede Token Savings

**B:** Reject Variant B; correctness and adherence gates must pass first.

- Context engineering treats token efficiency as a secondary optimization tier.
- A lean context that causes test failures or skips verification is an engineering regression, not an optimization.

---

<!-- _class: demo -->

# Demo: Context A/B/C Scorecard Evaluator

Run `python3 day1/demos/demo-context-ab-evaluator.py`.

- **Variant A (Bloated baseline):** High context footprint and failed rule adherence
- **Variant B (Over-trimmed):** Lowest token count, but fails tests and safety gates
- **Variant C (Engineered):** Passes all correctness and adherence gates with lower cost
- **Decision rule:** See how the evaluator automatically rejects the false economy

> Uses labeled synthetic benchmark fixtures to demonstrate the evaluation decision rule.

---

<!-- _class: discussion -->

# If-Then Context Engineering Transfer Plan

Choose one immediate commitment to apply in your everyday repositories:

- **If** my root `CLAUDE.md` is over 60 lines, **then** I will extract subsystem rules into `.claude/rules/*.md`.
- **If** an agent task runs past 15 turns, **then** I will write a `HANDOFF.md` and start a clean session with `/clear`.
- **If** a task requires heavy file search, **then** I will delegate the search to an isolated subagent or bounded `Grep`.

> Write your "If-Then" commitment in your private notes or chat.

---

# Key Takeaways

1. Audit context configurations regularly for verbose dumps, stale paths, redundancy, dilution, and conflicts.
2. Evaluate context changes against a pinned baseline using the same task prompt, commit, and tools.
3. Treat task correctness, instruction adherence, and safety boundaries as mandatory primary gates.
4. Use `/context`, `/cost`, and turn counts as supporting efficiency measures only after quality gates pass.

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

**Next up: Mandatory Course Survey and Course Wrap-up**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Let's Connect

**LinkedIn: <a href="https://www.linkedin.com/in/kpassoubady" style="color:#ffffff;">linkedin.com/in/kpassoubady</a>**

<img src="../../images/ConnectLinkedIn.jpg" alt="QR code linking to the instructor's LinkedIn profile" style="display:block; margin:0 auto; max-height:320px;" />

