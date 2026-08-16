---
name: Memory Flush
description: Promote important recent log entries into MEMORY.md
var: ""
---
> **${var}** — Topic to focus on. If empty, flushes all recent activity.

If `${var}` is set, only flush entries related to that topic.


Read memory/MEMORY.md for current memory state.
Read the last 3 days of memory/logs/ for recent activity.

Steps:
0. **Same-day rerun dedup** — If `memory/logs/${today}.md` already contains a `## Memory Flush` entry (case-insensitive match on the heading), and `${var}` is empty (no explicit topic requested), log `MEMORY_FLUSH_RERUN_QUIET: flush already ran today — skipping to avoid double-rotation` to `memory/logs/${today}.md` and **stop here**. Step 4's rotation rules are not idempotent — a second run in the same day could over-trim tables (e.g., first run trims Skills Built from 12→10, promotions add 2 back, second run trims 12→10 again, losing entries the first run intentionally kept).
1. Scan recent logs for entries worth promoting to long-term memory:
   - New lessons learned (errors encountered, workarounds found)
   - Topics covered (articles, digests) — add to the recent articles/digests tables
   - Features built or tools created
   - Important findings from monitors (on-chain, GitHub, papers)
   - Ideas captured that are still relevant
   - Goals completed or progress milestones
2. Check each candidate against existing MEMORY.md content — skip if already recorded.
3. Update memory:
   - Add brief entries to MEMORY.md
   - If a topic needs more detail, write to `memory/topics/<topic>.md` instead
   - Update the Recent Digests table with any new token-report or push-recap entries from logs
4. **Rotate old entries to keep MEMORY.md concise (~100 lines):**
   - Skills Built table: keep the **10 most recent rows** — remove older rows from the top
   - Recent Articles table: keep the **8 most recent rows** — remove older rows from the top
   - Recent Digests table: keep the **6 most recent rows** — remove older rows from the top
   - Feature candidates in Next Priorities: keep the **5 most recent entries** (by repo-actions date in parentheses) — remove older entries. Newer repo-actions runs supersede stale candidates with refreshed ideas.
   - Active Targets: remove entries marked "NOT CLEARED (deadline passed)" whose deadline is **more than 14 days ago** — they are expired and no longer actionable. Keep CLEARED entries (historical milestones) and entries with future or recent deadlines.
   - Lessons Learned: keep the **15 most recent entries** (by date in parentheses, or by position — newer entries are appended at the bottom). Archive removed entries by appending them to `memory/topics/lessons-archive.md` (create if missing; add a `## Archived ${today}` header before each batch). Most lessons describe fixes already coded into skill logic; the archive preserves history while freeing MEMORY.md.
5. **Update the "Last consolidated" date** at the top of MEMORY.md to today (`${today}`). Do this even if nothing else was promoted.
6. Do NOT rewrite the whole file — make targeted additions, removals, and date updates.
7. Log what you promoted (or "MEMORY_FLUSH_OK: no new entries, date updated") to memory/logs/${today}.md.
