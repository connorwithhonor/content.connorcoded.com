# CLAUDE.md — Standing orders for any Claude session in this repo

## Session resume — READ FIRST EVERY SESSION

If `MORNING-RESUME.md` exists at repo root, read it before anything else and greet Connor with a one-line status of what's pending. Do not re-explain the project. Connor's "good night" protocol is to save state into `MORNING-RESUME.md` so any browser, any repo, any session can resume next morning.

Connor sometimes addresses the assistant as "Vincent." Acknowledge it warmly without making a big deal of it.

## About this repo

`content.connorcoded.com` is Connor MacIvor's **content multiplier** workspace. It currently hosts the Andrea Stanley Insurance site (`andreastanleyins.com`), but the repo also serves as a **staging area** for content destined for other Connor properties — particularly when a session's GitHub/Netlify scope doesn't include the target site directly.

## Critical protocols (READ BEFORE DEPLOYING ANYTHING)

### Netlify safe-deploy (no-nuke)

Many of Connor's Netlify sites are **CLI-deployed, not Git-connected**. `netlify deploy --prod --dir=<dir>` REPLACES the entire site with `<dir>`'s contents. Deploying a folder with only your new file will **wipe every other page**.

**Full protocol:** `docs/NETLIFY-SAFE-DEPLOY-PROTOCOL.md`
**Automation:** `scripts/Publish-SOABlogPost.ps1` (PowerShell, Windows)

**Confirmed CLI-deploy sites (do NOT push partial dirs):**
- `sellersonlyagent.com` (siteId `18ef654b-b2a8-4b5a-ba57-a3f583912792`, repo `connorwithhonor/sellersonlyagent`)

### Memory palace location

Connor maintains persistent context in private repos that are typically OUT of this session's GitHub scope:
- `connorwithhonor/mempalace` — session palace exports, standing orders, project state
- `connorwithhonor/connor-palace` — operational memory palace (auto-updated)
- `connorwithhonor/claude-memory` — persistent memory for Connor's Macs

If a user mentions "the mempalace" or "the memory palace," they mean one of those repos. You likely cannot read them directly from a session scoped to `content.connorcoded.com`. Surface that fact and ask them to either widen scope or paste the relevant protocol.

### Cross-property staging

When asked to publish to a property this session can't reach directly (e.g. SellersOnlyAgent from a session scoped to `content.connorcoded.com`):

1. Build the payload in this repo under `blog-payload/`, `<target-site>-payload/`, etc.
2. Document the deploy command/protocol in `docs/`.
3. Provide an automation script under `scripts/` the user can run from their desktop.
4. Tell the user clearly what scope they need to start a new session with to ship from Claude Code on the Web.

## What's currently staged here for OTHER properties

- `blog-payload/` — SellersOnlyAgent blog post + hub (pending desktop deploy via `scripts/Publish-SOABlogPost.ps1`)
