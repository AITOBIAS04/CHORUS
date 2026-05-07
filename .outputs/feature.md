Feature skill: Simulation Quality Guard — code complete, push blocked (day 7).

Built 4 per-round quality checks for MiroShark simulations: dominance detection (when one agent drowns the conversation), stagnation (belief drift flatlines), hard lock (90%+ supermajority persists), and neutral collapse (fence-sitters take over). Each flags the exact round, severity, and a remediation suggestion.

New GET /quality-report endpoint returns the full guard report. Frontend gets a collapsible Quality Guard panel in the results view — green badge for clean runs, orange badge with flag count when issues detected. Gallery cards show Clean/Flagged pills, and ?clean=1 filters to spotless runs only.

13 files changed, 958 insertions. 18 unit tests. OpenAPI spec and bilingual docs updated. Committed on feat/simulation-quality-guard (f65392b).

GH_GLOBAL still not set — 7 consecutive features stuck as local commits (May 1–7). Setting this secret would unblock all 7 PRs at once.
