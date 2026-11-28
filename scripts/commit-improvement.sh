#!/usr/bin/env bash
# Stages, cleans, and commits improvement files for self-improve PRs.
# Enforces volatile file exclusion that text-only SKILL.md instructions
# cannot guarantee (observed: PRs #91, #94, #96 all included volatile files).
#
# Usage: ./scripts/commit-improvement.sh "commit message" file1 [file2 ...]

set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 \"commit message\" file1 [file2 ...]"
  exit 1
fi

MSG="$1"; shift
FILES=("$@")

VOLATILE_PATTERNS=(
  "memory/"
  ".outputs/"
  "dashboard/outputs/"
  ".pending-notify/"
  "token-usage.csv"
)

git add "${FILES[@]}"

for pattern in "${VOLATILE_PATTERNS[@]}"; do
  git reset HEAD -- "$pattern" 2>/dev/null || true
done

STAGED=$(git diff --cached --name-only)

BLOCKED=""
for pattern in "${VOLATILE_PATTERNS[@]}"; do
  MATCH=$(echo "$STAGED" | grep "^${pattern}" 2>/dev/null || true)
  if [ -n "$MATCH" ]; then
    BLOCKED="${BLOCKED}${MATCH}"$'\n'
  fi
done

if [ -n "$BLOCKED" ]; then
  echo "ERROR: Volatile files still staged after cleanup:"
  echo "$BLOCKED"
  echo "Unstaging them now..."
  echo "$BLOCKED" | while IFS= read -r f; do
    [ -n "$f" ] && git reset HEAD -- "$f" 2>/dev/null || true
  done
  STAGED=$(git diff --cached --name-only)
fi

if [ -z "$STAGED" ]; then
  echo "ERROR: No improvement files staged after volatile cleanup. Aborting."
  exit 1
fi

echo "Committing with these files:"
echo "$STAGED"
echo "---"

git commit -m "$MSG"
