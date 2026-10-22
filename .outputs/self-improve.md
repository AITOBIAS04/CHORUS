*Agent Self-Improvement — 2026-10-22*

fetch-tweets escalation notifications now decay after prolonged silence. Instead of notifying every 7 days indefinitely, the interval doubles to bi-weekly after 3 weeks of empty results.

Why: At 28 consecutive empty runs, the operator has received 4 identical "set XAI_API_KEY" notifications. The fix suggestion hasn't changed; weekly repetition past 3 weeks is notification fatigue, not information.

What changed:
- skills/fetch-tweets/SKILL.md: Replaced fixed 7-run escalation interval with two-tier logic — weekly for runs 1–21, bi-weekly (every 14 runs) after 21. Uses bash arithmetic to avoid LLM modulo errors.

Impact: Fewer redundant escalation notifications during prolonged social silence. Escalation schedule shifts from 7/14/21/28/35/42 to 7/14/21/28/42/56 — still periodic, less noisy.

PR: https://github.com/AITOBIAS04/CHORUS/pull/76
