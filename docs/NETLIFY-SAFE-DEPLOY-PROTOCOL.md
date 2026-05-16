# Netlify Safe-Deploy Protocol (no-nuke)

**Author:** Connor MacIvor
**Last updated:** 2026-05-16
**Applies to:** Any Netlify site in the SOA / CWH org where `deploy_source: cli` (not Git-connected) — `sellersonlyagent.com` being the canonical case.

## The problem

`netlify deploy --prod --dir=<dir>` **replaces the entire site** with the contents of `<dir>`. If you deploy a folder that only contains your new file, **every other page on the site is wiped**. There is no "add this one file" mode.

Compounding this: many of Connor's sites (including `sellersonlyagent.com`) are NOT git-connected in Netlify. A push to GitHub does NOT trigger a deploy. The Git repo is effectively a backup, and the live site is whatever the last CLI deploy uploaded.

## The protocol

To add/change any file on a CLI-deployed Netlify site safely:

1. **Get the full current site source.** Either:
   - Clone the GitHub backup repo (e.g. `connorwithhonor/sellersonlyagent`), OR
   - Pull from an existing local working copy

2. **Verify the working copy is complete** — check that root `index.html`, `/the-system/`, `/listings/`, etc. are all present BEFORE making changes.

3. **Make your changes** in the working copy (add `/blog/<slug>/index.html`, update `/blog/index.html`, etc.).

4. **Snapshot** the working copy before deploy so you can restore if something breaks.

5. **`netlify link --id <siteId>`** if the working copy isn't already linked (one-time per clone).

6. **`netlify deploy --prod --dir=.`** from the working copy root. The `.` is critical — it deploys the WHOLE tree, not just your new file.

7. **Commit and push** the same changes back to the GitHub backup repo so the repo stays the canonical source of truth.

## Known site IDs

| Site | Netlify Site ID | GitHub backup repo |
|---|---|---|
| sellersonlyagent.com | `18ef654b-b2a8-4b5a-ba57-a3f583912792` | `connorwithhonor/sellersonlyagent` |

(Add more here as they're confirmed.)

## Better long-term: wire Git → Netlify

The cleanest fix is to connect each Netlify site to its GitHub backup repo as a **build source**. Then:
- `git push origin main` auto-deploys
- No more CLI-only deploys
- No more nuke-the-site risk
- Future blog posts = a single commit

This is a 5-minute one-time setup per site in the Netlify dashboard:
**Site settings → Build & deploy → Continuous deployment → Link repository**

## Automation

A turnkey PowerShell script lives at `scripts/Publish-SOABlogPost.ps1`. It:
- Clones/pulls the SOA repo
- Merges a `blog-payload/` folder of new content into the working copy
- Snapshots before deploy
- Verifies root `index.html` survived the merge (safety halt if not)
- Runs `netlify deploy --prod --dir=.`
- Commits + pushes back to GitHub

Usage: `.\scripts\Publish-SOABlogPost.ps1 -PayloadDir .\blog-payload -LinkIfMissing`

## Why this protocol exists

A previous session almost deployed a single-file directory and would have wiped the entire SOA site. Connor's standing order: **document the safe pattern in a place that survives session resets** so no future Claude has to re-discover it. This file is that place.

If you're a future Claude reading this in `content.connorcoded.com/docs/`: copy this protocol to `connorwithhonor/mempalace` or `connorwithhonor/connor-palace` so it's findable from any session, not just one scoped to this repo.
