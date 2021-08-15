local asserts = require 'lib.asserts'
local Object  = require 'lib.object'
local Type    = require 'lib.luapi.type'


--[[ Single lua file
XXX: REDUCE COMPLEXITY

= @ (lib.object)
> reqpath  (string)
> fullpath (string)
> module   ({string=lib.luapi.type...}) [] external types indexed by type names
> locals   ({string=lib.luapi.type...}) [] internal types indexed by type names
> cache    (@.cache) [] gets removed after File:write() attempt
]]
local File = Object:extend 'lib.luapi.file'


--[[ Init file but don't read it
= @:init   (function)
> self     (@)
> reqpath  (string)
> fullpath (string)
]]
function File:init(reqpath, fullpath)
  asserts(function(x) return type(x) == 'string' end, reqpath, fullpath)
  self.reqpath = reqpath
  self.fullpath = fullpath
  self.cache = require 'lib.luapi.file.cache' ()
end


--[[ Read file
= @:read  (function)
> self    (@)
< success (@) []
]]
function File:read()
  -- init.lua
  local file = io.open(self.fullpath .. '/init.lua', 'rb')
  if not file then return nil end
  self.cache.content = file:read '*a'
  self.cache.code = self.cache.content
    :gsub('%-%-%[%[.-%]%]', '')
    :gsub('%-%-.-\n', '')
  file:close()
  -- modname.md
  local modname = self.fullpath:match '.+/(.+)'
  file = io.open(self.fullpath .. '/' .. modname .. '.md', 'rb')
  if file then
    self.cache.readme = '\n' .. file:read '*a'
    file:close()
  end
  -- example.lua
  file = io.open(self.fullpath .. '/example.lua', 'rb')
  if file then
    self.cache.example = file:read '*a'
    file:close()
  end
  return self
end


--[[ Parse file
= @:parse (function)
> self    (@)
< success (@) []
]]
function File:parse()
  -- Init
  self.module = {}
  self.locals = {}
  local escaped_reqpath = self.reqpath:gsub('%p', '%%%1')
  -- Parse blocks
  for block in self.cache.content:gmatch '%-%-%[%[.-%]%].-\n' do
    local type = Type(block)
    if type then
      local short_type_name = type.name:gsub(escaped_reqpath, '@')
      if short_type_name == '@' then
        for _, ifield in ipairs(type.fields) do
          self.module[ifield.name] = ifield
        end
      else
        local s = short_type_name:sub(1, 2)
        local e = short_type_name:sub(3, -1)
        if s == '@:' then
          self.module[e] = type
        elseif s == '@#' then
          self.locals[e] = type
        end
      end
    end
  end
  -- Convert line fields to types
  -- for name, line in pairs(self.module) do
  --   local type = Type(line)
  --   if type then self.module[name] = type end
  -- end
  -- Clean up
  if next(self.module) == nil then self.module = nil end
  if next(self.locals) == nil then self.locals = nil end
  return self
end


--[[ Write `@#output` to the file and clean up file cache
= @:write (function)
> self (@)
< self (@)
]]
function File:write()
  -- Touch file
  local file = io.open(self.fullpath .. '/readme.md', 'w+')
  if not file then
    print('error: failed to create "' .. self.fullpath .. '/readme.md' .. '"')
    return nil
  end

  -- Create output
  local self1 = self[1]
  if self1 then
    self1:output_main(self)
    for index = 2, #self do
      local selfi = self[index]
      assert(type(selfi.line) == 'table')
      assert(type(selfi.line.name) == 'string')
      assert(type(selfi.line.parent) == 'string')
      selfi:output_add(self)
    end
  end

  -- Write output
  local out = self.cache
  if out then
    file:write(out.head.text .. out.body.text .. out.foot.text)
    file:close()
  end

  return self
end


--[[ Try to get access to type in this file by path
= @:get_type (function)
> self       (@)
> path       (string)
< result     (lib.luapi.type|string)
]]
function File:get_type(path)
  path = path:gsub('@', self.reqpath)
  local len = self.reqpath:len()
  if path:sub(1, len) == self.reqpath then
    local type_name = path:sub(len+2, -1)
    local divider = len+1
    divider = path:sub(divider, divider)
    if divider == ':' then
      return self.module[type_name]
    elseif divider == '#' then
      return self.locals[type_name]
    end
  end
  return path
end


--[[ Remove cache
= @:cleanup (function)
> self (@)
]]
function File:cleanup()
  self.cache = nil
end


return File
