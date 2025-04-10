-- Mod Type Handlers
local lfs = require("lfs")
local logger = require("logger")

local handlers = {}

-- Utility functions
local function getFileExtension(path)
    return path:match("^.+%.(.+)$")
end

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

local function ensureDirectory(path)
    local success, err = lfs.mkdir(path)
    if not success and not string.match(tostring(err), "File exists") then
        return false, "Failed to create directory: " .. path .. " - " .. tostring(err)
    end
    return true
end

-- BLCMM mod handler
function handlers.handleBLCMM(modPath, gamePath)
    logger.info("Installing BLCMM mod: " .. modPath)
    
    -- BLCMM mods go in the Binaries folder
    local binariesPath = gamePath .. "/Binaries"
    if not lfs.attributes(binariesPath, "mode") then
        return false, "Binaries directory not found at: " .. binariesPath
    end
    
    -- Create mods directory if it doesn't exist
    local modsPath = binariesPath .. "/Mods"
    local success, err = ensureDirectory(modsPath)
    if not success then 
        return false, err
    end
    
    -- Copy the mod file to the mods directory
    local modName = modPath:match("([^/\\]+)$")
    local destPath = modsPath .. "/" .. modName
    local success, err = copyFile(modPath, destPath)
    if not success then
        return false, err
    end
    
    logger.info("Successfully installed BLCMM mod to: " .. destPath)
    return true
end

-- Text mod handler
function handlers.handleTextMod(modPath, gamePath)
    logger.info("Installing text mod: " .. modPath)
    
    -- Text mods usually go in the Binaries folder
    local binariesPath = gamePath .. "/Binaries"
    if not lfs.attributes(binariesPath, "mode") then
        return false, "Binaries directory not found at: " .. binariesPath
    end
    
    -- Copy the mod file to the binaries directory
    local modName = modPath:match("([^/\\]+)$")
    local destPath = binariesPath .. "/" .. modName
    local success, err = copyFile(modPath, destPath)
    if not success then
        return false, err
    end
    
    logger.info("Successfully installed text mod to: " .. destPath)
    return true
end

-- Custom mesh/texture handler
function handlers.handleCustomContent(modPath, gamePath)
    logger.info("Installing custom content mod: " .. modPath)
    
    -- Custom content mods go in the CookedPCConsole directory
    local cookedPath = gamePath .. "/WillowGame/CookedPCConsole"
    if not lfs.attributes(cookedPath, "mode") then
        return false, "CookedPCConsole directory not found at: " .. cookedPath
    end
    
    -- Copy the mod file to the cooked directory
    local modName = modPath:match("([^/\\]+)$")
    local destPath = cookedPath .. "/" .. modName
    local success, err = copyFile(modPath, destPath)
    if not success then
        return false, err
    end
    
    logger.info("Successfully installed custom content mod to: " .. destPath)
    return true
end

-- Save file modification handler
function handlers.handleSaveFile(modPath, gamePath)
    logger.info("Installing save file mod: " .. modPath)
    
    -- Save files are usually for reference or need special handling
    -- We'll recommend the user to manually handle these
    logger.warning("Save file mods should be handled manually. Please refer to the mod documentation.")
    
    -- Just return success, as this is more of a user notification
    return true
end

-- Detect mod type and return appropriate handler
function handlers.getHandler(modPath)
    local ext = getFileExtension(modPath)
    if not ext then
        return nil, "Could not determine mod type"
    end
    
    ext = ext:lower()
    
    if ext == "blcm" then
        return handlers.handleBLCMM
    elseif ext == "txt" then
        return handlers.handleTextMod
    elseif ext == "upk" or ext == "udk" then
        return handlers.handleCustomContent
    elseif ext == "sav" then
        return handlers.handleSaveFile
    end
    
    return nil, "Unsupported mod type: " .. ext
end

return handlers 