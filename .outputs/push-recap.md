*Push Recap — 2026-11-14*
aaronjmars/MiroShark — 1 substantive commit by Dependabot (1 automation commit filtered from miroshark-aeon)

Dependency Update — soupsieve 2.9 → 4.0: Major-version bump of the CSS selector engine used by BeautifulSoup4. Dependabot merged PR #358, updating backend/uv.lock with refined Python version resolution markers — soupsieve 4.0 now requires Python ≥ 3.11.5, so the resolver added a beautifulsoup4 4.6.3 fallback for older runtimes.

The lock file also picked up ~20 NVIDIA CUDA dependency marker simplifications (cosmetic cleanup by the uv resolver) and minor platform guard removals for pexpect and uvicorn dependencies.

Key changes:
- soupsieve 2.9 → 4.0 in backend/uv.lock (two major versions, released Nov 3)
- beautifulsoup4 now version-split: 4.14.3 for Python ≥ 3.11.5, 4.6.3 for older
- NVIDIA CUDA markers simplified across cuda-bindings, cublas, cudnn, cufft, cusolver, cusparse

Stats: 1 file changed, +68/-36 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-11-14.md
