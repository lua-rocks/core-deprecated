local Type = require 'lib.luapi.type'
local Class = Type:extend 'lib.luapi.type.class'


--[[ Old class definition FIXME: Remove it!
@ lib.luapi.file#class (lib.luapi.block)
> title       (string)               []
> description (string)               []
> codename    (string)               [] How its actually called in code
> reqpath     (string)                  Unique require path
> extends     (string)               [] Parent class reqpath or lua type
> requires    (list=string)          [] Modules only
> fields      (list=lib.luapi.block) []
> methods     (list=lib.luapi.block) []
]]


--[[
> parsed_block (lib.luapi.block) []
]]
function Class:init(parsed_block)
  parsed_block:each('field', function(k, v) self[k] = v end)
end


return Class