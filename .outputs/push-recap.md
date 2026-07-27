*Push Recap — 2026-07-27*
MiroShark — 2 commits by dependabot[bot] | miroshark-aeon — 2 commits by @aaronjmars (20 automation filtered)

Dependency Maintenance: Dependabot shipped two patch bumps — concurrently 10.0.3→10.0.4 (dev runner) and marked 18.0.6→18.0.7 (frontend Markdown renderer). Both semver-patch, no breaking changes.

Skill Cadence & Noise Reduction: The operator silenced the changelog skill entirely — it was posting a Telegram message on every run even though the real output is an article or website PR. Both shiplog and changelog are now Monday-only, down from every-3-days and Mon+Thu respectively. Consolidates the weekly rhythm.

Key changes:
- skills/changelog/SKILL.md: all ./notify calls removed, replaced with log-only output (+15/-25 lines)
- aeon.yml: changelog 0 8 */3 * * → 0 8 * * 1, shiplog 0 9 * * 1,4 → 0 9 * * 1
- concurrently + marked patch bumps via Dependabot auto-merge

Stats: 6 files changed, +31/-41 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-07-27.md
