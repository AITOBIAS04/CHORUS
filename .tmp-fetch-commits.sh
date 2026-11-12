#!/bin/bash
SINCE=$(date -u -d '24 hours ago' +%Y-%m-%dT%H:%M:%SZ)
echo "Since: $SINCE"
echo "=== aaronjmars/MiroShark ==="
gh api repos/aaronjmars/MiroShark/commits -X GET -f since="$SINCE" --jq '.[] | {sha: .sha[0:7], full_sha: .sha, message: .commit.message, author: .commit.author.name, date: .commit.author.date}' --paginate 2>&1
echo "=== aaronjmars/miroshark-aeon ==="
gh api repos/aaronjmars/miroshark-aeon/commits -X GET -f since="$SINCE" --jq '.[] | {sha: .sha[0:7], full_sha: .sha, message: .commit.message, author: .commit.author.name, date: .commit.author.date}' --paginate 2>&1
