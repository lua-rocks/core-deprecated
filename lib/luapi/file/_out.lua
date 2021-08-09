local _out = {}


--[[ Universal output for method args and returns
> self (lib.luapi.block.line)
> out (table)
> arrow (string)
]]
function _out.method_args_and_returns(self, out, arrow)
  out.head:add(self.name)
  out.body:add('\n' .. arrow .. ' `' .. self.name .. '`')
  if self.parent then
    out.body:add(' : **' .. self.parent .. '**')
  end
  if self.square then
    out.body:add(' _[' .. self.square .. ']_')
  end
  if self.title then
    out.body:add('\n`' .. self.title .. '`')
  end
  out.body:add '\n'
end


--[[ Universal output for methods and fields
> self (lib.luapi.block)
> out (table)
> is ('methods'|'fields')
]]
function _out.methods_and_fields(self, out, is)
  out.head:add('+ **' .. self.name)
  if is == 'fields' then
    if self.parent then out.head:add(' : ' .. self.parent) end
    if self.square then out.head:add(' = ' .. self.square) end
  elseif is == 'methods' then
    out.body:add('\n### Method `' .. self.name .. '`\n')
    if self.title then out.body:add('\n' .. self.title .. '\n') end
    if self.description then out.body:add('\n> ' ..
      self.description:gsub('\n', '\n> ') .. '\n') end
    if self.fields then
      out.head:add ' ('
      for index, value in ipairs(self.fields) do
        if index > 1 then out.head:add ', ' end
        _out.method_args_and_returns(value, out, '→')
      end
      out.head:add ')'
    end
    if self.returns then
      out.head:add ' : '
      for index, value in ipairs(self.returns) do
        if index > 1 then out.head:add ', ' end
        _out.method_args_and_returns(value, out, '←')
      end
    end
  end
  out.head:add '**'
  if self.title then
    out.head:add('\n  `' .. self.title .. '`')
  end
  out.head:add '\n'
end


--[[ Moulde output
> self (lib.luapi.file)
> out (table)
> content (lib.luapi.file.content)
]]
function _out.module(self, out)
  local self1 = self[1]
  if self1.methods then out.body:add '\n## 🧩 Details\n' end
  if self1.extends then
    out.head:add('\nExtends: **' .. self1.extends ..'**\n')
  end
  if self.content.example then
    out.head
      :add '\n<details><summary><b>Example</b></summary>\n\n```lua\n'
      :add (self.content.example)
      :add '```\n\n</details>\n'
  end
  if self.content.readme then
    if not self1.title then
      self1.title = self.content.readme:match '\n#%s(.-)\n'
    end
    self.content.readme = self.content.readme
      :gsub('\n#%s.-\n', '') -- remove title header
      :gsub('\n#', '\n##') -- increase all headers level
  end
  if self1.title then out.head:add('\n## ' .. self1.title .. '\n') end
  if self.content.readme then out.head:add(self.content.readme) end
  if self1.requires then
    out.head:add '\nRequires: **'
    for index, value in ipairs(self1.requires) do
      if index > 1 then out.head:add ', ' end
      out.head:add(value)
    end
    out.head:add '**'
  end
  if self1.description then
    out.head:add('\n' .. self1.description .. '\n')
  end

  if self1.fields then
    out.head:add('\n## 📜 Fields\n\n')
    for _, param in ipairs(self1.fields) do
      _out.methods_and_fields(param, out, 'fields')
    end
  end

  if self1.methods then
    out.head:add '\n## 💡 Methods\n\n'
    for _, param in ipairs(self1.methods) do
      _out.methods_and_fields(param, out, 'methods')
    end
  end
end


--[[ XXX: Types output
> self (lib.luapi.file)
> out (table)
]]
function _out.types(self, out)
  if self[2] then
    out.head:add '\n## 👨‍👦 Types\n\n'
    for i = 2, #self do
      local selfi = self[i]
      if selfi.typeset and selfi.typeset.name then
        out.head:add('+ **' .. selfi.typeset.name .. '**\n')
      end
    end
  end
end


return _out
