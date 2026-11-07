Context Engineering with Claude: the 11-Step Guide That Replaced Prompting
On July 24, 2026, Anthropic removed over 80% of Claude Code's system prompt - 800 tokens down to 164 - with zero drop on coding evaluations. 
The instructions were dead weight. The constraints were preventing capability. The model got smarter. The prompt didn't catch up.
Prompting is dead. The engineers shipping the best agents in 2026 talk about context: what data hits the model, in what order, at what moment. Karpathy defined it. Anthropic proved it. Most people missed the shift.
This is the 11-step guide that takes you from writing prompts to engineering the full context stack.
Follow my Substack to get fresh AI alpha: movez.substack.com
Context engineering is not "write a better prompt." 
It is designing the entire information architecture around the model: system prompt, CLAUDE.md, skills, tool descriptions, retrieved documents, conversation history, memory, examples, and constraints. 
The model is the same for everyone. The context is the variable. This is how to engineer it.
The LLM is the CPU. The context window is RAM. Your job is OS management.

01. What context engineering actually is
Karpathy's definition: context engineering is "the delicate art and science of filling the context window with just the right information for the next step."
The analogy that makes it click: the LLM is a CPU. The context window is RAM. Every time you send a message, the model does not "remember" anything. It reads the entire context window from scratch, processes it, and generates a response. 
Your job as an engineer is operating-system management: loading the right data into working memory before each inference step.
Prompt engineering was about writing one good instruction. Context engineering is about designing everything the model sees before it generates a single token. 
The system prompt, the retrieved documents, the tool descriptions, the conversation history, the skills, the memory files, the examples. All of it. The prompt is one line in that stack. Often the least important one.

02. The 80% cut
On July 24, 2026, Anthropic's Thariq Shihipar published "The new rules of context engineering for Claude 5 generation models." 
The key finding: the Claude Code team removed over 80% of their system prompt for Opus 5 and Fable 5 with zero performance loss on coding evaluations.
800 tokens down to 164. The instructions that took months to accumulate were not just unnecessary. They were actively harmful. Thariq's word for it: "unhobbling."
Constraints designed to prevent failures in older models were now creating conflicting instructions and stifling the capability of newer ones.
The old prompt had rules like "default to writing no comments. Never write multi-paragraph docstrings." 
The new version: "Write code that reads like the surrounding code: match its comment density, naming, and idiom." One rule. Broader. The model fills in the specifics from the codebase itself.
If Anthropic's own system prompt was 80% dead weight, yours almost certainly is too.
Anthropic built a tool for this: the /doctor command in Claude Code. It audits your instructions and identifies rules that are no longer needed for newer models. 
Run it before adding more rules.

03. The six shifts
Thariq's post documented six specific changes in how Anthropic now engineers context for Claude 5 models. Each shift is a reversal of what was considered best practice six months ago.
The through-line: give Claude more responsibility, less prescription. Older models needed every rule spelled out. 
Newer models work better when you describe the goal and let them figure out the path. Over-specifying now actively hurts performance.

04. System prompts: thin, not thick
The old advice was "put everything in the system prompt." The new rule: system prompts should be thin. Define the role, the output format, and the boundaries. Nothing else.
 Everything else goes into CLAUDE.md, skills, or tool descriptions where it can be loaded on demand instead of consuming tokens on every single call.
Thariq's framework: thin prompts, thick artifacts + context, thin skills. The system prompt is the thinnest layer. 
The surrounding context (CLAUDE.md, retrieved docs, code examples) is the thickest. Skills are thin because they are loaded only when needed.
plaintext
# OLD: 800 tokens of prescriptive rules
You are a coding assistant. When writing code:
- Default to writing no comments
- Never write multi-paragraph docstrings
- Use snake_case for variables
- Prefer list comprehensions over loops
- Always add type hints
- Never use print() for debugging
- ... (30 more rules)

# NEW: 164 tokens of judgment
You are a coding agent working in the user's repository.
Write code that reads like the surrounding code: match
its comment density, naming conventions, and idiom.
Run tests after every change. If tests fail, fix the
code, not the tests.
The old prompt told Claude what to do in 30 specific cases. The new prompt tells Claude the principle once and trusts it to apply the principle to every case. Fewer tokens. Better results.

