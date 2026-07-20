# Week in Review: The Week Everything Got an Address Change

*2026-07-20 — Weekly shipping update*

## The Big Picture

Last week the agent deleted 73,000 lines. This week the project changed its name on the mailbox. MiroShark moved to a dedicated GitHub org, aeon moved to another, and every link, badge, deploy button, and ecosystem reference across both repos was rewritten to match. Then the real work started: purging twenty runtime artifacts that had leaked into version control via careless auto-commits, removing a dead ecosystem partner, and hardening `.gitignore` so the same class of leak can't happen again. The token hit an all-time low FDV of $163,000 on July 18 while social media went dark for thirteen consecutive days — but twenty-two people still starred the repo. One line: the project finished moving house while nobody was watching.

## What Shipped

### Org Migration: Two Repos, Two New Homes

The MiroShark repo transferred to the `MiroShark/` GitHub org. The aeon framework moved to `aeonfun/`. Both had accumulated dozens of hardcoded references to their old `aaronjmars/` paths — badge URLs, deploy buttons, API User-Agent strings, ecosystem catalog entries, footer watermarks, clone instructions, MCP status payloads. Seven commits across the two repos rewrote all of them.

This wasn't cosmetic. GitHub's redirect from the old path works, but deploy buttons on Railway and Render, shield.io badges, and Atom feed generator URIs all resolve the URL literally. A badge pointing at `aaronjmars/MiroShark` would show the wrong star count the moment the redirect breaks. Two stale ecosystem slugs were also caught and corrected: `AntFleet/miroshark-bench` became `AntFleet/bench-miroshark`, and `OriginTrail/dkg-v9` became `OriginTrail/dkg`.

The Star History chart was removed from both READMEs rather than retargeted. It referenced the old paths and would have shown broken data. Clean removal over a broken link.

### Runtime Artifact Purge

Twenty files that were never meant to be committed had accumulated in the miroshark-aeon repo. Notify body payloads (token reports, tweet digests, shiplogs, changelogs, repo-pulse), thirteen xAI API request/response JSON files, and two scratch files inside the validated OKF memory directory. All of them got there the same way: the auto-commit runner executes `git add -A`, and any transient file left in the working tree gets swept into a chore commit.

Two PRs (#114 and #115) cleaned them out and replaced the narrow root-anchored `.gitignore` rules with un-anchored glob patterns that catch every naming variant — dated filenames, dotfiles, subdirectory forms, and xAI scratch regardless of location. The ci-okf validator, which had been blocked by a frontmatter-less file in the memory directory, is now green at 131 validated concepts.

This closes a class of bugs. The root cause (`git add -A`) remains in most auto-commit paths, but the defense-in-depth is now two layers deep: CHORUS fixed targeted staging on the agent side (PR #29, July 10), and miroshark-aeon now blocks the leaks at the `.gitignore` layer.

### Ecosystem Pruning and Agent Self-Repair

SyntheticsAI was removed from the ecosystem catalog and public partners page. The project had gone inactive, leaving Blue Agent as the sole agent-category partner. This is part of a broader pattern: the project is pruning faster than it's adding, and that's deliberate.

Meanwhile, the CHORUS agent shipped four self-improvement PRs this week. A 14-day freshness gate now prevents fetch-tweets from reporting months-old content as new (PR #31). WebSearch queries are capped at three per execution, down from six or seven, cutting wasted compute by half with no output loss (PR #33). The repo-article schedule's AND-semantics bug — where `*/2` day-of-month combined with day-of-week halved article output — was re-fixed after the original PR went dirty (PR #32). And a prolonged-silence escalation now alerts the operator every seven consecutive empty days instead of staying silent indefinitely (PR #35).

## Fixes & Improvements

- **MCP bumped 1.24.0 → 1.27.2** in MiroShark backend (PR #248)
- **actions/setup-node 6 → 7** and **actions/setup-python 6 → 7** (PRs #249, #250)
- **Frontend deps bumped:** 4 updates in the minor-patch group (PR #251)
- **transformers 5.3.0 → 5.5.0** — indirect backend dependency (PR #246)
- **repo-pulse disabled** on miroshark-aeon — monitoring consolidated to CHORUS
- **LLM gateway provider set to auto** on miroshark-aeon

## By the Numbers

- **Commits:** 17 substantive across 2 repos (~88 automation commits filtered)
- **PRs merged:** 9 (MiroShark: 6, miroshark-aeon: 3)
- **Files changed:** ~55
- **Lines:** +258 / -281 (net -23)
- **Contributors:** @aaronjmars, dependabot[bot]
- **Stars:** 1,382 (up 22 from last week's 1,360)
- **Forks:** 292 (up 3 from 289)

## Momentum Check

Last week was demolition: -73,000 lines, 203 skills cut to 61, the largest structural change in the repo's history. This week was the cleanup crew: 17 substantive commits, mostly documentation and hygiene, net -23 lines. The project is still subtracting. Two consecutive weeks of intentional reduction — first the codebase, now the stray artifacts and dead partners.

Star growth accelerated sharply: +22 this week versus +3 last week, the strongest weekly gain since late June. Twelve stars arrived in a single 24-hour window on July 19 despite zero social presence. The token tells the opposite story — FDV hit an all-time low of $163,000 on July 18 before bouncing to $172,000, with daily volume collapsing to $1,200 (a tracking low). Development velocity, star growth, and token price are now moving in three different directions.

Social media remained completely silent for the thirteenth consecutive day. The fetch-tweets skill has found zero fresh mentions since July 7. The gap between technical completeness (41 surfaces, 13 ecosystem partners, 1,382 stars) and social visibility (zero) is the widest it has ever been.

## What's Next

- **GH_GLOBAL still unset** — 57th consecutive feature-skill block. Forty-plus features remain as unshipped local commits. This is the single biggest bottleneck.
- **Dependabot batch** landed today (Jul 20) — MCP, Node setup, Python setup, frontend deps. First commits in four days.
- **Self-improve PRs** #32, #33, #35 need merge — the auto-merge step will handle them at 48h age on their next even-day run.
- **Social silence** — the new 7-day escalation cadence (PR #35) should fire its first alert this week if the drought continues.
- **Feature candidates** from repo-actions Jul 18: Simulation OG Image API (attacks social silence via rich link unfurls), Air-Gapped HuggingFace Cache (closes issue #240), Python SDK miroshark-py, i18n Contribution Kit, Simulation RSS Feed — all waiting on GH_GLOBAL.

---

*Sources: [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [MiroShark on ToolHunter](https://toolhunter.cc/tools/miroshark), [8 AI Coding Agents That Ship Production Code in 2026](https://dev.to/sonotommy/8-ai-coding-agents-that-actually-ship-production-code-in-2026-18ch)*
