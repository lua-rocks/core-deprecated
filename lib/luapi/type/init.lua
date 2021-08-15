local Object = require 'lib.object'
local lume = require 'lib.lume'


--[[ Parsed tagged comment block of any type
= @ (lib.object)
> name        (string)         First word after tag =
> parent      (string)         Text in parentheses after tag =
> title       (string)      [] Any text at the end of tag = or 1st line in block
> square      (string)      [] Text in square brackets after tag =
> description (string)      [] Not tagged lines in block
> fields      (list=@#line) [] Line after >
> returns     (list=@#line) [] Line after <
]]
local Type = Object:extend 'lib.luapi.type'


--[[ One line of tagged block
= @#line (table)
> name   (string)  [] First word after tag
> parent (string)  [] Text in parentheses
> title  (string)  [] Any text at the end
> square (string)  [] Text in square brackets
> index  (integer) [] Output order
]]


--[[ Take comments block and return a type
= @:init (function)
> self   (@)
> block  (string) []
]]
function Type:init(block)
  if not block then return false end
  assert(type(block) == 'string')
  if block then
    self:parse(block):correct()
  end
  if not self.name or not self.parent then return false end
end


--[[ Parse block
= @:parse (function)
> self    (@)
> block   (string)
]]
function Type:parse(block)
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
          self[long][parsed_line.name] = parsed_line
        end
      end
      if tag == '=' then
        for key, value in pairs(parsed_line) do
          self[key] = value
        end
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
= @:correct (function)
> self      (table)
]]
function Type:correct()
  assert(type(self) == 'table')
  for key, value in pairs(self) do
    if type(value) == 'table' then Type.correct(value)
    elseif type(value) == 'string' then
      value = lume.trim(value)
      if value == '' then value = nil end
      self[key] = value
    end
  end
  return self
end


return Type
