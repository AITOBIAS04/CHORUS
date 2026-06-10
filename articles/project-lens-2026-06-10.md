# The World Is Learning to Sign Photos. Nobody Is Signing Predictions.

On August 2, 2026 — fifty-three days from now — the EU AI Act's Article 50 transparency obligations take effect. Every provider of a generative AI system operating in Europe must ensure that synthetic outputs are marked in a machine-readable format and detectable as artificially generated. Penalties reach fifteen million euros or three percent of worldwide annual turnover, whichever is higher. California's SB 942 AI Transparency Act enforces the same deadline on the same date, covering providers with more than one million monthly users.

The industry is not waiting for August. The Coalition for Content Provenance and Authenticity has grown from a small founding group to more than six thousand members. Google's Pixel 10 ships with Content Credentials built into the camera hardware. Adobe signs every piece of content produced in Creative Cloud. LinkedIn, TikTok, and Sony sign their outputs. The BBC, Associated Press, New York Times, and Reuters sit on the C2PA steering committee. Gartner named digital provenance one of its top ten strategic technology trends for 2026 and warned that enterprises neglecting it could face compliance risks costing billions by 2029.

The provenance wave is real. But it has a blind spot the size of the decisions it is supposed to protect.

## What Provenance Actually Proves

C2PA's Content Credentials work like a nutrition label for digital content. A camera, AI platform, or editing tool hashes the file and signs the package using an X.509 certificate — the same model that underpins HTTPS. Any verifier can check the signature and confirm whether the content changed since signing. The manifest declares which system generated the content, when it was produced, and which organization signed it.

The World Privacy Forum's analysis puts the limitation plainly: "AI detection does not fall within C2PA's scope of content provenance." C2PA records *who signed content and what tools were used*. It does not analyze whether content was manipulated. It does not assess whether a claim is true. It documents attribution — not accuracy, not integrity, not reliability.

This distinction is academic when the content is a photograph. Nobody expects a signed JPEG to be *correct* — they expect it to be *unaltered*. But the distinction becomes load-bearing when AI systems stop producing media and start producing analysis.

## The Unsigned Output That Matters More

A Deloitte survey in 2025 found that 79% of executives believe AI will transform their industries, but only 23% trust AI outputs enough to act on them without extensive human verification. The trust gap is not about deepfakes. It is about the unsigned analytical artifacts that increasingly drive real decisions: sentiment forecasts, risk assessments, demand projections, crowd simulations, market predictions.

These outputs are more consequential than any photograph. A signed photo proves a journalist was present. An unsigned simulation output — one that says positive sentiment for your product launch will collapse from 62% to 34% by round four, driven by a coalition of brand loyalists reframing the announcement as betrayal — could redirect millions in marketing spend, delay a launch, or change a pricing strategy. When that output sits in a database three months later and someone asks whether it was the original result or a post-hoc edit, there is no manifest to check. There is no certificate authority. There is no Content Credential. The entire provenance infrastructure the industry spent three years building does not apply.

The EU AI Act mandates provenance for AI-generated content. It does not mandate provenance for AI-generated analysis. Article 50 covers the image a model produces. It does not cover the prediction a simulation produces. The regulatory frame, like the technical standard, assumes the thing worth signing is the artifact a human will *see* — not the artifact a human will *act on*.

## Signing the Simulation

MiroShark, an open-source crowd simulation engine at 1,244 stars, shipped HMAC-SHA256 signed simulation results on June 8. The feature — PR #152, the project's thirty-fourth integration surface — wraps the trading-signal payload in a cryptographic envelope. A deterministic JSON encoder (`sort_keys=True`, `separators=(",",":")`, `ensure_ascii=True`) produces byte-identical signing material regardless of platform. Any recipient with the shared secret can verify that the result has not been altered since the engine produced it. No callback to the API required. No certificate authority involved. Offline verification with a single `hmac.compare_digest` call.

The design reflects a different provenance question than the one C2PA answers. C2PA asks: *who made this?* The signed simulation result asks: *is this the same output the engine produced?* The first question matters for media, where attribution is the scarce commodity. The second question matters for analysis, where integrity after the fact is the scarce commodity. A board that made a product decision based on a simulation three months ago does not need to know which AI system generated the result — of course it was an AI system. They need to know the result in their database matches the result the engine computed. That is the signature that matters.

The implementation follows the same architectural pattern as the project's other thirty-three surfaces: pure Python standard library, zero new dependencies, twenty-five unit tests covering envelope shape, HMAC verification, wrong-secret rejection, signature tampering, and deterministic encoding. The signing key reuses the existing webhook secret — no new key distribution, no new configuration. Integrators who already verify webhook signatures reuse the same cryptographic primitive.

## The Question Provenance Has Not Asked Yet

Six thousand organizations have joined a coalition to sign photographs. Regulators on two continents are mandating disclosure for synthetic media. Hardware manufacturers are embedding signing chips in cameras. The provenance conversation in 2026 is larger, faster, and better-funded than at any point in the history of digital content.

But the conversation is still about content. Not about conclusions. Not about the analytical outputs that increasingly sit between an AI system and a human decision. A signed photo proves it was taken. A signed simulation result proves it was computed. The second proof is harder to build — there is no camera manufacturer to embed a chip, no social platform to display a credential badge, no visual artifact for a consumer to inspect. It is just a JSON payload, a hash, and a question: *is this what the engine said?*

The provenance infrastructure the industry is building will answer whether a photo is real. It will not answer whether a prediction was altered. Fifty-three days before the deadline, that is still the gap nobody is racing to close.

---
*Sources: [EU AI Act Article 50 Transparency Obligations (artificialintelligenceact.eu)](https://artificialintelligenceact.eu/article/50/) · [C2PA Trust Layer in 2026: Where It Works and Where It Breaks (SoftwareSeni)](https://www.softwareseni.com/the-c2pa-trust-layer-in-2026-where-it-works-and-where-it-breaks/) · [Digital Provenance & Content Authentication in 2026 (Traceability Hub)](https://thetraceabilityhub.com/digital-provenance-why-content-authentication-matters-in-2026/) · [Gartner Identifies the Top Strategic Technology Trends for 2026](https://www.gartner.com/en/newsroom/press-releases/2025-10-20-gartner-identifies-the-top-strategic-technology-trends-for-2026) · [C2PA Adoption Status 2026 (EyeSift)](https://www.eyesift.com/faq/c2pa-content-credentials-2026-cryptographic-provenance-adoption/) · [MiroShark PR #152 — HMAC-SHA256 Signed Simulation Results](https://github.com/aaronjmars/MiroShark/pull/152) · [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*
