$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$pluginJsonPath = Join-Path $repoRoot '.claude-plugin\plugin.json'

if (-not (Test-Path $pluginJsonPath)) {
    throw "Plugin manifest not found: $pluginJsonPath"
}

$json = Get-Content -Path $pluginJsonPath -Raw | ConvertFrom-Json

if (-not $json.version) {
    $json.version = '1.0.0'
}

$version = [version]::Parse($json.version)
$newVersion = [version]::new($version.Major, $version.Minor, $version.Build + 1)
$json.version = $newVersion.ToString()

$json | ConvertTo-Json -Depth 10 | Set-Content -Path $pluginJsonPath -Encoding utf8

Write-Output "Plugin version bumped to $($json.version)"
