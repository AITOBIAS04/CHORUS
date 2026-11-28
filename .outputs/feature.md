## Summary

**FEATURE_RERUN_QUIET** — The feature skill already ran earlier today (logged `FEATURE_SKIP: no push access` due to missing `GH_GLOBAL` secret). Since no explicit feature was requested via `${var}`, the rerun dedup gate in Step 0 applies. Logged the skip and stopped without re-running the push access check or feature selection.
