# Push Recap — 2026-10-25

## Overview
1 substantive commit by 1 author across 2 watched repos (8 automation commits filtered from miroshark-aeon). Another security-focused day — a bundled dependency PR patched vulnerabilities in zod, fast-uri, and body-parser across both the MCP server and Remotion skill project, consolidating three separate Dependabot PRs into one.

**Stats:** 3 files changed, +29/-26 lines across 1 substantive commit

---

## aaronjmars/MiroShark

No commits in the last 24 hours.

---

## aaronjmars/miroshark-aeon

### Security: Bundled Dependency Bumps (zod, fast-uri, body-parser)
**Summary:** A single PR consolidated three Dependabot alerts (#227, #228, #229) plus an additional MCP server zod/fast-uri fix into one commit. The most notable change is zod jumping two minor versions (4.4.3 → 4.6.6/4.6.7), with an `overrides` block added to the Remotion project to force nested Remotion Studio copies onto the same zod version.

**Commits:**
- `a5331ce` — fix(deps): bundle security bumps (zod, fast-uri, body-parser) (#231)
  - Changed `apps/mcp-server/package-lock.json`: Four dependency updates (+18, -18 lines):
    - **body-parser** 2.3.0 → 2.4.0 — HTTP request body parsing middleware; sub-dependencies also bumped (content-type 2.0.0→2.1.0, iconv-lite→0.7.3, qs 6.16.0→6.16.1)
    - **fast-uri** 3.1.8 → 3.1.9 — URI parsing library used by ajv/JSON schema validation
    - **zod** 4.4.3 → 4.6.7 — Schema validation library; two minor versions jumped
  - Changed `skills/remotion/project/package-lock.json`: Two dependency updates (+7, -7 lines):
    - **fast-uri** 3.1.8 → 3.1.9
    - **zod** 4.4.3 → 4.6.6
  - Changed `skills/remotion/project/package.json`: Bumped zod from 4.4.3 to 4.6.6 in direct dependencies and added an `overrides` block (`"zod": "$zod"`) to propagate the version into Remotion's nested studio copies (+4, -1 lines)

**Impact:** Closes 3 Dependabot security alerts in one commit. The zod override in the Remotion project is a pattern fix — without it, Remotion Studio's internal dependencies could resolve to an older, vulnerable zod version. body-parser 2.4.0 pulls in tighter sub-dependency versions (content-type, qs, iconv-lite). This is the second consecutive security-focused day, following yesterday's Next.js/MCP/brotli patches.

### Automation Activity (8 commits filtered)
Standard cron/scheduler cycle: token-movers log and state update, heartbeat log and state update, fetch-tweets log and state update, plus scheduler state changes.

---

## Developer Notes
- **New dependencies:** None (all updates to existing dependencies)
- **Breaking changes:** zod 4.4→4.6 is a minor version bump but jumps two minors; no breaking API changes expected in the 4.x line. body-parser 2.3→2.4 is similarly a minor bump.
- **Architecture shifts:** The `overrides` block in `skills/remotion/project/package.json` is new — forces version alignment for zod across Remotion's nested dependency tree. This pattern may be worth replicating if other workspace packages have similar transitive version divergence.
- **Tech debt:** None introduced

## What's Next
- Two consecutive days of security patching (Oct 24: Next.js/MCP SDK/brotli; Oct 25: zod/fast-uri/body-parser) — both repos should now be current on all known Dependabot alerts
- The self-improve cycle continues — PR #77 (memory-flush Active Targets archival) was merged Oct 24; the next window will assess fresh candidates
- MiroShark remains quiet with no code changes; the GH_GLOBAL secret block continues to prevent feature PRs from landing
