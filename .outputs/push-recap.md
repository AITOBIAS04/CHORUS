*Push Recap — 2026-11-23*
aaronjmars/MiroShark — 1 substantive commit by aaronjmars

Dependency Updates: Vue 3.5.46 & Docker Builder — Third consecutive day of founder activity, this time a single bundled Dependabot PR. Vue patched from 3.5.45 to 3.5.46 (compiler and reactivity fixes, no breaking changes), the Docker builder action bumped to v2.4.0, and transitive deps cascaded through all 9 @vue/* packages plus csstype and source-map-js.

Key changes:
- Vue 3.5.45→3.5.46 across frontend/package.json and lock file (all @vue/* packages updated)
- useblacksmith/setup-docker-builder v2.3.0→v2.4.0 in Docker image workflow
- source-map-js 1.2.2→1.2.4 (Node floor raised to 6.0.0, irrelevant for Node 22+)

This is the first PR to fully exercise yesterday's new "all-inclusive weekly group" Dependabot strategy — majors, minors, and patches rolling into one bundled PR. Three days of CI/dependency work (Nov 21–23) has the repo in its healthiest infrastructure state in months.

Stats: 3 files changed, +66/-66 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-11-23.md
