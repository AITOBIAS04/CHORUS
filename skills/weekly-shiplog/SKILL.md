---
name: weekly-shiplog
description: Weekly narrative of everything shipped — features, fixes, and momentum, written as a compelling update
var: ""
---
> **${var}** — Focus area or theme override. If empty, covers everything shipped this week.

Read memory/MEMORY.md and the last 7 days of memory/logs/ for context.
Read memory/watched-repos.md for repos to cover.

## Steps

0. **Same-day rerun dedup** — If `memory/logs/${today}.md` already contains a `## Weekly Shiplog` entry with `Article:` or `Notification sent:`, log `WEEKLY_SHIPLOG_RERUN_QUIET: shiplog already written today — skipping to avoid duplicate article and notification` to `memory/logs/${today}.md` and **stop here**. Double-dispatch would re-fetch 7 days of commits, re-read diffs, overwrite the article, and re-send the notification.

1. **Gather the full week of activity** for each watched repo:
   ```bash
   # Commits from the last 7 days
   gh api repos/owner/repo/commits -X GET -f since="$(date -u -d '7 days ago' +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date -u -v-7d +%Y-%m-%dT%H:%M:%SZ)" --jq '.[] | {sha: .sha[0:7], full_sha: .sha, message: .commit.message | split("\n")[0], author: .commit.author.name, date: .commit.author.date}' --paginate

   # PRs merged this week
   gh api repos/owner/repo/pulls -X GET -f state=closed -f sort=updated -f direction=desc --jq '[.[] | select(.merged_at != null) | select(.merged_at > (now - 604800 | strftime("%Y-%m-%dT%H:%M:%SZ"))) | {number, title, user: .user.login, merged_at, labels: [.labels[].name]}]'

   # Releases this week
   gh api repos/owner/repo/releases --jq '[.[] | select(.published_at > (now - 604800 | strftime("%Y-%m-%dT%H:%M:%SZ"))) | {tag_name, name, published_at, body}]'
   ```

1.5. **Filter automation noise** from agent/aeon repos. After gathering commits in Step 1, separate each repo's commits into two groups:
   - **Automation commits** — messages matching any of these patterns:
     - `chore(cron):` — cron state updates (e.g. "chore(cron): token-report success")
     - `chore(scheduler):` — scheduler state changes
     - `chore(` + `): auto-commit` — auto-committed output files (e.g. "chore(repo-pulse): auto-commit 2026-11-16")
     - Any other message starting with `chore(` and containing `):` — remaining automated skill outputs (e.g. "chore(token-movers): log CoinGecko scan"). All `chore(scope):` commits in agent repos are automated; human work uses descriptive messages or PR merge commits.
   - **Substantive commits** — everything else (PR merges, features, fixes, real code changes)

   Exclude automation commits from diff analysis in Step 3 and the narrative in Step 4. Report them as a separate count in the "By the Numbers" section (e.g. "12 substantive commits + 85 automation filtered"). Without this filter, the LLM must judge each commit's nature case-by-case, leading to inflated stats (observed: Nov 2 shiplog reported "~188 commits" when only 8 were substantive; Nov 9 reported "~90" with ~70 automation) and wasted diff API calls on cron-state updates.

2. **Read this week's push-recap articles** from `articles/push-recap-*.md` (last 7 days) to get detailed diff context without re-fetching everything.

3. **Read diffs for the most significant substantive commits** (top 10 by lines changed) to understand substance:
   ```bash
   gh api repos/owner/repo/commits/FULL_SHA --jq '{files: [.files[] | {filename, status, additions, deletions}], stats: .stats}'
   ```

4. **Synthesize into a narrative shiplog.** This is NOT a changelog or diff dump. Write it as a story of the week:
   - What was the main thrust? What moved the project forward?
   - What new capabilities exist now that didn't a week ago?
   - What problems got solved?
   - What's the pace/momentum like compared to recent weeks?

5. **Search the web** briefly for any external mentions, reactions, or related ecosystem developments that give context to the shipping.

6. **Write a 800-1200 word article** to `articles/weekly-shiplog-${today}.md`:
   ```markdown
   # Week in Review: [Compelling title capturing the week's theme]

   *${today} — Weekly shipping update*

   ## The Big Picture
   [3-4 sentences: what was the week about? What's the one-line summary someone would share?]

   ## What Shipped

   ### [Feature/Theme 1]
   [What it is, why it matters, how it works in plain language. Not commit messages — explain it like you're telling a colleague over coffee.]

   ### [Feature/Theme 2]
   [Same treatment]

   ### [Feature/Theme 3 if applicable]
   [Same treatment]

   ## Fixes & Improvements
   [Bullet list of notable fixes, refactors, DX improvements — brief but specific]

   ## By the Numbers
   - **Commits:** N substantive across M repos (+ Z automation filtered)
   - **PRs merged:** N
   - **Files changed:** N
   - **Lines:** +X / -Y
   - **Contributors:** [list]

   ## Momentum Check
   [How does this week compare to recent weeks? Accelerating? Steady? What's the trajectory?]

   ## What's Next
   [Based on open PRs, branches, TODO patterns, and recent direction — what's likely coming next week?]

   ---
   *Sources: [repo links, any external references]*
   ```

7. **Send notification** via `./notify`:
   ```
   *Weekly Shiplog — ${today}*

   [The one-line summary of the week]

   Shipped:
   - [Feature/theme 1 — one sentence]
   - [Feature/theme 2 — one sentence]
   - [Feature/theme 3 if applicable]

   Stats: N commits, M PRs merged, +X/-Y lines
   Full update: [link to articles/weekly-shiplog-${today}.md — use `git remote get-url origin` for THIS repo]
   ```

8. **Log** to `memory/logs/${today}.md`.
