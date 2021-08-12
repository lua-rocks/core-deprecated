local Object = require 'lib.object'
local Type = Object:extend 'lib.luapi.type'


--[[ Create type from block.
There is 4 general types: "class", "function", "table" and "simple".
Type "class" cannot be directly defined by user.
User must extend it from other class.
> raw_block (string) []
]]
function Type:init(raw_block)
  local parsed_block = require 'lib.luapi.block' (raw_block)
  if parsed_block.typeset and parsed_block.typeset.parent then
    local parent = parsed_block.typeset.parent
    if parent:find('%.') then
      parsed_block = require 'lib.luapi.type.class' (parsed_block)
    elseif parent == 'function' then
      parsed_block = require 'lib.luapi.type.function' (parsed_block)
    elseif parent == 'table' then
      parsed_block = require 'lib.luapi.type.table' (parsed_block)
    else
      parsed_block = require 'lib.luapi.type.simple' (parsed_block)
    end
    return parsed_block
  end
  return false
end


--[[ TODO: Output type
]]
function Type:out(file)
  print(self.title)
end


return Type