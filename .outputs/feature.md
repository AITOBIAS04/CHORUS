*Feature Built — 2026-06-04*

French Locale (i18n FR)
MiroShark now speaks French. Every UI label, tooltip, button, status message, and description across all 34 Vue components — from the home page hero to the deepest embed dialog section — is available in formal French. Users click the locale toggle in the navigation bar to cycle between English, Chinese, and French. The translation covers 600+ unique strings using the formal "vous" register, appropriate for a research and professional tool.

Why this matters:
A community contributor filed issue #95 on May 22 asking whether a French locale PR would be welcome. That issue has gone unanswered for 13 days. Chinese localization shipped weeks ago, setting the multilingual precedent, but French — the 5th most-spoken language globally and the dominant language in academic discourse across West Africa, the Maghreb, and much of Europe — was missing. This closes that gap and sends the fastest possible signal of community responsiveness: a contributor asked, and the platform shipped it. For MiroShark's thesis that AI crowd simulation has social science applications, the French-speaking academic community is a natural constituency.

What was built:
- frontend/src/locales/fr.js: A 600-entry French translation dictionary mapping every English UI string to its French equivalent. Dictionary-based approach means zero changes to any of the 34 existing Vue component files — the tr() function looks up the English key at runtime.
- frontend/src/i18n.js: Added French to the supported locales array. The tr() function now checks if the locale is 'fr' and looks up the English string in the French dictionary, falling back to English for any untranslated string. The toggleLocale function cycles through all three locales (EN → 中 → FR → EN).
- frontend/src/components/LocaleToggle.vue: Updated the navigation toggle button for three-way locale cycling with current and next locale indicators.

How it works:
The existing i18n system uses inline tr('English', '中文') calls throughout every Vue component — approximately 1,950 calls across 34 files. Rather than modifying all those call sites to add a third argument, the French locale uses a dictionary-keyed-by-English-string approach. When the locale is set to 'fr', the tr() function takes the English argument and looks it up in the imported frDict object. If a French translation exists, it returns it; otherwise it falls back to the English string. This means the feature is additive-only — no existing file was modified except i18n.js (the core module) and LocaleToggle.vue (the toggle button). Future locales can follow the same pattern: create a dictionary file, import it, add a lookup branch.

What's next:
Push blocked (GH_GLOBAL not set — 31st consecutive feature). Once the secret is configured, this PR will close issue #95 directly. A locale completeness CI check could prevent future English additions from silently leaving French untranslated.
