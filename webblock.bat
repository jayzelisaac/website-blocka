@echo off
setlocal enabledelayedexpansion

:: Define the location of the hosts file
set hostsFile=%SystemRoot%\System32\drivers\etc\hosts

:: Define the location of the log file
set logFile=%SystemRoot%\System32\drivers\etc\blocka_log.txt

:: Backup the original hosts file
if not exist "%hostsFile%.bak" (
    copy "%hostsFile%" "%hostsFile%.bak"
)

:: Get user input for websites to block
set /P "websites=Enter websites to block (separated by space): "

:: Confirm user input
echo You entered: %websites%
set /P "confirm=Do you want to block these websites? (yes/no): "
if /I "%confirm%" NEQ "yes" (
    echo Operation cancelled.
    goto :EOF
)

:: Block the websites
for %%w in (%websites%) do (
    echo 127.0.0.1 %%w >> %hostsFile%
    echo 127.0.0.1 %%~w >> %hostsFile%
    echo Blocked %%w >> %logFile%
)

echo Websites blocked successfully!
pause
:: Open the log file
:: start notepad.exe "%logFile%"
color 02 
:: Display usage instructions
echo Usage: webblock.bat
echo This script allows you to block websites by adding entries to the hosts file.
echo.
echo.
echo The blocked websites will Not load up.

:: Display usage instructions
echo.
set /P "readLog=Do you want to read the log file? (yes/no): "
if /I "%readLog%" EQU "yes" (
    start notepad.exe "%logFile%"
)
echo Operation completed.
pause > nul

:: Ask user if they want to unblock/restore host file
set /P "unblock=Do you want to unblock the websites? (yes/no): "
if /I "%unblock%" NEQ "yes" (
    echo Operation cancelled.
    goto :EOF
)

:: Restore the original hosts file
if exist "%hostsFile%.bak" (
    del "%hostsFile%"
    ren "%hostsFile%.bak" "hosts"
)

echo Websites unblocked successfully!
pause