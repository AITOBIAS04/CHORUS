#!/usr/bin/env bash
set -euo pipefail

# Stage files for self-improve commits, automatically stripping volatile paths.
# Usage: ./scripts/safe-stage.sh file1 file2 ...

VOLATILE_PATHS=(memory/ .outputs/ dashboard/outputs/ .pending-notify/ memory/token-usage.csv)

if [ $# -eq 0 ]; then
  echo "ERROR: no files specified. Pass the improvement files as arguments." >&2
  exit 1
fi

git add "$@"

for vp in "${VOLATILE_PATHS[@]}"; do
  git reset HEAD -- "$vp" 2>/dev/null || true
done

STAGED=$(git diff --cached --name-only)

if [ -z "$STAGED" ]; then
  echo "ERROR: no files remain staged after volatile cleanup. Re-check your file list." >&2
  exit 1
fi

LEAKED=false
while IFS= read -r f; do
  for vp in "${VOLATILE_PATHS[@]}"; do
    case "$f" in
      "$vp"*|"$vp") LEAKED=true; echo "VOLATILE FILE STILL STAGED: $f" >&2 ;;
    esac
  done
done <<< "$STAGED"

if [ "$LEAKED" = true ]; then
  echo "ERROR: volatile files remain staged after cleanup. Aborting." >&2
  exit 1
fi

echo "Staged files (clean):"
echo "$STAGED"
