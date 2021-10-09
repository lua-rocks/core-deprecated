local lume = require 'lib.lume'

--[[ Parse block
= @ (function)
> self    (lib.luapi.type)
> block   (string)
> reqpath (string) []
]]
return function (self, block, reqpath)
  assert(type(block) == 'string')
  -- Parse block line by line
  local line_index = 1
  for line in block:gmatch '\n(%C*)' do
    local tag = line:sub(1, 1)
    if tag == '>' or tag == '<' or tag == '=' then
      local tagged_line = line:sub(3, -1)
      if reqpath then tagged_line = tagged_line:gsub('@', reqpath) end
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
        parent = tagged_line:match '%((.-)%)' or 'any',
        square = square,
      }
      if parsed_line.name:find '[%[%(]' then parsed_line.name = nil end
      for short, long in pairs({ ['>'] = 'fields', ['<'] = 'returns' }) do
        if tag == short then
          self[long] = self[long] or {}
          self[long][parsed_line.name] = parsed_line
          self[long][parsed_line.name].index = line_index
          line_index = line_index + 1
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
  if not self.title or self.title == '' then
    self.title = block:match '%-%-%[%[(.-)%]%]':gsub('\n.*', '')
  end
  return self
end