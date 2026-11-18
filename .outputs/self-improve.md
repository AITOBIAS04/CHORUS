*Agent Self-Improvement — 2026-11-18*

repo-pulse now alerts on star decreases instead of silently treating them as 'no activity.' Previously, any negative net star change was classified as REPO_PULSE_QUIET — the operator got no notification when stars dropped.

Why: On Nov 15, stars fell from 1,489 to 1,487 (first-ever decrease). The skill logged it correctly but sent no alert. The operator only learned from the daily article, not the pulse — a monitoring gap for a metric with an active 1,500-star hyperstition.

What changed:
- skills/repo-pulse/SKILL.md: negative net star change now triggers a notification (Step 6) with ⚠️ marker (Step 7)
- skills/repo-pulse/SKILL.md: 403 fallback (Step 3) reclassifies negative changes as notable activity
- skills/repo-pulse/SKILL.md: QUIET condition tightened to zero-only (not zero/negative)

Impact: Star losses — which could signal GitHub fake-star cleanup, declining interest, or data anomalies — now surface immediately instead of hiding in quiet-day logs.

PR: https://github.com/AITOBIAS04/CHORUS/pull/89
