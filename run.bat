@echo off
echo Running BL2ModInstaller...

REM Set the PATH to include our lib directory
SET PATH=%CD%\lib;%CD%\lib\iup;%PATH%

REM Run the Lua script
lib\lua5.1.exe main.lua

echo Application closed. 