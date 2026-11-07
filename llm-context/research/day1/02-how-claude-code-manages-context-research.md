# Industry Research: Session 2 — How Claude Code Manages Context

**Course:** Context Engineering for Claude Code (4-Hour AM/PM)
**Day / Session:** Day 1, Session 2 (`02-how-claude-code-manages-context`)
**Scheduled Duration:** 30 minutes (Concept & Demo) + 25 minutes (Breakout Lab 2.1)
**Reviewed Against Documentation:** 2026-11-06

---

## 1. Scope & Alignment with Course Outline

- **Core Lifecycle Distinction:** Distinguish what Claude Code loads into the context window at **session startup** versus what it loads **on demand (just-in-time)** as work progresses.
- **Primary Mechanisms (Taught & Practiced in Depth):**
  - Project guidance via root `CLAUDE.md`. If cross-tool guidance lives in `AGENTS.md`, explicitly import it with `@AGENTS.md` from `CLAUDE.md` and verify loading on the classroom CLI; do not assume native interchangeability.
  - Path-scoped rules in `.claude/rules/*.md` using YAML frontmatter `paths:` globs.
  - On-demand file search and targeted reading (`Glob`, `Grep`, `Read`).
  - Context window inspection via `/context`.
  - Structuring task requests and bounding tool outputs.
- **Secondary Mechanisms (Introduced Conceptually):**
  - **Auto Memory (`MEMORY.md`):** Notes Claude writes and updates for itself across sessions based on user corrections and discovered repo patterns (first ~200 lines of `MEMORY.md` loaded at startup).
  - **Skills (`SKILL.md`):** Short skill descriptions load at startup so Claude knows when to invoke them; full `SKILL.md` instructions load only when invoked.
  - **MCP Tool Discovery / Tool Search:** MCP server tool names/metadata can be registered at startup while deferring heavy full JSON schemas until a relevant task requires them.
- **Critical Governance Distinction:** Project instructions (`CLAUDE.md`, `.claude/rules/`) guide model behavior, not authorization. Permission checks and correctly configured blocking `PreToolUse` hooks can constrain supported tool actions. `PostToolUse` runs after an action and cannot prevent it retroactively. Coverage depends on settings precedence, permission mode, hook type, failure behavior, and execution path; no hook configuration is a universal sandbox or zero-token guarantee.

---

## 2. Latest Technical Mechanics & Official Syntax

### 1. Startup vs. On-Demand Context Lifecycle in Claude Code

| Lifecycle Phase | Mechanism | Context Cost Behavior |
| :--- | :--- | :--- |
| **Session Startup** | System prompt, applicable `CLAUDE.md` files and explicit imports, unconditional `.claude/rules/*.md` (without `paths:`), Auto Memory (`MEMORY.md` entrypoint), Skill descriptions | Loaded content occupies the context window; prompt caching may change billing, not remove that content. Inspect the actual account/model behavior. |
| **Conditional / On-Demand** | `.claude/rules/*.md` with `paths:` frontmatter | Loaded dynamically only when Claude reads/edits a file matching the glob pattern |
| **On-Demand Retrieval** | `Glob`, `Grep`, `Read`, invoked `SKILL.md` bodies, deferred MCP tool schemas | Added to context only when triggered by the current task |
| **Tool-Execution Controls** | Permissions (`allow`/`ask`/`deny`), blocking `PreToolUse` hooks, and post-action `PostToolUse` checks | Policy evaluation is outside model reasoning; configuration-related messages and hook feedback can enter context. Post-action checks do not undo tool effects. |

### 2. Path-Scoped Rules Syntax (`.claude/rules/*.md`)
Official Claude Code syntax uses YAML frontmatter with `paths`:
```markdown
---
paths:
  - "services/billing/**/*.py"
  - "tests/billing/**/*.py"
---
# Billing Service Rules

- Represent all monetary values as integer minor units (cents) or `Decimal`; never use `float`.
- Every state-changing endpoint must require an `idempotency_key` parameter.
- Run billing verification with: `pytest tests/billing -q`
```
- Rules **without** `paths:` frontmatter load unconditionally at startup alongside `CLAUDE.md`.
- Rules **with** `paths:` stay out of the context window until Claude accesses a matching file path.

