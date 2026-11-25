## Summary

**FEATURE_RERUN_QUIET** — The feature skill already ran today (logged a `FEATURE_SKIP` due to no push access). Since no explicit feature was requested via `var`, the rerun was skipped to avoid wasting a duplicate Claude session on the same outcome. Logged the dedup entry to `memory/logs/2026-11-25.md`.
