# THOX Local Models Validation Script for Windows PowerShell
# Exit code 0 if all checks pass, 1 if any required files are missing or JSON is invalid

# Locate repository root (current directory or first parent with thox-local-models)
$repoRoot = Get-Location
while ($repoRoot.Parent.Path) {
    if (Test-Path Join-Path $repoRoot.Path "thox-local-models") {
        $repoRoot = Join-Path $repoRoot.Path "thox-local-models"
    }
    else {
        $repoRoot = $repoRoot.Parent
    }
}
Set-Location $repoRoot

# Check that models/ directory exists
Write-Host "=== Checking models/ directory ==="
if (-not (Test-Path "$repoRoot/models")) {
    Write-Host "FAIL: models/ directory is missing" -ForegroundColor Red
    exit 1
}

# Check for expected Gemma E2B GGUF file
Write-Host "=== Checking Gemma E2B GGUF file ==="
$gemmaGguf = "$repoRoot/models/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-Q4_K_P.gguf"
if (-not (Test-Path $gemmaGguf)) {
    Write-Host "FAIL: Missing Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-Q4_K_P.gguf" -ForegroundColor Red
    exit 1
}
Write-Host "OK: Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-Q4_K_P.gguf found" -ForegroundColor Green

# Check for expected Gemma E2B mmproj file
Write-Host "=== Checking Gemma E2B mmproj file ==="
$mmproj = "$repoRoot/models/mmproj-Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-f16.gguf"
if (-not (Test-Path $mmproj)) {
    Write-Host "FAIL: Missing mmproj-Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-f16.gguf" -ForegroundColor Red
    exit 1
}
Write-Host "OK: mmproj-Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-f16.gguf found" -ForegroundColor Green

# Check for at least one Qwythos 9B GGUF file containing Q4_K_M in filename
Write-Host "=== Checking Qwythos 9B GGUF file ==="
$qwythosGguf = Get-ChildItem -Path "$repoRoot/models" -Filter "*Qwythos*Q4_K_M*" -ErrorAction SilentlyContinue
if (-not $qwythosGguf) {
    Write-Host "FAIL: Missing Qwythos 9B GGUF file with Q4_K_M in filename" -ForegroundColor Red
    exit 1
}
Write-Host "OK: Found Qwythos 9B GGUF: $($qwythosGguf.Name)" -ForegroundColor Green

# Read both manifest files
Write-Host "=== Validating manifest JSON files ==="
$visionManifest = Join-Path $repoRoot "manifests" "thox-local-vision-e2b.json"
$codeManifest = Join-Path $repoRoot "manifests" "thox-local-code-9b.json"

function Read-Json-Safe {
    param([string]$path)
    if (-not (Test-Path $path)) {
        Write-Host "FAIL: Manifest missing: $path" -ForegroundColor Red
        return $null
    }
    try {
        $content = Get-Content -Path $path -Raw -Encoding UTF8
        $json = [System.Text.Json.JsonDocument]::Parse($content)
        $obj = [System.Text.Json.JsonElement]::ToElement($json.RootElement).ToObject()
        Write-Host "OK: $path loaded successfully" -ForegroundColor Green
        return $obj
    }
    catch {
        Write-Host "FAIL: JSON parse error in $path: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

$visionObj = Read-Json-Safe $visionManifest
if (-not $visionObj) { exit 1 }
$codeObj = Read-Json-Safe $codeManifest
if (-not $codeObj) { exit 1 }

# Validate required JSON fields in both manifests
Write-Host "=== Checking required JSON fields ==="
$requiredFields = @("id", "display_name", "family", "role", "upstream", "capabilities", "runtime", "generation", "thox")
foreach ($field in $requiredFields) {
    $missing = @()
    if (-not ($visionObj | Select-Object -ExpandProperty $field)) { $missing += $field }
    if (-not ($codeObj | Select-Object -ExpandProperty $field)) { $missing += $field }
}
if ($missing.Count -gt 0) {
    Write-Host "FAIL: Missing fields in manifests: $($missing -join ', ')" -ForegroundColor Red
    exit 1
}
Write-Host "OK: All required fields present" -ForegroundColor Green

# Validate upstream block has repo and url for each manifest
Write-Host "=== Checking upstream fields (repo and url) ==="
$visionUpstream = $visionObj.upstream
$codeUpstream = $codeObj.upstream
foreach ($field in @("repo", "url")) {
    if (-not ($visionUpstream | Select-Object -ExpandProperty $field)) {
        Write-Host "FAIL: thox-local-vision-e2b missing upstream.$field" -ForegroundColor Red
        exit 1
    }
    if (-not ($codeUpstream | Select-Object -ExpandProperty $field)) {
        Write-Host "FAIL: thox-local-code-9b missing upstream.$field" -ForegroundColor Red
        exit 1
    }
}
Write-Host "OK: All upstream fields present" -ForegroundColor Green

# Validate exact upstream URLs
Write-Host "=== Validating upstream URLs ==="
$expectedGemmaUrl = "https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive"
$expectedQwythosUrl = "https://huggingface.co/llmfan46/Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF"
if ($visionUpstream.url -ne $expectedGemmaUrl) {
    Write-Host "FAIL: thox-local-vision-e2b upstream.url mismatch: $($visionUpstream.url)" -ForegroundColor Red
    exit 1
}
if ($codeUpstream.url -ne $expectedQwythosUrl) {
    Write-Host "FAIL: thox-local-code-9b upstream.url mismatch: $($codeUpstream.url)" -ForegroundColor Red
    exit 1
}
Write-Host "OK: All upstream URLs verified" -ForegroundColor Green

# Print final status table
Write-Host "`n=== Validation Summary ===" -ForegroundColor Cyan
Write-Host "Models directory:      OK" -ForegroundColor Green
Write-Host "Gemma GGUF file:       OK" -ForegroundColor Green
Write-Host "Gemma mmproj file:     OK" -ForegroundColor Green
Write-Host "Qwythos GGUF file:     OK" -ForegroundColor Green
Write-Host "Vision manifest JSON:  OK" -ForegroundColor Green
Write-Host "Code manifest JSON:    OK" -ForegroundColor Green
Write-Host "All upstream URLs:     OK" -ForegroundColor Green
Write-Host "All required fields:   OK" -ForegroundColor Green
Write-Host "`nAll checks passed!" -ForegroundColor Green
exit 0
