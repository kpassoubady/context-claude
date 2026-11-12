---
marp: true
theme: default
style: '@import url("https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/blue-theme.css");'
paginate: true
header: 'Context Engineering for Claude Code'
footer: 'Day 1 - Session 1: From Prompt Engineering to Context Engineering'
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
.personal-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1em; margin: 0.8em 0; }
.personal-card { border-radius: 16px; box-shadow: 0 8px 20px rgba(30, 41, 59, 0.12); min-height: 155px; padding: 0.9em; }
.personal-card:nth-child(1) { background: #e3f2fd; border-top: 8px solid #1a73e8; }
.personal-card:nth-child(2) { background: #fff3e0; border-top: 8px solid #e65100; }
.personal-card:nth-child(3) { background: #f3e5f5; border-top: 8px solid #7b1fa2; }
.personal-number { color: #64748b; font-size: 0.72em; font-weight: 700; letter-spacing: 0.08em; }
.personal-card h2 { font-size: 1.05em; margin: 0.3em 0 0.5em; }
.personal-card p { font-size: 0.82em; line-height: 1.35; margin: 0; }
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
## From Prompt Engineering to Context Engineering

**Day 1 - Session 1**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Prerequisites

Confirm these prerequisites:

- Familiarity with core LLM (Large Language Model) concepts and prompt engineering terminology
- Basic experience using Claude Code or a comparable AI coding assistant
- Working knowledge of terminal commands, Git version control, and project navigation
- Pre-class environment setup verified via `test_setup.py`

---

<!-- _class: chat-waterfall -->
<!-- 🌊 WATERFALL STRATEGY INJECTION -->

# Introduce Yourself

In one chat message, type:

1. Your name
2. Your location or time zone
3. Your role
4. Your total experience in IT and at your current organization

> ### 🌊 Chat Waterfall
> **Type your answer in the chat, but do not send it yet.**
> *Wait for the countdown: 3... 2... 1... BLAST*

---

# A Little Beyond Work

Choose one prompt. Share only what feels comfortable.

<div class="personal-grid">
<div class="personal-card">
<div class="personal-number">01</div>
<h2>Bucket List</h2>
<p>Name one to three experiences you hope to have.</p>
</div>
<div class="personal-card">
<div class="personal-number">02</div>
<h2>Recent Trip</h2>
<p>Share a place you visited and one detail that stayed with you.</p>
</div>
<div class="personal-card">
<div class="personal-number">03</div>
<h2>Memorable Moment</h2>
<p>Share a recent moment that made you proud, grateful, or happy.</p>
</div>
</div>

> **60 seconds:** Share in chat, speak when invited, keep a private note, or pass.

---

<!-- _class: chat-waterfall -->
<!-- 🌊 WATERFALL STRATEGY INJECTION -->

# Your Context Engineering Experience

In one chat message, type:

1. **Your current Claude Code or AI assistant experience** (e.g., daily code assistant, occasional prompting, first-time user)
2. **Your main focus** (e.g., backend services, full-stack apps, refactoring, reviews)
3. **One context engineering challenge or question** you want answered (e.g., context bloat in long tasks, managing CLAUDE.md rules, compaction loss)

> ### 🌊 Chat Waterfall
> **Type your answer in the chat, but do not send it yet.**
> *Wait for the countdown: 3... 2... 1... BLAST*

---

<!-- _class: chat-waterfall-answer -->

# Your Context Engineering Experience: What We Learned

Your responses help us emphasize:

- **Your starting point:** Bridging from single-prompt prompting to multi-turn agentic context
- **Your focus area:** Tailoring `CLAUDE.md`, scoped rules, and subagents to real project workflows
- **Your key questions:** Preventing context degradation, managing compaction, and verifying handoffs

> ### 💬 Compare your response with these themes and note one topic to revisit.

---

# What We'll Cover

1. Extending prompt design to the agentic environment
2. How the Claude Code loop shapes working context
3. Context bloat, recall degradation, and focus
4. Demo: Comparing noisy and focused context payloads
5. Demo: Multi-turn tool output growth in an agent loop

---

<!-- _class: divider -->

# Extending Prompt Design

## Shaping the full information environment

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Prompt Design Remains the Foundation

- **Clear task phrasing:** Defines the goal, scope, and expected output
- **Explicit constraints:** Names files, interfaces, and boundaries to preserve
- **Context extension:** Applies those same principles across every turn
- **Working set curation:** Controls what enters and stays in the window

---

# Prompt Engineering vs. Context Engineering

| Dimension | Prompt Engineering | Context Engineering |
| :--- | :--- | :--- |
| **Scope** | Single request or static prompt | Full runtime state across turns |
| **Inputs** | Wording and few-shot examples | Guides, files, tools, and memory |
| **Failure mode** | Ambiguous task specification | Noisy dumps and competing rules |
| **Control unit** | Clauses in one message | Tokens entering at each step |

---

# Prompt vs. Context Engineering (Fintech)

<div class="industry-badge">REAL-WORLD SCENARIO</div>

**Fintech (Stripe - Payments Agent & Fraud Analysis):**

- Stripe engineered real-time transaction context across ledger APIs and dispute histories, moving beyond single-turn prompts to multi-turn agent investigations.
- Dynamic retrieval bounds context size to active merchant accounts and settlement windows, cutting latency and preventing hallucinations during balance reconciliation.

---

# Prompt vs. Context Engineering (Media / Entertainment)

<div class="skip-badge">SKIP</div>
<div class="industry-badge">REAL-WORLD SCENARIO</div>

**Media / Entertainment (Netflix - Content Localization & Subtitle Agent):**

- Netflix replaced static prompt translation with a context-engineered agent pulling glossaries, character bibles, and scene timestamps dynamically.
- The system loads episodic lore on demand while keeping subtitle constraints fixed, preserving creative continuity across twenty regional languages.

---

# From Single-Turn Prompts to Agentic Context

<img src="../diagrams/prompt-vs-context-engineering.svg" alt="Comparison between single-turn prompt design and multi-turn agentic context engineering" style="display:block; margin:0 auto; max-height:420px;" />

---

<!-- _class: divider -->

# The Agentic Context Loop

## How tool actions change the working set

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# How Claude Code Builds Working Context

- **Gather context:** Searches paths and reads targeted source files
- **Take action:** Edits code or executes commands in the workspace
- **Verify results:** Runs tests and inspects compiler or linter output
- **Accumulate state:** Appends every tool result to the active window

---

# The Iterative Context Loop

<img src="../diagrams/agentic-context-loop.svg" alt="Flowchart of the Claude Code agent loop showing context gathering, action, verification, and tool noise" style="display:block; margin:0 auto; max-height:420px;" />

---

# Unfiltered Tool Outputs Cause Bloat

<div class="trick-badge">TRICK OF THE TRADE</div>

```bash
# Unbounded test run floods the window with 400 passing traces
pytest -vv --tb=long

# Bounded test run returns only the failing assertion and summary
pytest tests/settlement/test_rounding.py -q --tb=short
```

> Bounding command output keeps diagnostic evidence while avoiding thousands of low-signal lines.

---

<!-- _class: chat-check -->

# Predict: Tool Output Context Bloat

When running `pytest -vv --tb=long` across 400 passing tests in an agent session:

A) Output is automatically discarded by the shell without reaching context
B) Hundreds of passing traces enter the window, diluting core prompt rules
C) Claude Code automatically triggers `/clear` to protect context limits
D) Token count remains unchanged because only test errors consume tokens

