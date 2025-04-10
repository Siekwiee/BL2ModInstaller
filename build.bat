@echo off
echo Building BL2ModInstaller...

REM Check if LuaRocks is installed
where luarocks >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo LuaRocks is not installed. Please install LuaRocks first.
    echo Visit https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Windows
    exit /b 1
)

REM Install dependencies
echo Installing dependencies...
luarocks install luafilesystem
luarocks install lua-zip

REM Build the project
echo Building project...
luarocks make bl2modinstaller-1.0-1.rockspec

REM Create bin directory if it doesn't exist
if not exist "bin" mkdir bin

REM Create the launcher script
echo Creating launcher...
echo @echo off > bin\bl2modinstaller.bat
echo luajit "%~dp0\..\main.lua" %%* >> bin\bl2modinstaller.bat

echo Build completed successfully!
echo You can find the executable in the bin directory. 