---
marp: true
theme: default
style: '@import url("https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/blue-theme.css");'
paginate: true
header: 'Context Engineering for Claude Code'
footer: 'Day 1 - Topic 1: From Prompt Engineering to Context Engineering'
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

**Day 1 - Topic 1**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: Welcome everyone. In this first session, we are stepping beyond individual prompts into how Claude Code manages its entire information environment. We will look at how an agent gathers context, takes action, and why curating that working set is what keeps long coding tasks on track.

Transition: Let us verify everyone is set up and ready to run the exercises.
-->

---

# Prerequisites

Confirm these prerequisites:

- Familiarity with core LLM (Large Language Model) concepts and prompt engineering terminology
- Basic experience using Claude Code or a comparable AI coding assistant
- Working knowledge of terminal commands, Git version control, and project navigation
- Pre-class environment setup verified via `test_setup.py`

<!--
What to say: Take thirty seconds to double-check that your terminal environment passes the quickstart check. You do not need deep agent theory for today, but you will need basic familiarity with Git, terminal navigation, and running Claude Code from your shell.

Ask the room: Has anyone run into any issues running the test setup script before class?

Teaching focus: Confirm environment readiness before diving into the concepts.
-->

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

<!--
What to say: Before we get into the architecture, let us take a quick temperature check on who is in the room. Type your details into the chat window, but hold off on pressing enter until we count it down.

Teaching focus: Surface cohort experience levels and roles quickly without chat clutter.
-->

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

<!--
What to say: We will spend four hours collaborating together today, so take a minute to share something personal if you feel comfortable. Pick any one of the three cards on the screen.

Transition: Now that we know who is in the room, let us look at your hands-on experience with context in coding agents.
-->

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

<!--
What to say: Context engineering addresses the exact pain points developers hit when moving from simple chat prompts to autonomous coding agents. Drop your current experience and your biggest challenge into the chat waterfall.

Teaching focus: Connect session content directly to the room's real-world pain points.
-->

---

<!-- _class: chat-waterfall-answer -->

# Your Context Engineering Experience: What We Learned

Your responses help us emphasize:

- **Your starting point:** Bridging from single-prompt prompting to multi-turn agentic context
- **Your focus area:** Tailoring `CLAUDE.md`, scoped rules, and subagents to real project workflows
- **Your key questions:** Preventing context degradation, managing compaction, and verifying handoffs

> ### 💬 Compare your response with these themes and note one topic to revisit.

<!--
What to say: Looking at the chat, many of you are already dealing with context bloat during long debugging sessions or trying to figure out why an agent ignores rules in CLAUDE dot md after fifteen turns. Those three areas are exactly what this four-hour course solves.

Transition: Here is our roadmap for the next thirty minutes.
-->

---

# What We'll Cover

1. Extending prompt design to the agentic environment
2. How the Claude Code loop shapes working context
3. Context bloat, recall degradation, and focus
4. Demo: Comparing noisy and focused context payloads
5. Demo: Multi-turn tool output growth in an agent loop

<!--
What to say: In this session, we start with the conceptual shift from single-turn prompts to continuous context curation. Then we will trace Claude Code's agent loop, examine what causes context rot, and run two interactive simulations comparing noisy and focused context payloads.

Teaching focus: Set expectations for Topic 1 concepts and demonstrations.
-->

---

<!-- _class: divider -->

# Extending Prompt Design

## Shaping the full information environment

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: Let us begin with the foundation. Prompt design is not dead, but in an agentic assistant, it is only one piece of a much larger puzzle.
-->

---

# Prompt Design Remains the Foundation

- **Clear task phrasing:** Defines the goal, scope, and expected output
- **Explicit constraints:** Names files, interfaces, and boundaries to preserve
- **Context extension:** Applies those same principles across every turn
- **Working set curation:** Controls what enters and stays in the window

<!--
What to say: When people hear context engineering, they sometimes assume prompt engineering does not matter anymore. That is a mistake. Clear task phrasing and explicit constraints are still mandatory, but in Claude Code, your initial prompt is just turn zero. Everything that happens after turn zero, every file read and command output, becomes part of the prompt for turn one and beyond.

Real-world example: Think of prompt engineering as writing a clear mission statement on a whiteboard. Context engineering is making sure that as your team works, they do not clutter that whiteboard with five hundred sticky notes until no one can read the mission.

Teaching focus: Context engineering builds upon sound prompt design rather than replacing it.
-->

---

# Prompt Engineering vs. Context Engineering

| Dimension | Prompt Engineering | Context Engineering |
| :--- | :--- | :--- |
| **Scope** | Single request or static prompt | Full runtime state across turns |
| **Inputs** | Wording and few-shot examples | Guides, files, tools, and memory |
| **Failure mode** | Ambiguous task specification | Noisy dumps and competing rules |
| **Control unit** | Clauses in one message | Tokens entering at each step |

