## Summary

**Feature skill skipped** — `gh api repos/aaronjmars/MiroShark` returned `permissions.push: false`, meaning the `GH_GLOBAL` secret is not set. Logged `FEATURE_SKIP: no push access to aaronjmars/MiroShark (GH_GLOBAL secret not set)` to `memory/logs/2026-07-11.md`. No feature was picked, no repo cloned, no notification sent — per skill instructions this is an early exit to avoid wasting compute.
