local Type = require 'lib.luapi.type'


--[[ Class
Main differences from Block:

+ `typeset` is not optonal; it must have `name` and `parent`
+ `fields` and `returns` are Types
+ additional fields: `requires` and `links`

@ lib.luapi.type.class (lib.luapi.type)
> requires    (list=string)         []        Required modules (reqpaths)
> links       ({string=lib.luapi.type...}) [] Links to internal types by names
> title       (string)              []        First line in block
> description (string)              []        Not tagged lines in block
> fields      (list=lib.luapi.type) []        Line after >
> returns     (list=lib.luapi.type) []        Line after <
> typeset     (lib.luapi.type.class#typeset)  Line after @
]]
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