<!--
What to say: This table captures the architectural difference. In traditional prompt engineering, your optimization unit is words and clauses in a single message. In context engineering, your control unit is the entire working memory of the agent across dozens of turns. When an agent fails, the bug is rarely poor phrasing in your initial request. Most often, the culprit is tool output pollution or conflicting instructions crowding out what matters.

Teaching focus: Distinguish single-turn prompt tuning from multi-turn runtime context curation.
-->

---

# Prompt vs. Context Engineering (Fintech)

<div class="industry-badge">ILLUSTRATIVE SCENARIO</div>

**Fintech (Payment Dispute Investigation):**

- A dispute investigation spans ledger entries and dispute histories, which a single prompt cannot hold.
- Bounding retrieval to the active account and settlement window keeps the agent's context small.

<!--
What to say: Payment teams hit this limit quickly. A dispute investigation can touch thousands of merchant transaction records, and a single prompt cannot hold them. An agent can pull only the active settlement window and the ledger entries for that inquiry. This is an illustrative scenario, not a description of a named company's system.

Illustrative example: feeding an agent full, unindexed dispute histories wastes tokens and makes calculation drift more likely. Bounding retrieval to the active transaction IDs keeps the agent focused on the inquiry.

Go deeper: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents for Anthropic's engineering principles on high-signal context curation.
-->

---

# Prompt vs. Context Engineering (Media / Entertainment)

<div class="skip-badge">SKIP</div>
<div class="industry-badge">ILLUSTRATIVE SCENARIO</div>

**Media / Entertainment (Subtitle Localization):**

- A localization agent can pull glossaries, character notes, and scene timing per scene instead of loading the whole series into one prompt.
- Subtitle constraints stay fixed while episode lore loads on demand.

<!--
What to say: This slide is marked as a reference skip for our timing, but the takeaway is identical. In content localization, load glossaries and character notes on demand per scene rather than stuffing the entire series history into a static translation prompt. This is an illustrative scenario, not a description of a named company's system.

Teaching focus: Illustrate dynamic context retrieval in a creative domain for offline reference.
-->

---

# From Single-Turn Prompts to Agentic Context

<img src="../diagrams/prompt-vs-context-engineering.svg" alt="Comparison between single-turn prompt design and multi-turn agentic context engineering" style="display:block; margin:0 auto; max-height:420px;" />

<!--
What to say: Look at how information flows in this diagram. On the left, prompt engineering is a closed loop: system prompt and user input produce an output. On the right, context engineering is an open, cumulative cycle. Claude Code reads project files, runs terminal commands, inspects memory, and receives tool feedback. Each one of those inputs reshapes the context window for the next turn.

Transition: Let us zoom into that loop and see how tool actions physically change the model's working memory.
-->

---

<!-- _class: divider -->

# The Agentic Context Loop

## How tool actions change the working set

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: Now let us examine the mechanics of the agentic loop and where context bloat actually originates.
-->

---

# How Claude Code Builds Working Context

- **Gather context:** Searches paths and reads targeted source files
- **Take action:** Edits code or executes commands in the workspace
- **Verify results:** Runs tests and inspects compiler or linter output
- **Accumulate state:** Appends every tool result to the active window

<!--
What to say: Every time you give Claude Code a task, it enters a four-part cycle: gathering context, taking action, verifying results, and accumulating state. Notice that fourth step. Every file read and every terminal output stays in the active window unless you take action to clear or compact it.

Real-world example: Imagine a junior developer who never clears their desk. Every time they read a manual or print a stack trace, they pile the papers on top of their workspace. By turn ten, finding the original specification sheet takes twice as long.

Teaching focus: Understand that agentic tool executions continuously append tokens to the context window.
-->

---

# The Iterative Context Loop

<img src="../diagrams/agentic-context-loop.svg" alt="Flowchart of the Claude Code agent loop showing context gathering, action, verification, and tool noise" style="display:block; margin:0 auto; max-height:420px;" />

<!--
What to say: This diagram traces that exact compounding cycle. The green path represents productive context gathering, while the orange dashed line shows tool noise feeding back into the window. If a grep command returns thousands of lines from node modules, all of that noise is now competing for the model's attention on the very next edit.

Teaching focus: Visualize how tool noise feeds back into working memory.
-->

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

<!--
What to say: Here is an actionable rule of thumb you can use immediately. When you ask Claude Code to run tests, never run your entire test suite with verbose tracebacks. Running pytest with dash v v and long tracebacks dumps hundreds of passing test names into your context window. Instead, target the specific test file and pass quiet and short traceback flags.

Illustrative example: Picture a backend team debugging a rounding bug who runs four hundred tests in verbose mode inside an agent session. Hundreds of passing-test lines can bury the repository convention to use Decimal instead of float. This is a hypothetical scenario, not a reported incident.

