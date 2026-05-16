<#
.SYNOPSIS
    Publishes a new blog post to sellersonlyagent.com without wiping the site.

.DESCRIPTION
    Safe-deploy protocol for the SOA Netlify site:
      1. Clones (or pulls) the connorwithhonor/sellersonlyagent repo
      2. Drops /blog/<slug>/index.html and updates /blog/index.html
      3. Deploys the ENTIRE repo via `netlify deploy --prod` so existing
         pages (/, /the-system/, /listings/, etc.) stay intact
      4. Commits + pushes back to GitHub as the canonical source

    The Netlify site for sellersonlyagent.com is NOT git-connected
    (deploy_source: cli). That means a "git push" alone will NOT
    publish. You MUST run `netlify deploy --prod` from a complete
    local copy of the site. This script does both.

.PREREQS
    - PowerShell 7+ (works on 5.1 too)
    - git
    - GitHub CLI (gh) authenticated:           gh auth status
    - Netlify CLI (netlify) authenticated:     netlify status
        Install: npm i -g netlify-cli
    - Run once: netlify link --id 18ef654b-b2a8-4b5a-ba57-a3f583912792
      (or this script will do it for you if you pass -LinkIfMissing)

.PARAMETER WorkDir
    Where to clone/pull the repo. Defaults to %USERPROFILE%\sellersonlyagent.

.PARAMETER PayloadDir
    Folder containing the /blog tree to merge into the site root.
    Should contain `blog/index.html` and `blog/<slug>/index.html`.

.PARAMETER SkipDeploy
    Build + commit + push, but DON'T run `netlify deploy`. Useful for dry runs.

.PARAMETER SkipGit
    Deploy to Netlify, but DON'T commit back to GitHub.

.PARAMETER LinkIfMissing
    If `netlify link` isn't set up in WorkDir, run it for you.

.EXAMPLE
    .\Publish-SOABlogPost.ps1 -PayloadDir C:\path\to\blog-payload

.EXAMPLE
    .\Publish-SOABlogPost.ps1 -PayloadDir .\blog-payload -SkipDeploy
#>

[CmdletBinding()]
param(
    [string]$WorkDir    = (Join-Path $env:USERPROFILE 'sellersonlyagent'),
    [Parameter(Mandatory = $true)]
    [string]$PayloadDir,
    [string]$RepoUrl    = 'https://github.com/connorwithhonor/sellersonlyagent.git',
    [string]$SiteId     = '18ef654b-b2a8-4b5a-ba57-a3f583912792',
    [string]$CommitMsg  = 'Add /blog/ hub and new post: Call the Sheriff Before You Buy (SCV inventory 722)',
    [switch]$SkipDeploy,
    [switch]$SkipGit,
    [switch]$LinkIfMissing
)

$ErrorActionPreference = 'Stop'

function Write-Step($msg) { Write-Host "`n>>> $msg" -ForegroundColor Cyan }
function Write-OK($msg)   { Write-Host "    OK: $msg" -ForegroundColor Green }
function Write-Warn2($msg){ Write-Host "    !! $msg" -ForegroundColor Yellow }

# ---- 0. Sanity checks --------------------------------------------------------
Write-Step "Checking prerequisites"

foreach ($cmd in @('git','gh','netlify')) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        throw "Missing required CLI: $cmd. Install it before running this script."
    }
}
Write-OK "git, gh, netlify all present"

# Verify auth
$ghStatus = (& gh auth status 2>&1 | Out-String)
if ($LASTEXITCODE -ne 0) { throw "GitHub CLI not authenticated. Run: gh auth login" }
Write-OK "GitHub CLI authenticated"

$nfStatus = (& netlify status 2>&1 | Out-String)
if ($LASTEXITCODE -ne 0) { throw "Netlify CLI not authenticated. Run: netlify login" }
Write-OK "Netlify CLI authenticated"

if (-not (Test-Path $PayloadDir)) {
    throw "PayloadDir not found: $PayloadDir"
}
$payloadFull = (Resolve-Path $PayloadDir).Path
Write-OK "Payload found at $payloadFull"