05. CLAUDE.md and skills
CLAUDE.md is your project's persistent context. Claude Code reads it at the start of every session. Your architecture decisions, naming conventions, known issues, build commands. Write it once, read forever.
Skills are reusable workflows loaded on demand. The difference from CLAUDE.md: skills are loaded only when relevant. 
If you have a "deploy-to-production" skill and you are fixing a CSS bug, the skill stays unloaded. This is progressive disclosure: give Claude the context it needs for the current task, not every possible task.
markdown
# Project: E-commerce API
Python 3.12, FastAPI, PostgreSQL 16, Redis

# Conventions
- All responses: {data, error, meta} schema
- Commit messages: type(scope): description
- Tests: pytest, every endpoint needs happy + error path

# Known issues
- Auth middleware expects x-auth-token, not Authorization
- Full test suite takes 45s. Use --filter for iteration.
- Payment API expects idempotency key in header, not body
The "Known issues" section is the highest-leverage part. Every bug your agents have already found goes here. Next session reads it. That bug never happens again.

06. Tool descriptions as context
Most people think of tool descriptions as metadata. They are not. Tool descriptions are context. 
Claude reads every tool description before deciding which tool to use and how to use it. A vague description means wrong calls. A precise description means accurate calls.
One of Thariq's six shifts: move instructions out of the system prompt and into tool descriptions. 
If a rule only applies when a specific tool is called, put the rule in that tool's description, not in the system prompt where it consumes tokens on every call.
python
# BAD: vague, rules in system prompt
{"name": "run_query", "description": "Run a database query"}

# GOOD: precise, rules in the tool itself
{
    "name": "run_query",
    "description": """Execute a read-only SQL query against
    the PostgreSQL database. SELECT only. Never INSERT,
    UPDATE, or DELETE. Results are returned as JSON rows.
    Maximum 1000 rows per query. If you need more, paginate
    with LIMIT/OFFSET. The database uses UTC timestamps."""
}
The rule "never INSERT, UPDATE, or DELETE" used to live in the system prompt. Now it lives in the tool description. It loads only when the tool is available. Zero tokens wasted when the tool is not in play.

07. Dynamic context: retrieval and progressive disclosure
Static context (system prompt, CLAUDE.md) is loaded every time. Dynamic context is loaded just-in-time based on what the task needs. 
This is how you keep the context window lean while still giving Claude access to large knowledge bases.
Retrieval means pulling relevant documents into context at the moment they are needed. Claude searches a knowledge base, fetches the 3 most relevant chunks, and uses them for the current step. The other 997 chunks stay out of the window.
Progressive disclosure means starting with a minimal context and expanding it as the task reveals what is needed. Step 1 loads only the task description. Step 2 loads the relevant skill. Step 3 loads the reference code. Each step gets exactly the context it needs, nothing more.

08. Memory: learnings, auto-memory, state files
Memory is context that accumulates over time. Without it, every session starts from zero. The agent re-discovers your conventions, re-learns your quirks, re-makes the mistakes it made yesterday.
Learnings file. A running log of bugs and fixes that the agent reads at the start of every session. When a mistake shows up three times, you promote it to CLAUDE.md as a permanent rule.
Auto-memory. One of Thariq's six shifts: newer Claude models support automatic memory consolidation. Instead of manually writing learnings, the model captures context across sessions using Anthropic's Dreaming memory feature. The shift from manual to automatic.
State files. For agentic loops, a JSON file that records what happened: attempts, successes, failures, next steps. The agent reads it at the start of each run. Run #50 starts where run #49 left off instead of from zero.
markdown
# learnings.md - accumulated context

- Payment API expects idempotency key in header, not body.
  Three agents hit this independently. Now a hard rule.

- PostgreSQL NOTIFY needs explicit LISTEN in connection pool.
  Default pool settings drop the channel after 30s.

- Rate limiter counts per-key, not per-IP.
  Tests need unique API keys or they share a bucket.
The compounding effect: every learnings entry makes the next session faster. First run: 20 minutes of discovering your project. Fiftieth run: 30 seconds of replaying accumulated context. 
Same model. Different context. Different speed.

