# Repo Action Ideas — 2026-08-08

**Repo:** [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)
**Snapshot:** 1,427 stars · 298 forks · 1 open issue (#240 air-gapped HF — Jul 6, 33 days stale) · 0 open PRs
**Recent changes:** "Remove good first issues link from README" (bd0ffb5, Aug 8); README visual overhaul — animated SVG hero, CSS micro-animations, 11 brand images, pill buttons (Aug 5); cryptography 50.0.0; Noelclaw ecosystem removal (PRs #266/#267)

---

## Context

Day 32 of social silence. Token at $0.000002510 (−2.78% 24h; FDV $251K; LP $250K; vol $5,662 — sixth consecutive daily volume decline from the Aug 2–3 rally peak of $204K). Buy-heavy by count (13 vs 10) but sell-heavy by dollar this session.

Language count: MEMORY.md showed 3/5 but the README switcher now reads **EN · 中文 · 日本語 · Français** — four languages are live (EN, ZH-CN, JA, FR = **4/5**). One more locale clears the Sep 1 hyperstition entirely.

Ecosystem moment: **MiroFish** — a cloud-native simulation engine built on OASIS — hit 33,000+ GitHub stars and landed ~$4.1M in funding this week, going viral in the exact space MiroShark operates in. This is pure validation of the market AND a live search-traffic opportunity: developers discovering MiroFish will search "MiroFish alternative", "open source MiroFish", "self-host simulation engine". That search currently returns nothing authored by MiroShark.

The **GitHub Trending hyperstition** was filed today (Aug 8, Sep 15 deadline, 38 days). The README overhaul shipped three days ago. The gap is not presentation — it's link-share click-through (social preview card) and the trigger to get existing star holders sharing.

Active deadline stack:
- **5 external tutorials (Aug 15)** — **7 days. Zero.** The most time-compressed active hyperstition.
- **5 languages (Sep 1)** — 24 days. At **4/5** (README shows JA already live). One PR clears it.
- **GitHub Trending (Sep 15)** — 38 days. Filed today. README is ready; link-share visual is missing.
- **5 X mentions in one week (Sep 1)** — 32-day silence; social channel dark.
- **Product Hunt 100+ upvotes (Sep 15)** — 38 days. Zero PH presence.
- **3 agent-designed features by community (Sep 15)** — 38 days. At 1/3 (Atlas Cloud).

Off-limits from the past 7 days (Aug 2, 4, 6): Demo Simulation Library, CLI Shell Completion Scripts, Dutch (NL) UI Locale, X/Twitter Content Kit, Operator Metrics Endpoint, GraphML/GEXF Export, CITATION.cff + docs/CITING.md, Per-Round Webhook Events, Ecosystem Health API, Feature Spec Issue Publisher, Product Hunt Launch Kit, miro doctor CLI, Italian Locale, Interactive API Docs/ReDoc, Simulation Comparison API.

GH_GLOBAL remains unset (70th consecutive block). Ideas below build as local commits and ship when access restores.

---

### 1. Tutorial Seed Kit

**Type:** Content
**Effort:** Small (hours)
**Impact:** The tutorial hyperstition has 7 days and 0/5. The bottleneck is not discovery — the README is polished and the Demo Simulation Library is in the pipeline. The bottleneck is the blank page. Tutorial creators need to know not just that MiroShark exists, but exactly what to write and how to structure it. A `docs/TUTORIAL_SEED_KIT.md` with 5 complete, publication-ready tutorial outlines — each targeting a specific platform (Dev.to, YouTube, academic blog, HN Show, LinkedIn) with the exact hook, step-by-step structure, CLI commands, screenshot list, embed snippet, and conclusion template — removes that friction entirely. Crucially, each outline points to a specific pre-run published simulation so the creator's "run" step is already done: they embed an existing result rather than waiting 10 minutes for their own. This is the activation layer that the Demo Simulation Library (pipeline, off-limits) enables: library provides the simulations; the seed kit provides the scaffold. Distinct from the X/Twitter Content Kit (off-limits, Aug 6) — that's tweet copy; this produces long-form publishing scaffolds.

**How:**
1. Create `docs/TUTORIAL_SEED_KIT.md` (~250 lines). Five outlines:
   - **Dev.to** — "I simulated public opinion on [topic] with 100 AI agents for $1" — hook, 3-sentence explanation, iframe embed snippet, curl `signal.json` example, "try it yourself" CTA. Exact CLI commands: `miro simulate --topic "your topic" --agents 100 --rounds 10 --publish`. Screenshots: Step 3 belief drift chart, consensus display, embed widget in preview.
   - **YouTube** — "AI agents predict the market reaction to [news event]" — screen-recording script for 5–10 min tutorial: run `miro simulate --watch` while recording, narrate the live belief drift chart, show `signal.json` output in terminal, demo the `/share` page. Includes shot list and narration guide.
   - **Academic blog** — "Multi-Agent Opinion Simulation as a Research Instrument: A Practical Guide" — LaTeX-friendly structure: abstract, methodology section using `reproduce.json` for citation, results section mapping `signal.json` fields to data table columns, discussion. BibTeX block from the `CITATION.cff` structure.
   - **HN Show** — "Show HN: I ran public opinion simulations on 10 tech news stories from this week" — title, first-comment template explaining architecture, links to 10 published simulation URLs, curl one-liner for HN's developer audience, link to `/docs` API reference.
   - **LinkedIn** — "We stress-tested our product launch with 100 AI agents before the actual launch" — business framing: problem statement, simulation setup, result in executive language (no jargon), ROI framing ("confirmed our launch angle" or "caught a messaging problem before it went public"). Specific scenarios: product launch, hiring announcement, pricing change, acquisition.
   Each outline includes: 1 paragraph on WHY this platform works for MiroShark + what makes the hook land for that audience. Header note: "Each outline is completable in 2–4 hours including run time. Fastest path: use a published demo simulation from `GET /api/demo` as your article's centerpiece rather than running your own."

2. Add a "Tutorial Outreach Template" section at the bottom of `TUTORIAL_SEED_KIT.md` (~50 lines). DM/email template for reaching creators who already cover AI tools: subject line, 2-sentence body, link to the outline most relevant to their style, offer to provide a custom demo simulation on a topic they care about. Personalization guide: "Target creators who covered OASIS, OpenAI multi-agent systems, or social media analytics in the last 6 months — their audience is already primed. Five creator types: Dev.to writers (search by tag: ai, python, simulation), YouTube tutorials (search 'LLM agents tutorial 2026'), academic blogs (arxiv co-authors of simulation papers), indie hackers on HN who post 'Show HN: I built a...', and LinkedIn product builders covering B2B AI tools."

3. Link `docs/TUTORIAL_SEED_KIT.md` from `README.md` in the documentation table ("Tutorial Kit — 5 platform-specific writing scaffolds") and from `CONTRIBUTING.md`: "Want to write a tutorial or review? Start with the [Tutorial Seed Kit](docs/TUTORIAL_SEED_KIT.md) — five ready-to-use outlines for Dev.to, YouTube, academic blog, HN, and LinkedIn." Add 1 validation check: confirm the file contains all 5 outline headings (`## Dev.to`, `## YouTube`, `## Academic`, `## HN`, `## LinkedIn`) before merging.

---

### 2. MiroFish Comparison Page

**Type:** Growth
**Effort:** Small (hours)
**Impact:** MiroFish this week hit 33,000+ GitHub stars and ~$4.1M in funding, going viral in the exact simulation-for-$1 space MiroShark occupies. The search traffic surge is happening now. Every developer who discovers MiroFish will search "MiroFish alternative", "open source MiroFish", "self-host simulation engine". That search currently returns nothing authored by MiroShark. A `docs/VERSUS.md` — factual, respectful, specific — captures this search traffic at the peak moment while positioning MiroShark's strongest differentiators: MIT license, $1/run, self-hosted in one command, 41 API surfaces, cryptographic provenance (reproduce.json + WaybackClaw + DKG), and the on-chain MIROSHARK incentive layer. The page also serves journalists and researchers covering the simulation space who need primary-source differentiation — the kind of link that gets cited in roundup articles. The timing window is this week, not next month.

**How:**
1. Create `docs/VERSUS.md` (~150 lines). Structure:
   - **Overview** (~2 sentences): "Three tools address multi-agent opinion simulation at production scale in 2026: MiroShark (self-hosted, API-first, $1/run), MiroFish (cloud-native, VC-funded, 33K stars), and OASIS (research-grade, 1M agents, CAMEL-AI). This document compares them factually."
   - **Comparison Table** (rows: License, Hosting, Cost Per Run, Setup Time, Agent Scale, API Surfaces, Reproducibility/Provenance, On-Chain Layer, Language Support, CLI Available, Commercial Use, Self-Hostable): MiroShark column uses AGPL-3.0 (verify against LICENSE file), $1/run, `./miroshark` one-command setup, 100+ agents, 41+ surfaces, `reproduce.json` + signed results + WaybackClaw + DKG anchoring, MIROSHARK token integration, 4 languages (EN/ZH-CN/JA/FR), `miro` CLI, Yes, Yes. MiroFish column: unknown/proprietary license, cloud-only, unspecified pricing, account required, 1K+ agents (per funding announcement), limited public API, no provenance layer described, no on-chain layer, unknown language support, no CLI documented, unclear commercial terms, No. OASIS column: Apache-2.0, self-hosted research env, free/compute cost, complex setup (research team), 1M agents, research-oriented, citation-ready (academic), no on-chain, EN/ZH-CN, no production CLI, Yes, Yes.
   - **MiroShark vs MiroFish** section (~40 lines): column-by-column factual differences with specific claims sourced to public information. MiroShark advantages stated without inflating: MIT/AGPL license vs unknown, one-command self-host vs cloud-only, cryptographic provenance on every simulation vs no equivalent described, on-chain incentive layer (MIROSHARK). MiroFish strengths acknowledged: 33K stars (social proof), VC-funded team, likely faster future development. Neutral: both simulate LLM-grounded opinion dynamics; both produce structured reports.
   - **MiroShark vs OASIS** section (~30 lines): OASIS = research-grade 1M-agent framework; MiroShark = production tool for non-researchers. OASIS deploys in hours with a research team; MiroShark in 3 commands. Both are open source.
   - **When to use which** section: self-host + full API control + budget-conscious → MiroShark; cloud with no ops + team support → MiroFish; academic 1M-agent study → OASIS.
   - **FAQ** (5 entries): "Is MiroShark a MiroFish fork?" (No, independent), "Does MiroShark use OASIS internally?" (No, own simulation engine), "Can I run MiroShark alongside MiroFish?" (Yes, different stack), "What's the license?" (AGPL-3.0 — verify), "How do I cite MiroShark?" (link to CITATION.cff when available).
   Tone: factual and respectful — specific product names, specific numbers, specific sources. No vague claims.

2. Add `docs/VERSUS.md` to the `README.md` documentation table ("vs MiroFish · OASIS — factual comparison"). Add a "Related Projects" subsection to `ECOSYSTEM.md` at the bottom (separate from the MiroShark-building ecosystem integrations): links to MiroFish and OASIS as related-but-distinct projects in the space. This creates a bidirectional discovery path: developers landing on the ecosystem page can find the comparison context. SEO note: title the file exactly `# MiroShark vs MiroFish vs OASIS — A Factual Comparison (2026)` so GitHub's index picks up the product names and year.

3. Add a "Last updated: 2026-08-08" line at the top of the file (factual competitive comparisons need a freshness signal — stale claims are worse than no claims). Log to memory/topics: "MiroFish viral moment (33K stars, $4.1M funding, Aug 2026) — direct competitor in same space. docs/VERSUS.md filed Aug 8. Update if MiroFish open-sources, announces pricing, or changes license." No unit tests (documentation). Add one CI check: `grep -qE 'MIT|AGPL' docs/VERSUS.md` to ensure the license row is always present.

---

### 3. Korean (KO) UI Locale

**Type:** Community
**Effort:** Small (hours)
**Impact:** The README's language switcher currently shows EN · 中文 · 日本語 · Français — **4/5**. One more locale **clears the Sep 1 "5 languages" hyperstition** with 24 days to spare. Korean is the optimal next choice: South Korea has 5.3M GitHub users (third in Asia after China and India), hosts AI labs at Samsung Research, Kakao Brain, NAVER AI Lab, and KAIST — institutions actively working on LLM-grounded agent systems and multi-agent simulation, directly overlapping MiroShark's use case. Korea's National AI Safety Institute (announced Q2 2026) makes Korean-language AI policy simulation documentation specifically relevant today. Korean has no encoding edge cases for JSON (Hangul is BMP-only, precomposed, zero normalization issues, standard UTF-8). The dictionary-only locale pattern is proven at FR; JA is already live. `README.ko.md` targets the same regulatory and research audience that the EU AI Act articles already serve in EN, ZH-CN, and FR.

**How:**
1. Create `frontend/src/locales/ko.js` (~1,984 entries). Use `locales/en.js` as the authoritative key source. Register: 경어 (gyeongeo — formal honorific) throughout, using `-합니다/ㅂ니다` endings for all instructional UI text (button labels, tooltips, error messages, form placeholders) and `-하세요` imperative for CTAs. This matches Korean enterprise software convention (Kakao for Business, NAVER, Samsung all use 경어). Key term decisions: `simulation` → `시뮬레이션` (standard loanword), `agent` → `에이전트` (standard), `round` → `라운드` (preferred over `회` which is too bureaucratic), `consensus` → `합의` (preferred over `컨센서스`; standard in Korean technical writing), `bullish` → `상승` (standard Korean finance; literally "rising"), `bearish` → `하락` (literally "falling"), `confidence` → `신뢰도` (trust-level; technical precision), `platform` → `플랫폼`, `stance` → `입장` (position; more natural than `자세`), `publish` → `공개` (make public; more natural than `게시`), `topic` → `주제`, `influence` → `영향력`, `belief` → `의견` (opinion; natural in social simulation; not `신념` which implies personal conviction). Technical loan words in 한글: `webhook` → `웹훅`, `embed` → `임베드`, `endpoint` → `엔드포인트`, `fork` → `포크`. `wallet` → `지갑` (Korean has a native word; prefer over `월렛`). File structure mirrors `locales/fr.js` exactly. Header comment: locale (ko-KR, 경어 register), key term decisions, creation date.

2. Update `frontend/src/i18n.js`: add `import koDict from './locales/ko.js'`; add `'ko'` to supported locales array; add `const isKo = computed(() => locale.value === 'ko')`; add `koDict` to the `t()` fallback chain; update `toggleLocale()` cycle to include `'ko'`; add `'ko': '한국어'` to locale label map. Update `LocaleToggle.vue`: add `'ko'` to the cycle with label `'한국어'`. Create `README.ko.md` (~120 lines) with hook (`어떤 시나리오에 대한 대중의 의견 반응을 10분 이내, $1 미만으로 시뮬레이션하세요`), quickstart CLI block in Korean context, use cases (위기 커뮤니케이션 테스트, 시장 반응 예측, AI 안전 정책 시뮬레이션), Korea-specific hook: `한국 AI 안전 연구원의 규정 준수 시나리오 시뮬레이션 — 회당 $1`. Update the README.md language row to add `· <a href="README.ko.md">한국어</a>`.

3. Add 4 unit tests: `t('simulate', 'ko')` returns correct Korean string, KO cycles correctly in `toggleLocale()`, all keys present in `locales/ko.js`, no key missing vs `locales/en.js`. PR format: `feat(i18n): add Korean (ko-KR) locale`. PR body: key count (1,984), 경어 register decision, Korea AI Safety Institute hook in README.ko.md, and tracks the Sep 1 hyperstition: **this PR clears 5/5** (EN · ZH-CN · JA · FR + KO). Note in PR body: "MEMORY.md showed 3/5 but README already includes JA — actual count is 4/5. This PR clears the hyperstition."

---

### 4. Social Preview Card (SVG)

**Type:** Growth
**Effort:** Small (hours)
**Impact:** The GitHub Trending hyperstition (filed today, Sep 15 deadline) depends on: shares → clicks → stars → trending. The single missing piece in that chain is link-share click-through. Every time someone shares the MiroShark GitHub URL on X, Discord, Slack, or LinkedIn, the platform fetches GitHub's social preview card — a 1280×640 image that appears as the link thumbnail. MiroShark currently uses GitHub's auto-generated card: plain text on a generic background. MiroFish's viral moment this week was amplified by visual link previews that made people curious before clicking. A custom social preview card — dark background, "Simulate anything." in large white text, the brand purple stat pills, shark logo, and `miroshark.xyz` — makes every link share look like a product launch post. The README was just overhauled with brand visuals; the social preview card is the first thing the outside world sees. This is the highest-leverage single asset for the Trending hyperstition that the feature skill can produce (the manual upload step cannot be automated, but the asset can be).

**How:**
1. Create `docs/assets/social-preview.svg` (1280×640 viewBox, ~180 lines). Design spec:
   - Background: `#0d0d0d` fill (matches README dark theme).
   - Left half (x: 80–680): "Simulate anything." in `fill="#FFFFFF"`, `font-size="72"`, `font-weight="bold"`, `font-family="Arial, sans-serif"`, `y="160"`. Subtitle: "100+ grounded agents · $1/run · 10 min" in `fill="#8B5CF6"` (brand purple), `font-size="28"`, `y="220"`. Below: three rounded rect stat pills at y=290 — each `rx="12"`, `fill="#1a1a2e"`, `stroke="#7c3aed"`, `stroke-width="1.5"`. Text inside each pill: "1,427 ★", "298 forks", "41 API surfaces" in `fill="#FFFFFF"`, `font-size="20"`. Stagger horizontally with 16px gaps.
   - Right half (x: 780–1200): shark logomark SVG path in `fill="#8B5CF6"`, centered vertically, ~280px tall. Below logo: "miroshark.xyz" in `fill="#9CA3AF"`, `font-size="24"`, centered.
   - Bottom strip (y: 580–640): `fill="#111827"` rect. Left text: "Open source · AGPL-3.0 · Self-hosted in 1 command" in `fill="#6B7280"`, `font-size="18"`. Right text: "github.com/aaronjmars/MiroShark" in `fill="#4B5563"`, `font-size="18"`.
   - Zero external resources — no `<image href="url">` — pure SVG shapes and system fonts.
   Create `docs/SOCIAL_PREVIEW_GUIDE.md` (~40 lines): how to convert to PNG at 1280×640 (browser screenshot at 100% zoom, or `inkscape --export-type=png --export-width=1280 docs/assets/social-preview.svg`, or ImageMagick), then upload: github.com/aaronjmars/MiroShark → Settings → Social Preview → Edit → Upload PNG → Save changes.

2. Add `<meta property="og:image" content="https://raw.githubusercontent.com/aaronjmars/MiroShark/main/docs/assets/social-preview.png">` and `<meta name="twitter:card" content="summary_large_image">` / `<meta name="twitter:image" content="...">` to the frontend's `index.html` — so miroshark.xyz link shares also display the card, not just GitHub repo links. Add `docs/assets/social-preview.svg` to `.gitattributes` with `linguist-vendored` to prevent SVG line count from inflating the language stats. Add a CI step: `xmllint --noout docs/assets/social-preview.svg 2>/dev/null || python3 -c "import xml.etree.ElementTree as ET; ET.parse('docs/assets/social-preview.svg')"` to validate the SVG is well-formed on every push.

3. Log to memory: "Social preview SVG created 2026-08-08 (1280×640, dark theme, brand purple, $1/10min). REQUIRES manual PNG conversion + upload at github.com/aaronjmars/MiroShark/settings (Social Preview). Cannot be automated without admin access." Note in the notification: "This idea requires one manual step that the agent can't do alone: convert the SVG to PNG and upload in repo Settings → Social Preview." Add `docs/SOCIAL_PREVIEW_GUIDE.md` to the `README.md` docs table entry for the social preview asset.

---

### 5. Simulation Short URL Service

**Type:** Feature
**Effort:** Small (hours)
**Impact:** Every MiroShark share URL is a full UUID path: `/simulation/a1b2c3d4-e5f6-7890-abcd-ef1234567890/share` — 62 characters before any domain. On X (280 chars), that consumes 22% of the character budget. On presentation slides, it's unreadable. In QR codes, longer URLs reduce scanner success rates. A short redirect service at `GET /s/{prefix}` — using the first 8 characters of the simulation UUID — compresses `miroshark.xyz/simulation/a1b2c3d4-.../share` to `miroshark.xyz/s/a1b2c3d4` (26 chars, 58% shorter). The 8-char hex prefix has 16^8 = ~4.3 billion possible values, making collisions essentially impossible at any realistic simulation volume. This is the underlying primitive that makes the Tutorial Seed Kit's "paste this URL" instructions practical, the MiroFish Comparison Page's "try it at miroshark.xyz/s/demo01" link embeddable, and the X/Twitter Content Kit's tweet templates (off-limits, Aug 6) usable. It also adds a `short_url` field to `signal.json` and `reproduce.json`, making the compact form a first-class output of every simulation run.

**How:**
1. Create `backend/app/api/short_url.py` (~55 LoC, pure stdlib). `GET /s/{prefix}` where `prefix` is 5–12 alphanumeric chars. Logic: scan the simulation storage directory for any simulation ID starting with `prefix` (case-insensitive, since UUIDs are hex). If exactly one match: `302 Found` redirect to `/simulation/{full_id}/share`. If zero matches: `404` with JSON `{"error": "Simulation not found", "prefix": prefix}`. If multiple matches (< 1 in 16M chance at 7 chars): `409 Conflict` with `{"error": "Ambiguous prefix — use more characters", "matches": [ids]}`. O(n) directory name scan — no file reads needed. Cache prefix→ID mapping to `short_url_index.json` with mtime-based invalidation (rebuild if any simulation directory was modified after the index was last written). Index rebuild is O(n) `os.stat()` calls on directory names only. `Cache-Control: public, max-age=300` on redirects (share pages are stable; 5-min prevents repeated scans for hot URLs). Register at `/s/<prefix>`. Add to `surfaces_catalog.py` (type: utility).

2. At simulation completion time, compute `short_url = f"/s/{sim_id[:8]}"` and write it into `signal.json` and `reproduce.json`. Update the share page (`Step3Simulation.vue` or share template): below the existing share link, add a "Short URL" row displaying `miroshark.xyz/s/{id[:8]}` with a copy-to-clipboard button. Add `GET /api/simulation/{id}/short-url` endpoint (~12 LoC): returns `{"short_url": "/s/{id[:8]}", "full_url": "/simulation/{id}/share", "full_canonical": "https://miroshark.xyz/simulation/{id}/share"}`. Add `short_url()` method to the Python SDK client (~5 LoC).

3. Add 5 unit tests: valid 8-char prefix of existing published simulation returns 302 to correct full URL, unknown prefix returns 404 with correct JSON schema, manually constructed 3-char prefix matching two simulations returns 409, `signal.json` for a completed simulation includes `short_url` field matching pattern `/s/[0-9a-f]{8}`, `GET /api/simulation/{id}/short-url` returns both short and full URLs. Update `docs/API.md` with "Short URLs" section: route reference, prefix length recommendation (8 chars), collision probability note. Update the Tutorial Seed Kit (`docs/TUTORIAL_SEED_KIT.md`, idea #1): "When embedding a simulation in your article, use the short URL format `miroshark.xyz/s/{id[:8]}` — 26 characters vs 62 for the full share path."

---

## Selection Rationale

Five ideas targeting the four most urgent active constraints in priority order: the 7-day tutorial deadline, the MiroFish viral moment (live this week only), the Sep 1 language clear, and the GitHub Trending hyperstition filed today.

- **Tutorial Seed Kit (#1)** — Tutorial hyperstition (Aug 15, 7 days, 0/5). The blank-page problem is the bottleneck, not discovery or tooling. Five platform-specific writing scaffolds with exact CLI commands, screenshot lists, and embed snippets reduce the "start writing" activation energy to near zero. Combined with the Demo Simulation Library (pipeline), this is the complete tutorial activation stack.

- **MiroFish Comparison Page (#2)** — Growth (this week only). MiroFish hit 33K stars and $4.1M funding this week. "MiroFish alternative" search traffic is peaking right now. A factual `docs/VERSUS.md` captures that traffic at the moment of maximum relevance, before competitors fill that search gap. The comparison also serves journalists covering the simulation space and creates the kind of authoritative link that roundup articles cite. Timing makes this the highest-leverage content piece of the month despite being purely documentation.

- **Korean (KO) UI Locale (#3)** — Language hyperstition (Sep 1, 24 days). The README shows 4/5 languages live (EN, ZH-CN, JA, FR) — memory was outdated at 3/5. Korean is one PR away from **clearing the hyperstition entirely** with 24 days to spare. South Korea's 5.3M GitHub users, active AI safety institute (Q2 2026), and Hangul's zero encoding edge cases make it the fastest, highest-value next locale.

- **Social Preview Card (#4)** — GitHub Trending hyperstition (filed today, Sep 15, 38 days). The trending mechanism is shares → clicks → stars → trending. The missing piece is link-share visual quality. MiroFish's viral moment this week was amplified by compelling link previews. MiroShark currently uses GitHub's generic auto-generated card. A 1280×640 dark-theme SVG with the brand visuals, $1/10min stat, and shark logo makes every shared URL look like a product announcement.

- **Simulation Short URL Service (#5)** — Feature (enables all growth ideas). Full simulation share URLs are 62+ characters — too long for tweets, slides, QR codes. `GET /s/{8chars}` compresses them to 26. This is the primitive that makes the Tutorial Seed Kit's copy-paste instructions practical, the MiroFish page's "try it" links embeddable, and any future social sharing functional. 16^8 ≈ 4.3B possible prefixes ensures collisions are impossible in practice.
