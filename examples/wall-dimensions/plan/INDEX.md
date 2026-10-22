# Plan: wall-dims

Status: done · Test: `pnpm check`
Current: wrapped 2026-10-13.

## Milestone 1 · The chain in the domain  ✅ gate passed 2026-10-12
A query returns a wall's pieces, and a command sets one. Covers AC-01, AC-02, AC-04.
- [x] 01 domain-wall-chain     (needs none)
- [x] 02 domain-set-piece      (needs none)  ∥ 01

## Milestone 2 · Draw and edit  ✅ gate passed 2026-10-13
A selected wall shows the chain, and every piece can be typed into. Covers AC-03.
- [x] 03 editor-chain          (needs 01, 02)

## Milestone 3 · Clear interior dimensions  ✅ final gate passed 2026-10-13
Added by the pivot wall-dims.06. Covers AC-05, AC-06.
- [x] 04 domain-clear-chain    (needs 01)
- [x] 05 editor-clear-chain    (needs 03, 04)

## Notes
- 2026-10-12 · Gate 1: the user approved the plan. Steps 01 and 02 share no files, so they run in parallel.
- 2026-10-13 · Final gate: Milestone 3 added after the pivot wall-dims.06. Done steps are not rewritten.