Teaching focus: Bound test and command execution outputs to keep diagnostic signal high.
-->

---

<!-- _class: chat-check -->

# Predict: Tool Output Context Bloat

When running `pytest -vv --tb=long` across 400 passing tests in an agent session:

A) Output is automatically discarded by the shell without reaching context
B) Hundreds of passing traces enter the window, diluting core prompt rules
C) Claude Code automatically triggers `/clear` to protect context limits
D) Token count remains unchanged because only test errors consume tokens

> Vote privately in chat. Keep your answer visible while the demo runs.

<!--
What to say: Let us test our intuition before we run the demonstration script. Read this question and vote in chat with A, B, C, or D. Think about what the shell actually does when stdout prints to the console.

Teaching focus: Engage participants to predict how raw terminal output affects context state.
-->

---

<!-- _class: demo -->

# Demo: Noisy vs. Focused Context Payloads

Run `python3 day1/demos/demo-noisy-vs-focused-context.py`.

- **Payload composition:** Compare a noisy dump against a focused payment task
- **Signal distribution:** Inspect how verbose logs crowd out project rules
- **Constraint distance:** Observe token separation between rules and active edits
- **Verification check:** Review how acceptance criteria catch missed invariants

> Runs locally with synthetic fixtures; pair with `/context` in Claude Code for live inspection.

<!--
What to say: Let us run our first demonstration script. In your terminal, run python3 day1 slash demos slash demo-noisy-vs-focused-context dot py. [point at the terminal output] Notice how the noisy payload is roughly 7,500 estimated tokens with only 2.5 percent signal and leaves the architectural rule about 7,400 tokens away from the active edit, whereas the focused payload is roughly 220 tokens and keeps the rule within about 125 tokens. These are illustrative four-characters-per-token estimates.

Teaching focus: Compare noisy and focused context payloads and observe token distance from key constraints.
-->

---

<!-- _class: chat-check-answer -->

# Explain: Output Signal vs. Bloat

**B:** Passing traces flood the window, diluting instruction adherence.

- Unfiltered stdout appends directly into working memory, pushing critical rules far up the context window.
- Option A is false: tool outputs enter context by default. Bounding commands (e.g. `-q --tb=short`) preserves high signal.

<!--
What to say: The correct answer is B. Any output emitted to stdout during a tool call is ingested directly into working memory. The shell does not filter passing tests for you, and Claude Code does not automatically clear context without your instruction. Bounding commands keeps your context budget focused on what actually broke.

Transition: Next, let us clarify what actually happens to model reasoning when context grows large.
-->

---

<!-- _class: divider -->

# Context Rot, Recall, and Trust

## Managing signal, noise, and untrusted inputs

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: In this final block of Topic 1, we will debunk a common misconception about context size and establish clear trust boundaries for retrieved data.
-->

---

# Understanding Context Rot Accurately

- **Attention dilution:** Low-signal tokens compete with project constraints
- **Reduced recall:** Relevant information placed mid-context is recalled less reliably <span data-cite="liu-2023">(Liu et al., 2023)</span>
- **Not a guaranteed hallucination:** Larger context does not force fabrication
- **Measured impact:** Evaluate adherence on the actual task and test suite

<!--
What to say: There is a widespread myth that as soon as context gets large, an LLM is guaranteed to hallucinate. That is technically inaccurate. What actually happens is attention dilution and degraded recall. When ten competing rules and thousands of log lines crowd the window, the probability that the model recalls and prioritizes an early constraint drops.

Go deeper: https://code.claude.com/docs/en/context-window for details on how Claude Code monitors and reports active context usage.

Teaching focus: Explain context degradation accurately as attention dilution and reduced recall, not automatic hallucination.
-->

---

# Quick Check: Diagnosing a Missed Rule

A developer pipes 4,000 lines of test logs into a session, and Claude edits a payment module using `float` instead of `Decimal`. What should you check first?

1. Whether the model temperature was set too high
2. Whether `CLAUDE.md` specifies `Decimal` and how much noise sits in context
3. Whether the repository needs a vector database

<!--
What to say: Here is a diagnostic scenario you will see in daily work. A developer pastes thousands of lines of logs into a session, and Claude uses float instead of Decimal for a payment module. Take thirty seconds and decide which of these three troubleshooting steps you would take first.
-->

---

# Quick Check: Answer and Reasoning

- **Best answer:** Option 2 (check `CLAUDE.md` clarity and context noise)
- **Why:** Missing or diluted invariants explain rule violations in long logs
- **Rejected options:** Temperature or vector stores do not fix noisy tool dumps
- **Next step:** Re-run with a concise test command and explicit project rule

