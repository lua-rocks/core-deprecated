local Type = require 'lib.luapi.type'
local Table = Type:extend 'lib.luapi.table'


--[[
> parsed_block (lib.luapi.block) []
]]
function Table:init(parsed_block)
  parsed_block:each('field', function(k, v) self[k] = v end)
end


return Table