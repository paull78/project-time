# Spec: wall-dims

Cycle: wall-dims · Type: feature · Branch: wall-dims · Status: approved, amended 2026-10-13

## Goal

When a wall is selected, show its length, split at its doors and windows, and let the user type a new value into any piece.

## Scope

In scope:
1. The total length on a selected wall.
2. A chain of pieces on a wall with doors or windows.
3. Editable pieces.

Non-goals: dimensions on walls that aren't selected; distances from furniture to walls.

## Behaviour

- A selected wall shows its total length. On a wall with openings, a chain runs under it: corner, opening, gap, opening, corner.
- ~~Dimensions run along the wall's centre line.~~ Dimensions measure clear interior space, from the room-side face of one wall to the next (wall-dims.06).
- Clicking a piece opens a field. Enter applies the value as one command and one undo step.

## Acceptance criteria

- AC-01 Selecting a wall shows its total length.
- ~~AC-02 The pieces add up to the wall's centre-line length.~~ Struck by wall-dims.06.
- AC-03 Typing a piece and pressing Enter changes the model with one command, and undo restores it.
- AC-04 A wall without openings shows only the total.
- AC-05 The pieces add up to the clear length between the room-side faces. Added by wall-dims.06.
- AC-06 At a corner, the chain starts at the neighbouring wall's face. Added by wall-dims.06.

## Testing

Unit tests on the chain query in the domain, tests on the drawing in the editor, and one browser test that types a piece.

## Amendments

- 2026-10-13 · final gate · wall-dims.06: measure clear interior space. AC-02 struck, AC-05 and AC-06 added, Milestone 3 added to the plan.
