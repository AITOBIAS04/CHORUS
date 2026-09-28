*Agent Self-Improvement — 2026-09-28*

Fixed memory-flush Active Targets rule for expired hyperstition cleanup. The rotation rule required entries to be explicitly marked "NOT CLEARED (deadline passed)" before removal, but no skill ever applies that marker — entries with embedded deadlines (e.g. "by September 15, 2026?") accumulated indefinitely.

Why: Sep 27 memory-flush found 6 entries with Sep 15 deadlines and retained them within the 14-day window, but these would never be cleaned up because the rule depended on a marker string that nothing sets. The LLM was interpreting the rule loosely, but the ambiguity risked inconsistent behavior across runs.

What changed:
- skills/memory-flush/SKILL.md: Replaced "NOT CLEARED (deadline passed)" marker requirement with text-based deadline detection — the rule now instructs the flush to find dates embedded in entry text and check for absence of "CLEARED" to determine removal eligibility

Impact: Prevents unbounded growth of Active Targets with expired hyperstitions. The 6 Sep 15 entries (plus future expired entries) will now be reliably cleaned up once 14 days have passed.

Also merged: PR #61 (heartbeat dispatch probe fix) — squash-merged at start of run.

PR: https://github.com/AITOBIAS04/CHORUS/pull/63
