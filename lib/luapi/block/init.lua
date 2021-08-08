local module = require 'lib.module'
local lume = require 'lib.lume'


--[[ One line of tagged block
@ lib.luapi.block.line (class)
> name    (string) [] First word after tag
> title   (string) [] Any text at the end
> parent  (string) [] Text in parentheses
> square  (string) [] Text in square brackets
]]


--[[ Parsed tagged comment block of any TYPE
@ lib.luapi.block (table)
> title       (string) []
> description (string) []
> name        (string) []
> codename    (string) [] Sets before parsing in lib.luapi.file
> codeargs    (list=string) [] Real function arguments (from lib.luapi.file)
> fields      (list=lib.luapi.block.line) [] Line after >
> returns     (list=lib.luapi.block.line) [] Line after <
> typeset     (lib.luapi.block.line)      [] Line after @
]]
local Block = module 'lib.luapi.block'


--[[ Parse block; do NOT overwrite existed data
> self (lib.luapi.block)
> block (string)
> last_line (string) []
]]
local function parse_block(self, block)
  self.title = self.title or block:match '%-%-%[%[(.-)%]%]':gsub('\n.*', '')

  -- Parse block line by line
  for line in block:gmatch '\n(%C+)' do
    local tag = line:sub(1, 1)
    if tag == '>' or tag == '<' or tag == '@' then
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
      if tag == '@' then
        self.typeset = self.typeset or parsed_line
      end
    elseif line ~= ']]' then
      local description = self.description or ''
      if description ~= '' then description = description .. '\n' end
      description = description .. line
      self.description = description
    end
  end
end


--[[ Trim and remove empty strings in table values
> self (table)
]]
local function correct_parsed(self)
  for key, value in pairs(self) do
    if type(value) == 'table' then correct_parsed(value)
    elseif type(value) == 'string' then
      value = lume.trim(value)
      if value == '' then value = nil end
      self[key] = value
    end
  end
end


--[[ Take comments block and create structured data block
> block (table=lib.luapi.block) []
]]
function Block:init(block)
  if not block then return self end
  parse_block(self, block)
  correct_parsed(self)
end


return Block
