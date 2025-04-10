# BL2ModInstaller

A robust and user-friendly Borderlands 2 mod installer with comprehensive mod support and safety features.

## Features

- **Progress Tracking**
  - Real-time progress indicators for all file operations
  - Detailed status updates during installation process

- **Mod Compatibility**
  - Automatic dependency checking and validation
  - Mod version compatibility verification
  - Conflict detection between installed mods

- **Backup System**
  - Automatic backup creation before mod installation
  - Easy restore functionality for previous game states
  - Backup management interface

- **Multi-Format Support**
  - Simple .txt mods
  - BLCMM mod files
  - Custom mesh and texture modifications
  - Save file modifications
  - Comprehensive mod package handling

## Dependencies

### Required
- LuaZip - For handling ZIP archive extraction
- LuaFileSystem - Enhanced file system operations

### Optional
- Native file dialogs (FFI) - For improved UI experience

## Installation Flow

1. **Game Detection**
   - Automatic detection of Borderlands 2 installation
   - Manual path selection option
   - Validation of game installation

2. **Mod Selection**
   - Support for both single files and mod folders
   - Drag-and-drop interface
   - Bulk mod installation capability

3. **Installation Process**
   - Path validation and verification
   - Mod compatibility checking
   - Automatic backup creation
   - Intelligent file placement
   - Special handling for BLCMM mods
   - Real-time progress tracking
   - Detailed success/error reporting

## Usage

1. Launch BL2ModInstaller
2. Select or confirm your Borderlands 2 installation directory
3. Choose the mod(s) you want to install
4. Review the compatibility check results
5. Confirm installation
6. Monitor progress through the installation interface

## Backup Management

- Backups are stored in `[game_path]/BL2ModInstaller/backups`
- Each backup is timestamped and labeled with mod information
- Use the restore feature to revert to any previous game state
- Automatic cleanup of old backups (configurable)

## Troubleshooting

- Check the log file at `[game_path]/BL2ModInstaller/logs` for detailed error information
- Verify that all dependencies are correctly installed
- Ensure sufficient disk space for backups
- Run the installer with administrator privileges if required

## License

[License Type] - See LICENSE file for details


