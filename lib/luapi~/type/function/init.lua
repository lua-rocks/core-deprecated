local Type = require 'lib.luapi.type'
local Function = Type:extend 'lib.luapi.type.function'


--[[
> parsed_block (lib.luapi.block) []
]]
function Function:init(parsed_block)
  parsed_block:each('field', function(k, v) self[k] = v end)
end


return Function