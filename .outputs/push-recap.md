*Push Recap — 2026-10-08*
MiroShark — 3 substantive commits | miroshark-aeon — 2 substantive + 14 automation filtered

Security & Dependency Hygiene: Four Dependabot alerts patched in MiroShark — shell-quote (critical command injection), source-map-js (high), fsspec (high), Werkzeug (medium). The miroshark-aeon instance repo deleted its entire dependabot.yml (114 lines) since version-update PRs duplicated those from the canon repo. Security alerts remain active.

CI/CD: Ruff Linter: A new Python lint job was added to MiroShark CI using ruff (pinned 0.15.11). The ruleset catches only real bugs — syntax errors, undefined names, unused imports/variables. No formatting enforced. Fixed four existing issues it found, including missing TYPE_CHECKING imports in env.py that could have caused runtime NameError.

Documentation: Install guides (EN + ZH) updated from claude-haiku-4-5 to claude-haiku-5-5.

Key changes:
- shell-quote 1.9.0 → 1.12.0 fixes a critical command injection CVE in dev tooling
- ruff.toml added with minimal bug-catching rules — every Python push now linted
- miroshark-aeon deps now flow exclusively through aeon-update from canon

Stats: 13 files changed, +87/-137 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-10-08.md
