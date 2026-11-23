@echo off
cd /d "%~dp0"
echo Demarrage de Surface Piece...
start "Serveur Surface Piece" powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0serveur-local.ps1"
for /l %%i in (1,1,20) do (
  powershell.exe -NoProfile -Command "try { $r=Invoke-WebRequest -UseBasicParsing http://localhost:8765/ -TimeoutSec 1; if($r.StatusCode -eq 200){exit 0}else{exit 1} } catch { exit 1 }" >nul 2>nul
  if not errorlevel 1 goto ready
  timeout /t 1 /nobreak >nul
)
echo.
echo Impossible de demarrer le serveur local. Verifie que PowerShell est disponible et que le port 8765 est libre.
pause
exit /b 1
:ready
start "" http://localhost:8765/
echo Surface Piece est lancee. Garde la fenetre du serveur ouverte.
