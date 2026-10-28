*Repo Action Ideas — 2026-10-28*
Generated from analysis of aaronjmars/MiroShark (1,484 stars · 305 forks · 0 open issues · 113-day social silence · 16 stars to 1,500 milestone).

1. Custom Agent Roster Upload (Feature, Small)
   Lets callers seed simulations with named agents (name, profession, initial_stance, influence_weight) to run reproducible A/B experiments — overrides the demographic generator for specified slots while filling the rest normally.

2. Webhook Payload Filter Expressions (Feature, Small)
   A WEBHOOK_FILTER env var (JSON Logic expression) gates webhook delivery to only the signals that match — e.g. only fire when confidence_pct >= 70 AND direction = BULLISH. Pre-dispatch evaluation in the existing webhook service, no new endpoints.

3. CLI Tab Completion (DX, Small)
   Adds a `miroshark completions [bash|zsh|fish]` subcommand that outputs a shell completion script. Tab-completing `--platform` to Twitter/LinkedIn/Reddit removes the most common first-time user error. Under 200 lines.

4. Simulation Fine-Tuning Dataset Export (Feature, Small)
   GET /api/simulation/:id/export/finetune.jsonl returns the simulation as JSONL fine-tuning data (system: persona, user: topic + round context, assistant: actual post). Compatible with OpenAI, Anthropic, and Hugging Face fine-tuning formats — positions MiroShark as a synthetic dialogue data generator.

5. Simulation Round-by-Round Summary API (Feature, Small)
   GET /api/simulation/:id/rounds returns a structured summary of every completed round: direction, avg confidence, stance distribution, top posts, convergence delta. The single-call primitive for replay UIs and longitudinal charts without raw log parsing.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-10-28.md
