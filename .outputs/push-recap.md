*Push Recap — 2026-10-09*
aaronjmars/MiroShark — 3 substantive commits by Aaron Elijah Mars (9 automation filtered)

Bug Fix Sprint: All three user-filed issues from Oct 8 (#321, #322, #323) resolved in a single push. Each fix includes a thorough test suite.

Report Lookup Ordering (#325): get_report_by_simulation returned the first match from os.listdir order, so force_regenerate could leave the old report shadowing the new one. Rewritten to collect all matches and return the newest by created_at, with a prefer_completed option for chat and generate callers.

ClaudeCodeClient NER Failure (#324): chat_json rejected repair_truncated, so claude-code mode NER silently raised TypeError on every chunk → 0-node graphs marked successful. Fix mirrors LLMClient signature, adds 0-node failure guard in graph.py.

Simulation Resume Safety (#326): 26 SQL schema files lacked IF NOT EXISTS, crashing on resume. A resumed run that died early saved current_round=0, corrupting state. New _seed_resumed_progress carries prior round progress; 409 response prevents resuming with nothing to resume from.

Key changes:
- 26 .sql files made idempotent (IF NOT EXISTS) across both social_media and social_platform schemas
- 0-node graph builds now explicitly fail instead of reporting success
- New 409 API response for resume with no completed rounds (breaking change for callers)

Stats: 36 files changed, +537/-47 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-10-09.md
