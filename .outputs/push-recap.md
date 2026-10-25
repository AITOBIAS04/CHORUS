*Push Recap — 2026-10-25*
miroshark-aeon — 1 substantive commit by Aaron Mars (8 automation commits filtered)

Security: Bundled dependency bumps (zod, fast-uri, body-parser): PR #231 consolidated three Dependabot alerts into one commit, patching the MCP server and Remotion skill project. Zod jumped from 4.4.3 to 4.6.6/4.6.7, and a new overrides block forces Remotion Studio nested copies onto the patched version.

Key changes:
- body-parser 2.3.0→2.4.0 in mcp-server (sub-deps: content-type, qs, iconv-lite also bumped)
- fast-uri 3.1.8→3.1.9 in both mcp-server and remotion project
- zod override added to remotion package.json — prevents nested transitive resolution to vulnerable versions

Second consecutive security day (Oct 24: Next.js/MCP SDK/brotli; Oct 25: zod/fast-uri/body-parser). Both repos current on all known Dependabot alerts.

Stats: 3 files changed, +29/-26 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-10-25.md
