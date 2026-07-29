# Push Recap — 2026-07-29

## Overview
2 substantive commits by 2 authors (9 automation commits filtered). Today was entirely security-focused dependency maintenance on miroshark-aeon's dashboard — two PRs landed closing high-severity Dependabot alerts for postcss and sharp, plus a routine Next.js patch bump. MiroShark itself had zero commits.

**Stats:** 2 files changed, +273/-184 lines across 2 substantive commits

---

## aaronjmars/MiroShark
No commits in the last 24 hours.

---

## aaronjmars/miroshark-aeon

### Security: Dashboard Dependency Hardening
**Summary:** Two high-severity Dependabot alerts in the dashboard app were closed in a single PR. postcss was vulnerable to path traversal via crafted `sourceMappingURL` comments (GHSA-r28c-9q8g-f849), and sharp inherited multiple libvips CVEs through its bundled native binaries (GHSA-f88m-g3jw-g9cj). Both were resolved by bumping to patched versions and adding an npm `overrides` entry for sharp, since it's an optional transitive dependency of Next.js that can't be pinned through normal dependency resolution.

**Commits:**
- `f620448` — chore(deps): align dashboard deps with aeon template (security) (#122)
  - Changed `apps/dashboard/package.json`: added `"sharp": "^0.35.3"` to the `overrides` block alongside the existing postcss override; postcss override bumped from `^8.5.10` to `^8.5.18` (+2/-1 lines)
  - Changed `apps/dashboard/package-lock.json`: major version bump for sharp 0.34.5 → 0.35.3 across all 24 platform-specific binaries (darwin, linux, win32, wasm32, linuxmusl variants); sharp-libvips binaries 1.2.4 → 1.3.2; new entries for `@img/sharp-freebsd-wasm32` and `@img/sharp-webcontainers-wasm32` (FreeBSD and WebContainers support added in 0.35.x); postcss 8.5.15 → 8.5.25; nanoid 3.3.12 → 3.3.16; semver 7.7.4 → 7.8.5; @emnapi/runtime 1.9.0 → 1.11.3; Node.js engine requirement tightened from `^18.17.0 || ^20.3.0 || >=21.0.0` to `>=20.9.0` (+230/-142 lines)

**Impact:** Closes 2 high-severity security alerts. The postcss path traversal (GHSA-r28c-9q8g-f849) could allow an attacker to read arbitrary files via a crafted CSS source map URL — relevant since the dashboard processes user-facing CSS. The sharp/libvips CVEs (GHSA-f88m-g3jw-g9cj) affect image processing pipelines. The `overrides` approach is necessary because sharp is declared as an optional peer of `next`, so version pinning only works through npm overrides. Node.js minimum bumped to 20.9.0 — all deployment targets already exceed this.

### Framework: Next.js Patch Bump
**Summary:** Dependabot auto-merged a routine patch bump for Next.js from 16.2.10 to 16.2.11. This is a bug-fix release with no breaking changes — all 8 platform-specific SWC compiler binaries updated in lockstep.

**Commits:**
- `b4a01fe` — chore(deps): bump next from 16.2.10 to 16.2.11 in /apps/dashboard (#120)
  - Changed `apps/dashboard/package.json`: version constraint `^16.2.10` → `^16.2.11` (+1/-1 line)
  - Changed `apps/dashboard/package-lock.json`: updated resolved URLs and integrity hashes for `next`, `@next/env`, and all 8 `@next/swc-*` platform binaries (darwin-arm64, darwin-x64, linux-arm64-gnu, linux-arm64-musl, linux-x64-gnu, linux-x64-musl, win32-arm64-msvc, win32-x64-msvc) (+40/-40 lines)

**Impact:** Keeps the dashboard framework current with upstream fixes. Next.js 16.2.11 is a semver-patch release — no API changes, no migration needed.

---

## Developer Notes
- **New dependencies:** None added; 2 existing ones bumped (postcss 8.5.25, sharp 0.35.3), plus transitive updates (nanoid, semver, emnapi)
- **Breaking changes:** Node.js minimum for sharp raised to >=20.9.0 (from ^18.17.0); all deployment environments already meet this
- **Architecture shifts:** None — pure dependency maintenance
- **Tech debt:** The `overrides` block in dashboard/package.json now has 2 entries (postcss + sharp); these should be removed once Next.js updates its own sharp constraint to >=0.35.3

## What's Next
- MiroShark itself had zero code changes today — all activity was on the agent repo's dashboard
- The sharp override is a stopgap — once Next.js formally pins sharp >=0.35.x, the override can be dropped
- With both postcss and sharp patched, the dashboard has zero open high-severity Dependabot alerts