# ---- 1. Clone or pull the SOA repo ------------------------------------------
Write-Step "Syncing repo at $WorkDir"
if (Test-Path (Join-Path $WorkDir '.git')) {
    Push-Location $WorkDir
    & git fetch origin
    if ($LASTEXITCODE -ne 0) { Pop-Location; throw "git fetch failed" }
    & git checkout main
    & git pull --ff-only origin main
    if ($LASTEXITCODE -ne 0) { Pop-Location; throw "git pull failed" }
    Pop-Location
    Write-OK "Pulled latest main"
} else {
    if (Test-Path $WorkDir) {
        throw "$WorkDir exists but isn't a git repo. Move or rename it, then re-run."
    }
    & git clone $RepoUrl $WorkDir
    if ($LASTEXITCODE -ne 0) { throw "git clone failed" }
    Write-OK "Cloned $RepoUrl into $WorkDir"
}

# ---- 2. Snapshot before changes (safety net) --------------------------------
$snapshotDir = Join-Path $env:TEMP ("soa-snapshot-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
Write-Step "Taking pre-change snapshot to $snapshotDir"
Copy-Item -Path $WorkDir -Destination $snapshotDir -Recurse -Force
Write-OK "Snapshot saved (use to restore if anything goes sideways)"

# ---- 3. Merge payload into repo ---------------------------------------------
Write-Step "Copying payload from $payloadFull into $WorkDir"
# Copy contents (not the payload dir itself) so /blog ends up at site root
Get-ChildItem -Path $payloadFull -Force | ForEach-Object {
    $dest = Join-Path $WorkDir $_.Name
    Copy-Item -Path $_.FullName -Destination $dest -Recurse -Force
    Write-OK "Merged: $($_.Name)"
}

# Quick sanity: make sure index.html still exists at site root (didn't get clobbered)
if (-not (Test-Path (Join-Path $WorkDir 'index.html'))) {
    throw "SAFETY HALT: $WorkDir\index.html is missing after merge. Aborting before deploy. Snapshot at $snapshotDir."
}
Write-OK "Root index.html still present (site won't be nuked)"

# ---- 4. Show what changed ---------------------------------------------------
Push-Location $WorkDir
Write-Step "Git status (changes about to be deployed/committed)"
& git status --short
Write-Host ""

# ---- 5. Ensure netlify is linked --------------------------------------------
$nfStateFile = Join-Path $WorkDir '.netlify\state.json'
if (-not (Test-Path $nfStateFile)) {
    if ($LinkIfMissing) {
        Write-Step "Linking Netlify site (siteId $SiteId)"
        & netlify link --id $SiteId
        if ($LASTEXITCODE -ne 0) { Pop-Location; throw "netlify link failed" }
    } else {
        Pop-Location
        throw "Netlify project not linked. Run once:`n    cd $WorkDir`n    netlify link --id $SiteId`nOr re-run this script with -LinkIfMissing"
    }
}
Write-OK "Netlify linked"

# ---- 6. Deploy --------------------------------------------------------------
if ($SkipDeploy) {
    Write-Warn2 "SkipDeploy set — not deploying to Netlify."
} else {
    Write-Step "Deploying full site to Netlify (production)"
    # --dir=. deploys the entire repo so nothing existing is lost
    & netlify deploy --prod --dir=. --message $CommitMsg
    if ($LASTEXITCODE -ne 0) {
        Pop-Location
        throw "netlify deploy failed. Snapshot at $snapshotDir."
    }
    Write-OK "Deploy complete: https://sellersonlyagent.com"
}

# ---- 7. Commit + push back to GitHub ----------------------------------------
if ($SkipGit) {
    Write-Warn2 "SkipGit set — not committing back to GitHub."
} else {
    Write-Step "Committing + pushing to GitHub"
    & git add -A
    & git commit -m $CommitMsg
    if ($LASTEXITCODE -ne 0) {
        Write-Warn2 "Nothing to commit (already clean) — skipping push."
    } else {
        & git push origin main
        if ($LASTEXITCODE -ne 0) { Pop-Location; throw "git push failed" }
        Write-OK "Pushed to origin/main"
    }
}

Pop-Location

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  DONE." -ForegroundColor Green
Write-Host "  Live:    https://sellersonlyagent.com/blog/" -ForegroundColor Green
Write-Host "  Post:    https://sellersonlyagent.com/blog/call-the-sheriff-before-you-buy-scv-inventory-722/" -ForegroundColor Green
Write-Host "  Backup:  $snapshotDir" -ForegroundColor Gray
Write-Host "========================================" -ForegroundColor Green
