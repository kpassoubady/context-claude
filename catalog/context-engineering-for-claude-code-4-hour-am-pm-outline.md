# Context Engineering for Claude Code

## Course Details

| Course detail | Value |
| --- | --- |
| Duration | 4 hours per cohort |
| Audience | Developers working in AI-assisted coding environments |
| Skill level | Intermediate |
| Format | Instructor-led course with demonstrations, a quiz, and two breakout labs |
| Primary tool | Claude Code |

## Delivery Model

| | Day 1 |
| --- | --- |
| **Morning Cohort** | Session 1 (AM) |
| **Afternoon Cohort** | Session 1 (PM, repeated) |

The instructor delivers the same four-hour session to both cohorts. The afternoon session repeats the morning instruction, demonstrations, quiz, labs, and outcomes without content changes.

## Course Overview

Participants learn context engineering principles specific to Claude Code. They begin by examining why static prompt engineering falls short in iterative agent loops and how unmanaged tool outputs cause context rot. They explore how Claude Code discovers and filters information at runtime using upfront project instructions in CLAUDE.md and on-demand search with glob and grep. Participants then practice preserving agent coherence across long tasks using transcript compaction, external note-taking, and sub-agent architectures. The session concludes with concrete diagnostic methods to identify context dilution, measure token efficiency, and iteratively improve context configurations.

## Main Topics Covered

- From prompt engineering to context engineering
- How Claude Code manages context at runtime
- Maintaining coherence across long tasks
- Context quality, evaluation, and iterative optimization

## Learning Outcomes

By the end of the session, participants will be able to:

- Distinguish context engineering from prompt engineering in the context of Claude Code.
- Describe how Claude Code retrieves and manages context at runtime using files and tools.
- Maintain agent coherence across extended workflows using compaction, structured handoffs, and external context.
- Recognize how context decisions affect output reliability, error rates, and token efficiency.

## Project Context and Tools

Participants use Claude Code, Git, and a multi-module sample repository with independent starter directories for each lab. The repository contains realistic application code, unconfigured build scripts, and test suites. Course materials provide reference prompt rules, task handoff templates, compaction runbooks, and context audit checklists. Each breakout lab starts from a verified standalone snapshot, allowing participants to complete each exercise without depending on outputs from earlier blocks.

## Prerequisites

Participants should have:

- Familiarity with core LLM concepts and prompt engineering terminology
- Basic experience using Claude Code or a comparable AI coding assistant
- Working knowledge of terminal commands, Git version control, and project navigation

## Session 1: Context Engineering for Claude Code

### 1. From Prompt Engineering to Context Engineering

#### Concept & Demo

The instructor contrasts conventional prompt engineering with context engineering in autonomous agent workflows. In simple chat interfaces, crafting clever instructions often suffices. In agentic tools like Claude Code, the model operates in a loop of reading files, executing shell commands, and interpreting errors. The demonstration illustrates how unmanaged tool outputs and compiler logs cause context rot, where accumulated irrelevant tokens degrade instruction adherence and induce hallucinations. Participants observe how agent reliability depends on deliberate context curation, explicit working-memory boundaries, and selective retrieval rather than prompt phrasing alone.

### 2. How Claude Code Manages Context

#### Concept & Demo

The instructor walks through the runtime context lifecycle of Claude Code, examining how the agent discovers, filters, and retains information. The demonstration details how CLAUDE.md files supply upfront project instructions, style conventions, and verification commands without saturating the context window. The instructor shows how Claude Code uses glob patterns and grep regex searches for just-in-time retrieval instead of ingesting entire directories. The demonstration highlights techniques for structuring inputs, formatting CLI outputs, and preventing context bloating during repository reconnaissance.

#### Breakout Lab 2.1: Structuring Project Context with CLAUDE.md

Participants inspect a multi-component codebase where Claude Code encounters ambiguous commands, contradictory conventions, and excessive token usage during file exploration. Working in their local environment, participants create and refine a project-level CLAUDE.md alongside targeted directory guidelines. They test and verify that Claude Code retrieves targeted files using glob and grep, follows project standards, and runs verification checks without human corrections.

Lab outcome: A tested CLAUDE.md configuration with project instructions, verification commands, and documented evidence of reduced retrieval token overhead during agent exploration.

### 3. Maintaining Coherence Across Long Tasks

#### Concept & Demo

The instructor demonstrates strategies for preserving context coherence across extended, multi-turn development workflows. The demonstration covers Claude Code compaction, showing how to prune discarded hypotheses and redundant terminal logs while retaining critical architecture decisions, file paths, and active goals. The instructor illustrates external context preservation using structured scratchpad notes in persistent documentation directories, lightweight retrieval mechanisms, and sub-agent exploration architectures that delegate exploratory tasks to isolated child contexts before summarizing findings to the primary session.

#### Breakout Lab 3.1: Context Compaction and State Handoffs

Participants inherit an ongoing debugging session with a bloated context history showing early signs of degradation. Participants analyze token accumulation, execute a structured compaction pass, and record active task state and architectural constraints into persistent scratchpad notes. They then transfer the task into a fresh agent session and verify that Claude Code completes the fix without repeating earlier failed steps or losing context.

Lab outcome: A documented handoff record including a distilled task summary, durable scratchpad notes, and verified test execution completed in a fresh agent session.

### 4. Context Quality and Iteration

#### Concept & Demo

The instructor presents methods for diagnosing context quality, measuring token efficiency, and refining context architectures over time. The demonstration identifies three primary context hazards: noise from verbose tool responses, staleness from cached file assumptions, and context dilution from redundant instructions. The instructor introduces metrics to track agent performance, including prompt-to-completion token ratios, turns required per task, and instruction compliance rates. The demonstration concludes with a systematic review process for auditing project rules and trimming obsolete guidance to maintain high agent velocity.

### Session Breakdown Table

| Topic | Duration |
| --- | ---: |
| Welcome, Course Intro & Setup | 15 min |
| 1. From Prompt Engineering to Context Engineering: Concept & Demo | 30 min |
| 2. How Claude Code Manages Context: Concept & Demo | 30 min |
| Lab 2.1: Structuring Project Context with CLAUDE.md | 25 min |
| Bio Break | 15 min |
| 3. Maintaining Coherence Across Long Tasks: Concept & Demo | 30 min |
| Lab 3.1: Context Compaction and State Handoffs | 25 min |
| Kahoot Quiz 1 | 15 min |
| Bio Break | 10 min |
| Mandatory Course Survey | 5 min |
| 4. Context Quality and Iteration: Concept & Demo | 25 min |
| Course Wrap-up | 15 min |
| **Total** | **4 hours** |

