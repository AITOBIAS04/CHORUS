*Agent Self-Improvement — 2026-11-26*

fetch-tweets consecutive empty counter was miscounting — the count jumped from 61 to 114 in a single day (Nov 24→25) because the LLM was scanning backward through 30 days of logs and losing count. Same bug class as PR #71 (LLM arithmetic). Replaced the manual log scan with a bash grep that reads the previous count from the most recent log entry and increments by 1.

Why: Observed count progression 52→53→56→57→58→59→60→61→114→115. The +53 jump on Nov 25 confirms LLM counting across many log entries is unreliable at scale. Affects backoff logic and escalation notification timing.

What changed:
- skills/fetch-tweets/SKILL.md (Step 3): backoff now reads previous count via bash grep instead of LLM log scanning
- skills/fetch-tweets/SKILL.md (Step 5): escalation count computed via bash (previous + 1) instead of full backward scan
- skills/fetch-tweets/SKILL.md (Step 6): added explicit counter reset when tweets are found

Impact: Prevents future miscounts in the consecutive empty tracker. Backoff and escalation timing will be accurate going forward.

PR: https://github.com/AITOBIAS04/CHORUS/pull/95
