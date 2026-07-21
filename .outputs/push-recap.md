*Push Recap — 2026-07-21*
MiroShark — 3 substantive commits by aaronjmars
miroshark-aeon — 1 substantive commit by aaronjmars (14 automation filtered)

Codebase Subtraction (PR #254): The largest single cleanup in project history — 53 files, -1,325 net lines. Collapsed 23 duplicate publish gates into one helper, unified four notification services into _notify_base.py, extracted shared utilities (sim_corpus, stance classification, CSS), and removed 17 dead methods, the Zep wait_for_processing shim, and 3 phantom env var configs. Full test suite green.

README Badge Polish (PRs #252, #253): Added Documentation badge, then tightened all badges — "Docs" instead of "Documentation", @miroshark_ without "Follow", $miroshark ticker on Bankr badge. All 4 locales updated.

Repo-Pulse Weekly Transition (PR #116): Switched agent monitoring from disabled daily to active weekly (Mon 10:00 UTC). Rebaselined SURGE from 10 stars/day to 50 stars/week, added events pagination with truncation detection, bumped profile enrichment cap 10→15.

Key changes:
- simulation.py lost 231 lines — publish gate consolidation is the single biggest diff
- New shared files: app/utils/sim_corpus.py, app/utils/text.py, app-shell.css
- railway.env.example no longer advertises dead config knobs

Stats: 63 files changed, +692/-2,009 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-07-21.md
