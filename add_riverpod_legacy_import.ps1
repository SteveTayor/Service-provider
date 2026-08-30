$libPath = Join-Path (Get-Location) "lib"

if (-not (Test-Path $libPath)) {
    Write-Host "ERROR: lib folder not found." -ForegroundColor Red
    exit 1
}

$legacyImport = "import 'package:flutter_riverpod/legacy.dart';"

# APIs that moved to Riverpod's legacy compatibility library.
$legacyApis = @(
    '\bStateNotifier\b',
    '\bStateNotifierProvider\b',
    '\bStateProvider\b',
    '\bChangeNotifierProvider\b'
)

$files = Get-ChildItem -Path $libPath -Recurse -Filter "*.dart" |
    Where-Object {
        $_.Name -notlike "*.g.dart" -and
        $_.Name -notlike "*.freezed.dart"
    }

$changed = 0
$skipped = 0

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw

    # Already imported.
    if ($content -match [regex]::Escape($legacyImport)) {
        $skipped++
        continue
    }

    # Check whether this file actually uses a legacy Riverpod API.
    $usesLegacyApi = $false

    foreach ($api in $legacyApis) {
        if ($content -match $api) {
            $usesLegacyApi = $true
            break
        }
    }

    if (-not $usesLegacyApi) {
        continue
    }

    # Prefer putting the import immediately after flutter_riverpod.dart.
    $flutterRiverpodImport =
        "import 'package:flutter_riverpod/flutter_riverpod.dart';"

    if ($content.Contains($flutterRiverpodImport)) {
        $replacement =
            "$flutterRiverpodImport`r`n$legacyImport"

        $newContent = $content.Replace(
            $flutterRiverpodImport,
            $replacement
        )
    }
    else {
        # If flutter_riverpod import isn't present, insert after the
        # last package import.
        $matches = [regex]::Matches(
            $content,
            "(?m)^import ['""][^'""]+['""];"
        )

        if ($matches.Count -gt 0) {
            $lastImport = $matches[$matches.Count - 1]

            $insertPosition =
                $lastImport.Index + $lastImport.Length

            $newContent =
                $content.Substring(0, $insertPosition) +
                "`r`n$legacyImport" +
                $content.Substring($insertPosition)
        }
        else {
            $newContent =
                "$legacyImport`r`n`r`n$content"
        }
    }

    Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8

    Write-Host "UPDATED: $($file.FullName)" -ForegroundColor Green
    $changed++
}

Write-Host ""
Write-Host "Finished." -ForegroundColor Cyan
Write-Host "Files updated: $changed"
Write-Host "Files already containing import: $skipped"