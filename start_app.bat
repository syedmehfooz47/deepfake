@echo off
echo Starting DeepSafe Application...
echo.
cd /d "%~dp0"
call ".venv\Scripts\activate.bat"
echo Virtual environment activated
echo.
echo Starting Streamlit server...
streamlit run main.py --server.enableCORS=false --server.enableXsrfProtection=false --server.maxUploadSize=200
pause
