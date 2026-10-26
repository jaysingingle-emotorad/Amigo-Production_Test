@echo off
title EMotorad Amigo Display & PCB Production Tester
echo ===================================================================
echo     EMotorad Amigo Display & PCB Production Tester
echo ===================================================================
echo.
echo Starting local test server on http://localhost:8000 ...
echo Opening Google Chrome / Microsoft Edge ...
echo.

cd /d "%~dp0"

start "" http://localhost:8000

python -m http.server 8000
if %errorlevel% neq 0 (
    echo Python not found, trying npx serve...
    npx -y serve -l 8000 .
)

pause
