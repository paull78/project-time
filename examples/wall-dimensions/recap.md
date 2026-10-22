# Recap: wall-dims

Cycle `wall-dims`, type feature, branch `wall-dims`. Started on 2026-10-12, closed on 2026-10-13.

## What was built

- **Wall dimensions.** A selected wall shows its clear length on the side facing the room, and a chain of pieces runs under it when the wall has doors or windows (wall-dims.01, .06).
- **Editable pieces.** Any piece can be clicked and typed into. Each edit is one command and one undo step (.03, .06).

## How it went

Three milestones, five steps; steps 01 and 02 ran in parallel. At the spec we chose the centre line, because each piece was then a stored number (.02). It was built and tested that way. At the final gate the user saw the dimensions start in the middle of the walls and asked for the free space between them. A discovery from step 01 had already removed the main objection (.04), so we amended the spec and added Milestone 3 (.06).

## Decisions that stand

- .01 The chain shows on the selected wall only.
- .03 No new commands: every edit uses an existing one.
- .06 Walls are measured face to face, as clear interior space.

## Takeaway

For a convention of the domain, such as which surface a dimension measures, check how standards and similar tools do it at the spec. Here it would have saved a milestone.
