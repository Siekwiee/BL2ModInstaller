-- Logger Module
local lfs = require("lfs")

local logger = {}

-- Log levels
logger.LEVELS = {
    DEBUG = 1,
    INFO = 2,
    WARNING = 3,
    ERROR = 4
}

local currentLevel = logger.LEVELS.INFO
local logFile = nil

-- Initialize logger
function logger.init(logPath)
    if logFile then
        logFile:close()
    end
    
    -- Create log directory if it doesn't exist
    local logDir = logPath:match("(.*)/")
    lfs.mkdir(logDir)
    
    -- Open log file with timestamp
    local timestamp = os.date("%Y%m%d_%H%M%S")
    local filename = string.format("%s/bl2_mod_installer_%s.log", logDir, timestamp)
    logFile = io.open(filename, "w")
    
    if not logFile then
        error("Could not create log file: " .. filename)
    end
    
    logger.info("Log initialized at: " .. filename)
end

-- Set log level
function logger.setLevel(level)
    currentLevel = level
end

-- Internal logging function
local function writeLog(level, message)
    if level >= currentLevel then
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        local levelName = ""
        
        for name, val in pairs(logger.LEVELS) do
            if val == level then
                levelName = name
                break
            end
        end
        
        local logMessage = string.format("[%s] [%s] %s\n", timestamp, levelName, message)
        
        if logFile then
            logFile:write(logMessage)
            logFile:flush()
        end
        
        -- Also print to console
        print(logMessage)
    end
end

-- Public logging functions
function logger.debug(message)
    writeLog(logger.LEVELS.DEBUG, message)
end

function logger.info(message)
    writeLog(logger.LEVELS.INFO, message)
end

function logger.warning(message)
    writeLog(logger.LEVELS.WARNING, message)
end

function logger.error(message)
    writeLog(logger.LEVELS.ERROR, message)
end

-- Cleanup
function logger.close()
    if logFile then
        logFile:close()
        logFile = nil
    end
end

return logger 