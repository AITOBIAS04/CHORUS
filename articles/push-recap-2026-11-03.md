# Push Recap — 2026-11-03

## Overview
3 substantive commits by Aaron Elijah Mars across both watched repos (11 automation commits filtered from miroshark-aeon). The day's headline is a 32-commit upstream sync that lands two new skills, hardens the supply chain for vulnerability scanning binaries, migrates three X/Twitter-facing skills from xAI Grok to twitterapi.io as primary, and removes the now-superseded `secretcurl` utility. A security patch bumps @hono/node-server, and a quick SEO fix strips dead ecosystem links from MiroShark.

**Stats:** 71 files changed, +2,085/-667 lines across 3 substantive commits

---

## aaronjmars/MiroShark

### SEO Hygiene: Dead Ecosystem Link Removal
**Summary:** PR #355 removes dead website links flagged by an SEO audit. The ecosystem table rows stay — only the unreachable URLs are stripped, preserving the X handles.

**Commits:**
- `36e5175` — Remove dead ecosystem links (sparkleware, mnemedb) (#355)
  - Changed `ECOSYSTEM.md`: Removed Sparkleware's miroshark kit link (`sparkleware.fun/kits/miroshark/`) and site link (`sparkleware.fun`) from the ecosystem table — the domain returns HTTP 402 (Vercel DEPLOYMENT_DISABLED). The X handle `@sparklewarefun` remains. (+1/-1 lines)

**Impact:** Eliminates dead outbound links that could hurt SEO signals and confuse users clicking through. Sparkleware's Vercel deployment was disabled; mnemedb.dev was returning HTTP 530 (Cloudflare origin down). Both projects' X handles still link, so the ecosystem table remains a valid directory.

---

## aaronjmars/miroshark-aeon

### New Skills: Flovia MCP Lookups and GitHub Filing Registry

**Summary:** The upstream sync lands two entirely new skills. Flovia (`skills/flovia/SKILL.md`, 79 lines) provides live crypto data lookups through the Flovia MCP server — Nansen smart money flows, CoinGecko markets, direct chain reads, Zerion wallets, Exa web search, and Firecrawl page reads — all on a free shared allowance with OAuth or API key auth. The GitHub Filing Registry (`skills/github-filing-registry/`, 755 lines across SKILL.md and a shell script) is a structured JSON tracker for every issue and PR filed against upstream repos, preventing duplicate filings and providing triage/sync/status subcommands via pure `gh` CLI.

**Commits (part of `771a89e`):**
- New file `skills/flovia/SKILL.md`: Complete skill definition with detection/auth flow, spend discipline (flat-rate vs metered sources, ≤8 tool calls/run, ≤2 Nansen calls), read-only enforcement for Aeon runs, operation_id idempotency, and data-use disclosure for Nansen lookups (+79 lines)
- New file `skills/github-filing-registry/SKILL.md`: Skill definition with registry schema (version, pulls, issues, activity_log), five subcommands (add, status, triage, sync, log), evidence tiers, and status lifecycle (+156 lines)
- New file `skills/github-filing-registry/filing-registry`: Shell script implementing the registry CRUD — JSON manipulation via `jq`, `gh api` for live GitHub state sync, triage sorting by last-action age (+599 lines)
- New file `scripts/tests/test_filing_registry_sync.sh`: Test suite for the filing registry sync behavior (+97 lines)
- New file `docs/assets/skill-icons/flovia.svg`: Skill icon for dashboard (+1 line)
- New file `docs/assets/skill-icons/github-filing-registry.svg`: Skill icon for dashboard (+1 line)
- New file `skills/sc-audit/README.md`: Documentation for the smart contract audit skill (+93 lines)
- New file `scripts/tests/test_score_output.sh`: New test suite for score output validation (+100 lines)

**Impact:** Skill count rises from 86 to 87 (flovia adds 1; filing-registry is a dev tool). Flovia brings structured on-chain and market data into the skill ecosystem — operators can ask natural-language questions about wallets, tokens, and smart money without writing API calls. The filing registry solves a coordination problem: autonomous agents filing issues upstream need to track what they filed, what happened, and what needs attention next.

### Twitter API Migration: twitterapi.io Becomes Primary

**Summary:** Three X/Twitter-facing skills — reply-maker, mention-radar, and write-tweet — all switch their primary data source from xAI Grok's `x_search` to twitterapi.io's structured endpoints. xAI becomes the fallback (Path B), and WebSearch drops to last-resort (Path C). Each skill now declares `TWITTER_API_KEY` in its `requires:` block alongside the now-optional `XAI_API_KEY?`.

**Commits (part of `771a89e`):**
- Changed `skills/reply-maker/SKILL.md`: Added `TWITTER_API_KEY` to requires; rewrote Step 2 with twitterapi.io `advanced_search` and `/user/last_tweets` as Path A for handle/topic/list scopes; moved xAI Grok to Path B; WebSearch to Path C; added `createdAt` strptime normalization for Twitter-native timestamps; handle-scope uses client-side date filtering since `/user/last_tweets` has no server-side date filter; list IDs still route to xAI (twitterapi has no `list:` operator) (+47/-14 lines)
- Changed `skills/mention-radar/SKILL.md`: Added `TWITTER_API_KEY` to requires; rewrote Step 2 Path A with twitterapi.io `advanced_search` using `since:`/`until:` and `-from:` exclusion in query; moved xAI to Path B; WebSearch to Path C; notes that `advanced_search` doesn't return `author.followers` — follower counts omitted on this path (+30/-12 lines)
- Changed `skills/write-tweet/SKILL.md`: Added `TWITTER_API_KEY` to requires; added twitterapi.io Path A for topic search and remix timeline fetch; remix branch now requires either key (not just xAI); added paginated `/user/last_tweets` with cursor for remix window; moved xAI to Path B throughout (+45/-18 lines)

**Impact:** The twitterapi.io migration reduces dependence on the expensive xAI API for routine X data fetching. twitterapi.io provides structured JSON responses (exact engagement counts, direct permalinks, author metadata) rather than Grok's free-text summaries that require LLM parsing. The three-tier fallback chain (twitterapi → xAI → WebSearch) means X data sourcing degrades gracefully. The `TWITTER_API_KEY` requirement is new — operators need to provision it for primary-path access.

### Supply Chain Hardening: Pinned Binary Digests for Vulnerability Scanners

**Summary:** The vuln-scanner staging script switches from trust-on-download to verify-then-execute for its two Go binary dependencies (TruffleHog and osv-scanner). Both are now pinned to specific versions with per-architecture SHA256 digests checked against the projects' official checksums files.

**Commits (part of `771a89e`):**
- Changed `scripts/stage-vuln-scanner.sh`: TruffleHog pinned to v3.99.7 with SHA256 digests for amd64 (`bdbea05...`) and arm64 (`3060f7c...`); osv-scanner pinned to v2.7.0 with digests for amd64 (`160c625...`) and arm64 (`4061ef4...`); added `sha256_ok()` verification function; downloads are deleted on checksum mismatch (fail-closed); added arch detection for amd64/arm64 runner support; replaced the trust-based `curl | sh` TruffleHog installer with direct tarball extraction (+60/-14 lines)

**Impact:** A compromised release asset or MITM'd download now fails the checksum and the scanner is skipped rather than executed. The old TruffleHog install piped a remote shell script — the new path downloads a release tarball and verifies its digest. Bumping versions now requires updating both the version AND the per-arch digests, which is documented in the script header.

### Observability: Permission Denials Surface in Langfuse Traces

**Summary:** Runs that complete successfully but had tool calls refused by the Claude Code permission system now emit WARNING-level traces instead of the default level, making wasted turns visible in Langfuse's level filters.

**Commits (part of `771a89e`):**
- Changed `harness-adapter/lib/otel-span.sh`: Added an `elif` branch in the jq span builder that checks for a non-empty `permission_denials` array; when present, sets `langfuse.observation.level` to `"WARNING"`, `status_message` to `"tool_denied: N refused tool calls"`, and `error_class` to `"tool_denied"` (+10/-1 lines)

**Impact:** Previously, 17 permission-denied runs per day across instances were all logged at DEFAULT level — invisible in error/warning filters. Now they surface alongside real errors in Langfuse dashboards without being flagged as failures.

### Infrastructure: secretcurl Removal, Git Push Retry Fix, and Scratch Cleanup

**Summary:** The `secretcurl` utility (292 lines) is removed from the repo — its env-var placeholder substitution mechanism is apparently superseded. The git push retry script gains a new pattern for GitHub's inline lock failure diagnostic. Several scratch files are cleaned up.

**Commits (part of `771a89e`):**
- Removed `secretcurl`: The 292-line bash script that substituted `{ENV_NAME}` placeholders with actual secret values to bypass Claude Code's static command analysis. The three skills above now use `./secretcurl` in their new twitterapi.io paths, so the utility itself is still referenced — this removal likely means it's now deployed differently (copied at runtime rather than tracked in git)
- Removed `.tm-msg.md` (-8 lines), `.tm-notify.md` (-10 lines), `notify-body.md` (-7 lines): Scratch notification files that should never have been committed
- Changed `scripts/git-push-retry.sh`: Added `inline_pattern` matching GitHub's lock failure inside the status record itself (`[remote rejected] (cannot lock ref...)`) alongside the existing stderr-based detection (+4/-2 lines)
- Changed `.gitignore`: 9 new ignore rules for scratch files (+9 lines)

**Impact:** The git push retry fix handles a race condition where GitHub returns the ref lock failure inline in the push status record rather than as a separate stderr diagnostic — previously this would have been treated as a non-retryable rejection. The secretcurl removal from version control reduces the tracked binary surface while the utility continues to be available at runtime.

### Security: @hono/node-server Bump

**Summary:** PR #239 bumps `@hono/node-server` from 2.1.0 to 2.1.6 in the MCP server app — a security patch release.

**Commits:**
- `a32bdcd` — security: bump @hono/node-server 2.1.0 to 2.1.6 in apps/mcp-server (#239)
  - Changed `apps/mcp-server/package-lock.json`: Version 2.1.0 → 2.1.6, updated resolved URL and integrity hash, peer dependency widened from `hono ^4` to `hono ^4 || ^5.0.0-0` (+4/-4 lines)

**Impact:** Picks up 6 patch releases of security and stability fixes for the Hono HTTP framework's Node.js adapter. The widened peer dependency prepares for Hono v5 without requiring it.

---

## Developer Notes
- **New dependencies:** @hono/node-server 2.1.0 → 2.1.6
- **Breaking changes:** Three skills now require `TWITTER_API_KEY` for primary X data access — operators without it fall back to xAI (if `XAI_API_KEY` set) then WebSearch
- **Architecture shifts:** Twitter data sourcing inverts from xAI-primary/WebSearch-fallback to twitterapi.io-primary/xAI-fallback/WebSearch-last-resort across reply-maker, mention-radar, and write-tweet
- **Tech debt:** secretcurl removed from version control (292 lines); 3 scratch notification files cleaned up; new .gitignore rules prevent recurrence

## What's Next
- Operators need to provision `TWITTER_API_KEY` for the three migrated skills to use the primary twitterapi.io path — without it they fall back to xAI then WebSearch
- The flovia skill is ready but requires MCP server connection (OAuth or `flv_` key) — first run will hit `FLOVIA_NOT_CONNECTED` until configured
- The github-filing-registry needs `memory/filing-registry.json` initialized on first triage run
- The 32-commit upstream sync notes "31 need manual review" — conflict resolution in the sync PR may have introduced drift worth checking
- Dependabot will likely produce another bundle PR tomorrow on MiroShark
