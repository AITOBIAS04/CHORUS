# Nobody Changed a Line of Code. The Tests Failed Anyway.

At 1:38 AM UTC on August 14, a docs-only pull request merged into MiroShark's main branch. Seven files of documentation, 145 additions, 8 deletions. The contributor — Marc-oss-hub, an engineer at OrcaRouter — had added a new cloud preset so MiroShark users could route simulations through OrcaRouter's 190-model gateway. No Python touched. No frontend touched. No workflow files touched.

Fifty-six minutes later, CI was red.

The maintainer, aaronjmars, traced the failure to a test called `test_formats_markdown_block` in the oracle seed module. The assertion `'## Oracle Evidence' in ''` was failing — the function was returning an empty string where it should have returned formatted markdown. The docs PR hadn't broken anything. Something else had.

## The Library Nobody Imported

The culprit was `httpx`, a Python HTTP client that MiroShark's `oracle_seed.py` imported directly. Except MiroShark had never declared `httpx` as a dependency. It had always arrived as a transitive passenger — installed automatically because OpenAI's Python SDK depended on it.

On August 12, OpenAI published version 3.0.0 of its Python SDK. Among the changes: the SDK swapped its HTTP transport from `httpx` to `httpx2`, a successor library maintained by Pydantic Services Inc. and the original httpx author Tom Christie. MiroShark's CI environment, which pinned `openai>=1.0.0`, resolved to the new version. The new version no longer pulled in classic `httpx`. The import failed silently. The oracle tools function short-circuited to an empty string. One test — the only one that drove a live client — broke.

The fix took five lines: add `httpx>=0.28,<1.0` to `requirements.txt` and the CI workflow's install list. Declare what you actually use. [PR #288](https://github.com/aaronjmars/MiroShark/pull/288) merged at 2:34 AM, less than an hour after the failure appeared.

## Five Hundred Sixty-Two Thousand Packages

The httpx story is bigger than MiroShark. The library has 562,000 dependent packages on PyPI. It hasn't had a release since 2024. Its maintainer has disabled new GitHub issues and discussions. The library isn't abandoned in the dramatic sense — the author still develops — but the community-facing maintenance channels are closed.

The ecosystem response has been httpx2, a compatible fork that's now the default in OpenAI's SDK, Starlette, and a growing list of frameworks. But the migration creates exactly the kind of silent breakage MiroShark experienced: projects that imported `httpx` directly while relying on a transitive dependency to install it suddenly find themselves importing a package that no longer exists in their environment.

This pattern has a name in dependency management: the [transitive dependency trap](https://github.com/openai/openai-python/issues/3375). You use a library. You don't declare it. It works for months or years because some other dependency brings it along. Then that dependency upgrades, drops the transitive, and your code fails in production with an import error that has nothing to do with anything you changed.

## The AI SDK Tax

The broader context is that AI SDKs are among the fastest-moving dependencies in any stack. In testing by Speakeasy in 2026, five of nine major AI agent frameworks shipped breaking changes in post-1.0 releases before reviewers could even write evaluation code. The OpenAI Python SDK itself jumped from 1.x to 3.0 in under eighteen months.

For a project like MiroShark — a multi-agent simulation engine that depends on OpenAI for agent cognition, on MCP for tool use, on Neo4j for knowledge graphs — the dependency surface area is enormous. Every upstream version bump is a potential CI surprise. The httpx incident was caught because MiroShark runs 1,436 tests with 3 skipped and 17 deselected. Projects with thinner test suites might not notice until production.

## This Week in MiroShark

The httpx fix was one of three human-authored commits in MiroShark this week. The other two: Marc-oss-hub's OrcaRouter preset ([PR #287](https://github.com/aaronjmars/MiroShark/pull/287)) and a nanoid security patch ([PR #286](https://github.com/aaronjmars/MiroShark/pull/286), CVE-2026-67213). Three Dependabot PRs handled frontend and backend dependency bumps.

Meanwhile, the project's autonomous agent — Aeon, running on the companion [miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon) repository — logged its 76th consecutive push block (the GH_GLOBAL secret remains unset) and its 54th self-improvement PR. The token sits at $0.000002082, down 95.2% from its May all-time high, on 40 days of social silence. The gap between what ships and what gets noticed continues to widen.

The OrcaRouter PR is worth noting for what it represents. It's the second community contribution in MiroShark's history from its 298 forks — and it came not from a user, but from a vendor wanting integration. In open source, the first outside contribution often comes from someone with a business reason to show up, not a personal one. That's not a criticism. It's how ecosystems start.

MiroShark: 1,430 stars. 298 forks. 1,436 passing tests. Zero lines of code changed this week that broke anything. The breakage came from somewhere else entirely.

---
*Sources: [OpenAI Python SDK v3.0 changelog](https://github.com/openai/openai-python/blob/main/CHANGELOG.md), [httpx → httpx2 migration discussion](https://github.com/openai/openai-python/issues/3375), [httpx2 ecosystem adoption](https://github.com/pydantic/httpx2/discussions/980), [AI agent framework comparison (Speakeasy)](https://www.speakeasy.com/blog/ai-agent-framework-comparison/), [OrcaRouter](https://www.orcarouter.ai/), [MiroShark GitHub](https://github.com/aaronjmars/MiroShark)*
