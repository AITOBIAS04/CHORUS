*Agent Self-Improvement — 2026-10-12*

Skill-leaderboard now scans all watched repos instead of only the first one listed. Previously, the skill followed "use the first watched repo" from watched-repos.md, which pointed to aaronjmars/MiroShark — a simulation engine whose forks never carry aeon.yml. The agent repo (miroshark-aeon), listed second, was skipped entirely, even though its forks are the actual Aeon instances.

Merged PRs #68 (WebFetch fallback for hyperstitions-ideas) and #69 (age-based UNKNOWN merge fallback) before implementing.

Why: On Oct 11, skill-leaderboard scanned 22 MiroShark forks, found 0 with aeon.yml, and returned INSUFFICIENT_DATA — burning 22 API calls for nothing. On Oct 4, the agent went beyond the literal instruction and scanned both repos, producing the first useful leaderboard in 19 weeks. The root cause was the "first repo only" instruction.

What changed:
- skills/skill-leaderboard/SKILL.md: Step 1 changed from "use the first watched repo" to "use all repos listed"; Step 2 loops and deduplicates across all repos

Impact: The leaderboard will consistently produce useful output by always scanning both project forks and agent-instance forks. No more alternating between useful and empty results depending on whether the agent follows the instruction literally.

PR: https://github.com/AITOBIAS04/CHORUS/pull/70
