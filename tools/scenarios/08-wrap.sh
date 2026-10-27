#!/usr/bin/env bash
# Final gate, recap, consolidation without questions, a frugal general level, archive.
source "$(dirname "$0")/lib.sh"

from_snapshot at-final-gate
protect_lessons
turn "/project-time"
drive '[ ! -d docs/current ]' "Gate approved and manual checks confirmed. Go ahead with the rest of the wrap." 10

arch="$(ls -d docs/archive/*-wordfreq 2>/dev/null | head -1 || true)"
[ -n "$arch" ] || fail "no archive folder"
for f in spec.md plan/INDEX.md memory/INDEX.md recap.md; do assert_file "$arch/$f"; done
for h in 'What was built' 'How it went' 'Decisions that stand' 'Takeaways'; do assert_grep "$arch/recap.md" "^## $h"; done
grep -q 'empty until the first cycle wraps' docs/memory/overview.md && fail "overview not rewritten"
grep -rqE '^### wordfreq\.[0-9]+' docs/memory || fail "no entries promoted to project memory"
# General memory is outside the repo: a headless run may be refused the write, so the skill hands the line to the user instead.
# Frugal: at most one new general line from a small cycle (a line whose only source is wordfreq);
# adding wordfreq as a source to an existing line is a merge. The wrap reports what it did.
n=0; [ -f "$LESSONS" ] && n="$(grep -cE '· wordfreq/[^ ,·]+ ·' "$LESSONS" || true)"
[ "$n" -le 1 ] || fail "$n new general lessons from one small cycle, want at most 1"
[ -f "$LESSONS" ] && cp "$LESSONS" "${TRANSCRIPT%.log}.lessons.md"  # kept for review: general memory is restored on exit
# Compact: a lessons file over its limit is compacted at the wrap, whether or not a line is added.
if [ -f "$LESSONS" ] && ! cmp -s "$LESSONS" "$GENERAL_BACKUP/memory/lessons.md" 2>/dev/null; then
  ln="$(wc -l < "$LESSONS")"; [ "$ln" -le 35 ] || fail "lessons.md written but left at $ln lines, want about 30"
fi
grep -E 'General memory' <<< "$LAST" >/dev/null || fail "wrap did not report the general memory result"
# After the gate the wrap runs on its own: the first turn reaches the gate, the second finishes.
turns="$(grep -c '^## user' "$TRANSCRIPT")"
[ "$turns" -le 3 ] || fail "wrap needed $turns user turns, want at most 3 (no questions after the gate)"
assert_last_commit '^wordfreq: wrap'
assert_clean_tree
pass "wrap"

save_snapshot wrapped