09. Four failure modes
When Claude produces bad output, the problem is almost always in one of four context failures. Diagnosing which one saves you from rewriting the prompt when the prompt was never the issue.
Poisoning. Bad data in the context window. A retrieved document that is outdated, irrelevant, or factually wrong. Claude trusts what it reads. If the context is wrong, the output is wrong. Fix: validate retrieved documents before loading them.
Distraction. Too much context. You dumped 200 pages of documentation into the window and the model cannot find the 3 paragraphs that matter. Fix: retrieve less, more precisely. 3 relevant chunks beat 50 tangential ones.
Confusion. Conflicting instructions. The system prompt says "never write comments." The CLAUDE.md says "add a comment above every public function." The model picks one arbitrarily or tries to satisfy both and produces nonsense. This is what Thariq found in 80% of their deleted instructions. Fix: audit for conflicts. Run /doctor.
Starvation. Missing context. You asked Claude to match the project's coding style but never showed it the existing code. You asked for a report in company format but never provided a template. Fix: show, don't describe. Give Claude the actual artifact instead of describing it in words.

10. The context audit
If you have a CLAUDE.md file, a system prompt, or a skills library that was built for Claude 3 or Claude 4 models, it is carrying legacy weight. 
Instructions that once prevented worst-case behavior now create conflicting guidance for a more capable model.
The audit process: pull every "verify," "double-check," "re-verify," "make sure to," and "always remember to" instruction out of your context stack. 
For each one, ask: does Claude 5 still need this rule, or does it do this by default? If the answer is "by default," delete the rule. It is consuming tokens and creating conflict potential for zero benefit.
markdown
# Context audit checklist

1. Run /doctor in Claude Code
2. Count total tokens in your static context
   (system prompt + CLAUDE.md + always-loaded skills)
3. For each rule ask: does Opus 5 do this by default?
   If yes: delete it
4. Check for conflicts between layers
   (system prompt says X, CLAUDE.md says not-X)
5. Move tool-specific rules into tool descriptions
6. Replace prescriptive rules with judgment principles
   "never write comments" -> "match surrounding style"
7. Replace markdown specs with real artifacts
   description of format -> actual example file

11. Richer references
The last of Thariq's six shifts: replace simple markdown specs with richer reference materials. 
Instead of describing the output format in words, show Claude the actual artifact. 
Instead of writing test criteria in the prompt, point at the test suite. Instead of explaining the code style, let Claude read the codebase.
This is Karpathy's Software 3.0 in practice: the context window is the program. The code, tests, and rubrics you load into it are your source code. The LLM interprets them.
markdown
# BEFORE: describing the format
Write a report with an executive summary (2 paragraphs),
three findings (each with a heading, 2-3 paragraphs,
and a supporting data point), and a conclusion with
three actionable recommendations.

# AFTER: showing the format
Here is a report we published last quarter that matches
the format and quality bar we want:

[actual report pasted or @-mentioned]

Write the new report in the same format, tone, and
depth. Match it, don't describe it.
One real example outperforms ten paragraphs of format specification. The model pattern-matches from the example.
That is faster, cheaper, and more accurate than parsing your prose description of what you want.

Five context engineering mistakes
x Stuffing the system prompt. Every rule in the system prompt costs tokens on every call. Move tool-specific rules into tool descriptions. Move project rules into CLAUDE.md. Keep the system prompt under 200 tokens.
x Describing instead of showing. Three paragraphs explaining the output format vs one real example pasted into context. The example wins every time. Show the artifact.
x Never auditing. Context accumulates like technical debt. Rules added for Claude 3 are still running on Claude 5. Run /doctor. Delete what the model no longer needs.
x Loading everything upfront. 50 skill files loaded on every call. The model cannot find the relevant one. Use progressive disclosure: load skills on demand based on the current task.
x Conflicting layers. System prompt says one thing. CLAUDE.md says another. Tool description says a third. The model picks one or tries all three. Audit for conflicts before adding more instructions.

Conclusion:
The prompt was never the variable. The context was.
For two years the AI industry optimized prompts. "Think step by step." "You are a senior engineer." "Be concise." Tricks that moved the needle 5-10%. Context engineering moves it 2-3x.
Karpathy defined it. Anthropic proved it by deleting 80% of their own instructions. The model is the same for everyone. The context is the variable. System prompt, CLAUDE.md, skills, tool descriptions, retrieved docs, memory, examples, state. That is your program. The LLM just interprets it.
The engineers who understand this are building agents that work. The ones still rewriting prompts are debugging the wrong layer.
