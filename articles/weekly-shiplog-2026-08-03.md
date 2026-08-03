# Week in Review: A Stranger Shipped a Cloud Provider and the Agent Learned to Check Its Own Wallet

*2026-08-03 — Weekly shipping update*

## The Big Picture

This was the week a community contributor proved the fork model isn't dead and the agent infrastructure got meaningfully smarter. PR #259 landed an entire Atlas Cloud provider preset — the first community feature contribution in months, written by someone who forked the repo and opened the PR in the same minute. Meanwhile, the agent learned to query its own wallet balances on-chain, migrated to Claude 5, and patched two high-severity CVEs before they were a day old. The codebase grew for the first time in three weeks.

## What Shipped

### Atlas Cloud Provider Preset (PR #259)

A contributor named binyangzhu000-sudo forked MiroShark on July 26 and immediately submitted a pull request adding Atlas Cloud as a provider preset. Five files, 361 lines total, 153 of which are unit tests. The backend got a new preset entry in the settings API, the frontend's SettingsPanel picked up the Atlas Cloud option, and `.env.example` added the required configuration keys. This is notable because 298 forks exist and this is the first one to contribute a full feature in weeks. The PR merged July 31 — four days from submission to main, reviewed and landed by the project founder. It's also the first data point for a new hyperstition: will 3 of MiroShark's 40+ agent-designed feature proposals get implemented by community contributors by September 15?

### Holdings Skill — The Agent Checks Its Own Wallet

The agent infrastructure gained a new capability: querying on-chain wallet balances via public Base RPC. The `holdings` skill (447 lines of pure-stdlib Python) reads token balances for the instance's configured wallets, writes results to `memory/holdings.json`, and runs on a weekly Monday schedule. No API keys needed — it talks directly to Base's public JSON-RPC endpoint. A follow-up refactor scoped it to the instance token only and dropped dollar-value conversion, keeping the output clean and dependency-free. The agent can now see what it holds without relying on any third-party service.

### Claude 5 Migration

The default model for the agent framework bumped from Claude Sonnet 4.5 to Claude Sonnet 5. Three additional commits updated gateway remap tables and workflow fallback model IDs to reference `sonnet-5` and `opus-5`. These changes are inert on the native Anthropic run path but keep the configuration honest for deployments that route through API gateways.

## Fixes & Improvements

- **Telegram security hardening** (PR #123): Added an owner-user gate so only the configured operator can trigger inline commands, plus auto-suppression of interactive buttons in public group chats. Eleven files changed, 49 new test lines. Prevents strangers from invoking agent actions through public Telegram groups.
- **Two high-severity CVE patches** (PR #122): postcss path traversal (GHSA-r28c-9q8g-f849) and sharp/libvips memory corruption (GHSA-f88m-g3jw-g9cj) both patched via version bumps and npm overrides. Node.js minimum raised to 20.9.0.
- **MCP 2.0 pin** (PR #263): Pinned `mcp<2.0.0` in backend requirements to keep the camel smoke test passing after upstream broke backwards compatibility.
- **actions/setup-node v6 to v7** (PR #124): Major version upgrade across both CI workflow files. Node 22 pinned explicitly to limit exposure to changed defaults.
- **Leaked scratch cleanup**: 709 lines of changelog data, notification payloads, and skill scratch files removed from the output root. Gitignore hardened with un-anchored globs to catch future leaks.
- **Self-improve PRs** (CHORUS #44, #45, #46): Lessons Learned rotation added to memory-flush, same-day rerun dedup added to token-report and hyperstitions-ideas — both fixing scheduler double-dispatch noise.
- **Dependency maintenance**: React 19.2.8, Tailwind 4.3.3, Next.js 16.2.12, Wrangler 4.115.0, concurrently 10.0.4, marked 18.0.7.

## By the Numbers

- **Commits:** ~21 substantive across 2 repos (MiroShark: 5, miroshark-aeon: 16)
- **PRs merged:** 13 (MiroShark: 3, miroshark-aeon: 7, CHORUS: 3)
- **Files changed:** ~57
- **Lines:** +1,442 / -1,183 (net +259)
- **Contributors:** aaronjmars, binyangzhu000-sudo, dependabot[bot], aeonframework

## Momentum Check

After three straight weeks of subtraction — the v0.1.0 migration shed 73,000 lines, the cleanup PR deleted 1,325 more, and last week's net was -1,307 — the codebase grew for the first time. Net +259 lines, driven by the Atlas Cloud preset and the holdings skill. The pace stayed steady at 13 PRs merged (vs. 15 last week), but the character shifted from deletion to construction.

Stars dipped from 1,417 to 1,412 over the week. Forks held at 298. Social silence extended to 28 consecutive days (Jul 7 — Aug 3). The token closed at $0.000001685, down 6.5% on the week and hovering 2% above its all-time low. Volume collapsed to under $1K/day. The project keeps shipping; the market and the community remain asleep.

The GH_GLOBAL block hit its 66th consecutive day. Forty-plus features remain built but unpushable. That single missing secret is the widest gap between what exists and what's visible.

## What's Next

- **GH_GLOBAL secret**: Still the top priority. Unblocking it would flood the repo with months of accumulated features — French locale, agent archetypes, stance flips, full-text search, cost estimates, and more.
- **EU AI Act enforcement**: Went live August 2. The project's daily articles have been building the narrative connecting MiroShark's agent-as-maintainer model to regulatory frameworks. Whether anyone in the compliance space notices remains to be seen.
- **New hyperstitions**: Two filed this week — 3 community feature PRs by September 15, and a Product Hunt launch with 100+ upvotes by September 15. Both test whether the project can convert its 298 forks and 1,412 stars into action outside GitHub.
- **Feature candidates queued**: Product Hunt Launch Kit, `miro doctor` CLI, Italian locale, Interactive API docs, Simulation Comparison API — all waiting on push access.
- **Social reactivation**: 28 days of silence. The project's next phase requires moving beyond code into community — live events, external content, platform presence. Every week of silence makes that transition harder.

---
*Sources: [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [AITOBIAS04/CHORUS](https://github.com/AITOBIAS04/CHORUS), [MiroShark on ToolHunter](https://toolhunter.cc/tools/miroshark), [MiroShark on Microlaunch](https://microlaunch.net/p/miroshark)*
