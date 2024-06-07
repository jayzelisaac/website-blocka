@echo off
setlocal enabledelayedexpansion

:: Define the location of the hosts file
set hostsFile=%SystemRoot%\System32\drivers\etc\hosts

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
)

echo Websites blocked successfully!
pause
