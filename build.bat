@echo off
echo Building BL2ModInstaller...

REM Create build directory
if not exist build mkdir build

REM Copy Lua files
echo Copying Lua files...
copy *.lua build\

REM Copy DLLs and dependencies 
echo Copying dependencies...
copy lib\*.dll build\
copy lib\iup\*.dll build\

REM Generate executable with srlua
echo Creating executable...
lib\srlua\glue.exe lib\srlua\srlua.exe build\main.lua build\BL2ModInstaller.exe

echo Build complete. You can find the executable in the build directory. 