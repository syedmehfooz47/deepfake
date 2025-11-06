# DeepSafe Model Downloader - PowerShell Script
# Downloads models using various methods with fallback options

Write-Host "=" -NoNewline -ForegroundColor Cyan
Write-Host ("=" * 69) -ForegroundColor Cyan
Write-Host "DeepSafe Model Downloader" -ForegroundColor Yellow
Write-Host "=" -NoNewline -ForegroundColor Cyan
Write-Host ("=" * 69) -ForegroundColor Cyan
Write-Host ""

$projectRoot = "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe"
$modelsDir = Join-Path $projectRoot "models"
$venvPython = Join-Path $projectRoot ".venv\Scripts\python.exe"
$folderUrl = "https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O"

# Create models directory if it doesn't exist
if (-not (Test-Path $modelsDir)) {
    New-Item -ItemType Directory -Path $modelsDir -Force | Out-Null
    Write-Host "✓ Created models directory" -ForegroundColor Green
}

Write-Host "Project root: $projectRoot" -ForegroundColor Cyan
Write-Host "Models directory: $modelsDir" -ForegroundColor Cyan
Write-Host ""

# Check current download status
Write-Host "Checking current download status..." -ForegroundColor Yellow
$existingFiles = Get-ChildItem -Path $modelsDir -Recurse -File -ErrorAction SilentlyContinue
$existingSize = ($existingFiles | Measure-Object -Property Length -Sum).Sum
if ($existingSize) {
    $sizeGB = [math]::Round($existingSize / 1GB, 2)
    Write-Host "✓ Found $($existingFiles.Count) files ($sizeGB GB) already downloaded" -ForegroundColor Green
} else {
    Write-Host "  No models downloaded yet" -ForegroundColor Gray
}
Write-Host ""

# Method selection
Write-Host "Available download methods:" -ForegroundColor Yellow
Write-Host "  1. Python gdown (recommended - auto retry on rate limit)"
Write-Host "  2. Manual browser download (most reliable)"
Write-Host "  3. Check existing files only"
Write-Host ""

$choice = Read-Host "Select method (1-3, or press Enter for method 1)"
if ([string]::IsNullOrWhiteSpace($choice)) { $choice = "1" }

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "=" -NoNewline -ForegroundColor Cyan
        Write-Host ("=" * 69) -ForegroundColor Cyan
        Write-Host "Method 1: Python gdown with improved retry logic" -ForegroundColor Yellow
        Write-Host "=" -NoNewline -ForegroundColor Cyan
        Write-Host ("=" * 69) -ForegroundColor Cyan
        Write-Host ""
        
        Write-Host "Starting download..." -ForegroundColor Green
        Write-Host "Note: This may take 30-60 minutes for ~5-8 GB of data" -ForegroundColor Gray
        Write-Host "The script will automatically retry if it encounters rate limits" -ForegroundColor Gray
        Write-Host ""
        
        # Run the improved Python downloader
        & $venvPython download_models_improved.py
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✓ Download completed successfully!" -ForegroundColor Green
        } else {
            Write-Host ""
            Write-Host "⚠ Download encountered issues" -ForegroundColor Yellow
            Write-Host "You can run this script again to resume" -ForegroundColor Gray
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "=" -NoNewline -ForegroundColor Cyan
        Write-Host ("=" * 69) -ForegroundColor Cyan
        Write-Host "Method 2: Manual Browser Download" -ForegroundColor Yellow
        Write-Host "=" -NoNewline -ForegroundColor Cyan
        Write-Host ("=" * 69) -ForegroundColor Cyan
        Write-Host ""
        
        Write-Host "Follow these steps:" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "1. Opening Google Drive folder in your browser..." -ForegroundColor Cyan
        Start-Process $folderUrl
        Start-Sleep -Seconds 2
        Write-Host ""
        Write-Host "2. In the browser:" -ForegroundColor Cyan
        Write-Host "   - You should see the shared folder with model files"
        Write-Host "   - Click the folder name or navigate into it"
        Write-Host "   - Look for 'Download' button or click three dots (...)"
        Write-Host "   - Select 'Download'"
        Write-Host "   - Google will prepare a ZIP file (this may take a few minutes)"
        Write-Host ""
        Write-Host "3. After download completes:" -ForegroundColor Cyan
        Write-Host "   - Locate the downloaded ZIP file (usually in Downloads folder)"
        Write-Host "   - Extract the ZIP file contents"
        Write-Host "   - Copy/Move all extracted folders to:"
        Write-Host "     $modelsDir" -ForegroundColor Green
        Write-Host ""
        Write-Host "4. Verify the structure:" -ForegroundColor Cyan
        Write-Host "   You should have these folders in models/:"
        Write-Host "   - cnndetection_image"
        Write-Host "   - cvit_video"
        Write-Host "   - deepware_video"
        Write-Host "   - faceforensics_image"
        Write-Host "   - ganimagedetection_image"
        Write-Host "   - photoshop_fal_image"
        Write-Host "   - selim_video"
        Write-Host ""
        
        Read-Host "Press Enter when you have completed the manual download"
    }
    
    "3" {
        Write-Host ""
        Write-Host "Checking downloaded files..." -ForegroundColor Yellow
        Write-Host ""
    }
    
    default {
        Write-Host "Invalid choice. Exiting." -ForegroundColor Red
        exit 1
    }
}

