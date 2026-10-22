# Changelog

## 1.0.0 · 2026-10-21

First release as its own repository. The skills were developed in [paull78/skills](https://github.com/paull78/skills) until now.

- Memory has three levels: cycle (`docs/current/memory/`), project (`docs/memory/`) and general (`~/.agents/memory/`, machine-wide). At wrap, lessons and standing rules that hold in every project are proposed for the general level one at a time. `~/.claude/CLAUDE.md` imports the general index, so Claude Code reads it in every session.
- Claude Code's per-folder auto-memory is turned off in a project-time repo, and setup offers a home for anything it already holds. Each fact has one place.
- The `AGENTS.md` block is at v4. Setup replaces an older block in place.
- The entry skill keeps its file templates in `project-time/templates.md` and reads them only when setup writes a file.
- Tested with the scenario suite on Claude Code, and one build step on Codex.
- A short example cycle in [`examples/wall-dimensions`](examples/wall-dimensions).

## Before 1.0.0

- 2026-10-19 · `AGENTS.md` block v3: repo memory goes to `docs/`, not to the agent's own memory folder.
- 2026-10-01 · Agents without a Skill tool (Codex and others) hand off between phases by reading the next skill's `SKILL.md`.
- 2026-09-29 · The five skills: `project-time`, `project-spec`, `project-plan`, `project-build` and `project-wrap`, made consistent with each other.
