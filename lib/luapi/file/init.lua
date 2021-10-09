local asserts = require 'lib.asserts'
local Object  = require 'lib.object'
local Type    = require 'lib.luapi.type'


--[[ Single lua file
= @ (lib.object)
> reqpath  (string)
> fullpath (string)
> module   (lib.luapi.type) []
> cache    (@.cache) [] Gets removed after File:write() attempt
]]
local File = Object:extend 'lib.luapi.file'


--[[ Init file but don't read it
= @>init   (function)
> self     (@)
> reqpath  (string)
> fullpath (string)
> conf (lib.luapi.conf)
]]
function File:init(reqpath, fullpath, conf)
  asserts(function(x) return type(x) == 'string' end, reqpath, fullpath)
  assert(conf:is('lib.luapi.conf'))
  self.reqpath = reqpath
  self.fullpath = fullpath
  self.cache = require 'lib.luapi.file.cache' (self, conf)
end


--[[ Read file
= @>read  (function)
> self    (@)
< success (@) []
]]
function File:read()
  -- init.lua
  local file = io.open(self.fullpath .. '/init.lua', 'rb')
  if not file then return nil end
  self.cache.content = file:read '*a' .. '\n'
  self.cache.code = self.cache.content
    :gsub('%-%-%[%[.-%]%]', '')
    :gsub('%-%-.-\n', '')
  file:close()
  -- modname.md or include.md
  local modname = self.fullpath:match '.+/(.+)'
  file = io.open(self.fullpath .. '/' .. modname .. '.md', 'rb')
    or io.open(self.fullpath .. '/include.md', 'rb')
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


--[[ Parse module before everything else
= @>parse (function)
> self    (@)
< success (@) []
]]
function File:parse_module()
  for block in self.cache.content:gmatch '%-%-%[%[.-%]%].-\n' do
    if block:find '\n=%s@%P'
    or block:find('\n=%s' .. self.cache.escaped_reqpath .. '%P') then
      self.module = Type(block, self.reqpath, self.cache.conf.parser)
      return self
    end
  end
end


--[[ Parse file
= @>parse (function)
> self    (@)
< success (@)
]]
function File:parse()
  local parser = self.cache.conf.parser
  if parser == 'strict' then
    local index = 1
    for block in self.cache.content:gmatch '%-%-%[%[.-%]%].-\n' do
      local type = Type(block, self.reqpath, parser)
      if type then
        type.index = index
        local short_type_name = type.name:gsub(self.cache.escaped_reqpath, '@')
        local s = short_type_name:sub(1, 2)
        type.name = short_type_name:sub(3, -1)
        if s == '@>' then
          self.module.fields = self.module.fields or {}
          self.module.fields[type.name] = type
        elseif s == '@<' then
          self.module.returns = self.module.returns or {}
          self.module.returns[type.name] = type
        elseif s == '@#' then
          self.module.locals = self.module.locals or {}
          self.module.locals[type.name] = type
        end
      end
      index = index + 1
    end
    return self
  end
  return false
end


--[[ Write @#output to the file and clean up file cache
= @>write (function)
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
  if self.module then self.module:build_output(self) end

  -- Write output
  local out = self.cache
  file:write(out.head.text .. out.body.text .. out.foot.text)
  file:close()

  return self
end


--[[ Try to get access to type in this file by path
= @>get_type (function)
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
= @>cleanup (function)
> self (@)
]]
function File:cleanup()
  self.cache = nil
end


return File
