-- Configuration file for BL2ModInstaller

local config = {
    -- Default paths
    backupDir = "BL2ModInstaller/backups",
    logDir = "BL2ModInstaller/logs",
    tempDir = "BL2ModInstaller/temp",
    
    -- Settings
    maxBackups = 5,  -- Maximum number of backups to keep
    defaultGamePaths = {
        "C:/Program Files (x86)/Steam/steamapps/common/Borderlands 2",
        "C:/Program Files/Steam/steamapps/common/Borderlands 2",
        "D:/Steam/steamapps/common/Borderlands 2",
        "C:/Epic Games/Borderlands2"
    },
    
    -- UI settings
    windowTitle = "BL2 Mod Installer",
    windowWidth = 600,
    windowHeight = 400
}

return config 