-- TODO: Add all core types as separate classmodules in true OOP style.
-- TODO: parse abstract (#) types


local Object = require 'lib.object'
local lume = require 'lib.lume'


--[[ Parsed tagged comment block of any type
= @ (lib.object)
> title       (string)      [] First line in block
> description (string)      [] Not tagged lines in block
> fields      (list=@#line) [] Line after >
> returns     (list=@#line) [] Line after <
> line        (@#line)      [] Line after =
]]
local Block = Object:extend 'lib.luapi.block'


--[[ One line of tagged block
= @#line (table)
> name   (string) [] First word after tag
> title  (string) [] Any text at the end
> parent (string) [] Text in parentheses
> square (string) [] Text in square brackets
]]


--[[ Take comments block and create structured data block
> block (string) []
]]
function Block:init(block)
  if not block then return self end
  assert(type(block) == 'string')
  if block then
    self:parse(block):correct()
  end
end


--[[ Parse block
> block (string)
]]
function Block:parse(block)
  assert(type(block) == 'string')
  self.title = self.title or block:match '%-%-%[%[(.-)%]%]':gsub('\n.*', '')
  -- Parse block line by line
  for line in block:gmatch '\n(%C*)' do
    local tag = line:sub(1, 1)
    if tag == '>' or tag == '<' or tag == '=' then
      local tagged_line = line:sub(3, -1)
      local comment_start_at = math.max(
        (tagged_line:find '%s' or 0),
        (tagged_line:find '%)' or 0),
        (tagged_line:find '%]' or 0)
      ) + 1
      local square = tagged_line:match '%[(.-)%]'
      if square == '' or square == 'opt' then square = 'nil' end
      local parsed_line = {
        name = lume.trim((tagged_line .. '\n'):match '^(.-)[%s\n]' or ''),
        title = lume.trim(tagged_line:sub(comment_start_at, -1)),
        parent = tagged_line:match '%((.-)%)',
        square = square,
      }
      if parsed_line.name:find '[%[%(]' then parsed_line.name = nil end
      for short, long in pairs({ ['>'] = 'fields', ['<'] = 'returns' }) do
        if tag == short then
          self[long] = self[long] or {}
          table.insert(self[long], parsed_line)
        end
      end
      if tag == '=' then
        self.line = self.line or parsed_line
      end
    elseif line ~= ']]' then
      local description = self.description or ''
      if line ~= '' or description:sub(-2) ~= '\n\n' then
        description = description .. line .. '\n'
      end
      self.description = description
    end
  end
  return self
end


--[[ Correct parsed block
Trim and remove empty strings in table values
> self (table)
]]
function Block:correct()
  assert(type(self) == 'table')
  for key, value in pairs(self) do
    if type(value) == 'table' then Block.correct(value)
    elseif type(value) == 'string' then
      value = lume.trim(value)
      if value == '' then value = nil end
      self[key] = value
    end
  end
  return self
end


return Block
