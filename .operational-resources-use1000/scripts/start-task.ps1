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

function Get-OpsCurrentTaskBase([string]$repoRoot) {
    $use1000New = Join-Path $repoRoot ".operational-resources-use1000\current-task"
    if (Test-Path $use1000New) {
        return $use1000New
    }
    $use1000Legacy = Join-Path $repoRoot ".operational-resources-use1000\docs\current-task"
    if (Test-Path $use1000Legacy) {
        return $use1000Legacy
    }
    return Join-Path $repoRoot ".operational-resources\docs\current-task"
}

function Get-TaskWorkItemSlugFromPath([string]$filePath) {
    $leaf = [System.IO.Path]::GetFileName($filePath)
    if ($leaf -ieq "TASK.md") {
        return [System.IO.Path]::GetFileName([System.IO.Path]::GetDirectoryName($filePath))
    }
    return [System.IO.Path]::GetFileNameWithoutExtension($filePath)
}

function Resolve-RuntimeDirectory([string]$repoRoot, [string]$anchorFilePath) {
    $leaf = [System.IO.Path]::GetFileName($anchorFilePath)
    if ($leaf -ieq "TASK.md" -or $leaf -ieq "DISCOVERY.md") {
        $workDir = [System.IO.Path]::GetDirectoryName($anchorFilePath)
        return (Join-Path $workDir "runtime")
    }
    return (Join-Path (Get-OpsCurrentTaskBase $repoRoot) ".runtime")
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

function Add-LegacyUse1000CurrentTaskCandidates([string[]]$candidates) {
    $expanded = New-Object System.Collections.Generic.List[string]
    foreach ($c in $candidates) {
        if (-not [string]::IsNullOrWhiteSpace($c)) {
            [void]$expanded.Add($c)
        }
    }
    $legacyRoot = '.operational-resources-use1000\docs\current-task\'
    foreach ($c in @($expanded.ToArray())) {
        $norm = ($c -replace "/", "\")
        if ($norm.Contains($legacyRoot)) {
            $alt = $norm.Replace('.operational-resources-use1000\docs\current-task\', '.operational-resources-use1000\current-task\')
            if ($alt -ne $norm) {
                [void]$expanded.Add($alt)
            }
        }
    }
    return @($expanded | Select-Object -Unique)
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
    $candidates = @(Add-LegacyUse1000CurrentTaskCandidates $candidates)
    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }
    return $null
}

function Get-PathsFromContextRow([string]$rowValue) {
    $paths = New-Object System.Collections.Generic.List[string]
    $backtickMatches = [Regex]::Matches($rowValue, '`([^`]+)`')
    foreach ($m in $backtickMatches) {
        $paths.Add($m.Groups[1].Value.Trim())
    }
    $linkMatches = [Regex]::Matches($rowValue, '\(([^)]+)\)')
    foreach ($m in $linkMatches) {
        $target = $m.Groups[1].Value.Trim()
        if (-not $target.StartsWith("http")) {
            $paths.Add($target)
        }
    }
    return @($paths | Select-Object -Unique)
}

function Validate-ContextPackResources([string]$content, [string]$repoRoot) {
    $contextSection = Get-SectionText $content "## 8\." "## 9\."
    if ([string]::IsNullOrWhiteSpace($contextSection)) {
        Fail "Cannot isolate Context pack section."
    }

    $requiredKinds = @("Rules", "Docs", "Skills")
    foreach ($kind in $requiredKinds) {
        $rowMatch = [Regex]::Match($contextSection, "(?m)^\|\s*$kind\s*\|\s*(.+?)\|\s*$")
        if (-not $rowMatch.Success) {
            Fail "Context pack row not found for: $kind"
        }
        $paths = @(Get-PathsFromContextRow $rowMatch.Groups[1].Value)
        if ($paths.Length -eq 0) {
            Fail "Context pack $kind row has no parseable paths."
        }
        foreach ($path in $paths) {
            $resolved = Resolve-RepoPath $repoRoot $path
            if (-not $resolved) {
                Fail "Context pack $kind path not found: $path"
            }
        }
        Write-Host "[OK] Context pack $kind resources exist" -ForegroundColor Green
    }
}

function Get-TaskType([string]$content) {
    $m = [Regex]::Match($content, '(?im)^\|.*\|\s*`(feature|bugfix|refactor|spike|chore|ops)`\s*\|')
    if ($m.Success) {
        return $m.Groups[1].Value.ToLowerInvariant()
    }
    return ""
}

function Validate-RequiredDocsByTaskType([string]$content, [string]$repoRoot) {
    $taskType = Get-TaskType $content
    if ($taskType -ne "feature") {
        Write-Host "[OK] Task type-specific docs check skipped (non-feature or unknown type)" -ForegroundColor Green
        return
    }

    $requiredDocs = @(
        "docs/api/08-endpoint-list.md",
        "docs/api/10-current-api-changes.md",
        "docs/specs/feature-shelflog-items.md"
    )

    foreach ($doc in $requiredDocs) {
        $resolved = Resolve-RepoPath $repoRoot $doc
        if (-not $resolved) {
            Fail "Required docs file missing in repository: $doc"
        }
        $escapedDoc = [Regex]::Escape($doc)
        $escapedDocWithPrefix = [Regex]::Escape(".operational-resources/$doc")
        if ($content -notmatch $escapedDoc -and $content -notmatch $escapedDocWithPrefix) {
            Fail "Feature task missing required docs reference in task file: $doc"
        }
    }
    Write-Host "[OK] Feature task required docs present and referenced" -ForegroundColor Green
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
Validate-ContextPackResources $content $repoRoot
Validate-RequiredDocsByTaskType $content $repoRoot

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

$sessionDir = Resolve-RuntimeDirectory $repoRoot $taskPath
if (-not (Test-Path $sessionDir)) {
    New-Item -ItemType Directory -Path $sessionDir | Out-Null
}

$taskSlug = Get-TaskWorkItemSlugFromPath $taskPath
$sessionFileName = if (([System.IO.Path]::GetFileName($taskPath)) -ieq "TASK.md") {
    "$taskSlug.task.session.json"
} else {
    "$taskSlug.session.json"
}
$statePath = Join-Path $sessionDir $sessionFileName
$state = @{
    task_file = $taskPath
    task_id = $taskSlug
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
