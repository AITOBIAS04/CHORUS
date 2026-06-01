*Feature Built — 2026-06-01*

Deployment Health & Status Endpoint
MiroShark deployments now have a proper health check and status page. Cloud Run, Fly.io, Railway, Docker Compose, and uptime monitors (UptimeRobot, Betterstack, StatusCake) can all point at /api/health and get a fast, structured response telling them whether the service is healthy or degraded — with subsystem detail, uptime, and recent simulation activity. Operators and users get a clean /status page showing the same data in a visual dashboard.

Why this matters:
Cloud Run deploy infra shipped last week (cloudbuild.yaml + deploy script), but without a health check endpoint, Cloud Run cannot perform liveness probes and will restart the service unnecessarily during cold starts. No uptime monitor could alert on outages. For any operator self-hosting MiroShark on Cloud Run, Fly.io, or Railway, this was the missing standard ops primitive — the one that should ship within 72 hours of any new deployment target. The /status page gives operators a clean URL to link from their README or share in a Slack channel when users ask "is it down?"

What was built:
- backend/app/services/health\_service.py: Three fast subsystem checks (filesystem readability, simulation directory writability, Python version), uptime computed from a startup timestamp file written at Flask init, recent simulation count via scandir mtime. All complete in under 50ms — no sim scanning, no database calls, no LLM.
- backend/app/api/health.py: Two endpoints — GET /api/health (returns 200 on ok, 503 on degraded) and GET /api/health/status (same payload, always 200). Both public, cached 30 seconds. Exempt from internal auth guard.
- frontend/src/views/StatusView.vue: Dark-themed /status page with large operational/degraded indicator, 4 metric cards (uptime, simulations 24h, storage health, Python version), subsystem check rows with pass/fail dots. Auto-refreshes every 60 seconds.
- backend/tests/test\_unit\_health.py: 16 unit tests covering ok/degraded states, startup timestamp creation, uptime computation, simulation counting, route declarations, auth exemption, and OpenAPI spec presence.

How it works:
On app startup, create\_app() writes a startup\_timestamp.json to the simulation data directory. When /api/health is called, health\_service.py runs three fast filesystem checks: can we list the data directory (filesystem), can we write to it (simulation\_dir\_writable), and what Python version is running. It reads the startup timestamp to compute uptime\_seconds, and does a quick scandir pass to count simulation directories modified in the last 24 hours. If any check fails, status is "degraded" and /api/health returns 503. The /status alias always returns 200 for dashboards that poll without caring about HTTP codes. The frontend StatusView calls the status endpoint on mount and every 60 seconds, rendering the results in a dark-themed card layout matching the new space-violet design system.

What is next:
Could add Neo4j connectivity check, LLM provider reachability, and disk usage metrics in a future iteration. The /status page could also serve as the foundation for an admin dashboard.

PR: blocked — GH\_GLOBAL secret not set (28th consecutive build blocked from push)
