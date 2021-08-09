local lume = require 'lib.lume'

--[[ Parse block; do NOT overwrite existed data
> self (lib.luapi.block)
> block (string)
> last_line (string) []
]]
local function parse(self, block)
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

return function(self, block)
  parse(self, block)
  correct_parsed(self)
end
