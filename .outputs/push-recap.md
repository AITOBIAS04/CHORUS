*Push Recap — 2026-08-23*
miroshark-aeon — 1 substantive commit by aaronjmars (9 automation commits filtered)

Reliability — Memory-Flush Deterministic Prep: The memory-flush skill's bookkeeping (scan-window calculation, log rotation, watermark management) was being done inside the LLM context every run — costly, fragile, and untestable. This commit extracts it all into scripts/memory_prep.py with a structured JSON watermark, automatic log archival, and 16 unit tests wired into CI. The model is now left with only judgment work: what to promote, dedup, and prune.

Key changes:
- New scripts/memory_prep.py (+278 lines): two subcommands — window (pre-pass: resolve watermark, compute scan window, rotate old months) and stamp (post-pass: write structured watermark + mirror to MEMORY.md)
- New scripts/tests/test_memory_prep.py (+179 lines): 16 unit tests covering watermark parsing, window computation, rotation logic, stamp idempotency, and full I/O integration
- skills/memory-flush/SKILL.md restructured: steps 0 and 8 now call the script; manual watermark and rotation instructions removed

Stats: 4 files changed, +489/-29 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-23.md
