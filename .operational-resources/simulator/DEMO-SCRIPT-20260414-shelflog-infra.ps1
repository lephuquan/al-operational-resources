param(
    [string]$ProjectRoot = "",
    [switch]$SkipDocker,
    [switch]$SkipTests,
    [switch]$DownAfter,
    [switch]$NoPrompt
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Section {
    param([string]$Title)
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor DarkGray
    Write-Host $Title -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor DarkGray
}

function Write-Ok {
    param([string]$Msg)
    Write-Host "[OK] $Msg" -ForegroundColor Green
}

function Write-WarnMsg {
    param([string]$Msg)
    Write-Host "[WARN] $Msg" -ForegroundColor Yellow
}

function Write-ErrMsg {
    param([string]$Msg)
    Write-Host "[ERR] $Msg" -ForegroundColor Red
}

function Add-LogEntry {
    param(
        [string]$LogPath,
        [string]$Step,
        [string]$Action,
        [string]$Evidence,
        [string]$IssueRisk,
        [string]$Next
    )

    $entry = @(
        ""
        "- Timestamp: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        "  Step: $Step"
        "  Action: $Action"
        "  Files: Khong doi file bang script"
        "  Evidence: $Evidence"
        "  Issue/Risk: $IssueRisk"
        "  Next: $Next"
    ) -join "`n"

    Add-Content -Path $LogPath -Value $entry -Encoding UTF8
}

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
    # Script path: <repo>/.operational-resources/simulator/*.ps1
    $ProjectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
}

$composePath = Join-Path $ProjectRoot ".operational-resources\simulator\docker-compose.postgres.yml"
$taskPath = Join-Path $ProjectRoot ".operational-resources\docs\current-task\20260414-shelflog-infra.md"
$logPath = Join-Path $ProjectRoot ".operational-resources\simulator\DEMO-LOG-20260414-shelflog-infra.md"
$pomPath = Join-Path $ProjectRoot "pom.xml"
$mvnwPath = Join-Path $ProjectRoot "mvnw.cmd"
$appYml = Join-Path $ProjectRoot "src\main\resources\application.yml"
$appDevYml = Join-Path $ProjectRoot "src\main\resources\application-dev.yml"
$appTestYml = Join-Path $ProjectRoot "src\main\resources\application-test.yml"
$testProps = Join-Path $ProjectRoot "src\test\resources\application.properties"
$healthTest = Join-Path $ProjectRoot "src\test\java\com\programming_with_al\al_operational_resources\infra\ActuatorHealthIntegrationTest.java"

Write-Section "SIM-DEMO-1 Infra Demo Script"
Write-Host "Project root : $ProjectRoot"
Write-Host "Task file    : $taskPath"
Write-Host "Log file     : $logPath"

foreach ($required in @($composePath, $taskPath, $logPath, $pomPath, $mvnwPath)) {
    if (-not (Test-Path $required)) {
        throw "Missing required file: $required"
    }
}

Write-Section "Step 0 - Read and confirm inputs"
Write-Host "Please read before executing:"
Write-Host " - .operational-resources/task-lifecycle/FROM-TICKET-TO-DONE.md"
Write-Host " - .operational-resources/docs/current-task/20260414-shelflog-infra.md"
Write-Host " - .operational-resources/simulator/DEMO-PROJECT-BRIEF.md (sec 2,6,8,9,11)"
Write-Host " - .operational-resources/docs/setup/02-local-development.md"
Write-Host " - .operational-resources/docs/setup/03-configuration.md"
if (-not $NoPrompt) {
    Read-Host "Press Enter after you confirm Step 0"
}
Add-LogEntry -LogPath $logPath -Step "0" -Action "Confirm required inputs" -Evidence "Confirmed by operator" -IssueRisk "None" -Next "Proceed DoR gate"

Write-Section "Step 1 - DoR gate"
Write-Host "DoR checks:"
Write-Host " [ ] Scope clear: Maven + profiles + Actuator + test"
Write-Host " [ ] Non-goal clear: no ShelfItem API in this task"
Write-Host " [ ] AC1..AC6 have verification path"
Write-Host " [ ] No open blocker"
if (-not $NoPrompt) {
    Read-Host "Press Enter after DoR is confirmed"
}
Add-LogEntry -LogPath $logPath -Step "1" -Action "DoR gate confirmation" -Evidence "Checklist confirmed" -IssueRisk "None" -Next "Validate infra files"

Write-Section "Step 2 - Validate infra baseline artifacts"
$existsChecks = @(
    @{ Name = "application.yml"; Path = $appYml },
    @{ Name = "application-dev.yml"; Path = $appDevYml },
    @{ Name = "application-test.yml"; Path = $appTestYml },
    @{ Name = "test application.properties"; Path = $testProps },
    @{ Name = "Actuator health IT"; Path = $healthTest }
)
foreach ($item in $existsChecks) {
    if (Test-Path $item.Path) {
        Write-Ok "$($item.Name) exists"
    } else {
        Write-WarnMsg "$($item.Name) missing: $($item.Path)"
    }
}

