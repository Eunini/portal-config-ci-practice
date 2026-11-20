# Supplied teaching tool. No extra module is needed.
[CmdletBinding()]
param([string]$ConfigPath = (Join-Path $PSScriptRoot '../app/portal-config.json'))
$ErrorActionPreference = 'Stop'
$script:FailureCount = 0
function Assert-Rule([bool]$Condition, [string]$Message) {
    if ($Condition) { Write-Output "PASS: $Message" }
    else { Write-Output "FAIL: $Message"; $script:FailureCount++ }
}
try {
    $Config = Get-Content -LiteralPath $ConfigPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
} catch {
    Write-Output 'FAIL: config must exist and contain valid JSON'
    exit 1
}
Assert-Rule (($Config.appName -is [string]) -and (-not [string]::IsNullOrWhiteSpace($Config.appName))) 'appName must be non-empty text'
Assert-Rule (($Config.environment -is [string]) -and ($Config.environment -ceq 'staging')) 'environment must be exactly staging'
$WholePort = ($Config.port -is [int]) -or ($Config.port -is [long])
Assert-Rule ($WholePort -and ($Config.port -ge 1024) -and ($Config.port -le 65535)) 'port must be a whole number from 1024 to 65535'
Assert-Rule (($Config.healthPath -is [string]) -and ($Config.healthPath.StartsWith('/'))) 'healthPath must be text that starts with /'
if ($script:FailureCount -gt 0) {
    Write-Output "RESULT: FAILED ($script:FailureCount rule(s))"
    exit 1
}
Write-Output 'RESULT: PASSED (4 rules)'
exit 0
