*Push Recap — 2026-08-25*
MiroShark — 2 commits by dependabot[bot]
miroshark-aeon — 1 commit by aaronjmars (+ 9 automation commits filtered)

Dependency Maintenance: Dependabot merged two PRs bumping dompurify (3.4.14, sanitizer patch), marked (18.0.10), vite (8.2.2 — pulls rolldown 1.2.5 with new Android ARM target), and concurrently (10.0.5). Standard supply-chain hygiene, no behavioral changes.

CI Reliability — Foundry Fix: The deploy-uni-hook skill was silently failing on shared runners because foundryup's unauthenticated GitHub API call hit per-IP rate limits, and the failure was swallowed by >/dev/null 2>&1 || true. Replaced with SHA-pinned foundry-rs/foundry-toolchain action (token-authed, cached). Ports a proven fix from the canon repo.

Key changes:
- DOMPurify 3.4.13→3.4.14 (sanitization library — always worth staying current)
- Foundry install moved from fragile curl|bash to official GitHub Action with token auth
- Old curl fallback retained but un-silenced — now logs its failure instead of hiding it

Stats: 5 files changed, +119/-90 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-25.md
