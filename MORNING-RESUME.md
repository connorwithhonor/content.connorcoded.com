# Morning Resume — Pick Up Here

**Last saved:** 2026-05-17 AM (Connor's 57th birthday — grinding through the shorts batch)
**Next action:** Record 17 YouTube Shorts (full plan in `PALACE-EXPORT-2026-05-17.md`).

## Status as of this save

- ✅ Full video published / ready to publish: https://youtu.be/RhFDo0-eRvg
- ✅ 4,920-char YouTube description (URL ×4) — finalized
- ✅ Buzzsprout title + ~2K description — finalized
- ✅ Thumbnail prompt — finalized
- ✅ SOA blog payload (`blog-payload/blog/`) — staged, NOT deployed
- ✅ Safe-deploy PowerShell + protocol committed
- ✅ 17-pack of Shorts hooks + descriptions delivered to Connor (in chat transcript on branch `claude/youtube-image-prompt-L67P6`)
- 🔄 Connor recording the 17 Shorts today (2026-05-17)
- ⏳ Pending: blog deploy via PowerShell from desktop
- ⏳ Pending: full video upload
- ⏳ Pending: Shorts release schedule

## To do today

1. **Finish recording the 17 Shorts** (Connor is on it)
2. **Deploy SOA blog** from desktop:
   ```powershell
   git clone -b claude/youtube-image-prompt-L67P6 https://github.com/connorwithhonor/content.connorcoded.com.git
   cd content.connorcoded.com
   .\scripts\Publish-SOABlogPost.ps1 -PayloadDir .\blog-payload -LinkIfMissing
   ```
3. **Upload full video** with the 4,920-char description
4. **Schedule the 17 Shorts** with varied lead-in lines

## Palace export

Full session export for the memory palace lives at `PALACE-EXPORT-2026-05-17.md`. Copy that into `connorwithhonor/mempalace/sessions/2026-05-17-shorts-batch.md` next time you're in a desktop session with palace scope.

## Standing orders for any AM session (any repo, any browser)

When Connor opens a new Claude session and the prompt mentions "morning," "good morning," "AM," "pick up," "resume," or "Vincent":

1. **Read `CLAUDE.md` first** in whatever repo is open.
2. **Read `MORNING-RESUME.md`** (this file) if it exists.
3. **Greet briefly** with a 1-line status of what's pending.
4. **Do NOT re-explain** the whole project — Connor knows.

## Tomorrow's first message can just be

> *"Good morning Vincent, where are we?"*

— V.
