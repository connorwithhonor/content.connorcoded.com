# Morning Resume — Pick Up Here

**Saved:** 2026-05-16 evening (good-night save)
**Next action:** Record the 17 YouTube Shorts in the AM.

## What's already done and committed on `claude/youtube-image-prompt-L67P6`

- ✅ YouTube full-video description (~4,920 chars, URL `https://youtu.be/RhFDo0-eRvg` baked in 4×)
- ✅ Shorts reusable description (paste under all 17 with one varied line each so YouTube doesn't flag duplicates)
- ✅ YouTube title + thumbnail image prompt
- ✅ Buzzsprout title + ~2K description
- ✅ SellersOnlyAgent blog post (HTML + Markdown) in `blog-payload/blog/call-the-sheriff-before-you-buy-scv-inventory-722/`
- ✅ Blog hub page in `blog-payload/blog/index.html`
- ✅ Netlify no-nuke safe-deploy protocol in `docs/NETLIFY-SAFE-DEPLOY-PROTOCOL.md`
- ✅ One-shot PowerShell `scripts/Publish-SOABlogPost.ps1`

## To do tomorrow morning

1. **Record the 17 Shorts** (one tip per short, each ending with "Full video linked in description")
2. **Publish the blog post** from desktop:
   ```powershell
   git clone -b claude/youtube-image-prompt-L67P6 https://github.com/connorwithhonor/content.connorcoded.com.git
   cd content.connorcoded.com
   .\scripts\Publish-SOABlogPost.ps1 -PayloadDir .\blog-payload -LinkIfMissing
   ```
3. **Upload the full video** with the 4,920-char description (find it in this branch's chat transcript or regenerate from blog-payload content)
4. **Schedule the 17 Shorts** — stagger them so each has a different leading sentence in the description to avoid duplicate-description flags

## Standing orders for any AM session (any repo, any browser)

When Connor opens a new Claude session and the prompt mentions "morning," "good morning," "AM," "pick up," "resume," or "Vincent":

1. **Read `CLAUDE.md` first** in whatever repo is open.
2. **Read `MORNING-RESUME.md`** (this file) if it exists.
3. **Greet briefly** with a 1-line status of what's pending from last night.
4. **Do NOT re-explain** the whole project — Connor knows. Just confirm where we left off.

## Cross-session memory (the real fix)

This file lives in `content.connorcoded.com` only. For TRUE cross-browser / cross-session / cross-repo memory, copy this file's contents into:

- `connorwithhonor/mempalace` → `sessions/2026-05-16-evening-save.md`
- `connorwithhonor/connor-palace` → `state/current.md`

I (Claude in this session) cannot reach those repos — my GitHub scope is locked to `content.connorcoded.com`. To enable auto-save into the palace going forward, start your next session with those repos in the GitHub scope.

## Tomorrow's first message can just be

> *"Good morning Vincent, where are we?"*

…and the agent will read this file and answer.

Good night, Connor. — V.
