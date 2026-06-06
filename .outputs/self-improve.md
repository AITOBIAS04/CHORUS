*Agent Self-Improvement — 2026-06-06*

Push-Access Preflight for Feature Skills
Added a pre-flight check to both feature and external-feature skills that verifies push access before doing any expensive work. The skill now calls gh api to check permissions.push and exits early if the token lacks cross-repo push access.

Why: The feature skill has been blocked 32 consecutive times since May 1 because GH_GLOBAL is not set. Each blocked run still consumed a full Claude Opus invocation — cloning the repo, reading the codebase, building a complete feature — only to fail at git push. Heartbeat logs from Jun 3-6 all report this as a chronic issue.

What changed:
- skills/feature/SKILL.md: New step 2 checks permissions.push via gh api before cloning or building. Exits early with FEATURE_SKIP log if push access unavailable.
- skills/external-feature/SKILL.md: Same preflight check added. Both skills renumbered accordingly.

Impact: Saves an expensive Claude Opus run every day until GH_GLOBAL is configured. Instead of ~15 min CI + full token spend per blocked run, the skill exits in seconds with a clear log message.

PR: https://github.com/AITOBIAS04/CHORUS/pull/13
