@echo off
setlocal

:: Get the current directory where this batch file is located
set "SCRIPT_DIR=%~dp0"

:: Prompt user for modpack name
set /p "MODPACK_NAME=Enter the new modpack name: "
set "MODPACK_NAME2=mp.%MODPACK_NAME%"

:: Define paths dynamically
set "MODPACK_FOLDER=%APPDATA%\Balatro\Mods.store\%MODPACK_NAME2%"
set "SYMLINK_SCRIPT=%SCRIPT_DIR%\sw.%MODPACK_NAME%.bat"
set "SYMLINK_TARGET=%APPDATA%\Balatro\Mods"

:: Create modpack folder
mkdir "%MODPACK_FOLDER%" || (
    echo Error: Could not create folder!
    msg * "Failed to create modpack folder."
    exit /b 1
)

:: Create the symlink batch file line-by-line.
:: For TARGET_PATH, we now use the actual modpack name value from the original input.
echo @echo off > "%SYMLINK_SCRIPT%"
echo setlocal >> "%SYMLINK_SCRIPT%"
echo. >> "%SYMLINK_SCRIPT%"
echo :: Define paths >> "%SYMLINK_SCRIPT%"
echo set "SYMLINK_PATH=C:\Users\Sam\AppData\Roaming\Balatro\Mods" >> "%SYMLINK_SCRIPT%"
echo set "TARGET_PATH=C:\Users\Sam\AppData\Roaming\Balatro\Mods.store\%MODPACK_NAME2%" >> "%SYMLINK_SCRIPT%"
echo. >> "%SYMLINK_SCRIPT%"
echo :: Remove existing symlink >> "%SYMLINK_SCRIPT%"
echo rmdir "%%SYMLINK_PATH%%" ^>nul 2^>^&1 >> "%SYMLINK_SCRIPT%"
echo if %%errorlevel%% neq 0 ( >> "%SYMLINK_SCRIPT%"
echo     echo Failed to remove existing symlink. >> "%SYMLINK_SCRIPT%"
echo     msg * "Error: Could not remove previous symlink!" >> "%SYMLINK_SCRIPT%"
echo     exit /b 1 >> "%SYMLINK_SCRIPT%"
echo ) >> "%SYMLINK_SCRIPT%"
echo. >> "%SYMLINK_SCRIPT%"
echo :: Create new symlink >> "%SYMLINK_SCRIPT%"
echo mklink /d "%%SYMLINK_PATH%%" "%%TARGET_PATH%%" ^>nul 2^>^&1 >> "%SYMLINK_SCRIPT%"
echo if %%errorlevel%% neq 0 ( >> "%SYMLINK_SCRIPT%"
echo     echo Failed to create new symlink. >> "%SYMLINK_SCRIPT%"
echo     msg * "Error: Could not create new symlink!" >> "%SYMLINK_SCRIPT%"
echo     exit /b 1 >> "%SYMLINK_SCRIPT%"
echo ) >> "%SYMLINK_SCRIPT%"
echo. >> "%SYMLINK_SCRIPT%"
echo echo Symlink updated successfully! >> "%SYMLINK_SCRIPT%"
echo msg * "Balatro - %MODPACK_NAME% installed successfully!" >> "%SYMLINK_SCRIPT%"
echo. >> "%SYMLINK_SCRIPT%"
echo endlocal >> "%SYMLINK_SCRIPT%"

echo Modpack '%MODPACK_NAME%' created successfully!
msg * "New modpack '%MODPACK_NAME%' created! Run 'sw.%MODPACK_NAME%.bat' to switch to it."

endlocal