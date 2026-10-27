# Changelog

## 1.1.0 · 2026-10-27

- After the final gate, the wrap runs without questions and reports what it moved. It asks only when a cycle pin could be for the repo or for this cycle, or when a new general line would contradict an existing one.
- General memory is frugal: only a big lesson that is general, proven, undisputed and new gets there, so most cycles add nothing. A narrow fact about a tool or library stays in project memory, and a merge adds only the new source to an existing line.
- Memory stays compact. Project memory keeps what is true now, with a promoted entry replacing the one it changes and the history left in `docs/archive/`. General memory stays under about 30 lessons and 10 pins: every wrap compacts a file over its limit, merging repeats and dropping lessons that only fit one repo, after saving a `.bak` copy for undo.
- The `AGENTS.md` block is at v5. Setup upgrades a v4 block in place.

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
