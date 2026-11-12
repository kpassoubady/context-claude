# Machine-Specific Path in Setup Template Script

- Severity: Minor
- Status: Open
- Found during: Course installation setup
- Affected files: ../../context-claude-setup/scripts/generate-excalidraw-diagrams.py
- Issue: Tracked template script hardcodes an absolute local path to an unrelated course.
- Edge case: Pre-existing, not added by this run; the script is not part of student setup.
- Recommended action: Remove the scripts/ template tooling from the setup repository or parameterize the path.
