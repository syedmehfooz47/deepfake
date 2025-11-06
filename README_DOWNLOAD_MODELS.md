# ⚠️ IMPORTANT: Model Download Instructions

## Current Situation

**Google Drive is blocking automated downloads** due to rate limiting. All automated download attempts have failed with errors:
- "Failed to retrieve file url"
- "Expecting value: line 1 column 1 (char 0)"

## ✅ SOLUTION: Manual Download (5 Simple Steps)

This is the **ONLY reliable method** and takes 15-30 minutes.

---

### Step 1: Open Google Drive

Click this link (or copy-paste into your browser):

**https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O**

---

### Step 2: Sign In

- Use any Google account (free Gmail account works)
- If you see the folder contents, you're ready!

---

### Step 3: Download

**Method A:** Right-click anywhere → Select "Download"

**Method B:** Click the download icon in the toolbar

**Method C:** Press `Shift + D` (keyboard shortcut)

Google will prepare a ZIP file (~5-8 GB). This takes 5-15 minutes.

---

### Step 4: Extract ZIP

**Your ZIP will download to:** (usually) `C:\Users\mehfo\Downloads\`

**Extract to this exact location:**
```
C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models\
```

**Windows Method:**
1. Go to Downloads folder
2. Find the ZIP file (might be named "models.zip" or similar)
3. Right-click → "Extract All..."
4. Browse to: `C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models`
5. Click "Extract"

**PowerShell Method:**
```powershell
# Adjust ZIP path if needed
$zip = "$env:USERPROFILE\Downloads\models.zip"
$dest = "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models"
Expand-Archive -Path $zip -DestinationPath $dest -Force
```

---

### Step 5: Verify

Run this verification script:
```powershell
cd "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe"
.\download_models_manual.ps1
```

**You should see 7 folders:**
- ✓ cnndetection_image
- ✓ cvit_video
- ✓ deepware_video
- ✓ faceforensics_image
- ✓ ganimagedetection_image
- ✓ photoshop_fal_image
- ✓ selim_video

**Total size:** 5-8 GB

---

## 🚀 After Download: Launch the App

### Quick Start:
```batch
start_app.bat
```

### Manual Start:
```powershell
cd "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe"
.venv\Scripts\activate
streamlit run main.py
```

App opens at: **http://localhost:8501**

---

## 🆘 Troubleshooting

### Problem: ZIP extraction fails
**Solution:** Try 7-Zip (free): https://www.7-zip.org/

### Problem: Models folder is empty after extraction
**Cause:** ZIP might have nested folders  
**Solution:**
```powershell
# Check structure
ls "C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\models"

# If you see "models\models\", move files up:
Move-Item "models\models\*" "models\" -Force
Remove-Item "models\models" -Recurse -Force
```

### Problem: Not enough disk space
**Requirement:** 10-15 GB free space  
**Check:** Right-click C: drive → Properties

---

## 📋 Files Already Created for You

✓ `download_models.py` - Original (hits rate limit)  
✓ `download_models_improved.py` - Improved retry logic (still fails)  
✓ `download_models.ps1` - Interactive PowerShell (rate limited)  
✓ `download_models_manual.ps1` - Verification script (use this!)  
✓ `MODEL_DOWNLOAD_GUIDE.md` - Detailed guide  
✓ `MODEL_DOWNLOAD_STATUS.md` - Status tracking  
✓ `start_app.bat` - Easy app launcher  
✓ `SETUP_COMPLETE.md` - Full project documentation

---

## ⏱️ Time Estimate

- **Google Drive visit:** 1 minute
- **ZIP preparation:** 5-15 minutes
- **ZIP download:** 10-30 minutes (depends on internet)
- **Extraction:** 2-5 minutes
- **Total:** 20-50 minutes

---

## ✅ What's Already Done

✓ Python 3.13.9 virtual environment configured  
✓ All dependencies installed (TensorFlow, PyTorch, Streamlit, etc.)  
✓ All code files fixed (deprecated functions updated)  
✓ Directory structure created  
✓ Startup scripts created  
✓ Documentation complete  

**ONLY REMAINING:** Model download (manual browser download required)

---

## 🎯 Action Required

1. **Open browser**
2. **Go to:** https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O
3. **Download folder** (right-click → Download)
4. **Extract ZIP** to models\ folder
5. **Run:** `.\start_app.bat`

---

**Need help?** See `MODEL_DOWNLOAD_GUIDE.md` for detailed instructions.
