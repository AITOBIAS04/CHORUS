*Push Recap — 2026-07-04*
MiroShark — 9 substantive commits by 3 authors (12 automation commits filtered)

Security & Dependency Hardening: Four-commit sweep patching 20+ CVEs across the Python backend. starlette jumped 0.50→1.3.1, cryptography 46→49, pytest 8→9.1.1, plus 13 patch/minor bumps (werkzeug, requests, urllib3, pillow, flask, and more). All transitive or dev-only — zero application code changes, full test suite green.

Community & Governance: SECURITY.md, expanded CONTRIBUTING.md (EN + ZH-CN), and FUNDING.yml landed. Community docs consolidated under .github/. LICENSE moved back to repo root after GitHub licensee detection broke. The repo now has a complete governance stack for its 1,355-star milestone.

Bug Fixes: Docker compose files now persist backend/data/ so Nemotron demographic datasets (hundreds of MB) survive container recreation. Daniel Andersen landed his 9th merged PR — fixing a cross-provider LLM message filtering issue where Gemini and Azure had conflicting requirements for tool_calls.

Key changes:
- 20+ CVEs patched across backend deps (starlette, cryptography, pyjwt, pillow, werkzeug)
- SECURITY.md + CONTRIBUTING.md + FUNDING.yml = complete community governance
- Nemotron data persistence fix prevents re-downloading 100s of MB on container updates

Stats: ~29 files changed, +757/-542 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-07-04.md
