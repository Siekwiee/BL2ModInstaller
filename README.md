# BL2ModInstaller

A simple Borderlands 2 mod installer for Windows that makes it easy to install and manage mods for the game.

## Features

- Simple, easy-to-use graphical interface
- Automatic game installation detection
- Support for various mod types (BLCMM, text, custom content)
- Automatic backup and restore system
- Detailed logging

## Requirements

To compile and run BL2ModInstaller, you'll need:

1. Windows operating system
2. The following dependencies (included in the `lib` folder):
   - Lua 5.1
   - LuaFileSystem (lfs)
   - IUP (for the GUI)
   - SRLua (for creating standalone executables)

## Project Structure

```
BL2ModInstaller/
├── main.lua             # Main application script
├── config.lua           # Configuration settings
├── logger.lua           # Logging module
├── mod_handlers.lua     # Mod type handlers
├── ui.lua               # User interface module
├── build.bat            # Build script for Windows
├── lib/                 # Dependencies
│   ├── lua5.1.dll
│   ├── lfs.dll
│   ├── iuplua51.dll
│   ├── iup/             # IUP library files
│   └── srlua/           # SRLua executable and glue utility
└── build/               # Compiled program (created by build script)
```

## Setting Up the Project

1. Create a `lib` directory and download the required dependencies:
   - Lua 5.1: https://sourceforge.net/projects/luabinaries/files/5.1.5/Windows%20Libraries/Dynamic/
   - LuaFileSystem: https://github.com/keplerproject/luafilesystem/releases
   - IUP: https://sourceforge.net/projects/iup/files/
   - SRLua: https://github.com/LuaDist/srlua

2. Place the DLL files in the `lib` directory:
   - lua5.1.dll
   - lfs.dll (Lua File System)
   - iuplua51.dll and other IUP dependencies in the `lib/iup` directory

3. Place the SRLua executable and glue utility in the `lib/srlua` directory:
   - srlua.exe
   - glue.exe

## Building the Executable

Simply run the `build.bat` script by double-clicking on it or executing it from the command line:

```
build.bat
```

This will:
1. Create a `build` directory (if it doesn't exist)
2. Copy all Lua files to the build directory
3. Copy all required DLLs to the build directory
4. Create a standalone executable named `BL2ModInstaller.exe`

## Using the Program

1. Run `BL2ModInstaller.exe`
2. The program will try to automatically detect your Borderlands 2 installation
   - If it cannot detect it, you can browse and select the game directory manually
3. Select a mod file to install using the "Browse" button
4. Click "Install Mod" to install the mod

## Mod Types Supported

- `.blcm` - BLCMM Mod Manager files (installed to Binaries/Mods)
- `.txt` - Text mods (installed to Binaries)
- `.upk`, `.udk` - Custom content mods (installed to WillowGame/CookedPCConsole)
- `.sav` - Save files (manual installation recommended)

## Troubleshooting

- If the program fails to start, make sure all required DLLs are in the same directory as the executable
- Check the log file in the BL2ModInstaller_log directory for detailed error information
- If a mod fails to install, try running the program as Administrator

## License

This project is licensed under the MIT License - see the LICENSE file for details.
