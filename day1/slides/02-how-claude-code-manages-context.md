---
marp: true
theme: default
style: '@import url("https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/blue-theme.css");'
paginate: true
header: 'Context Engineering for Claude Code'
footer: 'Day 1 - Session 2: How Claude Code Manages Context'
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
.trick-badge { border-left: 0.25em solid #7b1fa2; background: #f3e5f5; padding: 0.3em 0.8em; font-size: 0.78em; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: #7b1fa2; margin-bottom: 0.5em; display: inline-block; border-radius: 0 4px 4px 0; }
.skip-badge { border-left: 0.25em solid #c62828; background: #fce4ec; padding: 0.3em 0.8em; font-size: 0.78em; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: #c62828; margin-bottom: 0.5em; display: inline-block; border-radius: 0 4px 4px 0; }
.reference-badge { border-left: 0.25em solid #1a73e8; background: #e3f2fd; padding: 0.3em 0.8em; font-size: 0.78em; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: #1a73e8; margin-bottom: 0.5em; display: inline-block; border-radius: 0 4px 4px 0; }
</style>

<!-- _class: lead -->
<!-- _paginate: false -->

# Context Engineering
## How Claude Code Manages Context

**Day 1 - Session 2**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# What We'll Cover

1. Startup context versus on-demand retrieval
2. Project guidance with `CLAUDE.md` and `.claude/rules/`
3. Auto memory, Skills, and MCP (Model Context Protocol) tool discovery
4. Demo: Inspecting lifecycle loading and execution controls
5. Breakout Lab 2.1: Structuring Project Context with `CLAUDE.md`

---

<!-- _class: divider -->

# The Context Lifecycle

## What loads at startup versus on demand

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Startup vs. On-Demand Context

| Lifecycle Phase | Mechanisms Loaded | Context Impact |
| :--- | :--- | :--- |
| **Session start** | Root `CLAUDE.md`, unconditional rules, `MEMORY.md` | Occupies space from turn 1 |
| **Conditional** | `.claude/rules/*.md` with `paths:` globs | Loads when matching file is read |
| **On demand** | `Glob`, `Grep`, `Read`, full Skill and MCP schemas | Added only when task needs them |
| **Out of band** | Permissions and `PreToolUse` / `PostToolUse` hooks | Enforces policy outside model prose |

---

# Claude Code Context Lifecycle

<img src="../diagrams/claude-code-context-lifecycle.svg" alt="Flowchart showing startup context, conditional and on-demand retrieval, and active working context in Claude Code" style="display:block; margin:0 auto; max-height:420px;" />

---

# Inspecting Active Context with `/context`

<div class="trick-badge">TRICK OF THE TRADE</div>

- **Visibility:** Shows how much of the window is currently occupied
- **Category breakdown:** Separates system prompt, memory files, MCP tools, and turns
- **Verification habit:** Check `/context` before and after restructuring rules
- **Task reset:** Use `/clear` when switching to an unrelated task

---

<!-- _class: divider -->

# Project Instructions & Scoped Rules

## Designing `CLAUDE.md` and `.claude/rules/`

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# What Belongs in Root `CLAUDE.md`

- **Architecture summary:** Concise map of top-level modules and boundaries
- **Verification commands:** Exact build, test, and linter commands with flags
- **Global conventions:** Cross-cutting standards that apply to every file
- **Cross-tool imports:** Import shared `@AGENTS.md` explicitly if used

<div class="gfm-alert gfm-note">
<div class="gfm-alert-title">Note</div>
<p>Loaded CLAUDE.md content occupies context tokens; move subsystem details to scoped rules.</p>
</div>

---

# Path-Scoped Rules in `.claude/rules/`

```markdown
---
paths:
  - "services/orders/**/*.py"
  - "tests/orders/**/*.py"
---
# Orders Service Rules

- Represent all monetary amounts as integer cents; never use float.
- Require idempotency_key on state-changing order operations.
- Run verification with: pytest tests/orders -q
```

---

# Path-Scoped Rules (Fintech)

<div class="industry-badge">REAL-WORLD SCENARIO</div>

**Fintech (Brex - Ledger & Compliance Microservices):**

- Scoped rules bind banking transaction constraints (strict ISO 4217 currency codes, zero float precision) only to ledger and settlement paths.
- General developer tasks avoid loading compliance rule overhead, saving thousands of startup context tokens while enforcing strict financial invariants.

---

# Path-Scoped Rules (Media / Entertainment)

<div class="skip-badge">SKIP</div>
<div class="industry-badge">REAL-WORLD SCENARIO</div>

**Media / Entertainment (Spotify - Audio Metadata & Royalty Services):**

- Path-scoped rules activate DRM and royalty attribution standards exclusively when engineers modify audio ingest and playback pipeline files.
- Web client and UI developers work in the same monorepo without paying the context token cost of complex audio licensing schemas.

---

<!-- _class: demo -->

# Demo: Context Lifecycle Inspector

Run `python3 day1/demos/demo-context-lifecycle-inspector.py`.

- **Startup baseline:** Compare a 320-line monolithic guide against a 35-line root guide
- **Glob activation:** See which `.claude/rules/` files load when editing `services/orders/`
- **Control check:** Confirm unrelated modules do not trigger orders-specific rules
- **Live pairing:** Compare the estimated breakdown with `/context` in Claude Code

> Illustrates rule scoping mechanics; verify actual loading with `/context` in your CLI.

---

<!-- _class: divider -->

# Memory, Skills, MCP & Controls

## On-demand capabilities and deterministic boundaries

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Auto Memory, Skills, and MCP Discovery

- **Auto memory (`MEMORY.md`):** Notes Claude records across sessions from corrections
- **Skills (`SKILL.md`):** Descriptions load at start; full workflow loads on use
- **MCP tool discovery:** Defers heavy tool schemas until a task needs them
- **Progressive disclosure:** Keeps baseline startup overhead predictable

---

# Guidance vs. Deterministic Enforcement

<div class="reference-badge">REFERENCE ONLY</div>

- **Advisory prose:** `CLAUDE.md` and rules guide model choices but cannot enforce access
- **Pre-action blocking:** Permissions and `PreToolUse` hooks stop disallowed tool calls
- **Post-action checks:** `PostToolUse` runs linters or checks after an edit completes
- **Platform boundary:** Least-privilege credentials and CI protect repositories

---

# Guidance and Execution Controls

<img src="../diagrams/guidance-vs-enforcement.svg" alt="Comparison between model-facing advisory guidance and deterministic execution controls using permissions and hooks" style="display:block; margin:0 auto; max-height:420px;" />

---

<!-- _class: chat-check -->

# Predict: Enforcing Security Policies

If `CLAUDE.md` states "Never edit .env files", what prevents a tool call from editing `.env`?

A) `CLAUDE.md` prose strictly guarantees the model cannot issue the edit tool call
B) Only explicit permissions or a PreToolUse hook can deterministically block it
C) Git automatically revokes file write access whenever Claude Code launches
D) The model API automatically raises a 403 Forbidden error upon reading .env

