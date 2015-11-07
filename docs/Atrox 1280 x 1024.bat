@echo off
taskkill /f /im explorer.exe
"C:\Program Files\Joymax\Atrox\Atrox 1280 x 1024.exe"
echo 아무키나 누르면 다시 탐색기를 시작합니다.
pause >nul
start explorer.exe