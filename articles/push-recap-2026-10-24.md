# Push Recap — 2026-10-24

## Overview
3 substantive commits by 2 authors across 2 watched repos (9 automation commits filtered from miroshark-aeon). A security-focused day — both repos received patches addressing multiple CVEs, including two critical Next.js advisories and an MCP SDK vulnerability. Dependabot also swept through the Python backend lockfile with three indirect dependency updates.

**Stats:** 6 files changed, +197/-153 lines across 3 substantive commits

---

## aaronjmars/MiroShark

### Security: MCP Python SDK Vulnerability Fix
**Summary:** The MCP (Model Context Protocol) Python SDK was bumped from 1.28.1 to 1.30.0 to address Dependabot alert #94 (GHSA-84m7-p3x7-pcfv). The fix includes an explicit version pin in pyproject.toml to prevent the lockfile from ever resolving below 1.30.0, while keeping the ceiling at <2.0.0 to avoid the breaking FastMCP relocation in mcp 2.x.

**Commits:**
- `2ddfbc3` — security: bump mcp 1.28.1 to 1.30.0 (Dependabot alert 94, GHSA-84m7-p3x7-pcfv) (#342)
  - Changed `backend/pyproject.toml`: Added `mcp>=1.30.0,<2.0.0` as an explicit dependency with a comment explaining the camel-ai compatibility constraint — camel-ai allows mcp>=1.3.0 but mcp 2.0.0 moves FastMCP and breaks camel's import (+3 lines)
  - Changed `backend/requirements.txt`: Updated pip install pin and comments to reflect the 1.30.0 floor instead of 1.28.1 (+2, -2 lines)
  - Changed `backend/uv.lock`: Resolved mcp version bumped from 1.28.1 to 1.30.0 with new sdist/wheel hashes; lock revision dropped from 5 to 3; platform markers for NVIDIA CUDA packages tightened from bare `platform_machine` checks to `sys_platform == 'linux'` conjunctions (uv 0.9.26 resolver behavior); added `mcp` to the explicit requires-dist list (+34, -32 lines)

**Impact:** Closes a security vulnerability in the MCP SDK that the simulation backend depends on through camel-ai. The tighter version pin ensures no future lock resolution can regress below the fix. The platform marker refinements are a side effect of regenerating the lock with a newer uv version — they make the lockfile more precise about which NVIDIA packages are needed on which OS.

### Dependency Maintenance: Python Backend Lockfile
**Summary:** Dependabot grouped three indirect Python dependency updates into a single PR. The most notable is brotli 1.2.0 → 1.2.1, which addresses CVE-2026-111497 (the security advisory that also has an open PR in the repo). filelock jumps a major version (3.x → 4.x), and setuptools gets a minor bump.

**Commits:**
- `4be9cbf` — chore: bump the uv group across 1 directory with 3 updates (#341)
  - Changed `backend/uv.lock`: Updated three indirect dependencies (+110, -71 lines):
    - **brotli** 1.2.0 → 1.2.1 — Compression library patch addressing the brotli CVE. New wheel hashes across all platform/Python version combinations account for the bulk of the diff.
    - **filelock** 3.25.2 → 4.2.1 — Major version bump for the file-locking library. 4.x is a semver-major change; as an indirect dependency (used by virtualenv, pip internals), the risk is low but the jump is notable.
    - **setuptools** 83.0.0 → 84.1.0 — Minor version bump for the Python build tool. Indirect dependency, unlikely to affect runtime behavior.

**Impact:** The brotli update closes the CVE that Dependabot flagged separately. filelock 4.x and setuptools 84 are routine indirect bumps with no expected runtime impact. The lock revision advances from 3 to 5 after this commit (reverse of the earlier security commit's revision drop — the two commits were authored against different lock states and merged sequentially).

---

## aaronjmars/miroshark-aeon

### Security: Critical Next.js and MCP Server Patches
**Summary:** A bundled security PR addressed multiple vulnerabilities across the dashboard and MCP server apps. The most severe are two critical Next.js advisories (GHSA-673q-mjm6-r5xr, GHSA-2464-fhr4-w9xw), a high-severity Next.js advisory (GHSA-p3m5-59mp-jv5r), and vulnerabilities in ip-address and hono. The hono patch was not auto-filed by Dependabot and was manually included.

**Commits:**
- `b12c051` — chore(deps): bundle dependabot bumps (#224, #225) (#226)
  - Changed `apps/dashboard/package.json`: next dependency bumped from ^16.3.8 to ^16.4.3 (+1, -1 lines)
  - Changed `apps/dashboard/package-lock.json`: Full Next.js resolution update — `@next/env`, all 8 `@next/swc-*` platform packages, and the core `next` package all moved from 16.3.8 to 16.4.3. Sharp optional dependency specifier updated from ^0.35.4 to ^0.35.5 (+41, -41 lines)
  - Changed `apps/mcp-server/package-lock.json`: Two dependency updates (+6, -6 lines):
    - **hono** 4.13.7 → 4.13.13 — HTTP framework used by the MCP server; fixes GHSA-5r4p-p66f-jhc7 (alert #49, no Dependabot PR existed — manually bundled)
    - **ip-address** 10.7.2 → 10.7.4 — IP address parsing library; fixes GHSA-rxp7-6hxx-x8q5

**Impact:** Patches 5 security advisories in one commit, including 2 critical-severity Next.js vulnerabilities in the dashboard app. The hono fix is notable because Dependabot didn't generate a PR for it — the maintainer caught alert #49 and bundled it manually. The dashboard and MCP server are both now on patched versions.

### Automation Activity (9 commits filtered)
Standard cron/scheduler cycle: token-movers log and state update, heartbeat log and state update, fetch-tweets log and state update, plus scheduler state changes between each.

---

## Developer Notes
- **New dependencies:** `mcp` added as an explicit dependency in MiroShark's pyproject.toml (previously only an indirect dependency through camel-ai)
- **Breaking changes:** filelock 3.x → 4.x is a semver-major bump, but only used indirectly; Next.js 16.3→16.4 is a minor bump with security fixes, no breaking API changes expected
- **Architecture shifts:** None
- **Tech debt:** None introduced

## What's Next
- The brotli CVE PR that Dependabot filed separately may now be redundant since `4be9cbf` already bumped brotli to 1.2.1 — worth verifying and closing if so
- MiroShark has 1 open PR (the brotli security bump) that may overlap with today's grouped update
- miroshark-aeon's self-improve cycle (PR #77 for memory-flush Active Targets archival) was merged earlier today — the next self-improve window will assess fresh
- Both repos are now current on all known security advisories as of today
