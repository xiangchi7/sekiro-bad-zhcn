@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem ============================================================
rem  Restore the original msg bundles (rollback the localization)
rem  Usage:
rem    restore.cmd                       auto-detect Sekiro\mods
rem    restore.cmd "X:\...\Sekiro\mods"  explicit mods folder
rem    (or drag & drop your Sekiro\mods folder onto this file)
rem ============================================================

set "ARG=%~1"
set "TARGET="

if defined ARG if exist "%ARG%\" (
  set "TARGET=%ARG%"
  if "!TARGET:~-1!"=="\" set "TARGET=!TARGET:~0,-1!"
)

set "STEAM="
for /f "tokens=3" %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul ^| findstr /i "SteamPath"') do set "STEAM=%%~A"
if defined STEAM set "STEAM=!STEAM:/=\!"

if not defined TARGET if defined STEAM (
  if exist "!STEAM!\steamapps\common\Sekiro\mods" set "TARGET=!STEAM!\steamapps\common\Sekiro\mods"
)

set "VDF="
if defined STEAM set "VDF=!STEAM!\steamapps\libraryfolders.vdf"
if not defined TARGET if exist "!VDF!" (
  for /f "usebackq tokens=2" %%L in (`findstr /i /c:"path" "!VDF!"`) do (
    set "LIB=%%~L"
    set "LIB=!LIB:\\=\!"
    if not defined TARGET if exist "!LIB!\steamapps\common\Sekiro\mods" set "TARGET=!LIB!\steamapps\common\Sekiro\mods"
  )
)

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

if not defined TARGET (
  echo.
  echo [Sekiro\mods not found]
  echo Drag your Sekiro\mods folder onto this file, or run: restore.cmd "X:\your\Sekiro\mods"
  echo.
  pause
  exit /b 1
)

echo Target : %TARGET%\msg\zhocn
echo.

set "FOUND="
for %%F in (item.msgbnd.dcx menu.msgbnd.dcx) do (
  if exist "%TARGET%\msg\zhocn\%%F.bak" (
    copy /y "%TARGET%\msg\zhocn\%%F.bak" "%TARGET%\msg\zhocn\%%F" >nul
    echo   restored: %%F
    set "FOUND=1"
  ) else (
    echo   no backup for %%F - skipped
  )
)

if not defined FOUND (
  echo.
  echo Nothing restored: no *.bak files were found next to the localized bundles.
)

echo.
echo Done. Restart the game for the change to take effect.
pause
