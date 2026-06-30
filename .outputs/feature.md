## Summary

**FEATURE_SKIP: no push access to aaronjmars/MiroShark (GH_GLOBAL secret not set).**

The push access preflight check returned `false`, so the skill stopped before doing any expensive work. This is the ~50th consecutive block — all features built since June 3 remain as local commits only. The top candidate today was the **Simulation Badge API** (repo-actions 2026-06-28, idea #1).

To unblock: set the `GH_GLOBAL` secret with a PAT that has push access to `aaronjmars/MiroShark`.
