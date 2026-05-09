# Hittleman Footer Fix — Action Plan

## What the canonical (working) footer is
File: `hittleman-source-canonical/footer.html` (in this repo)
Source of truth: Drive file `hittleman-blog-FOOTER.html`, dated 2026-04-01

Self-contained `<style>` + `<footer class="hh-footer">` block. No external CSS dependencies. Drop-in.

Includes:
- Hittleman Health logo with link to home
- Tagline
- 5 social icons: Facebook, Instagram, LinkedIn, TikTok, **Substack** (Substack is the one missing from the old design)
- Quick Links column: Book a Consultation, Success Stories, About Julie, **Blog** (link to blog.hittlemanhealth.com — also handles the "Blog button" todo)
- Resources column: Julie's Substack Show, Get Started, Interested in Coaching?
- Bottom row: © 2026 Hittleman Health + "Coded by Connor with Honor"

## What the current production has
We can't read `hittlemanhealth.com/index.html` directly — sandbox egress blocks both Cloudflare/NF and api.netlify.com. The site is a **manual API deploy** (no GitHub repo wired up).

The January v3 (`hittleman-source-canonical/index-jan-v3.html`) shows the page structure pre-redesign — uses old `footer-main` class structure on lines 1616–1668. The April production deploy was the one that broke the footer.

## Two ways to ship this

### Option A — Manual swap (fastest)
1. On Connor's local machine, open the `index.html` that corresponds to the current `hittlemanhealth.com` deploy
2. Find the `<footer ...>` block (or wherever the bottom-of-page broke)
3. Replace from the `<style>` for the footer (if present) through `</footer>` with the entire contents of `hittleman-source-canonical/footer.html`
4. Re-deploy via your usual API push
5. Done

### Option B — Push from this session via Netlify MCP (`deploy-site`)
1. Connor pastes the current local `index.html` (and `coach-opportunity.html`) contents into this session, OR copies them into the local sandbox at a path I can read
2. I edit them in place, swapping the broken footer for the canonical block
3. I run `deploy-site` against site `23346e58-840e-49af-a7b1-6a3a7a12e82c` and ship a new deploy directly

## Header todos — already partially handled

- **Substack icon in header social row** — the canonical footer's social row already has the Substack icon. If the existing header has a social row, the same SVG can be lifted from the footer and dropped into the header.
- **Blog button** — already covered as a Quick Link in the new footer. If you want it visually emphasized in the header too, that's a separate small addition (we'd add it to the nav, oval styling matching her colors).

## Security follow-up (separate from the fix)
The Netlify Personal Access Token (`nfp_jewg...sb7cd`) is sitting in plaintext inside `SITE-REGISTRY.txt` on Drive. After we ship this fix, rotate the token and move the new one somewhere ACL-controlled.
