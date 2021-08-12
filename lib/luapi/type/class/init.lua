local Type = require 'lib.luapi.type'
local Class = Type:extend 'lib.luapi.type.class'


--[[
@ lib.luapi.type.class#typeset (table)
> name   (string)    First word after tag (Require path format)
> title  (string) [] Any text at the end
> parent (string)    Text in parentheses  (Extended from: reqpath or lua type)
> square (string) [] Text in square brackets
]]


--[[
> parsed_block (lib.luapi.block) []
]]
function Class:init(parsed_block)
  parsed_block:each('field', function(k, v) self[k] = v end)
end


return Class