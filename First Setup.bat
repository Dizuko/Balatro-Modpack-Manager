@echo off
setlocal

:: Prompt user for modpack name
set /p "MODPACK_NAME=Name your current 'modpack': "

:: Define paths using %APPDATA%
set "MODS_FOLDER=%APPDATA%\Balatro\Mods"
set "MODS_STORE=%APPDATA%\Balatro\Mods.store"
set "OLD_MODPACK=%MODS_STORE%\mp.%MODPACK_NAME%"
set "SCRIPT_DIR=%~dp0"

:: Ensure Mods.store and Modpack.old exist
mkdir "%MODS_STORE%" >nul 2>&1
mkdir "%OLD_MODPACK%" >nul 2>&1

:: Check if Mods is a symlink
dir "%MODS_FOLDER%" /AL >nul 2>&1
if %errorlevel% equ 0 (
    echo Mods is a symlink.
    goto SYMLINK_CHECK
) else (
    echo Mods is a real folder.
    goto BACKUP_REAL_FOLDER
)

:BACKUP_REAL_FOLDER
:: Copy contents from Mods to Modpack.old
echo Copying contents to mp.%MODPACK_NAME%...
xcopy /E /I /H "%MODS_FOLDER%\*" "%OLD_MODPACK%\" >nul 2>&1

:: Verify copy success
if exist "%OLD_MODPACK%" (
    echo Backup successful.
    msg * "Your original modded files have been backed up to mp.%MODPACK_NAME%."
) else (
    echo Error: Could not verify backup!
    msg * "Error: Backup failed!"
    exit /b 1
)

:: Remove the real Mods folder and create a symlink pointing to Modpack.old
rmdir /S /Q "%MODS_FOLDER%" >nul 2>&1
mklink /d "%MODS_FOLDER%" "%OLD_MODPACK%" >nul 2>&1

:: Create the default symlink switcher file in %MODS_STORE%
set "DEFAULT_SYMLINK_SCRIPT=%MODS_STORE%\sw.%MODPACK_NAME%.bat"
echo @echo off > "%DEFAULT_SYMLINK_SCRIPT%"
echo setlocal >> "%DEFAULT_SYMLINK_SCRIPT%"
echo. >> "%DEFAULT_SYMLINK_SCRIPT%"
echo :: Define paths >> "%DEFAULT_SYMLINK_SCRIPT%"
echo set "SYMLINK_PATH=%APPDATA%\Balatro\Mods" >> "%DEFAULT_SYMLINK_SCRIPT%"
echo set "TARGET_PATH=%APPDATA%\Balatro\Mods.store\mp.%MODPACK_NAME%" >> "%DEFAULT_SYMLINK_SCRIPT%"
echo. >> "%DEFAULT_SYMLINK_SCRIPT%"
echo :: Remove existing symlink >> "%DEFAULT_SYMLINK_SCRIPT%"
echo rmdir "%%SYMLINK_PATH%%" ^>nul 2^>^&1 >> "%DEFAULT_SYMLINK_SCRIPT%"
echo if %%errorlevel%% neq 0 ( >> "%DEFAULT_SYMLINK_SCRIPT%"
echo    echo Failed to remove existing symlink. >> "%DEFAULT_SYMLINK_SCRIPT%"
echo    msg * "Error: Could not remove previous symlink!" >> "%DEFAULT_SYMLINK_SCRIPT%"
echo    exit /b 1 >> "%DEFAULT_SYMLINK_SCRIPT%"
echo ) >> "%DEFAULT_SYMLINK_SCRIPT%"
echo. >> "%DEFAULT_SYMLINK_SCRIPT%"
echo :: Create new symlink >> "%DEFAULT_SYMLINK_SCRIPT%"
echo mklink /d "%%SYMLINK_PATH%%" "%%TARGET_PATH%%" ^>nul 2^>^&1 >> "%DEFAULT_SYMLINK_SCRIPT%"
echo if %%errorlevel%% neq 0 ( >> "%DEFAULT_SYMLINK_SCRIPT%"
echo    echo Failed to create new symlink. >> "%DEFAULT_SYMLINK_SCRIPT%"
echo    msg * "Error: Could not create new symlink!" >> "%DEFAULT_SYMLINK_SCRIPT%"
echo    exit /b 1 >> "%DEFAULT_SYMLINK_SCRIPT%"
echo ) >> "%DEFAULT_SYMLINK_SCRIPT%"
echo. >> "%DEFAULT_SYMLINK_SCRIPT%"
echo echo Symlink updated successfully! >> "%DEFAULT_SYMLINK_SCRIPT%"
echo msg * "Balatro - mp.%MODPACK_NAME% installed successfully!" >> "%DEFAULT_SYMLINK_SCRIPT%"
echo. >> "%DEFAULT_SYMLINK_SCRIPT%"
echo endlocal >> "%DEFAULT_SYMLINK_SCRIPT%"

msg * "Setup complete! Your mods are backed up in %MODS_STORE%\mp.%MODPACK_NAME% and symlink switchers have been created.

:END
endlocal