# Project Overview

Internal course repository for **Context Engineering for Claude Code** (4-hour course). Holds the catalog, session outlines, Marp slide decks, rendered HTML decks, Mermaid and Excalidraw diagrams, Kahoot quizzes, and research notes. This is the instructor-only repo; exported artifacts go to students, but this repo does not.

Instructor demos, concept docs, and labs live in the companion repository (see Related Repositories), not here.

## Directory Layout
- `catalog/`: Course outlines and delivery guides.
- `day1/`: Day 1 course content.
  - `slides/`: Marp slide decks (`01`–`04`).
  - `html/`: HTML decks rendered from `slides/` by `scripts/build-slides-html.sh`.
  - `diagrams/`: Mermaid (`.mmd`) sources with rendered `.svg`/`.png`, plus Excalidraw sketches.
  - `quizzes/`: Kahoot quizzes.
- `docs/`: Guides and instructor references.
- `images/`: Shared images (for example, the LinkedIn connect card).
- `llm-context/`: Stores context for LLM agents.
  - `issues/`: Evaluator, audit, and timing-gap reports (versioned and dated).
  - `done/`: Completed work trackers and briefs.
  - `todos/`: Pending work trackers (for example, `day1/`).
  - `research/`, `learnings/`: Research notes and reference material.
  - `artifacts/`, `brainstorm/`, `info/`, `prompts/`, `roadmap/`: Working folders.
- `scripts/`: Export and validation tooling (see `scripts/README.md`).
- `.claude/`: Claude Code configuration.
  - `skills/`: Course-authoring skills (`course-*`, `archify-*`, `excalidraw-*`, `kahoot-*`).
  - `docs/courseware/`: Content, slide, diagram, demo, and citation standards.
  - `docs/excalidraw/`: Excalidraw LLM guide.
  - `scripts/`: Build helpers used by skills.

## Moved to Companion Repo
The `demos/` folder is no longer in this repo. Demos now live at `/Users/kangs/code/github/context-claude-companion/day1/demos/` (eight `demo-*.py` scripts plus a README). The companion repo also holds `day1/concepts/` (concept docs `01`–`04`) and the `lab2_1` and `lab3_1` breakout labs.

## Related Repositories
- [context-claude-companion](https://github.com/kpassoubady/context-claude-companion) — Student hands-on lab repository (demos, concepts, labs).
- [context-claude-setup](https://github.com/kpassoubady/context-claude-setup) — Pre-class setup and environment verification.

## Verification Steps
TBD

## Content Guidelines
- Follow markdownlint conventions (`.markdownlint.json`) and keep slide decks compatible with Marp.
- Ensure diagrams are maintained as Mermaid (.mmd) source files.
- Rebuild `day1/html/` after editing `day1/slides/` (`scripts/build-slides-html.sh`).
- Do not add demo scripts here; add them to the companion repo's `day1/demos/`.
