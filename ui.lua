-- UI Module for BL2ModInstaller
local iup = require("iuplua")
local config = require("config")
local logger = require("logger")

local ui = {}

-- Initialize UI components
function ui.init(mainController)
    logger.info("Initializing UI")
    
    -- Controls
    local gamePath = iup.text{
        expand = "HORIZONTAL",
        value = "",
    }
    
    local modPath = iup.text{
        expand = "HORIZONTAL",
        value = "",
    }
    
    local browseGameBtn = iup.button{
        title = "Browse...",
        action = function()
            local filedlg = iup.filedlg{
                dialogtype = "DIR",
                title = "Select Borderlands 2 Directory",
                directory = "C:\\Program Files (x86)\\Steam\\steamapps\\common"
            }
            filedlg:popup()
            
            if filedlg.status ~= "-1" then
                gamePath.value = filedlg.value
            end
            
            return iup.DEFAULT
        end
    }
    
    local browseModBtn = iup.button{
        title = "Browse...",
        action = function()
            local filedlg = iup.filedlg{
                dialogtype = "OPEN",
                title = "Select Mod File",
                filter = "*.blcm;*.txt;*.upk;*.udk;*.sav",
                filterinfo = "Mod Files"
            }
            filedlg:popup()
            
            if filedlg.status ~= "-1" then
                modPath.value = filedlg.value
            end
            
            return iup.DEFAULT
        end
    }
    
    local statusText = iup.label{
        title = "Ready",
        expand = "HORIZONTAL"
    }
    
    local progressBar = iup.progressbar{
        min = 0,
        max = 100,
        value = 0,
        expand = "HORIZONTAL"
    }
    
    local installBtn = iup.button{
        title = "Install Mod",
        size = "80x30",
        action = function()
            if gamePath.value == "" then
                iup.Message("Error", "Please select Borderlands 2 directory")
                return iup.DEFAULT
            end
            
            if modPath.value == "" then
                iup.Message("Error", "Please select a mod file to install")
                return iup.DEFAULT
            end
            
            statusText.title = "Installing mod..."
            progressBar.value = 10
            
            -- Execute mod installation in protected mode
            local success, result = pcall(function()
                return mainController.installMod(modPath.value, gamePath.value)
            end)
            
            progressBar.value = 100
            
            if success then
                statusText.title = "Mod installed successfully!"
                iup.Message("Success", "Mod installed successfully!")
            else
                statusText.title = "Installation failed: " .. tostring(result)
                iup.Message("Error", "Failed to install mod: " .. tostring(result))
            end
            
            return iup.DEFAULT
        end
    }
    
    -- Layout
    local gamePathBox = iup.hbox{
        iup.label{title = "Game Path: "},
        gamePath,
        browseGameBtn,
        margin = "5x5",
        gap = 5
    }
    
    local modPathBox = iup.hbox{
        iup.label{title = "Mod File: "},
        modPath,
        browseModBtn,
        margin = "5x5",
        gap = 5
    }
    
    local statusBox = iup.hbox{
        iup.label{title = "Status: "},
        statusText,
        margin = "5x5",
        gap = 5
    }
    
    local buttonBox = iup.hbox{
        iup.fill{},
        installBtn,
        margin = "5x5",
        gap = 5
    }
    
    local mainDlg = iup.dialog{
        iup.vbox{
            gamePathBox,
            modPathBox,
            iup.frame{
                iup.vbox{
                    statusBox,
                    progressBar,
                    margin = "5x5"
                },
                title = "Progress"
            },
            buttonBox,
            margin = "10x10",
            gap = 10
        },
        title = config.windowTitle,
        size = config.windowWidth .. "x" .. config.windowHeight,
        resize = "NO",
        minbox = "YES",
        maxbox = "NO"
    }
    
    -- Auto-detect game path
    for _, path in ipairs(config.defaultGamePaths) do
        local attr = lfs.attributes(path)
        if attr and attr.mode == "directory" then
            gamePath.value = path
            break
        end
    end
    
    ui.dialog = mainDlg
    return ui
end

-- Show UI
function ui.show()
    ui.dialog:show()
    iup.MainLoop()
end

return ui 