---
name: project-wrap
description: Close a project-time cycle with a final gate, a recap distilled from memory and plan, consolidation of cycle memory into a compact project memory and the overview, promotion of only clear, general lessons to general (machine-wide) memory, and archiving of docs/current. Also writes interim recaps mid-cycle. Use when /project-time hands off to it, all plan steps are done, or the user wants to wrap up, finish or close the cycle, write takeaways, or get a recap of where the project stands.
---

# Project Wrap

Closes a cycle. Turns what's scattered across memory and plan into a recap a person can read, moves what's worth keeping up a level (cycle to project, then project to general), and archives the rest. After the final gate it runs without questions, except in real doubt, and reports what it moved.

Follow the conventions in the project-time block of `AGENTS.md`. If `docs/current/` is missing, there's nothing to wrap: say so.

**Modes.** Every step `[x]`, or `Current:` starts with `wrap` → full wrap. Otherwise, or when the user asks for "a recap" or "where do we stand" → interim recap: write section 2 only, commit only `recap.md` as `<slug>: interim recap`, and stop. If the user explicitly asks to close the cycle with steps left, list them, write a `decision` entry, and run the full wrap; the open steps go under Open issues in the recap.

Track progress in the plan INDEX `Current:`: `wrap: gate passed`, `wrap: recap written`, `wrap: memory consolidated`, `wrap: general done`. On entry, continue from the first unfinished section. Never copy an entry whose ID already exists in `docs/memory/`, and never add a line already in general memory.

## 1. Final gate

1. **Bring the branch up to date**, for a cycle on a branch other than the default one: consolidation must merge into the latest project memory. Ask the user whether to rebase onto the default branch or merge it in. Recommend merge if the branch has been pushed.
2. Run the full test command from the plan INDEX and show the result.
3. Check every acceptance criterion in the spec against the running code, struck-through ones excluded. List any that fail.
4. List every `manual:` item not already confirmed at a milestone gate.
5. If a test or acceptance criterion fails, or the user rejects a manual check, stop: write an `issue` entry and invoke `project-plan` in update mode to add a fix step. `project-build` brings the cycle back here.
6. Wait for the user's go-ahead. On the go-ahead, mark the last milestone `✅ gate passed <YYYY-MM-DD>` in the plan INDEX; it's committed with the wrap.

## 2. Recap

Write `docs/current/recap.md` from memory and plan, not from the conversation. It's prose for people: if the `human-write-time` skill is installed, follow it, along with `~/.claude/VOICE.md` if present.

```markdown
# Recap: <slug>

<cycle, type, branch, first and last date>

## What was built
<against the spec; deviations and why, with memory IDs>

## How it went
<milestones with gate dates; the pivot chain: what we believed, what changed our mind, what we did>

## Decisions that stand
- <id> · <decision> · <one-line why>

## Discoveries

## Open issues and known limitations

## Takeaways
<what worked, what to do differently next time>
```

Decisions that stand lists current entries only: skip anything superseded.

## 3. Consolidate project memory

Project memory holds what is true now for this repo. The history of how it got there stays in `docs/archive/`, in the cycle that recorded it. Sort each cycle entry without asking:

- **Promote:** a decision that still stands and constrains future work, a discovery that matters beyond this cycle, a pivot that changes a project-level entry.
- **Archive only:** everything else, such as detail that mattered only inside this cycle, superseded entries and fixed issues.
- **Cycle pins:** a standing rule for this repo goes under `## Pinned` in `docs/memory/INDEX.md`; a rule for this cycle only is archived. Ask only when a pin could be either.

Write each promoted entry so the level stays compact:

1. Read the area file it belongs in first. If the entry replaces or refines one already there, including every Overrides line, put the new entry in place of the old one. Otherwise add it, ID unchanged. Create the area file and its INDEX line if needed.
2. When two entries say nearly the same thing, merge them into one, keeping the newer ID.
3. Keep each area file under about 150 lines. Past that, tighten and merge entries, or split the file by topic and update the INDEX lines.
4. Rewrite `docs/memory/overview.md` to describe the system as it is now: what it is, its main parts and where they live, how to run and test it, the key decision IDs. Under a page.

## 4. Promote to general memory

The general level, `~/.agents/memory/`, is read in every project and never committed, so a narrow or wrong line there costs every future session. Be frugal: promote only what passes all four tests.

1. **General and big.** It holds in any project and would change how the work goes in most of them. It names nothing that exists only in this repo: no file, module or domain concept. A narrow fact about a tool, library or flag fails this test even when it is true everywhere; it stays in project memory.
2. **Proven.** This cycle showed it, with a real cost or a clear win. Not a hunch, not a one-off.
3. **Undisputed.** Nothing in this cycle or in general memory contradicts it.
4. **New.** No general line already says it, in other words.

Candidates come from the takeaways and the entries just promoted, and from facts about the user only when the user stated them as holding everywhere. Anything that fails a test stays in project memory or the archive. Most cycles add nothing here, and one line is already a lot.

Write without asking. Ask, in one question, only when a candidate would contradict or replace an existing general line or pin.

Keep the level small as you write:

- Read the whole area file first. If a line already says the same lesson, add the new source to it, and nothing else, instead of adding a line. Folding a new fact or example into an existing line promotes it without the four tests.
- A lesson is one line in `lessons.md`, or in the matching area file: `- <YYYY-MM-DD> · <repo>/<slug> · <lesson>`. A standing rule goes under `## Pinned` in `~/.agents/memory/INDEX.md`, as `- <the rule> (<repo>/<slug>, <YYYY-MM-DD>)`.
- Keep `lessons.md` under about 30 lines and Pinned under about 10. At every wrap, whether or not you add anything, compact a file that is over its limit, without asking. First copy it to `<file>.bak` next to it, replacing any older copy, so the last compaction can be undone. Then merge lines that say the same thing, drop lessons that a pin or a newer lesson already covers, that only make sense in one repo or that would fail the first test today, and group the rest under short topic headings. Never reword or drop a pin the user asked for without asking.
- If the write is refused, give the user the exact line and the file it belongs in.

Create `~/.agents/memory/INDEX.md` from `templates.md` in the `project-time` skill folder (next to this skill's folder) if it's missing.

## 5. Archive

`git mv docs/current docs/archive/<YYYY-MM-DD>-<slug>` with today's date, then commit everything as `<slug>: wrap`. Don't push, and don't merge the branch into the default branch.

Then report in a few lines:
- `Project memory:` the IDs promoted, the entries they replaced or merged, and the pins moved.
- `General memory:` each line added or merged, or `nothing new`, and after a compaction the line count before and after.
- The cycle is closed, the branch is ready to merge, and the next `/project-time` starts a new cycle.

The user can ask to undo any of it: revert the change in the repo with a new commit, or remove the line from general memory, and restore a compacted file from its `.bak`.
