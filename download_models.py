"""
Script to download all required model files from Google Drive
This script uses gdown to download the entire models folder
"""
import os
import gdown

def download_models_from_drive():
    """
    Downloads the models folder from Google Drive
    Folder ID: 1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O
    """
    
    # Create models directory if it doesn't exist
    models_dir = './models'
    if not os.path.exists(models_dir):
        os.makedirs(models_dir)
        print(f"Created {models_dir} directory")
    
    # Google Drive folder link
    folder_url = 'https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O'
    
    print("Starting download of models from Google Drive...")
    print("This may take a while depending on your internet connection...")
    
    try:
        # Download entire folder
        gdown.download_folder(folder_url, output=models_dir, quiet=False, use_cookies=False)
        print("\nModels downloaded successfully!")
        
        # List downloaded models
        print("\nDownloaded models:")
        for item in os.listdir(models_dir):
            item_path = os.path.join(models_dir, item)
            if os.path.isdir(item_path):
                print(f"  - {item}")
                
    except Exception as e:
        print(f"\nError downloading models: {e}")
        print("\nAlternative method:")
        print("1. Visit: https://drive.google.com/drive/folders/1bdzx0TJELfHQ4dDtzeTFtTFMpO4U7I-O")
        print("2. Download the entire folder manually")
        print("3. Extract contents to the 'models' directory")
        return False
    
    return True

if __name__ == "__main__":
    success = download_models_from_drive()
    if success:
        print("\n✓ Setup complete! You can now run the application.")
    else:
        print("\n✗ Download failed. Please download models manually.")
