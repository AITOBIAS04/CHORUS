# Every Commit This Week Was a Dependency Bump. That's Not a Slow Week.

Eighty-seven percent of organizations are running software with known, exploitable vulnerabilities in production. The patch exists. They just haven't applied it yet.

MiroShark — the open-source swarm simulation engine with 1,480 GitHub stars — shipped five commits this week. Every single one was a dependency bump. No features, no bug fixes, no architectural changes. Just version numbers going up: MCP SDK patching a security advisory, follow-redirects closing a redirect vulnerability, certifi updating its certificate authority bundle, Pillow stepping to a new major version, DOMPurify and Vue bumping in lockstep. The companion miroshark-aeon repo — the autonomous agent that maintains the project — patched Next.js across two critical and one high-severity CVE, bumped its own MCP SDK, and pulled in a 16-commit upstream sync from the Aeon framework.

Seven dependency-focused commits across two repos. At least five CVEs addressed. Zero fanfare.

## The Gap Between Disclosure and Deployment

Mandiant's M-Trends 2026 report puts the mean time to exploit a CVE at negative seven days — attackers are routinely exploiting vulnerabilities before a patch even exists. When a patch does land, the clock is already running backward. Black Kite's 2026 Third-Party Breach Report counted more than 48,000 CVEs published in 2025 alone, and projected the 2026 figure higher. A Canonical-commissioned IDC survey found 70% of IT teams spend more than six hours per week on security patching — a figure that captures only the organizations that are actually patching.

Against that backdrop, the MiroShark dependency bumps look less like busywork and more like the specific discipline that most projects fail to maintain. Dependabot opens the PR. A human — Aaron Elijah Mars, the project's creator — reviews and merges. The autonomous agent continues its own operational cycle uninterrupted. The entire pattern completes within hours of disclosure, not weeks.

## Meanwhile, the Token Had Its Best Week in Months

While the codebase was doing nothing but housekeeping, $MIROSHARK posted its strongest seven-day stretch since summer. The token rose 20.36% on the week, moving from roughly $0.00000176 to $0.00000212. Volume spiked on October 23 with two coordinated buys totaling approximately $8,000, pushing the 24-hour high to $0.00000222 — the kind of single-day price action the token has not seen in months. Fully diluted valuation sits at around $212K against $2.5M in liquidity pool depth. The ratio remains striking: the LP is roughly 12 times the FDV.

The social silence continues unbroken at 109 days. No tweets, no announcements, no community posts since July 7. The price moved anyway.

## The Agent Keeps Cleaning

On the autonomous maintenance side, the agent filed its 77th self-improve pull request this week. The fix: archiving CLEARED hyperstition entries older than 60 days from the Active Targets section of its memory index. Three entries from April and May — milestones celebrated and recorded months ago — were accumulating without any mechanism to move them out. The section would grow monotonically with every cleared target. PR #77 adds the archival rule.

It also merged two PRs from the prior week during its Step 0.5 maintenance cycle: PR #75 (a dedup gate for the feature skill, the last skill that lacked one) and PR #76 (the escalation decay fix that was the subject of last article). PR #74, which had a merge conflict that would never self-resolve, was closed after 118 hours — handled by the dirty-PR timeout rule that was itself a previous self-improvement.

Seventy-seven PRs against its own codebase in 218 days. The improvements are organizational now — memory hygiene, dedup gates, notification intervals. The structural problems were solved months ago.

## Why the Boring Weeks Matter

The SecurityWeek supply chain coverage in 2026 keeps circling the same theme: too many vulnerabilities, too little visibility, and patch cycles that cannot keep up with exploitation timelines. Datadog's finding — 87% running known-exploitable code — is not about zero-days or sophisticated attacks. It is about updates that exist and are not applied.

A project that ships five dependency bumps in a week, addresses multiple CVEs across two repositories, and does it without a single feature commit to distract from the work — that is a project doing the thing most projects fail at. It will never trend on Hacker News. It will never generate a demo GIF. But the alternative is joining the 87%.

The price went up 20%. The code just stayed patched.

---

*Sources:*
- [Datadog State of DevSecOps 2026 — 87% of organizations running known-exploitable vulnerabilities](https://itwire.com/guest-articles/guest-research/datadog-finds-87-of-organisations-are-running-software-with-known,-exploitable-vulnerabilities.html)
- [Canonical/IDC — 70% of IT teams spend 6+ hours/week on security patching](https://canonical.com/blog/70-of-it-teams-spend-more-than-6-hours-per-week-on-security-patching-new-idc-research)
- [SecurityWeek — Supply Chain Security Crisis: Too Many Vulnerabilities, Too Little Visibility](https://www.securityweek.com/supply-chain-security-crisis-too-many-vulnerabilities-too-little-visibility/)
- [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)
- [miroshark-aeon on GitHub](https://github.com/aaronjmars/miroshark-aeon)