### 3. Concise `CLAUDE.md` Engineering Best Practices
- **Target Length:** Use a concise root guide; the proposed lab target of fewer than 60 lines is a teaching constraint, not an official limit or quality metric. Move unrelated component details into scoped rules without removing essential global verification or safety guidance.
- **What Belongs in Root `CLAUDE.md`:**
  1. One-paragraph repository architecture overview.
  2. Exact build, test, and lint commands (non-inferable commands, flags, workspace layout).
  3. Global cross-cutting conventions that apply to *every* directory.
- **What Should Move to `.claude/rules/` or Docs:**
  - Component-specific rules (e.g., API route conventions, database migration checklists, frontend component styling rules).
- **Avoid claiming `CLAUDE.md` is "free":** Everything loaded from `CLAUDE.md` occupies context window tokens. Moving specialized rules into path-scoped `.claude/rules/` keeps startup context lean.

---

## 3. Illustrative Industry Scenario

This is a constructed teaching example, not a documented customer deployment or measured outcome.

### Case Study: Multi-Component Order & Fulfilment Monorepo
- **Scenario:** An e-commerce engineering team maintains a multi-component repo containing:
  - `services/orders/` (Python order validation & pricing service)
  - `services/SearchIndex/` or `services/webhook_gateway/` (fast webhook dispatcher)
  - `scripts/legacy_migration/` (deprecated migration scripts)
- **Problem:** The team had a bloated, 320-line root `CLAUDE.md` mixing legacy migration notes, contradictions about test runners (`unittest` vs `pytest`), and webhook retry rules alongside order pricing rules. When working on `services/orders/`, Claude followed a legacy rule from the migration section and used floating-point discounts instead of integer basis points.
- **Solution:**
  1. Distilled root `CLAUDE.md` down to 35 lines covering repo layout, global `pytest` verification commands, and shared coding standards.
  2. Extracted order-pricing invariants (`integer cents`, `basis-point discount calculation`, mandatory audit fields) into `.claude/rules/orders-service.md` scoped to `services/orders/**/*.py` and `tests/orders/**/*.py`.
  3. Documented and tested the configured permission boundary separately from project prose. Blocking a command string alone does not protect the same files from another tool, shell command, or process; use scoped credentials, OS/container isolation where appropriate, and repository protections for stronger boundaries.

---

## 4. Demo & Breakout Lab 2.1 Practicality Evaluation

### Demos for Session 2 (`day1/demos/`)
1. **`01_context_lifecycle_inspector.py`:** Illustrates expected context categories across a monolithic guide and a concise root guide with scoped rules. Label calculated payload sizes as estimates; verify actual startup and file-triggered loading separately in Claude Code.
2. **`02_instructions_vs_permissions_hooks.py`:** Illustrates the difference between advisory guidance, configured permission/pre-action checks, and post-action feedback. Use harmless fixtures and distinguish the illustration from an actual enforcement test.

These scripts are proposed illustrations, not existing implementations or validation of the installed CLI. A simulator cannot prove actual rule loading, token savings, or hook enforcement; pair it with a captured/live CLI run and the governance limits above.

### Breakout Lab 2.1 (`day1/lab2_1_structuring_project_context/` in Companion Repo)
- **25-Minute Classroom Feasibility:** Conditional on a prebuilt, verified starter and a tiny pricing task. The companion repository currently has no lab artifacts; the paths and checks below are specifications, not verified deliverables.
- **Student Tasks:**
  1. Audit the ambiguous starter `CLAUDE.md` and inspect what context is loaded.
  2. Refactor root `CLAUDE.md` into a concise, accurate project guide (<60 lines) with exact verification commands.
  3. Create a path-scoped rule file `.claude/rules/orders.md` with valid `paths:` YAML frontmatter targeting `services/orders/**` and `tests/orders/**`.
  4. Implement/verify the `services/orders/pricing.py` task according to the scoped rules and record before-and-after context footprint and verification output in a structured comparison table.
  5. Run the automated acceptance check (`python3 verify_lab.py` / `pytest`) to confirm both the code and context configuration pass all checks.

### Evaluator Addendum: Relevant Industry Controls

Evaluator review: 2026-11-06, local-document review; added reference links are not live-validated.

