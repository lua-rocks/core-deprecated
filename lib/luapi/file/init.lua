local asserts = require 'lib.asserts'
local module  = require 'lib.module'
local Block   = require 'lib.luapi.block'


local content_full
local content_code


--[[ Class structure
@ lib.luapi.file.class (lib.luapi.block)
> title       (string)               []
> description (string)               []
> codename    (string)               [] How its actually called in code
> reqpath     (string)                  Unique require path
> extends     (string)               [] Parent class reqpath or lua type
> requires    (list=string)          [] Modules only
> fields      (list=lib.luapi.block) []
> methods     (list=lib.luapi.block) []
]]


--[[ Single lua file
IDEA: Parse and write list of requires
@ (list=lib.luapi.file.class) First class is current module
> reqpath (string)
> fullpath (string)
]]
local File = module 'lib.luapi.file'


--[[ Universal output for method args and returns
> self (lib.luapi.block.line)
> out (table)
> arrow (string)
]]
local function out_method_args_and_returns(self, out, arrow)
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
local function out_methods_and_fields(self, out, is)
  out.head:add('+ **' .. self.name)
  if is == 'fields' then
    if self.parent then out.head:add(' : ' .. self.parent) end
    if self.square then out.head:add(' = ' .. self.square) end
  elseif is == 'methods' then
    out.body:add('\n## ' .. self.name .. '\n')
    if self.title then out.body:add('\n' .. self.title .. '\n') end
    if self.description then out.body:add('\n> ' ..
      self.description:gsub('\n', '\n> ') .. '\n') end
    if self.fields then
      out.head:add ' ('
      for index, value in ipairs(self.fields) do
        if index > 1 then out.head:add ', ' end
        out_method_args_and_returns(value, out, '✏️')
      end
      out.head:add ')'
    end
    if self.returns then
      out.head:add ' : '
      for index, value in ipairs(self.returns) do
        if index > 1 then out.head:add ', ' end
        out_method_args_and_returns(value, out, '🔚')
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
> self (lib.luapi.file.class)
> out (table)
]]
local function out_module(self, out)
  if self.methods then out.body:add '\n## 🧩 Details\n' end
  if self.extends then
    out.head:add('\nExtends: **' .. self.extends ..'**\n')
  end
  if self.title then out.head:add('\n## ' .. self.title .. '\n') end
  if self.requires then
    out.head:add '\nRequires: **'
    for index, value in ipairs(self.requires) do
      if index > 1 then out.head:add ', ' end
      out.head:add(value)
    end
    out.head:add '**'
  end
  if self.description then
    out.head:add('\n' .. self.description .. '\n')
  end

  if self.fields then
    out.head:add('\n## 📜 Fields\n\n')
    for _, param in ipairs(self.fields) do
      out_methods_and_fields(param, out, 'fields')
    end
  end

  if self.methods then
    out.head:add '\n## 💡 Methods\n\n'
    for _, param in ipairs(self.methods) do
      out_methods_and_fields(param, out, 'methods')
    end
  end
end


function File:init(reqpath, fullpath)
  asserts(function(x) return type(x) == 'string' end, reqpath, fullpath)

  self.reqpath = reqpath
  self.fullpath = fullpath
end


--[[
< success (lib.luapi.file|nil)
]]
function File:read()
  local file = io.open(self.fullpath .. '/init.lua', 'rb')
  if not file then file:close() return nil end
  content_full = file:read '*a'
  content_code = content_full:gsub('%-%-%[%[.-%]%]', ''):gsub('%-%-.-\n', '')
  file:close()
  return self
end


