::::::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights V2
::::::::::::::::::::::::::::::::::::::::::::
@echo off
CLS
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

::::::::::::::::::::::::::::
::START
::::::::::::::::::::::::::::
title FNF Multi-Haxe - Introduction
chdir C:\Users\%USERPROFILE%
echo Script was made by AutisticLulu
echo --
echo This script allows you to have two Haxe versions installed simultaneously.
echo This allows you to work on several Friday Night Funkin Engines without needing to reinstall Haxe or Haxelibs everytime.
echo With quick swap option so you can change System Environment Variables automatically.
echo --
echo Press any key to show options
pause >nul
goto Prompt

:Prompt
cls
title FNF Multi-Haxe - Select Task
echo if it's your first time running the script, press I to install Multi-Haxe.
echo Select a task:
echo =============
echo -
echo 1) Swap to Haxe 4.2.5
echo 2) Swap to Haxe 4.1.5
echo I) Install Multi-Haxe
echo C) Close Script
echo -
set /p menu=Type option:
if "%menu%"=="1" goto Haxe425
if "%menu%"=="2" goto Haxe415
if "%menu%"=="I" goto InstallHaxeMulti
if "%menu%"=="i" goto InstallHaxeMulti
if "%menu%"=="C" goto Close
if "%menu%"=="c" goto Close

:InstallHaxeMulti
title FNF Multi-Haxe - Installing Multi-Haxe
echo Downloading Haxe 4.2.5
curl -L -# -O https://github.com/HaxeFoundation/haxe/releases/download/4.2.5/haxe-4.2.5-win64.exe
echo Installing Haxe 4.2.5 to C:\HaxeToolKit\4.2.5
haxe-4.2.5-win64.exe /S /D=C:\HaxeToolKit\4.2.5
echo Deleting setup file...
del haxe-4.2.5-win64.exe
echo Installed Haxe 4.2.5
echo ---
echo Downloading Haxe 4.1.5
curl -L -# -O https://github.com/HaxeFoundation/haxe/releases/download/4.1.5/haxe-4.1.5-win64.exe
echo Installing Haxe 4.1.5 to C:\HaxeToolKit\4.1.5
haxe-4.1.5-win64.exe /S /D=C:\HaxeToolKit\4.1.5
echo Deleting setup file...
del haxe-4.1.5-win64.exe
echo Installed Haxe 4.1.5
goto HaxeMultiLibs

:HaxeMultiLibs
title FNF Multi-Haxe - Installing Haxelibs for Multi-Haxe
echo Setting path for Haxelibs 4.2.5
haxelib setup C:\haxelib\4.2.5
echo haxelib path for 4.2.5 is now C:\haxelib\4.2.5
echo Installing haxelib libraries...
haxelib install lime
haxelib install openfl
haxelib --never install flixel
haxelib run lime setup flixel
haxelib run lime setup 
haxelib install flixel-tools
haxelib install flixel-ui
haxelib install flixel-addons
haxelib install tjson
haxelib install hxjsonast
haxelib install hscript
haxelib git hxCodec https://github.com/polybiusproxy/hxCodec
haxelib git polymod https://github.com/larsiusprime/polymod.git
haxelib git linc_luajit https://github.com/AndreiRudenko/linc_luajit
haxelib git hscript-ex https://github.com/ianharrigan/hscript-ex
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib install hxcpp > nul
haxelib install hxcpp-debug-server
echo Haxelibs 4.2.5 is now installed.
echo ---
echo Setting path for Haxelibs 4.1.5
haxelib setup C:\haxelib\4.1.5
echo haxelib path for 4.1.5 is now C:\haxelib\4.1.5
echo Installing haxelib libraries...
haxelib install lime 7.9.0
haxelib install openfl
haxelib install flixel
haxelib install flixel-tools
haxelib install flixel-ui
haxelib install hscript
haxelib install flixel-addons
haxelib install actuate
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
haxelib git faxe https://github.com/uhrobots/faxe
haxelib git polymod https://github.com/MasterEric/polymod.git
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git extension-webm https://github.com/KadeDev/extension-webm
echo Haxelibs 4.2.5 is now installed.

echo Return to Select Task Menu. Press any key to continue. 
pause >nul
goto Prompt


:Haxe425
echo Setting paths...
setx HAXEPATH "C:\HaxeToolkit\4.2.5\haxe" -M
setx NEKO_INSTPATH "C:\HaxeToolkit\4.2.5\neko" -M
haxelib setup C:\haxelib\4.2.5
echo Swapped to Haxe 4.2.5 + it's Haxelibs for your build environment.
echo ---
echo 1) Close the script
echo 2) Go back to Task Menu
set /p menu=Type option:
if "%menu%"=="1" goto Close
if "%menu%"=="2" goto Prompt


:Haxe415
echo Setting paths...
setx HAXEPATH "C:\HaxeToolkit\4.1.5\haxe" -M
setx NEKO_INSTPATH "C:\HaxeToolkit\4.1.5\neko" -M
haxelib setup C:\haxelib\4.1.5
echo Swapped to Haxe 4.1.5 + it's Haxelibs for your build environment.
echo ---
echo 1) Close the script
echo 2) Go back to Task Menu
set /p menu=Type option:
if "%menu%"=="1" goto Close
if "%menu%"=="2" goto Prompt

:Close
exit