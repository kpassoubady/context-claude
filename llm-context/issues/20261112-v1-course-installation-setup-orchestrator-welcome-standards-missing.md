# Welcome Message Standards Document Not Found

- Severity: Minor
- Status: Open
- Found during: Course installation setup
- Affected files: ../../context-claude-setup/Welcome.md
- Issue: `docs/courseware/welcome-message-standards.md` could not be located, so Welcome.md follows the section order in the course-welcome-message skill instead.
- Edge case: Welcome.md uses absolute `blob/main` links that resolve only after the setup repository changes are pushed.
- Recommended action: Audit Welcome.md against the standards document if it exists, and push the setup repository before distributing.