# Check final status
Write-Host ""
Write-Host "=" -NoNewline -ForegroundColor Cyan
Write-Host ("=" * 69) -ForegroundColor Cyan
Write-Host "Final Status Check" -ForegroundColor Yellow
Write-Host "=" -NoNewline -ForegroundColor Cyan
Write-Host ("=" * 69) -ForegroundColor Cyan
Write-Host ""

$finalFiles = Get-ChildItem -Path $modelsDir -Recurse -File -ErrorAction SilentlyContinue
$finalSize = ($finalFiles | Measure-Object -Property Length -Sum).Sum
$finalSizeGB = [math]::Round($finalSize / 1GB, 2)

Write-Host "Files in models directory: $($finalFiles.Count)" -ForegroundColor Cyan
Write-Host "Total size: $finalSizeGB GB" -ForegroundColor Cyan
Write-Host ""

# Check for expected model folders
$expectedFolders = @(
    "cnndetection_image",
    "cvit_video",
    "deepware_video",
    "faceforensics_image",
    "ganimagedetection_image",
    "photoshop_fal_image",
    "selim_video"
)

Write-Host "Model folders status:" -ForegroundColor Yellow
foreach ($folder in $expectedFolders) {
    $folderPath = Join-Path $modelsDir $folder
    if (Test-Path $folderPath) {
        $folderFiles = Get-ChildItem -Path $folderPath -Recurse -File -ErrorAction SilentlyContinue
        $folderSize = ($folderFiles | Measure-Object -Property Length -Sum).Sum
        $folderSizeMB = [math]::Round($folderSize / 1MB, 2)
        Write-Host "  ✓ $folder - $($folderFiles.Count) files ($folderSizeMB MB)" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $folder - NOT FOUND" -ForegroundColor Red
    }
}

Write-Host ""

if ($finalSizeGB -ge 3.0) {
    Write-Host "✓ Download appears complete! (Total: $finalSizeGB GB)" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Run the application:" -ForegroundColor Cyan
    Write-Host "   .\start_app.bat" -ForegroundColor White
    Write-Host "   or" -ForegroundColor Gray
    Write-Host "   streamlit run main.py" -ForegroundColor White
    Write-Host ""
    Write-Host "2. The app will open in your browser at http://localhost:8501" -ForegroundColor Cyan
} elseif ($finalSizeGB -gt 0) {
    Write-Host "⚠ Partial download detected ($finalSizeGB GB)" -ForegroundColor Yellow
    Write-Host "Expected size: 5-8 GB" -ForegroundColor Gray
    Write-Host ""
    Write-Host "To complete the download:" -ForegroundColor Yellow
    Write-Host "- Wait 15-30 minutes for Google Drive rate limit to reset"
    Write-Host "- Run this script again (option 1)"
    Write-Host "- Or use manual download (option 2)"
} else {
    Write-Host "✗ No models found" -ForegroundColor Red
    Write-Host "Please run this script again and select a download method" -ForegroundColor Gray
}

Write-Host ""
Write-Host "=" -NoNewline -ForegroundColor Cyan
Write-Host ("=" * 69) -ForegroundColor Cyan
Write-Host ""

# Keep window open
Read-Host "Press Enter to exit"
