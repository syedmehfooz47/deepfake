# Alternative Model Downloader - Direct File IDs
# This script downloads model files one at a time with delays to avoid rate limits

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "DeepSafe Alternative Model Downloader" -ForegroundColor Yellow
Write-Host "Direct file download with rate limit avoidance" -ForegroundColor Yellow
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""

$projectRoot = "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe"
$modelsDir = Join-Path $projectRoot "models"
$venvPython = Join-Path $projectRoot ".venv\Scripts\python.exe"

# Create models directory structure
$modelFolders = @(
    "cnndetection_image\weights",
    "cvit_video\weight",
    "deepware_video\weights",
    "faceforensics_image\architectures",
    "ganimagedetection_image\weights",
    "photoshop_fal_image\weights",
    "selim_video\weights"
)

Write-Host "Creating directory structure..." -ForegroundColor Yellow
foreach ($folder in $modelFolders) {
    $fullPath = Join-Path $modelsDir $folder
    if (-not (Test-Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
        Write-Host "  Created: $folder" -ForegroundColor Green
    }
}
Write-Host ""

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "IMPORTANT NOTICE" -ForegroundColor Yellow
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Google Drive is currently rate limiting automated downloads." -ForegroundColor Yellow
Write-Host "The most reliable method is:" -ForegroundColor Yellow
Write-Host ""
Write-Host "MANUAL DOWNLOAD (Recommended):" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Open this link in your browser:" -ForegroundColor White
Write-Host "   https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O" -ForegroundColor Green
Write-Host ""
Write-Host "2. Sign in to your Google account (if not already signed in)" -ForegroundColor White
Write-Host ""
Write-Host "3. Right-click the 'models' folder or click the three dots (...)" -ForegroundColor White
Write-Host ""
Write-Host "4. Select 'Download'" -ForegroundColor White
Write-Host "   - Google will prepare a ZIP file (may take 5-10 minutes)" -ForegroundColor Gray
Write-Host "   - The ZIP will be ~5-8 GB" -ForegroundColor Gray
Write-Host ""
Write-Host "5. After download completes:" -ForegroundColor White
Write-Host "   - Open the ZIP file" -ForegroundColor Gray
Write-Host "   - Extract all contents to this location:" -ForegroundColor Gray
Write-Host "     $modelsDir" -ForegroundColor Green
Write-Host ""
Write-Host "6. Verify the structure:" -ForegroundColor White
Write-Host "   After extraction, you should have:" -ForegroundColor Gray
Write-Host "   models\" -ForegroundColor Gray
Write-Host "   ├── cnndetection_image\" -ForegroundColor Gray
Write-Host "   ├── cvit_video\" -ForegroundColor Gray
Write-Host "   ├── deepware_video\" -ForegroundColor Gray
Write-Host "   ├── faceforensics_image\" -ForegroundColor Gray
Write-Host "   ├── ganimagedetection_image\" -ForegroundColor Gray
Write-Host "   ├── photoshop_fal_image\" -ForegroundColor Gray
Write-Host "   └── selim_video\" -ForegroundColor Gray
Write-Host ""
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""

$openBrowser = Read-Host "Open Google Drive folder in browser now? (Y/n)"
if ($openBrowser -ne "n" -and $openBrowser -ne "N") {
    Write-Host ""
    Write-Host "Opening Google Drive in your default browser..." -ForegroundColor Green
    Start-Process "https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O"
    Write-Host "✓ Browser opened" -ForegroundColor Green
}

Write-Host ""
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""

$continueCheck = Read-Host "Have you completed the download and extraction? (y/N)"
if ($continueCheck -eq "y" -or $continueCheck -eq "Y") {
    Write-Host ""
    Write-Host "Verifying downloaded models..." -ForegroundColor Yellow
    Write-Host ""
    
    # Check each model folder
    $expectedFolders = @(
        "cnndetection_image",
        "cvit_video",
        "deepware_video",
        "faceforensics_image",
        "ganimagedetection_image",
        "photoshop_fal_image",
        "selim_video"
    )
    
    $allPresent = $true
    $totalSize = 0
    $totalFiles = 0
    
    foreach ($folder in $expectedFolders) {
        $folderPath = Join-Path $modelsDir $folder
        if (Test-Path $folderPath) {
            $files = Get-ChildItem -Path $folderPath -Recurse -File -ErrorAction SilentlyContinue
            $folderSize = ($files | Measure-Object -Property Length -Sum).Sum
            $sizeMB = [math]::Round($folderSize / 1MB, 2)
            $totalSize += $folderSize
            $totalFiles += $files.Count
            Write-Host "  ✓ $folder" -ForegroundColor Green -NoNewline
            Write-Host " - $($files.Count) files ($sizeMB MB)" -ForegroundColor Gray
        } else {
            Write-Host "  ✗ $folder - NOT FOUND" -ForegroundColor Red
            $allPresent = $false
        }
    }
    
    $totalSizeGB = [math]::Round($totalSize / 1GB, 2)
    
    Write-Host ""
    Write-Host "Total: $totalFiles files ($totalSizeGB GB)" -ForegroundColor Cyan
    Write-Host ""
    
    if ($allPresent -and $totalSizeGB -ge 3.0) {
        Write-Host "=================================================================" -ForegroundColor Green
        Write-Host "✓ ALL MODELS SUCCESSFULLY DOWNLOADED!" -ForegroundColor Green
        Write-Host "=================================================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "You can now run the application:" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Method 1 (Easy):" -ForegroundColor Cyan
        Write-Host "  .\start_app.bat" -ForegroundColor White
        Write-Host ""
        Write-Host "Method 2 (Direct):" -ForegroundColor Cyan
        Write-Host "  streamlit run main.py" -ForegroundColor White
        Write-Host ""
        Write-Host "The app will open at: http://localhost:8501" -ForegroundColor Gray
        Write-Host ""
    } elseif ($totalSizeGB -gt 0) {
        Write-Host "⚠ Partial download detected" -ForegroundColor Yellow
        Write-Host "Expected: ~5-8 GB, Found: $totalSizeGB GB" -ForegroundColor Gray
        Write-Host ""
        Write-Host "Please ensure all model folders are extracted correctly" -ForegroundColor Yellow
    } else {
        Write-Host "✗ No models found" -ForegroundColor Red
        Write-Host "Please complete the download and extraction, then run this script again" -ForegroundColor Gray
    }
} else {
    Write-Host ""
    Write-Host "No problem! Follow the instructions above to download the models." -ForegroundColor Yellow
    Write-Host "Run this script again after completing the download to verify." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to exit"
