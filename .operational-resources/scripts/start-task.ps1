param(
    [Parameter(Mandatory = $true)]
    [string]$TaskFile,
    [switch]$AllowUnready
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Fail([string]$msg) {
    Write-Host "[FAIL] $msg" -ForegroundColor Red
    exit 1
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

function Ensure-NoPlaceholders([string]$content) {
    $badPatterns = @(
        "YYYYMMDD-slug",
        "PROJ-123",
        "\[Short title\]",
        "\[One sentence:",
        ":\s*…",
        "\|\s*…\s*\|"
    )
    foreach ($p in $badPatterns) {
        if ($content -match $p) {
            Fail "Template placeholder found ($p). Fill all placeholders before AL execution."
        }
    }
    Write-Host "[OK] No template placeholders detected" -ForegroundColor Green
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

Write-Host "Starting task gate for: $taskPath" -ForegroundColor Cyan

Check-Contains $content "## Metadata" "Metadata"
Check-Contains $content "## 0." "DoR section"
Check-Contains $content "## 2." "Sources/scope section"
Check-Contains $content "## 3." "AC section"
Check-Contains $content "## 4." "AC -> test mapping"
Check-Contains $content "## 8." "Context pack"
Check-Contains $content "## 10." "AI guidance"
Check-Contains $content "## 12." "Progress log"
Check-Contains $content "## 13." "DoD"
Check-Contains $content "task_contract:" "task_contract block"

Check-Regex $content "(?m)^\s*task_id:\s*[A-Za-z0-9\-]+\s*$" "task_contract.task_id"
Check-Regex $content "(?m)^\s*ticket:\s*.+$" "task_contract.ticket"
Check-Regex $content "(?m)^\s*dependencies:\s*(\[\])?\s*$" "task_contract.dependencies"
Check-Regex $content "(?m)^\s*required_test_command:\s*.+$" "task_contract.required_test_command"
Check-Regex $content "(?m)^\s*required_outputs:\s*$" "task_contract.required_outputs"
Check-Regex $content "(?m)^\s*-\s*code_changes\s*$" "required_output code_changes"
Check-Regex $content "(?m)^\s*-\s*test_updates\s*$" "required_output test_updates"
Check-Regex $content "(?m)^\s*-\s*test_evidence\s*$" "required_output test_evidence"
Check-Regex $content "(?m)^\s*-\s*ac_test_mapping\s*$" "required_output ac_test_mapping"
Check-Regex $content "(?m)^\s*-\s*handoff_notes\s*$" "required_output handoff_notes"

Check-Regex $content "(?m)^\|\s*Rules\s*\|.+\|\s*$" "Context pack Rules path"
Check-Regex $content "(?m)^\|\s*Docs\s*\|.+\|\s*$" "Context pack Docs path"
Check-Regex $content "(?m)^\|\s*Skills\s*\|.+\|\s*$" "Context pack Skills path"

Check-Regex $content "(?m)- \*\*MUST:\*\*\s*.+$" "MUST guidance"
Check-Regex $content "(?m)- \*\*SHOULD:\*\*\s*.+$" "SHOULD guidance"
Check-Regex $content "(?m)- \*\*ASK FIRST:\*\*\s*.+$" "ASK FIRST guidance"

Ensure-NoPlaceholders $content

$dorSection = Get-SectionText $content "## 0\." "## 1\."
if ([string]::IsNullOrWhiteSpace($dorSection)) {
    Fail "Cannot isolate Definition of Ready section."
}
$hasUncheckedDor = $dorSection -match "- \[ \]"
if ($hasUncheckedDor -and -not $AllowUnready.IsPresent) {
    Fail "Definition of Ready has unchecked items. Complete DoR or run with -AllowUnready."
}
if ($hasUncheckedDor -and $AllowUnready.IsPresent) {
    Write-Host "[WARN] DoR has unchecked items; bypassed with -AllowUnready." -ForegroundColor Yellow
} else {
    Write-Host "[OK] Definition of Ready checked" -ForegroundColor Green
}

$sessionDir = Join-Path $repoRoot ".operational-resources\docs\current-task\.runtime"
if (-not (Test-Path $sessionDir)) {
    New-Item -ItemType Directory -Path $sessionDir | Out-Null
}

$taskId = [System.IO.Path]::GetFileNameWithoutExtension($taskPath)
$statePath = Join-Path $sessionDir "$taskId.session.json"
$state = @{
    task_file = $taskPath
    task_id = $taskId
    started_at = (Get-Date).ToString("s")
    status = "in_progress"
    role_model = "AL_implementation_and_testing_only"
}
$state | ConvertTo-Json | Set-Content -Path $statePath -Encoding UTF8

Write-Host ""
Write-Host "Task gate passed." -ForegroundColor Green
Write-Host "Session state: $statePath"
Write-Host ""
Write-Host "Next actions:"
Write-Host "1) Implement with context pack in task file"
Write-Host "2) Run required tests"
Write-Host "3) Run close-task.ps1 for output gate"
