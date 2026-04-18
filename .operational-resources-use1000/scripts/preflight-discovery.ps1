param(
    [Parameter(Mandatory = $true)]
    [string]$DiscoveryFile,
    [switch]$AllowUnready
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Fail([string]$msg) {
    Write-Host "[FAIL] $msg" -ForegroundColor Red
    exit 1
}

function Get-OpsCurrentTaskBase([string]$repoRoot) {
    $use1000 = Join-Path $repoRoot ".operational-resources-use1000\docs\current-task"
    if (Test-Path $use1000) {
        return $use1000
    }
    return Join-Path $repoRoot ".operational-resources\docs\current-task"
}

function Resolve-RuntimeDirectory([string]$repoRoot, [string]$anchorFilePath) {
    $leaf = [System.IO.Path]::GetFileName($anchorFilePath)
    if ($leaf -ieq "TASK.md" -or $leaf -ieq "DISCOVERY.md") {
        $workDir = [System.IO.Path]::GetDirectoryName($anchorFilePath)
        return (Join-Path $workDir "runtime")
    }
    return (Join-Path (Get-OpsCurrentTaskBase $repoRoot) ".runtime")
}

function Resolve-DiscoveryStateFilename([string]$discoveryPath) {
    $leaf = [System.IO.Path]::GetFileName($discoveryPath)
    if ($leaf -ieq "DISCOVERY.md") {
        $folder = [System.IO.Path]::GetDirectoryName($discoveryPath)
        $slug = [System.IO.Path]::GetFileName($folder)
        return "$slug.discovery.session.json"
    }
    return "$([System.IO.Path]::GetFileNameWithoutExtension($discoveryPath)).discovery.session.json"
}

function Check-Contains([string]$content, [string]$needle, [string]$label) {
    if ($content -notmatch [Regex]::Escape($needle)) {
        Fail "Missing required section: $label"
    }
    Write-Host "[OK] $label" -ForegroundColor Green
}

function Check-Regex([string]$content, [string]$pattern, [string]$label) {
    if ($content -notmatch $pattern) {
        Fail "Missing required pattern: $label"
    }
    Write-Host "[OK] $label" -ForegroundColor Green
}

function Resolve-RepoPath([string]$repoRoot, [string]$rawPath) {
    $clean = $rawPath.Trim()
    if ([string]::IsNullOrWhiteSpace($clean)) {
        return $null
    }
    $clean = $clean -replace "\\", "/"
    $candidates = @()
    if ($clean.StartsWith(".operational-resources/")) {
        $candidates += Join-Path $repoRoot ($clean -replace "/", "\")
        $use1000Alt = $clean -replace "^\.operational-resources/", ".operational-resources-use1000/"
        $candidates += Join-Path $repoRoot ($use1000Alt -replace "/", "\")
    } else {
        $candidates += Join-Path $repoRoot ($clean -replace "/", "\")
        $candidates += Join-Path (Join-Path $repoRoot ".operational-resources") ($clean -replace "/", "\")
        $candidates += Join-Path (Join-Path $repoRoot ".operational-resources-use1000") ($clean -replace "/", "\")
    }
    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }
    return $null
}

function Ensure-NoPlaceholders([string]$content) {
    $badPatterns = @(
        "YYYYMMDD-slug",
        "YYYY-MM-DD",
        "Discovery ready:\s*Yes / No",
        "Draft / In Progress / Ready",
        "\|\s*\.\.\.\s*\|",
        "^- Q1:\s*$",
        "^- Q2:\s*$"
    )
    foreach ($p in $badPatterns) {
        if ($content -match "(?m)$p") {
            Fail "Discovery placeholder found ($p). Fill all placeholders before AL execution."
        }
    }
    Write-Host "[OK] No discovery placeholders detected" -ForegroundColor Green
}

$repoRoot = (Get-Item -Path (Join-Path $PSScriptRoot "..\..")).FullName
$discoveryPath = if ([System.IO.Path]::IsPathRooted($DiscoveryFile)) { $DiscoveryFile } else { Join-Path $repoRoot $DiscoveryFile }

if (-not (Test-Path $discoveryPath)) {
    Fail "Discovery file not found: $discoveryPath"
}

$content = Get-Content -Path $discoveryPath -Raw -Encoding UTF8

Write-Host "Starting discovery preflight for: $discoveryPath" -ForegroundColor Cyan

Check-Contains $content "## 1)" "Discovery metadata"
Check-Contains $content "## 2)" "Problem framing"
Check-Contains $content "## 3)" "Known vs unknown inputs"
Check-Contains $content "## 4)" "Mandatory decisions"
Check-Contains $content "## 5)" "Domain-specific addendum"
Check-Contains $content "## 6)" "Risks and mitigations"
Check-Contains $content "## 7)" "Readiness gate"
Check-Contains $content "## 8)" "Handoff into task contract"

Check-Regex $content "(?m)^\|\s*Task file\s*\|.+\|\s*$" "Metadata task file row"
Check-Regex $content "(?m)^- Discovery ready:\s*(Yes|No)\s*$" "Readiness result line"
Check-Regex $content "(?m)^- Approved by:\s*.+$" "Approved by line"
Check-Regex $content "(?m)^- Approval date:\s*.+$" "Approval date line"

$taskRowMatch = [Regex]::Match($content, '(?m)^\|\s*Task file\s*\|\s*`?([^`|]+)`?\s*\|\s*$')
if (-not $taskRowMatch.Success) {
    Fail "Cannot parse task file path from discovery metadata."
}
$taskFileRef = $taskRowMatch.Groups[1].Value.Trim()
$taskResolved = Resolve-RepoPath $repoRoot $taskFileRef
if (-not $taskResolved) {
    Fail "Task file referenced in discovery metadata not found: $taskFileRef"
}
Write-Host "[OK] Discovery task file reference exists" -ForegroundColor Green

Ensure-NoPlaceholders $content

$hasOpenUnknown = $content -match '(?mi)^\|\s*U-\d+\s*\|.*\|\s*Open\s*\|\s*$'
$hasOpenRisk = $content -match '(?mi)^\|[^|]+\|[^|]+\|[^|]+\|[^|]+\|\s*Open\s*\|\s*$'
$hasUncheckedGate = $content -match '(?m)^- \[ \]'
$isReadyYes = $content -match '(?m)^- Discovery ready:\s*Yes\s*$'

if (-not $AllowUnready.IsPresent) {
    if ($hasOpenUnknown) {
        Fail "Unknown inputs still marked Open in section 3.2."
    }
    if ($hasOpenRisk) {
        Fail "Risks table still contains Open items."
    }
    if ($hasUncheckedGate) {
        Fail "Readiness gate checklist has unchecked items."
    }
    if (-not $isReadyYes) {
        Fail "Discovery ready must be Yes before implementation."
    }
} else {
    if ($hasOpenUnknown -or $hasOpenRisk -or $hasUncheckedGate -or -not $isReadyYes) {
        Write-Host "[WARN] Discovery is not fully ready; bypassed with -AllowUnready." -ForegroundColor Yellow
    }
}

$sessionDir = Resolve-RuntimeDirectory $repoRoot $discoveryPath
if (-not (Test-Path $sessionDir)) {
    New-Item -ItemType Directory -Path $sessionDir | Out-Null
}

$stateFileName = Resolve-DiscoveryStateFilename $discoveryPath
$statePath = Join-Path $sessionDir $stateFileName
$state = @{
    discovery_file = $discoveryPath
    task_file = $taskResolved
    checked_at = (Get-Date).ToString("s")
    status = if ($AllowUnready.IsPresent) { "warning_bypassed" } else { "ready" }
}
$state | ConvertTo-Json | Set-Content -Path $statePath -Encoding UTF8

Write-Host ""
Write-Host "Discovery preflight passed." -ForegroundColor Green
Write-Host "Session state: $statePath"
Write-Host ""
Write-Host "Next actions:"
Write-Host "1) Copy confirmed outputs into task file sections 2/8/10/11"
Write-Host "2) Run start-task.ps1 for strict task input gate"
