*Repo Action Ideas — 2026-10-12*
Generated from analysis of aaronjmars/MiroShark — ideas scoped for autonomous build by the feature skill.

1. GitHub Codespaces DevContainer Config (DX, Small)
   Adds .devcontainer/devcontainer.json with Neo4j service — turns 60-min setup into a 3-min click; directly targets the 304-forks / 0-PRs conversion gap.

2. Agent Demographic Stance Breakdown (Feature, Medium)
   GET /api/simulation/:id/subgroups returns final stance split by profession group, age bracket, and platform — turns '73% BULLISH' into 'crypto-native 91% / retail 44%'.

3. Consensus Convergence Round (Feature, Small)
   Adds convergence_round + consensus_stability to signal.json — the round at which ≥75% of agents first reached consensus, surfacing how contested a topic was throughout the run.

4. LLM Provider Fallback Chain (Integration, Medium)
   PROVIDER_FALLBACK_CHAIN env var routes retry traffic to the next provider on 429/5xx — prevents simulation failures from single-provider outages, natural follow-on to the Oct 10 LLM client hardening.

5. Post-Simulation Outcome Annotation (Feature, Small)
   POST /api/simulation/:id/annotations lets users record real-world outcomes after events resolve — closes the prediction/ground-truth feedback loop, no prior batch has touched this.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-10-12.md
