# Sellers Only Agent™ — Content Multiplier Preferences

This repo turns one piece of source content (typically a video transcript from
Connor's "Sellers Only Agent™" show) into a full multi-channel publish kit:
YouTube, Buzzsprout (podcast), an image prompt, and a long-form blog post for
**sellersonlyagent.com**.

When the user (Connor) drops a transcript and says some variation of "you know
how I like it," produce ALL of the deliverables below by default. Save each
episode under `content/<slug>/` and use the file names listed.

## About Connor (use this voice/credentials)
- Connor — REALTOR® since 1998 (28+ years).
- California sellers-only agent (does not represent buyers).
- Former LAPD — 17 years full-time + 3 years reserve = 20 years, honorably
  retired (no monetary pension). Lean into the "protection" angle.
- Brand: **Sellers Only Agent™** — sellersonlyagent.com.
- Tone: plain-spoken, conversational, a little dry humor, occasionally folksy
  ("grow a set", "naked mole rats and unicorns"), but always protective of the
  consumer and respectful of the profession. Never flashy/lifestyle.
- He dislikes flashy "look at my Lambo" agents and calls that out.

## Deliverables to produce per episode

Create a folder `content/<kebab-case-slug>/` containing:

1. `youtube.md` — title (≤70 chars, keyword-front-loaded), description
   (hook → value bullets → timestamped chapters → links → hashtags →
   disclaimer), 15–20 tags, pinned comment, end-screen CTA.
2. `buzzsprout.md` — episode title, episode number placeholder, season
   placeholder, podcast description (plaintext + HTML version with `<a>`
   links because Buzzsprout supports HTML), tags (comma-separated),
   episode type (full), explicit (no), 1–2 sentence "summary" field, and a
   transcript-ready snippet.
3. `image-prompt.md` — a single ready-to-paste prompt for an image model
   (Midjourney/DALL·E/etc.). Photoreal, cinematic, no text-in-image,
   16:9 thumbnail-friendly, plus a vertical variant (9:16) for Shorts/Reels.
   Include negative prompt and a thumbnail text overlay suggestion (kept
   separate from the image generation since models render text poorly).
4. `blog-post.md` — long-form post for sellersonlyagent.com. Requirements:
   - **AEO/SEO/GEO/AIEO** optimized. Conversational, written so an LLM can
     extract crisp Q&A pairs.
     - SEO: H1, semantic H2/H3, meta title (≤60), meta description (≤155),
       slug, internal-link suggestions, image alt text.
     - AEO/AIEO: question-led H2s, ≤60-word direct answers under each, then
       expanded context. Include "TL;DR" up top.
     - GEO: California-specific where applicable (CA disclosures count,
       statewide market notes); name the state by name.
     - FAQ section with FAQPage JSON-LD schema block.
     - Speakable schema hints, Article + Person (Connor) JSON-LD.
   - Structure: TL;DR → Key Takeaways (bulleted) → Story/Body in Connor's
     voice → Q&A section → FAQ (schema) → "What this means for you if
     you're selling in California" → CTA to sellersonlyagent.com →
     Disclaimer (not legal advice).
   - Include a JSON-LD block at the bottom (Article + FAQPage + Person).
   - Length target: 1,200–1,800 words.
5. `social.md` — optional but include: 3 X/Twitter posts, 1 LinkedIn post,
   1 Instagram caption, 3 YouTube Shorts hooks pulled verbatim or near-verbatim
   from the transcript.

## Delivery rules (how Connor wants the output)
- **Always paste every deliverable inline in the chat** in addition to
  writing it to disk. Do not just point at file paths — Connor wants to be
  able to copy from the chat without opening files. Use clearly labeled
  fenced code blocks per file.
- After pasting, commit + push to the assigned branch as usual.
- When Connor sends a YouTube link, swap `{{YOUTUBE_URL}}` everywhere and
  re-paste the affected files inline.

## Publishing to sellersonlyagent.com
- Connor expects the blog post to be **published** to sellersonlyagent.com,
  not just drafted. If the publishing target / CMS is not yet configured
  in this repo, ask once how the site is hosted (WordPress REST API,
  Ghost, Netlify CMS, static repo, etc.) and save the answer here so
  future episodes auto-publish.
- Until that's wired, deliver the blog post inline and clearly state that
  it has NOT been published yet and why.

## House style rules
- Never invent legal advice. Always close consumer-facing pieces with a short
  disclaimer: "Educational only — not legal advice. Consult a licensed
  professional for your specific situation."
- Always reference the 2024 commission lawsuit context as "the 2024
  commission-related lawsuits / NAR settlement era" — do not invent specific
  parties or dollar figures not in the transcript.
- Trademark: write **Sellers Only Agent™** on first use per document.
- Domain: sellersonlyagent.com (no www in body copy; use full URL in schema).
- Use em-dashes sparingly; Connor talks in long, breathy sentences — mirror that
  rhythm in the body but keep Q&A answers tight.
- No emojis unless Connor explicitly asks.

## When the user provides a YouTube link
Drop it into `youtube.md` (as the canonical URL) and into the blog post as the
embed/canonical reference. If not provided yet, leave `{{YOUTUBE_URL}}` as a
placeholder and note it at the top of `youtube.md` so Connor knows to fill it.

## When the user provides additional assets
- Image: store path under `content/<slug>/assets/`.
- Buzzsprout episode URL: add to `buzzsprout.md` and link from the blog post.
