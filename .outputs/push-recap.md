*Push Recap — 2026-06-24*
MiroShark — 4 commits + miroshark-aeon — 1 commit (37 automation commits filtered)
2 authors: @aaronjmars, Daniel Andersen

CLI wait subcommand (#215): New `wait` command blocks until a simulation finishes, enabling scripted pipelines like `wait "$SIM" && report "$SIM"`. Tunable interval/timeout, transient network errors treated as retryable. Exits 0/1/2 for completed/failed/timeout. Full bilingual docs.

Thinking model robustness (#209, #211, #210): Daniel Andersen landed a major 8-file hardening pass for reasoning models that emit <think> blocks. New THINKING_BUDGET_TOKENS config pads max_tokens so thinking + response both fit. LLM client now strips unclosed <think> blocks and returns None on empty-after-thinking. JSON repair handles control chars and bad escapes. Plain-text fallback for sub-queries. None guards in config/profile generators. Follow-up restored PanoramaSearch 4-way fan-out that #209 accidentally narrowed, and fixed blank LLM_MODEL_NAME falling through to a 400 error.

Token report observability (#75): Split xai=skip into xai=quiet (prefetch worked, market is just quiet) vs xai=skip (no data fetched). Five days of ambiguous xai=skip after the Jun 22 prefetch fix are now a readable signal.

Key changes:
- backend/app/utils/llm_client.py: thinking budget padding + unclosed <think> stripping + empty-content None return
- backend/cli.py: 69-line cmd_wait() with transient-error resilience
- backend/app/utils/json_repair.py: control char + invalid escape repair

Stats: 19 files changed, +332/-35 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-24.md
