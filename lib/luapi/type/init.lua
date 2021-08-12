local Object = require 'lib.object'


--[[ Type copies all its fields from Block but not extends from it
Module is the first type in file.

Main differences from Block:

+ additional fields: `requires` and `links` for modules
+ `typeset` is not optional for modules; it must have `name` and `parent` fields

@ lib.luapi.type (lib.object=lib.luapi.block)
> requires    (list=string)         []          Required modules (reqpaths)
> links       ({string=lib.luapi.type...}) []   Links to internal types by names
> title       (string)              []          First line in block
> description (string)              []          Not tagged lines in block
> fields      (list=lib.luapi.type) []          Line after >
> returns     (list=lib.luapi.type) []          Line after <
> typeset     (lib.luapi.type.class#typeset) [] Line after @
]]
local Type = Object:extend 'lib.luapi.type'


--[[ Create type from block.
There is 4 general types: "class", "function", "table" and "simple".
Type "class" cannot be directly defined by user.
User must extend it from other class.
> raw_block (string) []
]]
function Type:init(raw_block)
  assert(type(raw_block) == 'string')
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


--[[ TODO: Output type as module
> file (lib.luapi.file)
]]
function Type:output_main(file)
  assert(file:is 'lib.luapi.file')
end


--[[ TODO: Add type to the output as part of existed module
> file (lib.luapi.file)
]]
function Type:output_add(file)
  assert(file:is 'lib.luapi.file')
end


return Type