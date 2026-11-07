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
3. Auto memory, Skills, and MCP tool discovery
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

- **Advisory prose:** `CLAUDE.md` and rules guide model choices but cannot enforce access
- **Pre-action blocking:** Permissions and `PreToolUse` hooks stop disallowed tool calls
- **Post-action checks:** `PostToolUse` runs linters or checks after an edit completes
- **Platform boundary:** Least-privilege credentials and CI protect repositories

---

# Guidance and Execution Controls

<img src="../diagrams/guidance-vs-enforcement.svg" alt="Comparison between model-facing advisory guidance and deterministic execution controls using permissions and hooks" style="display:block; margin:0 auto; max-height:420px;" />

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

# Lab 2.1: Structuring Project Context with `CLAUDE.md`

Open `labs/day1/lab2_1/` in the `context-claude-companion` repo.

**Goal:** Refactor an ambiguous root `CLAUDE.md`, add a path-scoped rule for `services/orders/`, and verify the pricing fix.

1. Run baseline tests and inspect the bloated starter `CLAUDE.md`
2. Distill root `CLAUDE.md` and create `.claude/rules/orders.md` with `paths:` globs
3. Fix `services/orders/pricing.py` and run `python3 verify_lab.py`

> Stretch goal: Test a control read on `services/notifications/` and record `/context` differences.

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