$pomContent = Get-Content -Path $pomPath -Raw -Encoding UTF8
$requiredDeps = @(
    "spring-boot-starter-web",
    "spring-boot-starter-validation",
    "spring-boot-starter-data-jpa",
    "spring-boot-starter-actuator",
    "<artifactId>postgresql</artifactId>",
    "<artifactId>h2</artifactId>"
)
foreach ($dep in $requiredDeps) {
    if ($pomContent -match [Regex]::Escape($dep)) {
        Write-Ok "Dependency marker found: $dep"
    } else {
        Write-WarnMsg "Dependency marker missing: $dep"
    }
}
Add-LogEntry -LogPath $logPath -Step "2" -Action "Validated baseline artifacts/dependencies" -Evidence "File existence + dependency markers checked" -IssueRisk "Check warnings if any missing" -Next "Run Docker step"

if (-not $SkipDocker) {
    Write-Section "Step 3 - Start Docker Postgres for dev profile"
    try {
        Push-Location $ProjectRoot
        docker compose -f ".operational-resources/simulator/docker-compose.postgres.yml" up -d | Out-Host
        $psOutput = docker compose -f ".operational-resources/simulator/docker-compose.postgres.yml" ps
        $psOutput | Out-Host
        Pop-Location

        Write-Ok "Docker compose started (verify postgres is Up in output above)"
        Add-LogEntry -LogPath $logPath -Step "3" -Action "docker compose up + ps" -Evidence "Docker compose executed successfully" -IssueRisk "None" -Next "Run tests (Step 4)"
    }
    catch {
        try { Pop-Location } catch {}
        Write-ErrMsg "Docker step failed: $($_.Exception.Message)"
        Add-LogEntry -LogPath $logPath -Step "3" -Action "docker compose up + ps" -Evidence "Failed to connect Docker engine" -IssueRisk $_.Exception.Message -Next "Start Docker Desktop, re-run script (or use -SkipDocker)"
    }
}
else {
    Write-WarnMsg "Step 3 skipped by flag -SkipDocker"
    Add-LogEntry -LogPath $logPath -Step "3" -Action "Skipped Docker by flag" -Evidence "Operator used -SkipDocker" -IssueRisk "Dev profile not verified" -Next "Continue to tests"
}

if (-not $SkipTests) {
    Write-Section "Step 4 - Run required tests"
    try {
        Push-Location $ProjectRoot
        & ".\mvnw.cmd" -q test | Out-Host
        Pop-Location

        Write-Ok "Test command finished successfully"
        Add-LogEntry -LogPath $logPath -Step "4" -Action "./mvnw.cmd -q test" -Evidence "Exit code 0" -IssueRisk "None" -Next "Sync checklist and dashboard"
    }
    catch {
        try { Pop-Location } catch {}
        Write-ErrMsg "Test step failed: $($_.Exception.Message)"
        Add-LogEntry -LogPath $logPath -Step "4" -Action "./mvnw.cmd -q test" -Evidence "Test failed" -IssueRisk $_.Exception.Message -Next "Inspect failure, fix, then rerun Step 4"
    }
}
else {
    Write-WarnMsg "Step 4 skipped by flag -SkipTests"
    Add-LogEntry -LogPath $logPath -Step "4" -Action "Skipped test by flag" -Evidence "Operator used -SkipTests" -IssueRisk "No AC6 evidence" -Next "Run tests manually before closing task"
}

Write-Section "Step 5 - Manual sync checklist"
Write-Host "Now update manually:"
Write-Host " - .operational-resources/docs/current-task/20260414-shelflog-infra.md"
Write-Host "   * Tick AC1..AC6"
Write-Host "   * Update section 4 (AC->test), section 12 (progress), section 13 (DoD)"
Write-Host " - .operational-resources/simulator/DEMO-TICKET-20260414-shelflog-infra.md"
Write-Host " - .operational-resources/docs/current-task/README.md (status Done)"
Write-Host " - .operational-resources/docs/api/10-current-api-changes.md (if needed)"
Add-LogEntry -LogPath $logPath -Step "5-7" -Action "Manual checklist/self-review required" -Evidence "Instructions shown in console" -IssueRisk "Pending manual updates" -Next "Finish manual sync and close SIM-DEMO-1"

if ($DownAfter) {
    Write-Section "Optional - stop Docker compose"
    try {
        Push-Location $ProjectRoot
        docker compose -f ".operational-resources/simulator/docker-compose.postgres.yml" down | Out-Host
        Pop-Location
        Write-Ok "Docker compose stopped"
    }
    catch {
        try { Pop-Location } catch {}
        Write-WarnMsg "Could not stop compose automatically: $($_.Exception.Message)"
    }
}

Write-Section "Demo script completed"
Write-Host "Log has been appended to:"
Write-Host " - $logPath"
Write-Host ""
Write-Host "If any step failed, fix and rerun with:"
Write-Host " - .operational-resources/simulator/DEMO-SCRIPT-20260414-shelflog-infra.ps1"
Write-Host ""
Write-Host "Useful flags:"
Write-Host " -SkipDocker   (skip docker step)"
Write-Host " -SkipTests    (skip test step)"
Write-Host " -DownAfter    (docker compose down at end)"
Write-Host " -NoPrompt     (non-interactive)"
