@echo off
cd /d "%~dp0.."
echo Android devices:
flutter devices
echo.
set /p DEVICE_ID=Enter your Android device ID (for example emulator-5554): 
if "%DEVICE_ID%"=="" exit /b 1
flutter test integration_test/app_test.dart -d "%DEVICE_ID%"
pause
