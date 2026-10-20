@echo off
cd /d "%~dp0.."
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter is not in PATH. Install Flutter SDK and restart VS Code.
  pause
  exit /b 1
)
flutter create . --project-name online_store --platforms=android,web,windows
if errorlevel 1 goto fail
flutter pub get
if errorlevel 1 goto fail
echo.
echo Project is ready. Use scripts\run_web.bat to launch it.
pause
exit /b 0
:fail
echo Setup failed. Please read README.md.
pause
exit /b 1
