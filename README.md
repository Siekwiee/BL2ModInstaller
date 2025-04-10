# BL2ModInstaller

A tool for installing and managing Borderlands 2 mods. This tool helps you install mods while maintaining backups of your original game files.

## Prerequisites

To build the project, you'll need:

1. [LuaJIT](https://luajit.org/download.html) - The Just-In-Time Compiler for Lua
2. [LuaRocks](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Windows) - The package manager for Lua

## Building from Source

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/bl2modinstaller
   cd bl2modinstaller
   ```

2. Run the build script:
   ```bash
   build.bat
   ```

   This will:
   - Install required dependencies
   - Build the project
   - Create an executable in the `bin` directory

## Usage

After building, you can run the installer using:
```bash
bin\bl2modinstaller.bat
```

The tool will:
- Automatically detect your Borderlands 2 installation
- Create backups before installing mods
- Manage multiple backups
- Install mods safely

## Dependencies

- LuaFileSystem (lfs)
- Lua-Zip
- LuaJIT

## License

MIT License