| Framework | Course-specific application | Boundary to state explicitly |
| --- | --- | --- |
| OWASP LLM01 Prompt Injection and LLM06 Excessive Agency (2025) | Use an inert fixture comment asking the agent to ignore pricing rules; show that retrieved content is untrusted. Keep available tools and credentials minimal. | A rule saying "do not do this" is not an access-control mechanism. Do not run destructive commands to demonstrate a refusal. |
| NIST SP 800-218 Secure Software Development Framework (SSDF) | Review `CLAUDE.md`, scoped rules, hooks, and MCP/Skill definitions as code; require applicable owners and automated checks on changes. | Local instructions support the development process but do not replace protected branches, CI, or human approval. |
| NIST SP 800-207 Zero Trust Architecture | Authorize tool and external-data access using identity, resource, and policy; limit credentials to the exercise. | A path-scoped rule controls when guidance applies, not which files or services the agent can access. This is a principle mapping, not a full Zero Trust deployment. |

### Evaluator Addendum: A Lab That Fits 25 Minutes

- **Prepare before class:** Provide independent `labs/day1/lab2_1/start/` and `solution/` snapshots, one chosen Python runtime, preinstalled test dependencies, working verification commands, and a short rule template. Reconcile these proposed paths with the companion's `labs/` convention; do not ship the earlier `day1/...` path as if it already exists.
- **Bound the code task:** Limit the pricing fix to one function using integer cents and a specified rounding rule. Supply edge-case tests and leave notifications and legacy scripts untouched. No web service, database, OAuth/JWT setup, custom MCP server, or hook authoring belongs in this lab.
- **Separate evidence:** The proposed `verify_lab.py` should check frontmatter/path syntax, retained verification instructions, and pricing tests, not merely guide length. Static checks cannot prove Claude loaded or followed a rule. Capture a real targeted read and resulting behavior for the orders module; use a nonmatching component as a control and record `/context` where available.
- **Environment control:** Record applicable user/project instructions, memory state, model, CLI version, and available tools for both runs. Use the supported lab-scoped memory setting or a disposable profile to avoid memory carryover; do not delete participants' global instructions or memory.

| Minutes | Required activity |
| --- | --- |
| 0-4 | Run the starter's focused test and capture baseline guidance/context evidence. |
| 4-11 | Refine the root guide and complete one supplied `paths:` rule template. |
| 11-19 | Start the controlled comparison session, retrieve the target file, and make the small pricing fix. |
| 19-23 | Run static configuration checks and pricing tests; record adherence and observed context use. |
| 23-25 | Submit the guide, scoped rule, and comparison record; note uncertainties. |

If the CLI is unavailable, use an instructor-captured before/after transcript plus local tests and label runtime loading as not personally observed. At minute 19, provide the pricing solution if needed so the context-configuration objective remains assessable. Skills, MCP setup, and authoring security hooks remain instructor demonstrations, not extra lab deliverables.

### Evaluator Addendum: Enterprise Configuration Ownership

Platform/security teams own managed settings, approved tools/MCP servers, credentials, sandbox/egress policies, and audit handling. Component owners maintain scoped conventions and tests. Repository owners review guidance and executable hook/Skill changes through the normal pull-request process. Demonstrate an innocuous preconfigured action check and test its allowed and blocked cases through the intended tool path; do not imply it covers untested execution paths.

Keep secrets out of `CLAUDE.md`, rule files, auto memory, and hook output. `.gitignore`, search exclusions, and scoped guidance do not stop a tool from reading a file. Use OS/service authorization and least-privilege credentials for that boundary.

---

## 5. Sources & References

- [Claude Code Documentation: Manage Claude's memory (`CLAUDE.md`, `.claude/rules/`, Auto Memory)](https://code.claude.com/docs/en/memory)
- [Claude Code Documentation: Explore the context window (`/context`)](https://code.claude.com/docs/en/context-window)
- [Claude Code Documentation: Configure permissions](https://code.claude.com/docs/en/permissions)
- [Claude Code Documentation: Extend Claude Code (Skills, Hooks, MCP)](https://code.claude.com/docs/en/features-overview)
- [Claude Code Documentation: Hooks reference](https://code.claude.com/docs/en/hooks)
- [OWASP: Top 10 for Large Language Model Applications](https://genai.owasp.org/llm-top-10/)
- [NIST: Secure Software Development Framework](https://csrc.nist.gov/projects/ssdf)
- [NIST SP 800-207: Zero Trust Architecture](https://csrc.nist.gov/pubs/sp/800/207/final)
