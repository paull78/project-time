# Dimensions: wall-dims

### wall-dims.01 · decision · 2026-10-12 · spec
The chain shows on the selected wall only.
**Why:** in a small room, numbers on every wall overlap. Rejected: every wall, always.

### wall-dims.02 · decision · 2026-10-12 · spec
Dimensions run along the wall's centre line.
**Why:** each piece is a number the model stores, and the pieces add up to the stored length, so a typed piece maps to one command. Rejected: clear interior faces (they don't add up to the stored length, and where a face ends at a corner looked ambiguous).
Superseded by wall-dims.06.

### wall-dims.04 · discovery · 2026-10-12 · step 01
The wall outline already ends each face at the neighbouring walls, so the room-side face has a clear start and end at every corner.
**Why:** found while writing the corner case of the chain test. It answers the corner objection in wall-dims.02.

### wall-dims.05 · issue · 2026-10-13 · step 03
In the user's browser, typing digits into a dimension field showed only the dot. The scripted browser couldn't reproduce it: a keyboard-shortcut extension was taking the digits. No code change.
**Why:** kept so that the next report like this starts with a private window.

### wall-dims.06 · pivot · 2026-10-13 · final gate · Supersedes wall-dims.02
Dimensions measure clear interior space, from the room-side face of one wall to the next. Each piece still maps to one command: the total sets the clear length, and the stored length is the typed value plus both face insets.
**Why:** the user, at the final gate: "dimension should not start mid wall." Interior drawings dimension face to face, and the corner objection in wall-dims.02 no longer holds (wall-dims.04). Rejected: a switch between centre line and clear space (more to build, for a use the app doesn't have).
