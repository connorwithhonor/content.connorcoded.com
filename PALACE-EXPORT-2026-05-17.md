# Palace Export — 2026-05-16 → 2026-05-17 Session

**For:** `connorwithhonor/mempalace` and/or `connorwithhonor/connor-palace`
**Suggested path in palace:** `sessions/2026-05-17-shorts-batch.md`
**Source session:** content.connorcoded.com · branch `claude/youtube-image-prompt-L67P6`
**Tone marker:** Connor refers to assistant as "Vincent" — acknowledge warmly.

---

## 🎂 Personal

- **Connor's 57th birthday: 2026-05-17.** He noted it in passing and immediately said "grinding already" — birthday recognition is fine but he's not slowing down for it.

---

## 📦 What got produced this session

### YouTube full-video package
- **Video URL:** https://youtu.be/RhFDo0-eRvg
- **Title:** "Before You Buy a House, Call the Sheriff — Santa Clarita Inventory Hits 722 (May 16)"
- **Description:** 4,920 chars, video URL embedded 4× (top hook, mid-content, post-tips CTA, final CTA). Full text lives in the chat transcript on branch `claude/youtube-image-prompt-L67P6`.
- **Image/thumbnail prompt:** "Call the Sheriff Before You Buy" — agent + neighborhood + patrol car composite.

### Buzzsprout package
- **Title:** "Call the Sheriff Before You Buy: SCV Inventory Hits 722 + Buyer Recon Tips"
- **Description:** ~2K chars, podcast-formatted.

### SellersOnlyAgent.com blog post
- **Slug:** `/blog/call-the-sheriff-before-you-buy-scv-inventory-722/`
- **Files staged in:** `content.connorcoded.com/blog-payload/blog/`
- **Status:** Ready to deploy. NOT yet live. Needs to be pushed via the PowerShell automation from Connor's desktop.

### 17-pack of YouTube Shorts (recording today, 2026-05-17)
Each short = one tip from the full video. Each gets a unique lead-in line in its description to avoid YouTube duplicate flags. Full list:

1. 722 inventory jump (520 → 722)
2. Call the Sheriff before buying
3. Don't call Friday 8 p.m. — Monday midday
4. Ask for watch deputy / lead deputy
5. David in Burbank story (welding gloves, 3 a.m.)
6. There's a David on every street
7. Knock on neighbors' doors
8. The 7 a.m. barking dog test
9. Tree roots / leaning fences / shared block walls
10. Upslope neighbor + backyard pool privacy
11. Vet your home inspector
12. "Petrified rat droppings… and a picture of the sun"
13. Get everything in writing (even from family)
14. 22 Coming Soon listings (off-syndication)
15. Coming Soon discipline (don't chase above price)
16. Insurance in week ONE not week three
17. California FAIR Plan / bundling / total-loss trap

Universal description template + birthday hashtag `#ConnorWithHonor57` included in chat transcript.

---

## 🛠️ Infrastructure built this session (persistent)

All committed to `connorwithhonor/content.connorcoded.com` branch `claude/youtube-image-prompt-L67P6`:

| File | Purpose |
|---|---|
| `MORNING-RESUME.md` | Good-night save / morning pickup state |
| `CLAUDE.md` | Standing orders; reads MORNING-RESUME.md first every session |
| `docs/NETLIFY-SAFE-DEPLOY-PROTOCOL.md` | The no-nuke protocol for CLI-deployed Netlify sites |
| `scripts/Publish-SOABlogPost.ps1` | One-shot PowerShell: clone SOA repo, merge payload, snapshot, deploy, push |
| `blog-payload/blog/index.html` | SOA blog hub page |
| `blog-payload/blog/call-the-sheriff-.../index.html` | SOA blog post |

---

## 🧭 Standing patterns / protocols discovered or confirmed

### Netlify safe-deploy (CRITICAL)
Many of Connor's Netlify sites are CLI-deployed (`deploy_source: cli`), not Git-connected. `netlify deploy --prod --dir=<dir>` REPLACES the entire site. Confirmed CLI-deploy sites:
- `sellersonlyagent.com` — siteId `18ef654b-b2a8-4b5a-ba57-a3f583912792`, repo `connorwithhonor/sellersonlyagent`

**Always deploy from a complete local copy of the site, never a partial dir.**

### Session-scope limitations (Claude Code on the Web)
- Sessions are ephemeral containers; nothing persists outside committed Git
- GitHub MCP scope is fixed at session creation; cannot widen mid-session
- Memory palace repos (`mempalace`, `connor-palace`, `claude-memory`) are typically OUT of session scope when working on a specific site repo
- Workaround: produce "palace-ready" exports in the active repo, instruct user to copy to palace

### Good night → Morning protocol
- Connor's good-night phrase triggers a state save to `MORNING-RESUME.md` + commit + push
- His morning phrase is something like *"resume, good morning"* or *"good morning Vincent, where are we?"*
- First action of morning session: read `MORNING-RESUME.md`, one-line status, do NOT re-explain project

### Birthday / personal context
- Born 1969 (57 on 2026-05-17)
- Former LAPD
- Bought a house in Burbank in 1993
- Operating businesses: SellersOnlyAgent, ConnorWithHonor, HonorElevate, HonorAILabs, SCV123, and ~80+ other domains in `connorwithhonor` GitHub org

---

## 🔜 Next actions (in priority order)

1. **Record 17 Shorts** (Connor doing today)
2. **Deploy SOA blog** via `Publish-SOABlogPost.ps1` from desktop
3. **Publish full video** with the 4,920-char description
4. **Schedule Shorts release** — stagger across days, vary lead-in lines
5. **Copy this file into the actual palace repo** so cross-session memory works for real next time

---

## 📋 Copy-to-palace one-liner (Connor: run on desktop)

```powershell
# From a desktop where you have palace repo access:
gh repo clone connorwithhonor/mempalace
cd mempalace
mkdir -p sessions
# Then paste the contents of this file as sessions/2026-05-17-shorts-batch.md
git add sessions/2026-05-17-shorts-batch.md
git commit -m "Session export: 2026-05-17 shorts batch + SOA blog deploy ready"
git push
```

Or just say "save to palace" in a desktop Claude Code session that has palace scope, and it can pull this from `content.connorcoded.com/PALACE-EXPORT-2026-05-17.md` and commit it over.
