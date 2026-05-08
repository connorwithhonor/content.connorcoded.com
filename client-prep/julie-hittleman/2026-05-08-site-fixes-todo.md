# Julie Hittleman — Open Site Fixes (Connor side)

Date opened: 2026-05-08
Site: hittlemanhealth.com (main) + blog.hittlemanhealth.com (blog subdomain)

## 1. Restore footer on hittlemanhealth.com
- **Status:** broken / missing after last deploy
- **Reference:** working version still lives on `blog.hittlemanhealth.com`
- **Plan:** copy footer markup from blog subdomain → drop into main site
- **Blocker:** need source access — both domains return 403 to external fetches; this repo doesn't contain the hittlemanhealth source. Resolve by either:
  - Pasting the working footer HTML (View Source on blog subdomain) and the broken one (main domain)
  - Confirming where the site source actually lives (Honor Elevate visual editor vs. separate repo)

## 2. Add Blog button to header
- Oval button, matching her color scheme
- Links to `https://blog.hittlemanhealth.com`
- Place near the existing social icon row

## 3. Add Substack icon to header
- Substack social icon next to Insta/FB/etc.
- Links to her Substack profile

## Notes from the call
- Julie noticed the missing footer link to the blog at the end of the 5/8 session ("it would be in the footer or the header but I don't see it")
- She asked for an oval matching her colors with "Blog" in it — confirmed
