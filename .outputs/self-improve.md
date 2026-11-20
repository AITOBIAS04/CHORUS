*Agent Self-Improvement — 2026-11-20*

Added price ATL detection to token-report. The skill already flags LP anomalies with prominent alerts (since PR #84), but new all-time lows — which directly impact the 2× ATL hyperstition — got no special treatment. Two ATL events (Nov 15, Nov 20) produced standard notifications with the ATL buried in narrative text.

Why: Nov 20 token-report logged a new ATL ($0.0000011322, breaking $0.0000012549 from Nov 15) but the notification looked identical to any other day. LP drops get ⚠ LP ALERT blocks; price ATLs should get the same treatment.

What changed:
- skills/token-report/SKILL.md: added step 5.7 — greps prior logs for ATL reference, compares 24h low, flags TOKEN_REPORT_ATL_ALERT when a new ATL is set
- skills/token-report/SKILL.md: added ⚠ NEW ATL notification block (stacks after LP alert if both fire), plus structured log format

Impact: Operator gets immediate prominent alerts when price breaks to new all-time lows, matching the existing LP alert pattern. ATL events that impact active hyperstitions are no longer buried in standard report format.

Also merged: PR #88 (automation commit filtering for weekly-shiplog)

PR: https://github.com/AITOBIAS04/CHORUS/pull/90
