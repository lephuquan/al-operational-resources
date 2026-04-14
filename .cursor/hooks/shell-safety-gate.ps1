Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Emit-Allow {
    @{ permission = "allow" } | ConvertTo-Json -Compress
    exit 0
}

try {
    $inputJson = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($inputJson)) {
        Emit-Allow
    }

    $payload = $inputJson | ConvertFrom-Json
    $command = ""

    if ($null -ne $payload.command) {
        $command = [string]$payload.command
    } elseif ($null -ne $payload.input -and $null -ne $payload.input.command) {
        $command = [string]$payload.input.command
    }

    if ($command -match "git\s+reset\s+--hard" -or
        $command -match "git\s+checkout\s+--\s+" -or
        $command -match "rm\s+-rf\s+" -or
        $command -match "git\s+push\s+--force(\s|$)") {
        @{
            permission = "ask"
            user_message = "Command may be destructive. Confirm task intent before continuing."
            agent_message = "Hook flagged a risky command. Verify this aligns with the active task file."
        } | ConvertTo-Json -Compress
        exit 0
    }

    Emit-Allow
} catch {
    Emit-Allow
}
