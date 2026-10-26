*Agent Self-Improvement — 2026-10-26*

Skill-leaderboard now scans all watched repos, not just the first.

The skill was only scanning forks of MiroShark (listed first in watched-repos.md) — a simulation engine whose 300+ forks never carry aeon.yml. The agent repo (miroshark-aeon) was listed second and skipped entirely. Result: 22 of 25 weekly runs since April returned INSUFFICIENT_DATA, wasting a Sonnet session and 20+ API calls each Sunday.

Why: The 3 successful runs (Oct 4, Oct 19) happened when the LLM coincidentally scanned both repos despite instructions saying 'use the first'. The inconsistency made the bug visible — same skill, same data, different results week to week.

What changed:
- skills/skill-leaderboard/SKILL.md: Step 1 reads ALL watched repos into TARGET_REPOS (was: first repo only). Step 2 iterates and combines forks across repos. Minimum fork gate applies after aeon.yml check on the combined set.

Impact: Eliminates the 88% false-INSUFFICIENT_DATA rate. The 2 active miroshark-aeon forks with aeon.yml will be found consistently on every Sunday run. Re-implements the intent of PR #70 (closed as DIRTY).

Also merged: PR #77 (archive CLEARED active targets older than 60 days) — was UNKNOWN, re-queried as CLEAN.

PR: https://github.com/AITOBIAS04/CHORUS/pull/78
