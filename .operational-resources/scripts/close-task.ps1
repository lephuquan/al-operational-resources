param(
    [Parameter(Mandatory = $true)]
    [string]$TaskFile,
    [Parameter(Mandatory = $true)]
    [string]$TestEvidence,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Fail([string]$msg) {
    Write-Host "[FAIL] $msg" -ForegroundColor Red
    exit 1
}

function Get-SectionText([string]$content, [string]$startPattern, [string]$nextPattern) {
    $match = [Regex]::Match($content, "$startPattern[\s\S]*?(?=$nextPattern)", [System.Text.RegularExpressions.RegexOptions]::Multiline)
    if ($match.Success) {
        return $match.Value
    }
    return ""
}

$repoRoot = (Get-Item -Path (Join-Path $PSScriptRoot "..\..")).FullName
$taskPath = if ([System.IO.Path]::IsPathRooted($TaskFile)) { $TaskFile } else { Join-Path $repoRoot $TaskFile }

if (-not (Test-Path $taskPath)) {
    Fail "Task file not found: $taskPath"
}

$content = Get-Content -Path $taskPath -Raw -Encoding UTF8

if ($content -notmatch "## 13.") { Fail "Definition of Done section missing." }
if ($content -notmatch "### 13.1") { Fail "Missing AL Done subsection (13.1)." }
if ($content -notmatch "### 13.2") { Fail "Missing Human Done subsection (13.2)." }

$evidencePath = if ([System.IO.Path]::IsPathRooted($TestEvidence)) { $TestEvidence } else { Join-Path $repoRoot $TestEvidence }
if (-not (Test-Path $evidencePath)) {
    if (-not $Force.IsPresent) {
        Fail "Test evidence file not found: $evidencePath"
    }
    Write-Host "[WARN] Missing test evidence, bypassed with -Force." -ForegroundColor Yellow
}

if ($content -notmatch "## 4.") { Fail "Missing AC -> test mapping section." }
if ($content -match "\|\s*…\s*\|") {
    if (-not $Force.IsPresent) {
        Fail "AC -> test mapping still contains placeholders."
    }
    Write-Host "[WARN] Placeholder found in AC -> test mapping, bypassed with -Force." -ForegroundColor Yellow
}

$alDoneSection = Get-SectionText $content "### 13\.1" "### 13\.2"
if ([string]::IsNullOrWhiteSpace($alDoneSection)) {
    Fail "Cannot isolate AL Done subsection (13.1)."
}
if ($alDoneSection -match "- \[ \]" -and -not $Force.IsPresent) {
    Fail "AL Done checklist (13.1) has unchecked items."
}

if ($content -notmatch "## 12.") {
    if (-not $Force.IsPresent) {
        Fail "Progress log section missing."
    }
    Write-Host "[WARN] Missing progress log section, bypassed with -Force." -ForegroundColor Yellow
}

$reportDir = Join-Path $repoRoot ".operational-resources\docs\current-task\reports"
if (-not (Test-Path $reportDir)) {
    New-Item -ItemType Directory -Path $reportDir | Out-Null
}

$taskId = [System.IO.Path]::GetFileNameWithoutExtension($taskPath)
$reportPath = Join-Path $reportDir ("{0}-{1}-review.md" -f (Get-Date -Format "yyyyMMdd"), $taskId)

$report = @"
# AL Handoff Report - $taskId

## 1) AL execution status

- [x] Code implementation completed by AL
- [x] Test implementation/update completed by AL
- [x] Test evidence provided: $evidencePath

## 2) Human review required (outside AL)

- [ ] Scope matches task file
- [ ] Code quality reviewed by human
- [ ] Testing evidence reviewed by human
- [ ] MR created by human
- [ ] Merge/close decision completed by human process

Generated at: $(Get-Date -Format "s")
Task file: $taskPath
"@

$report | Set-Content -Path $reportPath -Encoding UTF8

Write-Host "AL done gate completed." -ForegroundColor Green
Write-Host "Handoff report: $reportPath"
