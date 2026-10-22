---
name: project-time
description: Entry point for the project workflow. Sets up the docs folder and standing memory rules on first run, then reads the state on disk and continues the active cycle (spec, plan, build, or wrap) for a new project or a feature. Use when the user types /project-time, wants to start a new project or feature with a spec and a tracked plan, or says continue, resume, or what's next on the project.
---

# Project Time

The front door of the project workflow. It makes sure the repo is set up, then hands off to the phase skill that owns the current state. It never does a phase's work itself.

Every piece of work is a **cycle**: the first build of a new project, or a feature. A cycle lives in `docs/current/` on its own branch and goes spec → plan → build → wrap, with a gate at each main point. Memory has three levels (cycle `docs/current/memory/`, project `docs/memory/`, general `~/.agents/memory/`), described in the project-time block of `AGENTS.md`. The files on disk are the source of truth, so any session resumes by running `/project-time`.

The templates for every file this skill writes are in `templates.md`, next to this file. Read it only when a setup or cycle-start step needs to write one.

| Phase skill | Owns |
|---|---|
| `project-spec` | the interview, `docs/current/spec.md`, Gate 0, spec amendments |
| `project-plan` | `docs/current/plan/`, Gate 1, plan updates |
| `project-build` | steps, progress, milestone gates, parallel runs |
| `project-wrap` | final gate, recap, promotion to project and general memory, archive |

## 1. Setup check

Run on every invocation. Each check is cheap; write only what is missing or outdated.

1. **Git.** `git rev-parse --is-inside-work-tree`. Not a repo: offer `git init`. If the user declines, carry on and skip every commit in the workflow.
2. **AGENTS.md block.** Look for `<!-- project-time:start v4 -->` … `<!-- project-time:end -->`.
   - No block: append the AGENTS.md block from `templates.md`, creating `AGENTS.md` if needed.
   - An older version marker: replace everything between the markers, markers included, with the block from `templates.md`.
   - The v4 marker: leave it alone. If the user asks to repair the block, replace it as above.
3. **CLAUDE.md import.** Claude Code ignores `AGENTS.md` when a `CLAUDE.md` exists, so `CLAUDE.md` must import it. No file: create it containing `@AGENTS.md`. File without an `@AGENTS.md` line: append one.
4. **Project memory.** Create `docs/memory/INDEX.md` and `docs/memory/overview.md` from `templates.md` if missing. Leave any other `docs/` content alone. If one of these paths exists but isn't ours, ask; never overwrite.
5. **Auto-memory off.** In a project-time repo the three levels replace Claude Code's per-folder auto-memory. Set `"autoMemoryEnabled": false` in `.claude/settings.json`, creating the file or merging the key into it. If the auto-memory folder for this repo (`~/.claude/projects/<path with / as ->/memory/`) holds entries, show them and propose a home for each: project memory (repo facts, machine facts such as ports included), general memory (facts about the user or their tools), or drop. Write the approved ones, then empty that folder.
6. **General memory.** Machine-wide, outside the repo, not committed. Create `~/.agents/memory/INDEX.md` from `templates.md` if missing. If `~/.claude/project-lessons.md` exists (the old general file), move its lines into `~/.agents/memory/lessons.md`, add the area to the INDEX, and delete the old file. Make sure `~/.claude/CLAUDE.md` has the line `@~/.agents/memory/INDEX.md`, creating the file if needed, so Claude loads the general level in every session.

If anything in the repo was written, commit only those files as `project-time: setup`.

## 2. Route

Read the `Status:` field in the headers of `docs/current/spec.md` and `docs/current/plan/INDEX.md`, and the current branch.

| State | Action |
|---|---|
| No `docs/current/` | Start a new cycle (section 3) |
| Spec `Status: draft` | Invoke `project-spec` |
| Spec `approved`, plan missing or `Status: draft` | Invoke `project-plan` |
| Plan `approved`, any step not `[x]` | Invoke `project-build` |
| Every step `[x]`, or `Current:` starts with `wrap` | Invoke `project-wrap` |

Before routing, compare the spec header's `Branch:` with the current branch. If they differ, stop and explain: either the user switched branches, or a branch was merged without wrapping. Ask how to proceed, and offer to wrap the cycle here.

If the user asks for something specific, route to its owner instead: "reopen" or "change the spec" → `project-spec` (amend mode); "change the plan" → `project-plan` (update mode); "a recap", "where do we stand" → `project-wrap` (interim recap).

**Hand off by invoking the phase skill with the Skill tool, not by reading its file.** In Claude Code an invoked skill survives context compaction; a file read doesn't. In agents without a Skill tool (Codex and others), read the phase skill's `SKILL.md`, from the folder next to this skill's, and follow it. Pass one line of context: the cycle slug and the state you found.

## 3. Start a new cycle

1. **Slug.** Ask for a short kebab-case name, or propose one from the user's message. It prefixes memory IDs and commit messages, so keep it short. It must not match a slug under `docs/archive/` or an ID prefix in `docs/memory/`.
2. **Type.** Infer it, don't ask. The repo is **blank** when `docs/archive/` is missing or empty and `git ls-files` lists nothing outside `docs/`, `AGENTS.md`, `CLAUDE.md`, `README*`, `LICENSE*` and dotfiles.
   - Blank → `project`. Not blank → `feature`.
   - State it in one line and carry on: "Starting feature cycle `import`. Say so if this is a project-level rewrite." A user override to `project` in a non-blank repo means a rewrite: a full-depth spec that still reads existing memory and code.
3. **Branch.** If the repo is not blank and you're on the default branch (`git symbolic-ref --short refs/remotes/origin/HEAD`, else `main` or `master`), offer `git switch -c feature/<slug>`. A blank repo's first cycle may stay where it is. One active cycle per branch.
4. **Skeleton.** Create `docs/current/spec.md` and `docs/current/memory/INDEX.md` from `templates.md`. Commit as `<slug>: start cycle`.
5. Invoke `project-spec`.
