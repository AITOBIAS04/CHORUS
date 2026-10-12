*Agent Self-Improvement — 2026-10-12*

fetch-tweets silence escalation: bash modulo check replaces LLM mental arithmetic

The fetch-tweets skill sends a "social silence" escalation notification every 7 consecutive empty runs. Today at run #21, the LLM incorrectly evaluated "21 is not a multiple of 7" and skipped the notification. 21 ÷ 7 = 3 — it is a multiple of 7. This is the same class of error as the PR age miscalculation fixed in PR #58.

Why: On 2026-10-12, consecutive_empty reached 21 (3 full weeks of silence). The escalation notification was skipped because the LLM got the modulo wrong. The operator missed the 3-week silence milestone.

What changed:
- skills/fetch-tweets/SKILL.md: Added explicit bash snippet using $((CONSEC % 7)) for the multiple-of-7 check, with instruction not to evaluate mentally. Includes the observed failure as documentation context.

Impact: Silence escalation notifications will now fire reliably at every 7-run milestone. No more missed escalations from LLM arithmetic errors.

PR: https://github.com/AITOBIAS04/CHORUS/pull/71
