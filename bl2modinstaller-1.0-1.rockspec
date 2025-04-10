package = "bl2modinstaller"
version = "1.0-1"
source = {
   url = "git://github.com/yourusername/bl2modinstaller",
   tag = "v1.0"
}
description = {
   summary = "Borderlands 2 Mod Installer",
   detailed = [[
      A tool for installing and managing Borderlands 2 mods.
      Handles backup creation and mod installation.
   ]],
   homepage = "http://github.com/yourusername/bl2modinstaller",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1",
   "luafilesystem",
   "lua-zip"
}
build = {
   type = "builtin",
   modules = {
      ["main"] = "main.lua",
      ["logger"] = "logger.lua",
      ["mod_handlers"] = "mod_handlers.lua"
   },
   install = {
      bin = {
         "bin/bl2modinstaller"
      }
   }
} 