--[[
< success (lib.luapi.file|nil)
]]
function File:parse()
  local self1 = Block()
  local selfN = {}
  self1.codename = content_code:match 'return%s([%w_]+)\n?$'

  local function set_block_name(block)
    if block.extends and block.extends.name then
      block.name = block.extends.name
      block.extends.name = nil
    else
      block.name = block.codename
    end
  end

  local function return_self()
    -- Convert self1.fields in lines format to blocks format
    for field_i, field in ipairs(self1.fields or {}) do
      if tostring(field) ~= 'instance of lib.luapi.block' then
        self1.fields[field_i] = Block()
        for line_key, line in pairs(field) do
          self1.fields[field_i][line_key] = line
        end
      end
    end
    -- Replace `self1.extends` tables with strings
    if self1.extends then self1.extends = self1.extends.parent end
    -- Insert classes
    self[1] = self1
    for _, class in ipairs(selfN) do table.insert(self, class) end
    return self
  end

  if not self1.codename then
    -- If module codename not found in last return,
    -- lets try to take it from first described class.
    self1.codename = content_full:match
      '%-%-%[%[.-\n@%s.-]%].-\nlocal%s([%w_]+)'
  end
  if not self1.codename then
    -- Abstract module?
    local block = content_full:match '%-%-%[%[.-\n@%s.-%]%].-\n'
    self1 = Block(block)
    for _, value in pairs(self1) do
      if type(value) ~= 'function' then
        return return_self()
      end
    end
    return nil
  end

  -- Parse each commented block
  for block, last_line in content_full:gmatch '(%-%-%[%[.-%]%].-\n)(.-)\n' do
    local module_codename_found = ('\n' .. last_line)
      :find('%W' .. self1.codename .. '%W')
    if module_codename_found then
      -- Field
      if module_codename_found == 1 then
        local field = Block(block)
        field.codename = last_line
          :gsub('%s', '')
          :match(self1.codename .. '%.(.+)=')
        set_block_name(field)
        if field.extends then
          for key, value in pairs(field.extends) do field[key] = value end
          field.extends = nil
        end
        if next(field) then
          self1.fields = self1.fields or {}
          table.insert(self1.fields, field)
        end
      -- Method
      elseif last_line:find 'function%s' == 1 then
        local method = Block(block)
        method.codename = last_line
          :sub(10)
          :gsub('%s', '')
          :match(self1.codename .. '[:%.](.+)%(')
        if next(method) then
          self1.methods = self1.methods or {}
          table.insert(self1.methods, method)
        end
        set_block_name(method)
        local codeargs = {}
        for comma_separated in last_line:gmatch '%((.-)%)' do
          for arg in comma_separated:gmatch '[%w_]+' do
            table.insert(codeargs, (arg:gsub('[,%s]', '')))
          end
        end
        if next(codeargs) then method.codeargs = codeargs end
      -- Module
      elseif last_line:match 'local%s([%w_]+)' == self1.codename then
        local codename = self1.codename
        self1 = Block(block) or self1
        if codename then self1.codename = codename end
      end
    elseif block:match '\n@.+' then -- Class
      table.insert(selfN, Block(block))
    end
  end

  if next(self1) then
    if not self1.fields and
      not self1.methods and
      not self.title and
      not self.description
    then return nil end
    return return_self()
  end
  return nil
end


--[[
< success (lib.luapi.file|nil)
]]
function File:write()
  -- Touch file
  local file = io.open(self.fullpath .. '/readme.md', 'w+')
  if not file then
    print('error: failed to create "' .. self.fullpath .. '/readme.md' .. '"')
    return nil
  end

  -- Create a table for preparations
  local self1 = self[1]
  local add = function(add, text) add.text = add.text .. text end
  local out = {}
  for _, key in ipairs { 'head', 'body', 'foot' } do
    out[key] = { text = '', add = add }
  end

  out.foot:add '\n## 🖇️ Links\n'
  out.foot:add('\n[Go up](..)\n')

  -- See `lib.luapi.block:out()`
  if self1 then
    -- IDEA: Include lua-file as example
    -- IDEA: Include md-file as additional info
    -- TODO: Module classes
    -- TODO: Links across document

    out.head:add('# `' .. self.reqpath .. '`\n')
    out_module(self1, out)
  end

  -- Write everything
  file:write(out.head.text .. out.body.text .. out.foot.text)
  file:close()
  return self
end


return File