> Vote privately in chat. Keep your answer visible while the demo runs.

---

<!-- _class: demo -->

# Demo: Noisy vs. Focused Context Payloads

Run `python3 day1/demos/demo-noisy-vs-focused-context.py`.

- **Payload composition:** Compare a noisy dump against a focused payment task
- **Signal distribution:** Inspect how verbose logs crowd out project rules
- **Constraint distance:** Observe token separation between rules and active edits
- **Verification check:** Review how acceptance criteria catch missed invariants

> Runs locally with synthetic fixtures; pair with `/context` in Claude Code for live inspection.

---

<!-- _class: chat-check-answer -->

# Explain: Output Signal vs. Bloat

**B:** Passing traces flood the window, diluting instruction adherence.

- Unfiltered stdout appends directly into working memory, pushing critical rules far up the context window.
- Option A is false: tool outputs enter context by default. Bounding commands (e.g. `-q --tb=short`) preserves high signal.

---

<!-- _class: divider -->

# Context Rot, Recall, and Trust

## Managing signal, noise, and untrusted inputs

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

# Understanding Context Rot Accurately

- **Attention dilution:** Low-signal tokens compete with project constraints
- **Reduced recall:** Earlier conventions become harder to retrieve reliably
- **Not a guaranteed hallucination:** Larger context does not force fabrication
- **Measured impact:** Evaluate adherence on the actual task and test suite

---

# Quick Check: Diagnosing a Missed Rule

A developer pipes 4,000 lines of test logs into a session, and Claude edits a payment module using `float` instead of `Decimal`. What should you check first?

1. Whether the model temperature was set too high
2. Whether `CLAUDE.md` specifies `Decimal` and how much noise sits in context
3. Whether the repository needs a vector database

---

# Quick Check: Answer and Reasoning

- **Best answer:** Option 2 (check `CLAUDE.md` clarity and context noise)
- **Why:** Missing or diluted invariants explain rule violations in long logs
- **Rejected options:** Temperature or vector stores do not fix noisy tool dumps
- **Next step:** Re-run with a concise test command and explicit project rule

---

# Trust Boundaries in Retrieved Content

- **Untrusted evidence:** Issue text, logs, and READMEs are data, not authority
- **Prompt injection risk:** Retrieved comments must not override system rules
- **Data minimization:** Redact secrets and use synthetic records in class
- **Platform controls:** Enforce access at the repository and credential layer

<div class="gfm-alert gfm-caution">
<div class="gfm-alert-title">Caution</div>
<p>Search exclusions reduce noise, but they are not a security or confidentiality boundary.</p>
</div>

---

<!-- _class: demo -->

# Demo: Multi-Turn Agent Loop Context Growth

Run `python3 day1/demos/demo-agent-loop-context-growth.py`.

- **Turn-by-turn growth:** Track context accumulation across six agent turns
- **Unbounded vs. bounded:** Compare broad directory scans with targeted queries
- **Artifact pollution:** See how un-ignored `dist/` files mislead later edits
- **Remediation pattern:** Apply path filters and concise flags at each step

> Illustrates multi-turn payload growth; verify live window state with `/context`.

---

# Key Takeaways

1. Context engineering extends prompt design across instructions, files, tool outputs, and memory.
2. Every file read, search match, and test run in an agentic loop adds tokens to the working window.
3. Excessive or irrelevant context can reduce recall and focus without guaranteeing hallucination.
4. Retrieved files and logs are untrusted evidence that require bounded queries and verification tests.

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

**Next up: Session 2 - How Claude Code Manages Context**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v6/logo-white.svg" />

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Let's Connect

**LinkedIn: <a href="https://www.linkedin.com/in/kpassoubady" style="color:#ffffff;">linkedin.com/in/kpassoubady</a>**

<img src="../../images/ConnectLinkedIn.jpg" alt="QR code linking to the instructor's LinkedIn profile" style="display:block; margin:0 auto; max-height:320px;" />

