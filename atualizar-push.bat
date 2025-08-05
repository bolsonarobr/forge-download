@echo off
cd /d "%~dp0"
git add .
git commit -m "Atualiza FORGE.exe"
git push
pause
