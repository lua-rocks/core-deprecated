---@type lib.ansicolors|lib.ansicolors-__call
local colors = require 'lib.ansicolors'


print(colors('%{red}hello'))
print(colors('%{redbg}hello%{reset}'))
print(colors('%{bright red underline}hello'))
