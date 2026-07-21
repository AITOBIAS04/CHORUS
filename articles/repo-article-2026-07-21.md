# Eight Agents Audited Fifty-Three Files. Three of Them Found Nothing Safe to Change.

Technical debt costs the software industry between $1.3 and $2.5 trillion a year. Most teams chip away at it one ticket at a time. On July 21, a solo-maintained open-source project tried something different: it dispatched eight AI research agents to audit an entire codebase across eight dimensions of cleanup, then merged only what every agent could prove was safe.

## The Pull Request

[PR #254](https://github.com/aaronjmars/MiroShark/pull/254) in MiroShark — a $1-per-run AI simulation engine with 1,413 GitHub stars — landed as a single merge touching 53 files and deleting 1,325 net lines of code. The work was split into four domain commits, each independently revertible:

| Domain | Net lines |
|---|---|
| Dead code | -414 |
| Legacy paths | -63 |
| Duplication and type consolidation | -1,200 |
| Weak types | ~0 |

Seventeen unreferenced methods. Six dead constants. Three config knobs that read environment variables but were never consumed by any code path — including `WONDERWALL_DEFAULT_MAX_ROUNDS` and `REPORT_AGENT_TEMPERATURE`, which had been silently advertised to operators in the deployment template as if they did something. Twenty-three byte-identical copies of a publish-gate pattern collapsed into a single `_load_public_summary` helper. A ~171-line CSS block duplicated across three Vue views extracted into one shared stylesheet.

## What Did Not Ship

The discipline shows in the zeros. Three of the eight audited dimensions produced no commit at all — not because they were skipped, but because nothing passed the safety bar.

Defensive code: the ~200 route-level try/catch blocks looked removable until the agents confirmed there is no Flask error boundary anywhere in the project. Delete one, and the API returns raw Werkzeug HTML instead of the documented JSON shape. Left alone.

Circular dependencies: the frontend was clean — 53 modules, 153 edges, zero cycles. The single backend finding was the blueprint registration pattern, rated medium severity. Left alone.

Comment cleanup: declined entirely for this pass.

Three additional changes were rejected mid-implementation. One method flagged as dead turned out to be called by a test fixture. Two modules contained an apparently identical `_truncate_scenario` function, but one reads `SCENARIO_PREVIEW_CHARS` at 80 characters while the other reads it at 200 — both pinned by tests. Merging them would have silently changed a preview length. A `Callable[..., None]` type annotation looked tightenable until nine of eleven call sites turned out to pass extra keyword arguments.

## The Bugs It Found and Did Not Fix

The sweep surfaced six open correctness and security bugs. The most notable: `hash(str)` in the Wonderwall profile generator is salted per-process in Python, which means the reproducibility contract that `reproduce.json` and the signed-result HMAC advertise is quietly broken across restarts. All six were documented and left for separate pull requests.

This is the kind of separation that research on technical debt consistently recommends and that most teams consistently skip. A 2022 study across 76 open-source Java projects found that technical debt removal usually co-occurs with refactoring — meaning cleanup and behavior changes get tangled in the same commit, making both harder to verify and harder to revert. PR #254 enforces the opposite: cleanup in, bug fixes out.

## Verification at Scale

The PR's verification section reads like a checklist from a team sprint, not a solo commit:

- 1,435 unit tests passed (identical count to baseline)
- Frontend build clean (only a pre-existing dynamic-import warning)
- i18n scan passed with zero blocking issues
- Smoke tests passed
- Linter clean on all unused-import and unused-variable rules
- CSS rules diffed before and after with scope hashes normalized — `ReportView` at 459/459 rules, `SimulationRunView` at 641/641 rules, zero unscoped leaks

Studies estimate that 16% of methods in typical open-source projects are effectively dead. On the web, a median of 70% of JavaScript functions on any given page are unused. The code exists, the tests pass around it, and nobody removes it because removal is harder to justify than addition. Researchers at Ohio State documented this as addition bias: given a problem, 92% of people add something rather than subtract.

## Why It Matters Now

MiroShark gained 53 stars this week — from 1,360 to 1,413 — while its social mentions remained at zero for the fifteenth consecutive day and its token sat at 96% below its all-time high. The project is being discovered by developers through GitHub's organic search and recommendation algorithms, not through marketing or community activity.

What those developers find when they arrive is a codebase that got lighter this week, not heavier. One pull request, eight auditors, 53 files, 1,325 fewer lines, six bugs documented but not mixed in. Shopify allocates 25% of its development capacity to technical debt prevention. This project allocated one afternoon and eight agents to the same goal — and had the restraint to ship nothing where nothing was safe.

---

*Sources: [IBM — Reducing Technical Debt in 2026](https://www.ibm.com/think/insights/reduce-technical-debt), [Zylos — Technical Debt Management 2026](https://zylos.ai/research/2026-02-07-technical-debt/), [Pensero — Dead Code Identification 2026](https://pensero.ai/blog/dead-code), [Socket — Solo Maintainers](https://socket.dev/blog/the-unpaid-backbone-of-open-source), [IEEE — Self-Admitted Technical Debt Removal](https://ieeexplore.ieee.org/document/8919002/), [PR #254](https://github.com/aaronjmars/MiroShark/pull/254)*
