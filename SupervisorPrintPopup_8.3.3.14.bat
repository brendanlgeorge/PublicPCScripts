:: File Version 20211102.1	02/11/2021
:: Built and maintained by Brendan George - Cultural Services - Systems Administrator

:: This package installs the Monitor Supervisor Print Popup Utility onto machines as neccessary

@echo off
@setlocal enableextensions enabledelayedexpansion
cd /d "%~dp0"

:: setting the Supervisor Print Popup version to allow incrementing the package when deployed via DeepFreeze
set PrintPopUpPkgVersion=1.0
:: setting package name
set package=Monitor.PrintPopUp_8.3.3.14


del "C:\Users\PublicPC\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\SupervisorPrintPopup.exe.url"
taskkill /f /IM "sppplMonitor.exe"
taskkill /f /IM "spppl.exe"
timeout 2 > nul 2>&1
del "C:\Users\PublicPC\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\SupervisorPrintPopup.exe.url"
taskkill /f /IM "sppplMonitor.exe"
taskkill /f /IM "spppl.exe"


rmdir /S /Q "C:\Users\PublicPC\AppData\Local\Monitor Business Machines\SupervisorPrintPopup"
rmdir /S /Q "C:\mbm\SupervisorPrintPopup"

timeout 2 > nul 2>&1

mkdir "C:\mbm\SupervisorPrintPopup"

timeout 2 > nul 2>&1

xcopy /s /e /v /c /i /q /h /y SupervisorPrintPopup "C:\mbm\SupervisorPrintPopup"
schtasks /delete /F /TN "PrintPopUp"

timeout 2 > nul 2>&1

schtasks /create /SC ONLOGON /TN "PrintPopup" /TR "cmd /c start /min C:\mbm\SupervisorPrintPopup\LaunchPrintPopUp.bat" /F /RU Users /RL HIGHEST


:: writing to registry the installed version of hosts file script
::reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\!package! /f
::timeout 3 > nul 2>&1
::reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\!package! /v "DisplayName" /t REG_SZ /d "!package!" /f
timeout 3 > nul 2>&1
::reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\!package! /v "DisplayVersion" /t REG_SZ /d "!PrintPopUpPkgVersion!" /f

:: work completed
exit
