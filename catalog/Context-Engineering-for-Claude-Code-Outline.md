# Context Engineering for Claude Code

This course introduces context engineering principles specific to Claude Code. Participants will learn to recognize how context quality affects agent behavior and understand strategies for managing it across tasks of varying complexity.

## Audience

This course is ideal for:

- Developers working in AI-assisted coding environments

## Prerequisites

To get the most out of this session, participants should have:
- Familiarity with LLM concepts and terminology
- Basic experience with Claude Code or a comparable AI development tool

## Learning Objectives

After this course, participants will be able to:

- Distinguish context engineering from prompt engineering in the context of Claude Code
- Describe how Claude Code retrieves and manages context at runtime
- Recognize how context decisions affect output reliability and system performance

## Duration

4 hours

## Outline

### From Prompt Engineering to Context Engineering

- Why prompt engineering alone falls short in agentic systems
- Context rot and agent reliability
- How Claude Code manages context differently than general-purpose LLM tools

### How Claude Code Manages Context

- CLAUDE.md as an upfront context signal
- Just-in-time retrieval using glob and grep
- Structured inputs and outputs

### Maintaining Coherence Across Long Tasks

- RAG as an external context source
- Compaction and when to apply it
- Structured note-taking as persistent memory
- Sub-agent architectures for parallel exploration

### Context Quality and Iteration

- Noise, staleness, and context dilution
- Measuring whether context decisions are working
