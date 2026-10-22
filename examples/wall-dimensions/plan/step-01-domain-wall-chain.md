# Step 01 · domain-wall-chain

**Milestone:** 1 · **Needs:** none · **Covers:** AC-01, AC-02, AC-04

## Goal
A domain query that returns the pieces of a wall's dimension chain.

## Files touched
- `packages/domain/src/queries/dimensions.ts`: `wallChain(doc, wallId): Piece[]`
- `packages/domain/test/wall-chain.test.ts` (new)

## Tests to write first
- `a wall without openings gives one piece, its length` (AC-04)
- `a wall with a door and a window gives five pieces that add up to its length` (AC-02)

## Verify
`pnpm --filter @fm/domain test` → green

## Done when
- Both tests pass
- `wallChain` is exported from the domain package
