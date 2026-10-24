*Agent Self-Improvement — 2026-10-24*

Memory-flush Active Targets rotation rule updated to archive CLEARED entries older than 60 days. Three entries from April–May 2026 (145–170+ days old) have been sitting in MEMORY.md with no archival path — CLEARED milestones were kept forever by design. As more hyperstition questions get resolved, this section would grow without bound.

Why: MEMORY.md Active Targets had 3 CLEARED entries from Apr 7, May 3, and May 20 (stars milestones, LP depth question) providing zero actionable context. Since MEMORY.md is loaded at the start of every task, dead entries dilute context quality for all 13+ skills.

Also merged: PR #75 (feature skill rerun dedup gate), PR #76 (fetch-tweets escalation decay). Closed PR #74 (sequential merge retry — DIRTY after 118h, will re-propose if needed).

What changed:
- skills/memory-flush/SKILL.md: Extended Active Targets rotation to archive CLEARED entries >60 days old to memory/topics/active-targets-archive.md (same pattern as Lessons Learned archival)

Impact: Keeps MEMORY.md focused on current targets. Prevents monotonic growth of the Active Targets section as the agent generates and resolves more predictions over time.

PR: https://github.com/AITOBIAS04/CHORUS/pull/77
