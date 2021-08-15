local Object = require 'lib.object'
local Block  = require 'lib.luapi.block'


--[[ Type is a parsed Block
It copies all blocks fields but not extends from it.

Module is the type with the same `line.name` as File's `reqpath`.

Main differences from Block:

+ additional field: `requires` for modules
+ `line` is not optional; it must have `name` and `parent` fields
+ TODO: fields and returns can be parsed as lines, but then converted into types
+ fields indexed by name

= @ (lib.object=lib.luapi.block)
> requires    (list=string)   [] Required modules (reqpaths)
> title       (string)        [] First line in block
> description (string)        [] Not tagged lines in block
> fields      ({string=@...}) [] Line after > (indexed by name)
> returns     (list=@)        [] Line after <
> line        (@#line)           Line after =
]]
local Type = Object:extend 'lib.luapi.type'


--[[ One line of tagged block (in Type)
= @#line (table)
> index  (integer) [] IDEA: Output order
> name   (string)     First word after tag (reqpath or lua type)
> parent (string)     Text in parentheses  (extended from: reqpath or lua type)
> title  (string)  [] Any text at the end
> square (string)  [] Text in square brackets
]]


--[[ Create type from block.
There is 3 general types: "simple", "composite" and "function".
Type "class" cannot be directly defined by user.
User must extend it from other class.
> raw_block (string|@#line) []
]]
function Type:init(raw_block)
  local parsed_block

  if type(raw_block) == 'string' then
    parsed_block = Block(raw_block)
  elseif type(raw_block) == 'table' then
    parsed_block = Block()
    parsed_block.line = raw_block
  else
    return false
  end

  if not parsed_block then return false end
  if not parsed_block.line then return false end
  local name = parsed_block.line.name
  if not name then return false end
  local parent = parsed_block.line.parent
  if not parent then return false end

  if parent == 'table' or parent:find('%.') then
    parsed_block = require 'lib.luapi.type.composite' (parsed_block)
  elseif parent == 'function' then
    parsed_block = require 'lib.luapi.type.function' (parsed_block)
  else
    parsed_block = require 'lib.luapi.type.simple' (parsed_block)
  end
  return parsed_block
end


--[[ TODO: Output type as module
> file (lib.luapi.file)
]]
function Type:output_main(file)
  assert(file:is 'lib.luapi.file')
end


--[[ TODO: Detect is this type component or local and add it
> file (lib.luapi.file)
]]
function Type:output_add(file)
  assert(file:is 'lib.luapi.file')
end


--[[ TODO: Add type to the output as component of existed module
> file (lib.luapi.file)
]]
function Type:output_add_component(file)
  assert(file:is 'lib.luapi.file')
end


--[[ TODO: Add type to the output as local type of existed module
> file (lib.luapi.file)
]]
function Type:output_add_local(file)
  assert(file:is 'lib.luapi.file')
end


return Type