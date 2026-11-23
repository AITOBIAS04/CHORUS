# Week in Review: The Founder Came Back to Fix the Pipes

*2026-11-23 — Weekly shipping update*

## The Big Picture

Three consecutive days of founder commits landed while the token set new all-time lows. The week's work was entirely infrastructure: CI timeouts, randomized tests, Docker publishing, runner migrations, and dependency housekeeping. No new features, no product changes — just a methodical tightening of the build pipeline at the exact moment the market said nobody's watching. Meanwhile, the autonomous agent merged three self-improve PRs and filed three more, pushing its total to PR #92.

## What Shipped

### CI Hardening Sprint (MiroShark)

Aaron returned on November 20 with a two-PR opener that immediately paid for itself. The first PR dropped every CI job timeout from a blanket 15 minutes down to roughly 2x each job's measured p95 wall time — unit tests went from 15 minutes to 2, lint from 15 to 2. A hang that previously sat silently for a quarter-hour now fails in under three minutes.

The second PR added `pytest-randomly` to shuffle backend test execution order. On day one, it caught a Config state leak that had been invisible for months: `POST /api/settings` writes provider, model, and API key slots directly onto a shared Config class, but the preset tests only monkeypatched a subset. When randomized ordering put certain tests first, the leaked `LLM_API_KEY` sent subsequent `create_app()` calls into Neo4j's schema retry loop — 15 seconds per test, 135 seconds total across nine auth tests. The fix was an autouse fixture that snapshots and restores every uppercase Config attribute. One PR found and fixed a bug that had been adding two phantom minutes to every CI run.

### Docker and Deployment Overhaul (MiroShark)

November 21-23 brought a broader infrastructure cleanup. Docker images now publish automatically from main on every relevant push — previously they only built on tags, so consumers were perpetually behind. The image reference migrated from a personal namespace (`ghcr.io/aaronjmars/miroshark`) to the org-level package (`ghcr.io/miroshark/miroshark`). All four CI jobs switched from paid Blacksmith runners to free GitHub-hosted `ubuntu-latest` — for jobs completing in under 30 seconds, Blacksmith's queue overhead was the dominant cost.

Dependabot got a matching overhaul. All dependency groups were renamed from `*-minor-patch` (which excluded majors) to `*-weekly` with wildcard patterns that catch everything. A new `docker-weekly` group tracks the base image. The result: one PR per ecosystem per week instead of the previous minor/patch groups plus manually-batched majors.

### Agent Self-Improvement (CHORUS)

The autonomous agent merged three self-improve PRs this week:

- **PR #87** — Quiet-day rerun optimization for repo-pulse. When the first daily run finds no activity, the rerun now short-circuits instead of making four redundant API calls. Five consecutive days of wasted calls (Nov 10-14) prompted this fix.
- **PR #88** — Automation commit filtering for weekly-shiplog. Previous shiplogs inflated stats by counting cron-state and auto-commit messages (Nov 2: "~188 commits" when only 8 were substantive). The filter now separates `chore(scope):` automation from real work.
- **PR #89** — Star decrease detection in repo-pulse. The first-ever star drop (1,489 to 1,487 on Nov 15) was classified as "quiet" and suppressed. Now any negative net change triggers a notification.

Three more PRs were filed: #90 (ATL price alerts for token-report), #91 (volatile-file safety net preventing memory/output files from leaking into self-improve PRs), and #92 (reducing stale PR cutoff from 48h to 44h to align with the agent's 48h schedule interval — a 4-hour buffer that eliminates an extra 2-day merge cycle).

## Fixes & Improvements

- DOMPurify patched 3.4.17 to 3.4.18 (XSS sanitizer)
- Tornado bumped to 6.6.1 in backend
- chokidar major-bumped to 6.0 (raises minimum Node to 22.22 for self-hosters)
- `astral-sh/setup-uv` bumped to v10.4.0 in CI
- Five frontend packages updated via grouped Dependabot PR
- Old nju.edu.cn Docker mirror reference removed

## By the Numbers

- **Commits:** 5 substantive across MiroShark (+ 4 dependabot filtered across both repos)
- **PRs merged:** 8 on MiroShark, 3 self-improve on CHORUS, 1 dependabot on miroshark-aeon (12 total)
- **Files changed:** ~16 (excluding lockfiles)
- **Lines:** +120 / -34 substantive; +275 / -163 including dependency lockfiles
- **Contributors:** Aaron Elijah Mars (MiroShark), aeonframework (CHORUS agent), dependabot (both repos)

## Momentum Check

This is the most concentrated founder activity since the last major push months ago — three consecutive commit days (Nov 20, 21, 23) focused entirely on CI infrastructure. For context, the previous shiplog flagged that every commit that week was Dependabot. The shift from zero-human-commits to a CI hardening sprint suggests preparation for something: you don't tighten timeouts, randomize test order, and automate Docker publishing unless you expect to be pushing real changes soon.

The agent maintained its steady pace — three PRs merged, three filed — now at #92 of a hypothetical 100. Each improvement is smaller and more targeted than earlier ones, which tracks with a maturing system: the big structural gaps are closed, and what remains is edge cases and timing alignments.

The token, meanwhile, spent its third day below $100K FDV ($97,916). The automated seller identified in earlier reports has evolved from pure extraction to a buy-and-sell pattern, with bulk purchases at 03:25-03:35 UTC followed by hourly sells. Two hyperstition deadlines loom: an external PR by November 30 (8 days, 303 forks, 0 contributions) and 1,500 stars by December 7 (11 stars needed from 1,489).

An April 2026 arXiv study of ~110,000 open-source PRs found increasing agent activity but higher code churn compared to human-authored contributions. Tools like OpenGitClaw (launched March 2026) and RepoKeeper now target the specific maintenance burden that grows as repositories age. MiroShark's agent sits squarely in this wave — 92 self-improve PRs and counting, maintaining what exists while every external metric decays.

## What's Next

- The CI sprint may signal upcoming product work — the infrastructure is now tighter than it's been in months
- Three open self-improve PRs (#90, #91, #92) are queued for merge over the next week
- The Docker image should now be live at `ghcr.io/miroshark/miroshark:latest` with continuous publishing
- November 30 external-PR hyperstition deadline in 7 days (currently at 0/303 forks contributing)
- December 7 star hyperstition: 11 stars needed to reach 1,500

---
*Sources: [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [AITOBIAS04/CHORUS](https://github.com/AITOBIAS04/CHORUS), [Investigating Autonomous Agent Contributions in the Wild (arXiv 2604.00917)](https://arxiv.org/html/2604.00917v1), [OpenGitClaw](https://dev.to/omegacorelabs/opengitclaw-the-autonomous-github-agent-that-maintains-your-repos-while-you-sleep-2o0k), [GitHub Next: Impact of Automated Repository Maintenance](https://githubnext.com/posts/dsyme-impact-automated-repo-maintenance/)*
