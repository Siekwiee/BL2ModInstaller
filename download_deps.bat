@echo off
echo Downloading dependencies for BL2ModInstaller...

REM Create directories if they don't exist
if not exist lib mkdir lib
if not exist lib\iup mkdir lib\iup
if not exist lib\srlua mkdir lib\srlua

REM Define URLs for dependencies
set LUA_URL=https://sourceforge.net/projects/luabinaries/files/5.1.5/Windows%%20Libraries/Dynamic/lua-5.1.5_Win32_dll15_lib.zip/download
set IUP_URL=https://sourceforge.net/projects/iup/files/3.30/Windows%%20Libraries/Dynamic/iup-3.30_Win32_dll15_lib.zip/download
set LFS_URL=https://github.com/keplerproject/luafilesystem/releases/download/v1_8_0/lfs-1.8.0-win32.zip
set SRLUA_URL=https://github.com/LuaDist/srlua/archive/refs/heads/master.zip

REM Download and extract dependencies
echo Downloading Lua...
powershell -Command "Invoke-WebRequest -Uri '%LUA_URL%' -OutFile 'lua.zip'"
echo Extracting Lua...
powershell -Command "Expand-Archive -Path 'lua.zip' -DestinationPath 'temp'"
copy temp\lua5.1.dll lib\
copy temp\lua5.1.lib lib\
del lua.zip
rd /s /q temp

echo Downloading IUP...
powershell -Command "Invoke-WebRequest -Uri '%IUP_URL%' -OutFile 'iup.zip'"
echo Extracting IUP...
powershell -Command "Expand-Archive -Path 'iup.zip' -DestinationPath 'temp'"
copy temp\*.dll lib\iup\
del iup.zip
rd /s /q temp

echo Downloading LuaFileSystem...
powershell -Command "Invoke-WebRequest -Uri '%LFS_URL%' -OutFile 'lfs.zip'"
echo Extracting LuaFileSystem...
powershell -Command "Expand-Archive -Path 'lfs.zip' -DestinationPath 'temp'"
copy temp\*.dll lib\
del lfs.zip
rd /s /q temp

echo Downloading srlua...
powershell -Command "Invoke-WebRequest -Uri '%SRLUA_URL%' -OutFile 'srlua.zip'"
echo Extracting srlua...
powershell -Command "Expand-Archive -Path 'srlua.zip' -DestinationPath 'temp'"
echo Compiling srlua...
cd temp\srlua-master
cl /O2 /DNDEBUG /MD srlua.c lua51.lib /link /out:srlua.exe
cl /O2 /DNDEBUG /MD glue.c lua51.lib /link /out:glue.exe
cd ..\..
copy temp\srlua-master\srlua.exe lib\srlua\
copy temp\srlua-master\glue.exe lib\srlua\
del srlua.zip
rd /s /q temp

echo All dependencies downloaded and extracted.
echo.
echo Note: If you don't have Visual Studio installed, you'll need to manually compile srlua 
echo or download pre-compiled binaries from elsewhere.
echo.
echo You can now run build.bat to build the BL2ModInstaller. 