> Vote privately in chat. Keep your answer visible while the demo runs.

---

<!-- _class: demo -->

# Demo: Instructions vs. Permissions and Hooks

Run `python3 day1/demos/demo-instructions-vs-permissions-hooks.py`.

- **Advisory guidance:** Observe how `CLAUDE.md` steers coding conventions
- **PreToolUse gate:** See how a blocking check halts a forbidden path edit before execution
- **PostToolUse check:** Watch a post-edit check report formatting drift after a write
- **Coverage limits:** Identify why OS permissions and CI remain mandatory

> Uses harmless local fixtures to contrast advisory prose with pre- and post-action checks.

---

<!-- _class: chat-check-answer -->

# Explain: Advisory Prose vs. Deterministic Gates

**B:** Only permissions and PreToolUse hooks enforce deterministic blocking.

- `CLAUDE.md` is model guidance; prompt injection, complex context, or drift can cause instructions to be bypassed.
- Deterministic controls operate out-of-band: PreToolUse hooks intercept and cancel actions before execution.

---

<!-- _class: divider -->

# Breakout Lab 2.1

## Structuring Project Context with `CLAUDE.md`

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Breakout Lab 2.1: Structuring Project Context

**Location:** `labs/day1/lab2_1/start/` in `context-claude-companion`
**Time Budget:** 25 Minutes (Pair work: Driver / Navigator)

