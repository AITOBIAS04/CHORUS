---
name: skill-leaderboard
description: Weekly ranking of which skills are most popular across all active forks
var: ""
tags: [meta]
---
> **${var}** — Target repo to scan forks of (e.g. "owner/aeon"). If empty, reads from memory/watched-repos.md.

Today is ${today}. Generate a leaderboard of the most popular Aeon skills across all active forks.

## Steps

0. **Same-day rerun dedup** — If `memory/logs/${today}.md` already contains a `## Skill Leaderboard` entry (case-insensitive match for "skill leaderboard" or "skill-leaderboard") with `Notification sent:`, and `${var}` is empty (no explicit target requested), log `SKILL_LEADERBOARD_RERUN_QUIET: leaderboard already generated today — skipping to avoid duplicate API calls and notifications` to `memory/logs/${today}.md` and **stop here**. A rerun would re-fetch aeon.yml from every active fork (O(N) API calls), re-write the article, and re-send the notification — wasted compute with identical output on the same day.

1. **Determine the target repos.** If `${var}` is set, use that single repo. Otherwise read `memory/watched-repos.md` and use **all** watched repos. Store as `TARGET_REPOS` (a list).

   Why all repos: the watched list typically contains both the project repo (e.g. MiroShark — a simulation engine whose forks never carry aeon.yml) and the agent repo (e.g. miroshark-aeon — whose forks DO carry aeon.yml). Scanning only the first repo misses the agent forks entirely, causing persistent INSUFFICIENT_DATA when the project repo is listed first (observed: 22 of 25 weeks returned INSUFFICIENT_DATA because only MiroShark was scanned).

2. **Fetch all active forks** across all target repos (pushed within the last 30 days):
   ```bash
   CUTOFF=$(date -u -d "30 days ago" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date -u -v-30d +%Y-%m-%dT%H:%M:%SZ)
   # For each repo in TARGET_REPOS:
   gh api repos/${REPO}/forks --paginate --jq "[.[] | select(.pushed_at > \"$CUTOFF\") | {owner: .owner.login, full_name: .full_name, pushed_at, source_repo: \"${REPO}\"}]"
   ```
   Combine active forks from all repos into a single list. Deduplicate by `full_name` (a fork may appear under multiple sources if cross-forked). If no active forks found across any repo, log "SKILL_LEADERBOARD_NO_FORKS" and stop (no notification).

   **Early exit — minimum fork gate:** After combining forks from all repos, if fewer than 2 active forks with readable aeon.yml are found (checked after Step 3), log `SKILL_LEADERBOARD_INSUFFICIENT_DATA: only N active fork(s) with aeon.yml, minimum 2 required for meaningful ranking` and **stop here** — do not aggregate, compare, or write an article. A single-fork "leaderboard" where every skill is at 100% provides no comparative insight.

3. **Read each active fork's `aeon.yml`** to extract enabled skills:
   ```bash
   gh api repos/{fork_full_name}/contents/aeon.yml --jq '.content' | base64 -d
   ```
   For each fork, extract all skill entries where `enabled: true`. If the fork has no `aeon.yml` or the API returns 404, skip it and note "no aeon.yml".

4. **Aggregate skill counts** across all forks:
   - For each skill name that appears with `enabled: true` in any fork, count how many forks have it enabled.
   - Also collect the total count of forks with a readable `aeon.yml`.

5. **Compare to last week's leaderboard** — check for `articles/skill-leaderboard-*.md` files from the last 7 days. If one exists, extract its ranked list and compute week-over-week changes (new entries, rank changes, dropouts).

6. **Identify insight categories:**
   - **Consensus skills**: enabled in >50% of active forks
   - **Adoption-gap skills**: exist in the source repo but enabled in zero forks (documentation/discoverability candidates)
   - **Rising skills**: moved up 3+ positions from last week
   - **New entries**: skills not on last week's list

7. **Write the leaderboard article** to `articles/skill-leaderboard-${today}.md`:
   ```markdown
   # Skill Leaderboard — ${today}

   *${N} active forks scanned (pushed in last 30 days)*

   ## Top Skills Across the Fleet

   | Rank | Skill | Forks Enabled | % of Fleet | Change |
   |------|-------|---------------|------------|--------|
   | 1 | skill-name | N | XX% | — |
   | 2 | skill-name | N | XX% | ↑2 |
   | ... | ... | ... | ... | ... |

   ## Consensus Skills (>50% of forks)
   [List skills with broad adoption and why they matter]

   ## Adoption Gaps
   [Skills with zero fork enables — these may need better docs or examples]

   ## Week-over-Week
   [Changes from last week's leaderboard, or "First leaderboard — no prior data" if this is the first run]

   ## Fleet Summary
   - **Active forks scanned:** N
   - **Total skill slots enabled (across all forks):** N
   - **Unique skills seen:** N
   - **Forks with no aeon.yml:** N (likely template/non-running forks)

   ---
   *Source: GitHub API — forks of ${TARGET_REPOS} (all watched repos)*
   ```

8. **Send notification** via `./notify`:
   ```
   *Skill Leaderboard — ${today}*

   Top skills across ${N} active forks:
   1. [skill] — N forks (XX%)
   2. [skill] — N forks (XX%)
   3. [skill] — N forks (XX%)
   4. [skill] — N forks (XX%)
   5. [skill] — N forks (XX%)

   Consensus: [list of skills enabled by >50% of forks, or "none yet"]
   Adoption gaps: [skills with zero fork enables]

   Full leaderboard: articles/skill-leaderboard-${today}.md
   ```
   **Only send a notification if at least 2 active forks were found with readable aeon.yml files.** (The minimum-fork check in step 2 should already catch this, but this is a safety net in case forks had unreadable aeon.yml files.) Otherwise log "SKILL_LEADERBOARD_INSUFFICIENT_DATA" and stop.

9. **Log** to `memory/logs/${today}.md`:
   ```
   ## Skill Leaderboard
   - **Forks scanned:** N active (of M total)
   - **Top skill:** [skill-name] (N forks)
   - **Consensus skills:** [list or "none"]
   - **Notification sent:** yes/no
   ```