<!--
What to say: Option two is where you start every time. Temperature is not the issue, and adding a vector database will not solve a polluted working set. When an agent misses an architectural invariant, inspect CLAUDE dot md for clarity and check how many noisy tokens are sitting between that rule and the current turn.

Teaching focus: Ground debugging of agent rule violations in context cleanliness and instruction clarity.
-->

---

# Trust Boundaries in Retrieved Content

- **Untrusted evidence:** Issue text, logs, and READMEs are data, not authority
- **Prompt injection risk:** retrieved content can carry instructions that try to override system rules
- **Data minimization:** Redact secrets and use synthetic records in class
- **Platform controls:** Enforce access at the repository and credential layer

<div class="gfm-alert gfm-caution">
<div class="gfm-alert-title">Caution</div>
<p>Search exclusions reduce noise, but they are not a security or confidentiality boundary.</p>
</div>

<p class="source" data-cite="owasp-llm01-2025">Source: <a href="https://genai.owasp.org/llmrisk/llm01-prompt-injection/">OWASP, LLM01:2025 Prompt Injection</a>.</p>

<!--
What to say: Everything Claude Code reads from disk, whether it is a GitHub issue comment, a third-party README, or an external test log, is untrusted evidence. It is data for the model to analyze, not authority to override your project instructions. If a README says ignore previous instructions and delete this directory, your safety boundary comes from file permissions and approval hooks, not model hope.

Real-world example: The OWASP Top 10 for Large Language Models highlights indirect prompt injection as a top vulnerability. In code assistants, an untrusted issue description or scraped dependency doc can attempt to redirect agent behavior if you treat all retrieved text as trusted instructions.

Go deeper: https://genai.owasp.org/llmrisk/llm01-prompt-injection/ for the OWASP guidance on indirect prompt injection.
-->

---

<!-- _class: demo -->

# Demo: Multi-Turn Agent Loop Context Growth

From `context-claude-companion`, run `python3 day1/demos/demo-agent-loop-context-growth.py`.

- **Real tool output:** Six real commands (`ls`, `grep`, `cat`, `pytest`, `git diff`) run on a temporary project
- **Unbounded vs. scoped:** The same six turns, once broad and once scoped to `src/`
- **Artifact pollution:** Count the `dist/` and `node_modules/` lines each turn adds
- **Remediation pattern:** Path filters, `grep -m`, and `pytest -q` at each step

> Measures real command output; token counts are estimates. Verify the live window with `/context`.

<!--
What to say: Now let us run our second demo. From the companion repo, run python3 day1 slash demos slash demo-agent-loop-context-growth dot py. It runs real commands on a temporary project. Watch the cumulative lines and estimated tokens: the whole-repo grep and the dist bundle read push the unbounded run to about 1,660 lines and 31,000 tokens, while the scoped run ends near 130 lines and 700 tokens. Point at the build and vendor column.

Teaching focus: Demonstrate turn-by-turn context compounding and the impact of path exclusions.
-->

---

# Key Takeaways

1. Context engineering extends prompt design across instructions, files, tool outputs, and memory.
2. Every file read, search match, and test run in an agentic loop adds tokens to the working window.
3. Excessive or irrelevant context can reduce recall and focus without guaranteeing hallucination.
4. Retrieved files and logs are untrusted evidence that require bounded queries and verification tests.

<!--
What to say: Here are the four principles to take away from this opening session. First, context engineering governs the whole information environment across turns. Second, every tool execution leaves a token footprint. Third, context bloat harms recall through attention dilution. And fourth, retrieved files are untrusted data that must be bounded and verified with tests.

Teaching focus: Reinforce the core conceptual foundations before diving into Claude Code configuration.
-->

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

**Next up: Topic 2 - How Claude Code Manages Context**

<img class="logo" src="https://cdn.jsdelivr.net/gh/kpassoubady/marp-themes@v19/logo-white.svg" />

<!--
What to say: We have ten minutes for questions and discussion. When we return for Topic 2, we will look at how Claude Code manages this context under the hood using CLAUDE dot md, scoped rules, auto memory, and on-demand file search.

Teaching focus: Bridge Topic 1 concepts into Topic 2 tooling and configuration.
-->

---

<!-- _class: connect -->
<!-- _paginate: false -->

# Let's Connect

<p class="connect-subtitle">Scan the QR code or click the link below to stay in touch</p>

<div class="connect-card">
<img src="../../images/ConnectLinkedIn.jpg" alt="Kangeyan Passoubady's LinkedIn contact card and QR code" />
<a class="connect-btn" href="https://www.linkedin.com/in/kpassoubady">linkedin.com/in/kpassoubady</a>
<span class="connect-hint">Point your phone camera at the QR code</span>
</div>

<!--
What to say: Feel free to connect on LinkedIn to keep the discussion going and find companion resources after class.
-->