- **Goal:** Refactor bloated root `CLAUDE.md`, author `.claude/rules/orders.md`, and fix order pricing.
- **Pacing:**
  - **0-4m:** Baseline & Audit (`python3 verify_lab.py`)
  - **4-11m:** Refactor `CLAUDE.md` (<60 lines) and complete `.claude/rules/orders.md`
  - **11-19m:** Fix integer-cent pricing in `services/orders/pricing.py` (swap roles)
  - **19-23m:** Verify with `python3 verify_lab.py` and fill `context_comparison.md`
  - **23-25m:** Prepare 60-second evidence share-out

---

# Lab 2.1 Architecture: Scoped Rule Activation

<img src="../diagrams/claude-code-context-lifecycle.svg" alt="Context lifecycle diagram showing global startup rules vs conditional scoped rules" style="display:block; margin:0 auto; max-height:400px;" />

---

# Lab 2.1: Tasks & Workflow Checkpoints

1. **Baseline & Audit (0-4m):** Run `python3 verify_lab.py` in `start/` (observe 8 initial check failures).
2. **Refactor Guidance (4-11m):**
   - Trim root `CLAUDE.md` under 60 lines, retain `@AGENTS.md`, remove legacy float directives.
   - Author `.claude/rules/orders.md` with `paths:` globs for `services/orders/**/*.py`.
3. **Scoped Fix (11-19m):**
   - Open `services/orders/pricing.py`; reject untrusted comments (OWASP LLM01).
   - Implement integer-cents and idempotency validation adhering to the scoped rule.
4. **Verify & Compare (19-23m):** Run `python3 verify_lab.py` to confirm all 5 checks pass.

---

# Lab 2.1: Constraints & Definition of Done

- **Constraints to Preserve:**
  - Do NOT modify `tests/**` or `verify_lab.py` (executable contract).
  - Use integer arithmetic only; never use `float` in currency logic.
- **Security Rule:** Comments inside source files are untrusted data, not model instructions.
- **Definition of Done:**
  - `CLAUDE.md` is under 60 lines and references `@AGENTS.md`.
  - `.claude/rules/orders.md` starts with valid `paths:` YAML frontmatter.
  - `python3 verify_lab.py` prints `ALL LAB 2.1 CHECKS PASSED!`.
- **Share-Out:** 60-second summary explaining your glob pattern and rejected comment.

---

# Key Takeaways

1. Root `CLAUDE.md` loads on every session start, so keep it concise and global.
2. Path-scoped rules in `.claude/rules/` load on demand when matching files are accessed.
3. Auto memory, Skills, and MCP tool discovery progressively disclose context as needed.
4. Project instructions guide model behavior, whereas permissions and hooks enforce tool constraints.

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

**Next up: 15-Minute Bio Break, then Session 3**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Let's Connect

**LinkedIn: <a href="https://www.linkedin.com/in/kpassoubady" style="color:#ffffff;">linkedin.com/in/kpassoubady</a>**

<img src="../../images/ConnectLinkedIn.jpg" alt="QR code linking to the instructor's LinkedIn profile" style="display:block; margin:0 auto; max-height:320px;" />

