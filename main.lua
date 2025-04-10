-- BL2ModInstaller Main Script
local lfs = require("lfs")
local logger = require("logger")
local modHandlers = require("mod_handlers")
local config = require("config")
local ui = require("ui")

-- Main controller
local controller = {}

-- Utility Functions
local function ensureDirectory(path)
    local success, err = lfs.mkdir(path)
    if not success and not string.match(tostring(err), "File exists") then
        error("Failed to create directory: " .. path .. " - " .. tostring(err))
    end
end

-- Game Detection
function controller.detectGamePath()
    -- Check common installation paths
    for _, path in ipairs(config.defaultGamePaths) do
        if lfs.attributes(path) then
            return path
        end
    end
    
    return nil
end

-- Backup System
local function copyFile(src, dest)
    local sourceFile = io.open(src, "rb")
    if not sourceFile then
        return false, "Could not open source file: " .. src
    end
    
    local destFile = io.open(dest, "wb")
    if not destFile then
        sourceFile:close()
        return false, "Could not create destination file: " .. dest
    end
    
    local content = sourceFile:read("*all")
    destFile:write(content)
    
    sourceFile:close()
    destFile:close()
    
    return true
end

local function createBackup(gamePath)
    local timestamp = os.date("%Y%m%d_%H%M%S")
    local backupPath = gamePath .. "/" .. config.backupDir .. "/backup_" .. timestamp
    
    ensureDirectory(gamePath .. "/" .. config.backupDir)
    ensureDirectory(backupPath)
    
    logger.info("Creating backup at: " .. backupPath)
    
    -- Backup important directories
    local dirsToBackup = {
        "Binaries",
        "WillowGame/CookedPCConsole",
    }
    
    for _, dir in ipairs(dirsToBackup) do
        local sourcePath = gamePath .. "/" .. dir
        local destPath = backupPath .. "/" .. dir
        
        if lfs.attributes(sourcePath) then
            ensureDirectory(destPath)
            
            for file in lfs.dir(sourcePath) do
                if file ~= "." and file ~= ".." then
                    local srcFile = sourcePath .. "/" .. file
                    local destFile = destPath .. "/" .. file
                    
                    if lfs.attributes(srcFile, "mode") == "file" then
                        local success, err = copyFile(srcFile, destFile)
                        if not success then
                            logger.error("Failed to backup file: " .. srcFile .. " - " .. err)
                            return nil
                        end
                    end
                end
            end
        end
    end
    
    logger.info("Backup completed successfully")
    return backupPath
end

-- Cleanup old backups
local function cleanupOldBackups(gamePath)
    local backupDir = gamePath .. "/" .. config.backupDir
    local backups = {}
    
    for file in lfs.dir(backupDir) do
        if file:match("^backup_%d+") then
            table.insert(backups, file)
        end
    end
    
    table.sort(backups)
    
    while #backups > config.maxBackups do
        local oldestBackup = backupDir .. "/" .. backups[1]
        logger.info("Removing old backup: " .. oldestBackup)
        
        -- Remove the backup directory and its contents
        for file in lfs.dir(oldestBackup) do
            if file ~= "." and file ~= ".." then
                os.remove(oldestBackup .. "/" .. file)
            end
        end
        lfs.rmdir(oldestBackup)
        
        table.remove(backups, 1)
    end
end

-- Mod Installation
function controller.installMod(modPath, gamePath)
    -- Validate paths
    if not lfs.attributes(modPath) then
        error("Mod file not found: " .. modPath)
    end
    
    if not lfs.attributes(gamePath) then
        error("Game directory not found: " .. gamePath)
    end
    
    -- Create backup
    local backupPath = createBackup(gamePath)
    if not backupPath then
        error("Failed to create backup")
    end
    
    -- Clean up old backups
    cleanupOldBackups(gamePath)
    
    -- Get appropriate handler for mod type
    local handler, err = modHandlers.getHandler(modPath)
    if not handler then
        error("Failed to get mod handler: " .. err)
    end
    
    -- Install the mod
    local success, err = handler(modPath, gamePath)
    if not success then
        error("Failed to install mod: " .. err)
    end
    
    logger.info("Mod installation completed successfully")
    return true
end

-- Initialize the application
local function init()
    logger.info("BL2ModInstaller Starting...")
    
    -- Auto-detect game path
    local gamePath = controller.detectGamePath()
    if gamePath then
        logger.info("Game installation found at: " .. gamePath)
    else
        logger.warning("Could not auto-detect Borderlands 2 installation")
    end
    
    -- Initialize logger
    logger.init("BL2ModInstaller_log")
    logger.setLevel(logger.LEVELS.DEBUG)
    
    -- Initialize UI
    ui.init(controller)
    
    -- Show the UI
    ui.show()
end

-- Start the application
init()
