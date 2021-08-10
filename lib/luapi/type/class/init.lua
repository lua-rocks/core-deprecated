local Type = require 'lib.luapi.type'
local Class = Type:extend 'lib.luapi.class'


--[[
> parsed_block (lib.luapi.block) []
]]
function Class:init(parsed_block)
  parsed_block:each('field', function(k, v) self[k] = v end)
end


return Class