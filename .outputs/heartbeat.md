**Heartbeat 2026-06-10** — 4 skills missed today.

**New misses (not seen in last 48h):**
- `fetch-tweets` — scheduled 06:30 UTC, ~13h ago. Auto-dispatch failed (403 actions:read).
- `push-recap` — scheduled 15:00 UTC, ~4h ago. Auto-dispatch failed (403 actions:read).

**Recurring misses (already reported Jun 9):**
- `feature` — scheduled 11:00 UTC, ~8h ago. Dispatch failed (403).
- `repo-actions` — scheduled 14:00 UTC, ~5h ago. Dispatch failed (403).

Root cause: all auto-dispatch blocked by actions:read scope — fix requires updating aeon.yml permissions or messages.yml scheduler.

Memory flags: GH_GLOBAL unset (35 consecutive feature blocks); XAI_API_KEY absent; notification channels unconfigured.
