# How to Split Marp Across Two Monitors

Marp exports HTML presentations powered by Bespoke.js, which includes built-in presenter mode and multi-window synchronization. You can present on an external monitor or projector while viewing speaker notes, slide previews, and timing on your primary screen without relying on external plugins or proprietary presentation software.

## Quick Start Summary

1. **Open your presentation twice**: Open your exported `presentation.html` file in two separate browser windows (not two tabs in the same window).
2. **Set one window to Presenter View**: In the second browser window, click the address bar and add `?view=presenter` to the end of the URL (for example: `file:///path/to/deck.html?view=presenter`), then press Enter (or press `p` on your keyboard).
3. **Separate the windows**: Drag your normal window (audience view without `?view=presenter`) onto your external monitor or projector, and keep the presenter view window on your laptop screen.
4. **Present normally**: Click into either window and use your arrow keys or spacebar. Because both windows share the same local URL origin, slide changes remain synchronized automatically across both screens.

## Detailed Step-by-Step Instructions

### Step 1: Export Presentation to HTML

Generate the standalone HTML slide deck using Marp CLI or the workspace build script:

```bash
# Using the workspace script
./scripts/build-slides-html.sh

# Or directly with Marp CLI
marp --html --allow-local-files day1/slides/01-from-prompt-engineering-to-context-engineering.md -o day1/slides/html/01-from-prompt-engineering-to-context-engineering.html
```

The resulting HTML file contains the complete presentation engine, themes, assets, and Bespoke.js presenter logic in a single file.

### Step 2: Open Two Separate Browser Windows

Launch your browser (Google Chrome, Microsoft Edge, Brave, or Mozilla Firefox) and open the exported HTML file in two independent windows:

1. Open the first window displaying the presentation:
   - macOS: Open Terminal or Finder and run `open day1/slides/html/01-from-prompt-engineering-to-context-engineering.html`
   - Windows: Double-click the file or run `start day1/slides/html/01-from-prompt-engineering-to-context-engineering.html`
2. Open a **brand new browser window** (press `Cmd+N` on macOS or `Ctrl+N` on Windows).
3. Copy the URL from the first window and paste it into the second window's address bar, or drag the tab out into its own standalone window.

> **Important**: Both views must run in separate **windows**, not separate tabs in the same window, so that you can move them to different physical displays.

### Step 3: Enable Presenter View on the Instructor Window

In your second window (the one that will stay on your laptop screen):

1. Click the browser address bar.
2. Append `?view=presenter` to the end of the file or web URL:
   - Local file example (macOS/Linux): `file:///Users/username/project/deck.html?view=presenter`
   - Local file example (Windows): `file:///C:/slides/deck.html?view=presenter`
   - Local server example: `http://localhost:8080/deck.html?view=presenter`
3. Press **Enter** to reload the page in Presenter View.

Alternatively, you can click into the window and press the keyboard shortcut **`p`** or click the presenter icon on the bottom navigation overlay.

### Step 4: Position Windows Across Displays

1. **Audience Display (External Monitor / Projector / Screen Share)**:
   - Drag the standard window (without `?view=presenter`) onto the external display.
   - Press **`f`** (or your browser's fullscreen shortcut, such as `F11` or `Cmd+Ctrl+F`) to enter clean fullscreen presentation mode.
2. **Presenter Display (Laptop Screen)**:
   - Keep the window with `?view=presenter` on your laptop or primary monitor.
   - Adjust the window size so you have a comfortable view of speaker notes, elapsed time, current slide, and upcoming slide.

### Step 5: Navigate and Deliver

- Click into either window and navigate using standard presentation keys:
  - **Next slide**: `Right Arrow`, `Down Arrow`, `Space`, or `Page Down`
  - **Previous slide**: `Left Arrow`, `Up Arrow`, or `Page Up`
  - **First slide**: `Home`
  - **Last slide**: `End`
- Both windows synchronize instantly through the browser's storage and message bus because they share the identical URL origin.

## Presenter View Interface Overview

When running with `?view=presenter`, Marp provides:

| Element | Location | Description |
| :--- | :--- | :--- |
| **Current Slide** | Left / Main panel | Live preview of what the audience sees |
| **Next Slide** | Top-right panel | Advance preview of the upcoming slide |
| **Speaker Notes** | Bottom-right panel | Markdown-formatted notes authored in slide decks |
| **Timer & Clock** | Header / Controls | Displays current local time and presentation duration |
| **Slide Counter** | Bottom control bar | Current slide index and total count (e.g., `12 / 29`) |

## Authoring Speaker Notes in Marp

Speaker notes in Marp decks are written using HTML comments:

```markdown
---
# Context Engineering Principles

Context is the runtime working memory of an agent.

<!--
Speaker Notes:
- Emphasize that prompt engineering is static, whereas context engineering is dynamic.
- Ask learners how often they run /compact in their daily workflows.
- Keep timing under 3 minutes for this slide.
-->
```

Anything inside `<!-- ... -->` on a slide is parsed into the notes panel in Presenter View and will never be rendered on the audience-facing slide.

## Keyboard Shortcuts Reference

| Key | Action |
| :--- | :--- |
| `Right` / `Down` / `Space` | Next slide |
| `Left` / `Up` | Previous slide |
| `p` | Toggle Presenter View |
| `f` | Toggle Fullscreen |
| `o` | Toggle Slide Overview (grid layout) |
| `Home` | Jump to first slide |
| `End` | Jump to last slide |

## Best Practices and Troubleshooting

### 1. Ensure Identical URL Origin

Synchronization relies on the browser's local origin storage (`localStorage` and `BroadcastChannel`). Both windows must use the identical URL prefix (e.g., both use `file:///...` or both use `http://localhost:3000/...`). Do not mix `localhost` and `127.0.0.1`.

### 2. Virtual Meetings (Zoom / Microsoft Teams / Google Meet)

When delivering online without a second physical monitor:

- Share only the **Audience Window** (Application Window share mode in your conference software).
- Keep the Presenter View window on your desktop alongside the meeting chat and participant list.

### 3. Audio or Video Media

If your slides embed local video or audio files, control playback from the Audience window so media playback events do not desynchronize.

### 4. Refreshing or Re-syncing

If slide advancement stops synchronizing, refresh both browser windows (`Cmd+R` or `Ctrl+R`). Navigating on either window re-establishes the broadcast channel immediately.
