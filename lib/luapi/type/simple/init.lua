local Type = require 'lib.luapi.type'
local Simple = Type:extend 'lib.luapi.simple'


--[[
> parsed_block (lib.luapi.block) []
]]
function Simple:init(parsed_block)
  parsed_block:each('field', function(k, v) self[k] = v end)
end


return Simple