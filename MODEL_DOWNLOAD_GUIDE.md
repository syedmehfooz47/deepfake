# Model Download Guide - DeepSafe Platform

## Current Status: Rate Limiting Issues with Automated Download

Google Drive is enforcing strict rate limits on the model folder, preventing fully automated downloads. This guide provides multiple solutions.

---

## 🎯 RECOMMENDED METHOD: Manual Browser Download

This is **the most reliable** method and will complete in 15-30 minutes.

### Step-by-Step Instructions:

#### 1. Open the Google Drive Folder
Click this link or copy-paste into your browser:
```
https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O
```

#### 2. Sign In to Google Account
- If not signed in, use any Google account
- Free Google accounts work fine

#### 3. Download the Folder
You have two options:

**Option A: Download entire folder**
- Right-click anywhere in the file list
- Select "Download" or click the three dots menu (⋮)
- Click "Download"

**Option B: Download as ZIP**
- Click the folder name if inside it
- Use the download button in the toolbar
- Or use keyboard shortcut: `Shift + D`

#### 4. Wait for ZIP Preparation
- Google Drive will prepare a ZIP file
- This takes 5-15 minutes for ~5-8 GB
- You'll see a progress indicator
- The ZIP will download automatically when ready

#### 5. Extract the ZIP File

**Location:**
```
C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models\
```

**Using Windows Explorer:**
1. Locate the downloaded ZIP (usually in `Downloads` folder)
2. Right-click the ZIP file
3. Select "Extract All..."
4. Browse to the models folder: `C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models`
5. Click "Extract"

**Using PowerShell:**
```powershell
# Adjust the ZIP file path if different
$zipPath = "$env:USERPROFILE\Downloads\models.zip"
$destination = "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models"

Expand-Archive -Path $zipPath -DestinationPath $destination -Force
```

#### 6. Verify the Structure

After extraction, your folder structure should look like:
```
models/
├── __pycache__/
├── cnndetection_image/
│   ├── networks/
│   ├── weights/
│   │   └── blur_jpg_prob0.5.pth (282 MB)
│   ├── __init__.py
│   ├── demo.py
│   └── predictor.py
├── cvit_video/
│   ├── helpers/
│   ├── model/
│   ├── preprocessing/
│   ├── weight/
│   │   ├── deepdeepfake_cvit_gpu_ep50.pkl
│   │   └── deepfake_cvit_gpu_inference_ep_50.pth
│   └── demo.py
├── deepware_video/
│   ├── weights/
│   │   └── deepware.pt
│   └── demo.py
├── faceforensics_image/
│   ├── architectures/
│   ├── blazeface/
│   └── weights/
├── ganimagedetection_image/
│   ├── weights/
│   │   ├── gandetection_resnet50nodown_progan.pth
│   │   └── gandetection_resnet50nodown_stylegan2.pth
│   └── demo.py
├── photoshop_fal_image/
│   ├── networks/
│   ├── utils/
│   ├── weights/
│   │   ├── global.pth
│   │   └── local.pth
│   └── demo.py
└── selim_video/
    ├── configs/
    ├── preprocessing/
    ├── training/
    ├── weights/
    │   └── (multiple EfficientNet weight files)
    └── demo.py
```

#### 7. Verify Download Success

Run the verification script:
```powershell
cd "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe"
.\download_models_manual.ps1
```

Or check manually:
- **Expected total size:** 5-8 GB
- **Expected folders:** 7 model folders
- **Critical files:** Look for `.pth`, `.pt`, `.pkl` weight files in each model's weight folder

---

## 🔧 ALTERNATIVE METHOD 1: Automated with Retry

The automated script attempts to download with rate limit handling:

```powershell
cd "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe"
.\.venv\Scripts\python.exe download_models_improved.py
```

**Pros:**
- Fully automated
- Resumes if interrupted
- Skips already-downloaded files

**Cons:**
- May still hit rate limits
- Requires multiple attempts
- Can take several hours with retries

---

## 🔧 ALTERNATIVE METHOD 2: Individual Model Downloads

Download each model folder separately with delays:

1. **cnndetection_image** (~300 MB)
2. **cvit_video** (~1-2 GB)  
3. **deepware_video** (~500 MB)
4. **faceforensics_image** (~1-2 GB)
5. **ganimagedetection_image** (~500 MB)
6. **photoshop_fal_image** (~500 MB)
7. **selim_video** (~1-2 GB)

Visit the Google Drive folder and download each subfolder individually, waiting 5-10 minutes between downloads to avoid rate limits.

---

## ✅ After Download Completes

### 1. Verify Installation
```powershell
# Check models directory
Get-ChildItem "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models" -Recurse

# Check size
$size = (Get-ChildItem "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models" -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1GB
Write-Host "Total size: $([math]::Round($size, 2)) GB"
```

### 2. Launch the Application

**Easy Method:**
```batch
start_app.bat
```

**Manual Method:**
```powershell
cd "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe"
.\.venv\Scripts\activate
streamlit run main.py
```

### 3. Test the Application
- Open http://localhost:8501 in your browser
- Upload a test image or video
- Try different detection models
- Verify results are generated

---

## 🚨 Troubleshooting

### Download Keeps Failing
**Solution:** Use the manual browser download method (most reliable)

### ZIP Extraction Fails
**Solution:** 
- Ensure you have enough disk space (~10 GB free)
- Try extracting to a different location first, then move to models/
- Use 7-Zip if Windows extraction fails

### Models Folder Empty After Extraction
**Issue:** ZIP might have nested folders  
**Solution:**
```powershell
# Check for nested structure
Get-ChildItem "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models" -Directory

# If you see an extra "models" folder inside models/, move contents up one level:
Move-Item "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models\models\*" `
          "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models\" -Force
```

### Application Won't Start
**Check:**
1. All 7 model folders are present
2. Weight files (.pth, .pt, .pkl) exist in each model's weight subfolder
3. Total size is at least 3-5 GB

---

## 📊 Expected Download Specifications

| Model | Size | Critical Files |
|-------|------|----------------|
| cnndetection_image | ~300 MB | blur_jpg_prob0.5.pth |
| cvit_video | ~1-2 GB | deepfake_cvit_gpu_inference_ep_50.pth |
| deepware_video | ~500 MB | deepware.pt |
| faceforensics_image | ~1-2 GB | Multiple architecture files |
| ganimagedetection_image | ~500 MB | resnet50 .pth files |
| photoshop_fal_image | ~500 MB | global.pth, local.pth |
| selim_video | ~1-2 GB | EfficientNet weight files |

**Total:** ~5-8 GB

---

## 📞 Support

**If issues persist:**

1. **Check existing files:**
   ```powershell
   .\download_models_manual.ps1
   ```

2. **Original repository:** https://github.com/siddharthksah/DeepSafe

3. **Google Drive folder:** https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O

---

**Last Updated:** November 6, 2025  
**Status:** Manual download recommended due to Google Drive rate limits
