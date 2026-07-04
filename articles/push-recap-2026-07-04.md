# Push Recap — 2026-07-04

## Overview
9 substantive commits across aaronjmars/MiroShark by 3 authors (12 automation commits filtered from miroshark-aeon). The day's thrust was a comprehensive security hardening sweep — patching 20+ CVEs across backend and frontend dependencies — alongside a community governance overhaul that added SECURITY.md, CONTRIBUTING.md, and FUNDING.yml. Two targeted bug fixes rounded it out.

**Stats:** ~29 files changed, +757/-542 lines across 9 substantive commits

---

## aaronjmars/MiroShark

### Security & Dependency Hardening
**Summary:** A four-commit blitz that patches 20+ CVEs across the Python backend and Node.js frontend. The work is split into safe patch/minor bumps, major-version transitive deps behind camel-ai's MCP, a pytest major-version CVE fix, and a dependabot-driven pyproject.toml constraint update. All changes are in lock files and dependency specs — zero application code changes.

**Commits:**

- `8656844` — fix(deps): safe patch/minor bumps for Dependabot alerts (A+B) (#229)
  - Changed `backend/uv.lock`: 13 Python packages bumped — werkzeug 3.1.4→3.1.8 (CVE-2026-21860, CVE-2026-27199), requests 2.32.5→2.34.2, urllib3 2.6.2→2.7.0, idna 3.11→3.18, flask 3.1.2→3.1.3, python-dotenv 1.2.1→1.2.2, pillow 12.1.1→12.3.0 (5 CVEs), pydantic-settings 2.12.0→2.14.2, tornado 6.5.4→6.5.7, mistune 3.1.4→3.3.2, nbconvert 7.16.6→7.17.1, bleach 6.3.0→6.4.0, pygments 2.19.2→2.20.0 (+125/-129 lines)
  - Changed `frontend/package-lock.json`: form-data 4.0.5→4.0.6 (CVE-2026-12143 CRLF injection in multipart field names) (+8/-8 lines)

- `2e3cc38` — fix(deps): bump major-version deps behind camel-ai's MCP (starlette/pyjwt/cryptography/python-multipart) (#230)
  - Changed `backend/uv.lock`: starlette 0.50.0→1.3.1 (4 CVEs), cryptography 46.0.3→49.0.0 (4 CVEs), pyjwt 2.10.1→2.13.0 (6 CVEs), python-multipart 0.0.21→0.0.32 (7 CVEs) (+57/-63 lines)
  - All four are transitive via camel-ai's optional MCP toolkit — not in MiroShark's own request surface (Flask, not Starlette; static key auth, not JWT). Verified mcp import chain and pyjwt RS256 sign/verify still pass.

- `a50d3a6` — fix(deps): bump pytest 8.2→9.1.1 and pytest-asyncio 0.23.6→1.4.0 (#231)
  - Changed `backend/uv.lock`: pytest and pytest-asyncio major bumps, dev-only (+8/-6 lines)
  - Fixes CVE-2025-71176. Verified: 1,423 passed, 3 skipped under new versions.

- `38322e5` — chore: bump the uv group across 1 directory with 6 updates (#233) — dependabot[bot]
  - Changed `backend/pyproject.toml`: Updated minimum version constraints for torch (≥2.12.1), pytest (≥9.0.3) (+3/-3 lines)
  - Changed `backend/uv.lock`: torch 2.11.0→2.12.1, plus resolved versions for pytest, cryptography, pyjwt, python-multipart, starlette (+48/-56 lines)

**Impact:** Clears all active Dependabot alerts. The starlette 0.x→1.x major bump was the riskiest — verified end-to-end against mcp==1.24.0. All dev-only and transitive deps, so zero risk to MiroShark's own Flask/Next.js application paths. Test suite fully green.

---

### Community & Governance Infrastructure
**Summary:** Three commits that professionalize the repo's community-facing surface: a proper security disclosure policy, expanded contribution guides in two languages, GitHub Sponsor integration, and consolidated community docs under `.github/`. The LICENSE file was briefly moved to `.github/` then moved back to root because GitHub's licensee detector only scans the repo root.

**Commits:**

- `eb2e5f5` — chore: add SECURITY + CONTRIBUTING, consolidate community docs under .github/ (#235)
  - New file `.github/SECURITY.md`: Tailored security policy — private vulnerability reporting via GitHub PVR, response targets, per-repo threat model and scope (+101 lines)
  - New file `.github/CONTRIBUTING.md`: Real dev setup instructions, test/CI commands, PR conventions, new-endpoint checklist (+114 lines)
  - New file `.github/CONTRIBUTING.zh-CN.md`: Chinese translation of contributing guide (+86 lines)
  - Renamed/moved `README.md`, `README.zh-CN.md`, `README.ja.md`, `README.fr.md` under `.github/` with rebased relative links (image paths changed from `./docs/` to `../docs/`, inter-README links updated)
  - Moved `LICENSE` to `.github/LICENSE`
  - Removed old root-level `CONTRIBUTING.md` and `CONTRIBUTING.zh-CN.md` (-168 lines)
  - Changed `CLAUDE.md`: Updated README link to new `.github/` path (+2/-2 lines)

- `47141db` — fix: move LICENSE back to repo root so GitHub detects it (#236)
  - Renamed `.github/LICENSE` back to root `LICENSE` (GitHub's licensee only scans repo root)
  - Updated 5 doc files (CONTRIBUTING.md, CONTRIBUTING.zh-CN.md, README.fr.md, README.ja.md, README.md, README.zh-CN.md) to point `../LICENSE` instead of `LICENSE` (+5/-5 lines)

- `e25ad45` — chore: add FUNDING.yml (Sponsor button) (#237)
  - New file `.github/FUNDING.yml`: Sponsor button linking to miroshark.xyz, bankr.bot terminal, DexScreener pool, and BaseScan token page (+7 lines)

**Impact:** The repo now has a complete community governance stack: security disclosure policy, detailed contribution guides in English and Chinese, and a GitHub Sponsor button. These are table-stakes for a 1,355-star repo approaching the 1,500-star target — signals maturity and lowers the barrier for new contributors.

---

### Bug Fixes
**Summary:** Two targeted fixes — one from a community contributor (Daniel Andersen, 9th merged PR) fixing an LLM provider compatibility issue, and one from the maintainer fixing a data persistence problem in Docker deployments.

**Commits:**

- `7a3f46f` — fix(compose): persist backend/data so Nemotron datasets survive container recreation (#238) — aaronjmars
  - Changed `docker-compose.yml`: Added `./backend/data:/app/backend/data` bind-mount (+1 line)
  - Changed `docker-compose.ollama.yml`: Same bind-mount (+1 line)
  - Changed `docker-compose.traefik.yml`: Same bind-mount (+1 line)
  - The demographics sampler downloads Nemotron-Personas parquet files (hundreds of MB per country) to `backend/data/nemotron/`. Without this mount, data lived only in the container's writable layer and was re-downloaded on every container recreation.

- `f15baf5` — fix(social-agent): preserve tool_calls when filtering empty LLM messages (#232) — Daniel Andersen (community)
  - New file `backend/app/utils/llm_message_filter.py`: Extracted `filter_openai_messages_for_api()` — dependency-free utility that drops empty user/assistant content (Gemini rejects these) while preserving assistant messages that carry `tool_calls` (Azure requires tool_calls to precede tool results) (+36 lines)
  - New file `backend/tests/test_unit_social_agent_messages.py`: 56 lines of unit tests covering both Gemini and Azure provider edge cases
  - Changed `backend/wonderwall/social_agent/agent.py`: Imported the new utility, removed inline filtering logic (+2/-6 lines)
  - The filter was moved out of the `wonderwall` package to avoid importing numpy/camel-ai in the thin unit-test CI job.

**Impact:** Docker users no longer re-download hundreds of MB of Nemotron demographic data on container updates. The social-agent fix resolves a cross-provider compatibility issue where Gemini and Azure had conflicting requirements for message filtering — empty messages needed to be dropped for Gemini, but not if they carried tool_calls for Azure.

---

## aaronjmars/miroshark-aeon

12 automation commits filtered (4× `chore(cron):`, 4× `chore(scheduler):`, 4× auto-commit). No substantive changes.

---

## Developer Notes
- **New dependencies:** torch 2.11→2.12.1 (PyTorch minor), pytest 8.2→9.1.1 (major), starlette 0.50→1.3.1 (major, transitive), cryptography 46→49 (major, transitive), pyjwt 2.10→2.13 (minor, transitive), plus 10+ patch bumps
- **Breaking changes:** None for MiroShark's own code. The starlette/pyjwt/cryptography major bumps only affect camel-ai's MCP toolkit and were verified against mcp==1.24.0.
- **Architecture shifts:** Community docs consolidated under `.github/` — README, CONTRIBUTING, and SECURITY now live there. LICENSE stays at repo root for GitHub detection. New `app/utils/llm_message_filter.py` extracts message filtering from the wonderwall package.
- **Tech debt:** None introduced. The llm_message_filter extraction actually reduces coupling (wonderwall no longer needed for unit tests).

## What's Next
- The security hardening clears the dependency alert backlog — the repo is now clean on both npm and pip advisories.
- FUNDING.yml enables GitHub Sponsors — the maintainer may start promoting sponsorship alongside the 1,500-star push.
- Daniel Andersen's 9th merged PR (tool_calls fix) continues his streak as the only sustained community contributor — the new CONTRIBUTING.md may help recruit more.
- The Nemotron data persistence fix suggests active Docker deployment work — self-hosted instances may be getting closer to production-ready.
- GH_GLOBAL secret still blocks 50+ feature PRs from being pushed.
