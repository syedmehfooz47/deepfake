# DeepSafe Project - Setup Complete

## Summary of Work Completed

### 1. Virtual Environment Configuration ✓
- Successfully configured Python virtual environment at: `C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\.venv`
- Python Version: 3.13.9

### 2. Dependencies Installation ✓
All required packages have been successfully installed:

#### Core Scientific Computing
- numpy==2.2.6
- scipy==1.16.3
- pandas==2.3.3
- matplotlib==3.10.7
- pillow==12.0.0
- scikit-learn==1.7.2
- scikit-image==0.25.2
- opencv-python-headless==4.12.0.88

#### Deep Learning Frameworks
- torch==2.9.0+cpu
- torchvision==0.24.0+cpu
- tensorflow==2.20.0
- keras==3.12.0
- efficientnet-pytorch==0.7.1

#### Web Framework & UI
- streamlit==1.51.0
- altair==5.5.0
- plotly==6.4.0
- bokeh==3.8.0
- Flask==3.1.2

#### Utility Packages
- requests==2.32.5
- validators==0.35.0
- tqdm==4.67.1
- gdown==5.2.0
- yt-dlp==2025.10.22
- boto3==1.40.67
- av==16.0.1
- pathvalidate==3.3.1

### 3. Code Fixes ✓
Fixed deprecated function calls:
- Changed `@st.cache` to `@st.cache_data` in `utils/save_uploaded_image_temp.py`
- Changed `st.experimental_rerun()` to `st.rerun()` in `examples/show_sample_deepfakes_from_url.py`

### 4. Directory Structure ✓
Created required directories:
- temp/
- stats/ (with state.txt and state.csv initialized)
- database/
- models/ (currently being populated with model files)

### 5. Model Download ⏳
Models are currently being downloaded from Google Drive using gdown.
The download includes multiple deepfake detection models:
- CViT (image)
- Deepware (video)
- FaceForensics (image)
- GANImageDetection (image)
- And more...

### 6. Requirements.txt ✓
Updated requirements.txt with compatible versions for Python 3.13:
```
numpy>=1.24.0
scikit-learn>=1.3.0
scikit-image>=0.21.0
albumentations>=1.3.0
av>=10.0.0
bokeh>=3.0.0
boto3>=1.26.0
efficientnet-pytorch>=0.7.1
facenet-pytorch>=2.5.2
Flask>=2.3.0
image-similarity-measures>=0.3.5
matplotlib>=3.7.0
opencv-python-headless>=4.7.0
pandas>=2.0.0
pathvalidate>=3.0.0
Pillow>=10.0.0
plotly>=5.14.0
pretrainedmodels>=0.7.4
requests>=2.31.0
scipy>=1.11.0
streamlit>=1.28.0
torch>=2.0.0
torchvision>=0.15.0
validators>=0.20.0
protobuf>=4.21.0
click>=8.1.0
altair>=5.0.0
tensorflow>=2.15.0
gdown>=5.0.0
tqdm>=4.65.0
yt-dlp>=2024.0.0
```

## How to Run the Application

### Method 1: Using the Batch Script (Easiest)
Simply double-click `start_app.bat` in the project root directory.

### Method 2: Using PowerShell
```powershell
cd 'C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe'
& 'C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe\.venv\Scripts\python.exe' -m streamlit run main.py
```

### Method 3: Using Virtual Environment Activation
```powershell
cd 'C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe'
.venv\Scripts\Activate.ps1
streamlit run main.py
```

## Next Steps

1. **Wait for Model Download to Complete**
   - The model download is currently in progress
   - Check the terminal running `download_models.py` for completion status
   - Models will be saved in the `models/` directory

2. **Test the Application**
   - Once models are downloaded, run the application using one of the methods above
   - Access the web interface at `http://localhost:8501`

3. **Features to Test**
   - Image upload and deepfake detection
   - Video upload and deepfake detection
   - URL-based media analysis
   - Multiple model comparisons
   - Benchmarking datasets
   - Examples gallery

## Project Features

### Core Functionality
- Multi-model deepfake detection for images and videos
- File upload support (jpg, png, jpeg, mp4, mov)
- URL input for image/video analysis
- GPU/CPU processing selection
- Result visualization with charts
- Downloadable CSV results

### Additional Features
- Examples gallery with sample deepfakes
- Dataset benchmarking capabilities
- Model comparison tools
- Educational resources about deepfakes
- Custom dataset support

## Troubleshooting

### If models haven't downloaded:
Run the download script manually:
```powershell
cd 'C:\Users\mehfo\OneDrive\Documents\VS CODE\Deepfake\DeepSafe'
& '.venv\Scripts\python.exe' download_models.py
```

### If you encounter import errors:
Reinstall dependencies:
```powershell
& '.venv\Scripts\python.exe' -m pip install -r requirements.txt
```

### If streamlit doesn't start:
Check if it's installed:
```powershell
& '.venv\Scripts\python.exe' -m pip list | findstr streamlit
```

## File Structure

```
DeepSafe/
├── main.py                 # Main application file
├── requirements.txt        # Python dependencies
├── download_models.py      # Model download script
├── start_app.bat          # Easy startup script
├── .venv/                 # Virtual environment
├── assets/                # Static assets
├── database/              # Inference history
├── datasets/              # Custom datasets
│   ├── image/
│   └── video/
├── examples/              # Sample code
├── leaderboard/           # Benchmark results
├── models/                # Downloaded model files
├── stats/                 # Usage statistics
├── temp/                  # Temporary file storage
└── utils/                 # Utility functions
```

## System Requirements

- **Python**: 3.13+ (using 3.13.9)
- **OS**: Windows 10/11
- **RAM**: Minimum 8GB (16GB recommended)
- **Storage**: ~10GB for models and dependencies
- **Optional**: CUDA-capable GPU for faster processing

## Notes

- The application uses CPU by default for PyTorch operations
- GPU support can be enabled if CUDA is available
- All temporary files are automatically cleaned up
- No uploaded media is stored permanently
- Analytics are tracked using streamlit-analytics

## Support

For issues or questions:
- Check the main README.md for detailed documentation
- Review the original repository: https://github.com/siddharthksah/DeepSafe
- Contact: siddharth123sk@gmail.com

---

**Project Status**: ✅ Setup Complete - Ready to use once model download finishes
**Date**: November 6, 2025
**Version**: 1.0
