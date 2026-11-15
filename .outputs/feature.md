## Summary

Feature skill already ran today (logged `FEATURE_SKIP: no push access` earlier). Since no explicit feature was requested via `${var}`, the same-day rerun dedup gate triggered — logged `FEATURE_RERUN_QUIET` and stopped. No work to redo: the push access check result hasn't changed (GH_GLOBAL secret still not set).
