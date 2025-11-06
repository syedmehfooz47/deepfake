"""
Improved model downloader with retry logic and rate limit handling
Downloads models from Google Drive folder to models/ directory
"""

import os
import time
import gdown
from pathlib import Path

def download_with_retry(url, output, max_retries=3, wait_time=10):
    """Download with retry logic"""
    for attempt in range(max_retries):
        try:
            print(f"\nAttempt {attempt + 1}/{max_retries} for {os.path.basename(output)}")
            gdown.download(url, output, quiet=False, fuzzy=True)
            if os.path.exists(output) and os.path.getsize(output) > 0:
                print(f"✓ Successfully downloaded: {os.path.basename(output)}")
                return True
        except Exception as e:
            print(f"✗ Error: {str(e)}")
            if attempt < max_retries - 1:
                print(f"Waiting {wait_time} seconds before retry...")
                time.sleep(wait_time)
                wait_time *= 2  # Exponential backoff
    return False

def main():
    print("=" * 70)
    print("DeepSafe Model Downloader - Improved Version")
    print("=" * 70)
    
    # Get the project root directory
    project_root = Path(__file__).parent.absolute()
    models_dir = project_root / "models"
    
    # Create models directory if it doesn't exist
    models_dir.mkdir(exist_ok=True)
    
    print(f"\nProject root: {project_root}")
    print(f"Models directory: {models_dir}")
    
    # Google Drive folder ID
    folder_id = "1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O"
    
    print(f"\n{'='*70}")
    print("DOWNLOADING ENTIRE FOLDER")
    print(f"{'='*70}")
    print(f"Folder ID: {folder_id}")
    print(f"Destination: {models_dir}")
    print("\nThis may take 30-60 minutes depending on your connection...")
    print("Download size: ~5-8 GB")
    print(f"{'='*70}\n")
    
    try:
        # Use gdown.download_folder with options to handle rate limits
        print("Starting folder download...")
        print("Note: This will download ALL model files in the folder\n")
        
        # Download the entire folder
        gdown.download_folder(
            id=folder_id,
            output=str(models_dir),
            quiet=False,
            use_cookies=False,
            remaining_ok=True  # Continue even if some files fail
        )
        
        print("\n" + "="*70)
        print("Download process completed!")
        print("="*70)
        
        # Check what was downloaded
        if models_dir.exists():
            total_size = 0
            file_count = 0
            for root, dirs, files in os.walk(models_dir):
                for file in files:
                    file_path = os.path.join(root, file)
                    total_size += os.path.getsize(file_path)
                    file_count += 1
            
            size_gb = total_size / (1024**3)
            print(f"\nDownload Summary:")
            print(f"  Files downloaded: {file_count}")
            print(f"  Total size: {size_gb:.2f} GB")
            print(f"  Location: {models_dir}")
            
            if size_gb < 1.0:
                print("\n⚠ Warning: Total size is smaller than expected (< 1 GB)")
                print("Some files may not have been downloaded due to rate limits.")
                print("\nRecommended actions:")
                print("1. Wait 15-30 minutes")
                print("2. Run this script again (it will skip existing files)")
                print("3. Or download manually from:")
                print(f"   https://drive.google.com/drive/folders/{folder_id}")
            else:
                print("\n✓ Download appears successful!")
                print("\nNext steps:")
                print("1. Run: .\\start_app.bat")
                print("2. Or run: streamlit run main.py")
        
    except KeyboardInterrupt:
        print("\n\nDownload interrupted by user.")
        print("You can resume by running this script again.")
    except Exception as e:
        print(f"\n✗ Error during download: {str(e)}")
        print("\nAlternative download method:")
        print(f"1. Visit: https://drive.google.com/drive/folders/{folder_id}")
        print("2. Click the folder name")
        print("3. Click 'Download' or three dots (...) > Download")
        print("4. Extract the downloaded ZIP to the 'models' folder")
        return 1
    
    return 0

if __name__ == "__main__":
    exit(main())
