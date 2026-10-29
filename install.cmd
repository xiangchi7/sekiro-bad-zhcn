@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem ============================================================
rem  Sekiro "Malevolence" mod - Simplified Chinese localization installer
rem  Usage:
rem    install.cmd                       auto-detect Sekiro\mods in Steam libraries
rem    install.cmd "X:\...\Sekiro\mods"  explicit mods folder
rem    install.cmd /check                detect only, write nothing
rem    (or drag & drop your Sekiro\mods folder onto this file)
rem ============================================================

set "SRC=%~dp0msg\zhocn"
set "ARG=%~1"
set "TARGET="
set "CHECKONLY="
if /i "%ARG%"=="/check" set "CHECKONLY=1"

rem ---------- 1) explicit argument ----------
if defined ARG if not defined CHECKONLY (
  if exist "%ARG%\" (
    set "TARGET=%ARG%"
    if "!TARGET:~-1!"=="\" set "TARGET=!TARGET:~0,-1!"
  )
)

if defined ARG if not defined TARGET if not defined CHECKONLY (
  echo [error] path not found: %ARG%
  echo Run install.cmd /check to see what is auto-detected.
  pause
  exit /b 1
)

rem ---------- 2) Steam root from registry ----------
set "STEAM="
for /f "tokens=3" %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul ^| findstr /i "SteamPath"') do set "STEAM=%%~A"
if defined STEAM set "STEAM=!STEAM:/=\!"

if not defined TARGET if defined STEAM (
  if exist "!STEAM!\steamapps\common\Sekiro\mods" set "TARGET=!STEAM!\steamapps\common\Sekiro\mods"
)

rem ---------- 3) every library listed in libraryfolders.vdf ----------
set "VDF="
if defined STEAM set "VDF=!STEAM!\steamapps\libraryfolders.vdf"
if not defined TARGET if exist "!VDF!" (
  for /f "usebackq tokens=2" %%L in (`findstr /i /c:"path" "!VDF!"`) do (
    set "LIB=%%~L"
    set "LIB=!LIB:\\=\!"
    if not defined TARGET if exist "!LIB!\steamapps\common\Sekiro\mods" set "TARGET=!LIB!\steamapps\common\Sekiro\mods"
  )
)

rem ---------- 4) common fallbacks ----------
if not defined TARGET (
  for %%D in (
    "D:\steam\steamapps\common\Sekiro\mods"
    "D:\SteamLibrary\steamapps\common\Sekiro\mods"
    "E:\steam\steamapps\common\Sekiro\mods"
    "E:\SteamLibrary\steamapps\common\Sekiro\mods"
    "F:\steam\steamapps\common\Sekiro\mods"
    "F:\SteamLibrary\steamapps\common\Sekiro\mods"
    "C:\Program Files (x86)\Steam\steamapps\common\Sekiro\mods"
  ) do (
    if not defined TARGET if exist "%%~D" set "TARGET=%%~D"
  )
)

rem ---------- result ----------
if not defined TARGET (
  echo.
  echo [Sekiro\mods not found]
  echo.
  echo This installer needs either a path to your Sekiro mods folder or the folder itself.
  echo Three ways to fix it:
  echo   1^) drag your Sekiro\mods folder onto this file
  echo   2^) run:  install.cmd "X:\your\Sekiro\mods"
  echo   3^) manual: copy this pack's msg folder into Sekiro\mods\
  echo.
  echo See the bundled readme file for Chinese instructions.
  pause
  exit /b 1
)

if "%TARGET:~-4%"=="\mod" set "TARGET=%TARGET%s"
echo Target : %TARGET%
echo Source : %SRC%
echo.

if defined CHECKONLY (
  if exist "!TARGET!\..\sekiro.exe" (
    echo Verify : sekiro.exe found in the parent folder - looks correct.
  ) else (
    echo Verify : no sekiro.exe in the parent folder - please make sure this is Sekiro\mods.
  )
  echo [check only, nothing written]
  pause
  exit /b 0
)

if not exist "%SRC%\item.msgbnd.dcx" (
  echo [error] %SRC%\item.msgbnd.dcx is missing - keep the extracted folder intact.
  pause
  exit /b 1
)

if not exist "%TARGET%\msg\zhocn" mkdir "%TARGET%\msg\zhocn" 2>nul

for %%F in (item.msgbnd.dcx menu.msgbnd.dcx) do (
  if exist "%SRC%\%%F" (
    if exist "%TARGET%\msg\zhocn\%%F" if not exist "%TARGET%\msg\zhocn\%%F.bak" copy /y "%TARGET%\msg\zhocn\%%F" "%TARGET%\msg\zhocn\%%F.bak" >nul
    copy /y "%SRC%\%%F" "%TARGET%\msg\zhocn\%%F" >nul
    echo   installed: %%F
  )
)

echo.
echo Done. In game: title screen - Language - Text - Simplified Chinese, then restart.
echo Rollback: run restore.cmd
echo See the bundled readme file for Chinese instructions.
pause
