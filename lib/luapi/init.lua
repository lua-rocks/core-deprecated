local module = require 'lib.module'


--[[ Documentation generator
> conf (lib.luapi.conf)
> files (lib.luapi.files)
]]
local LUAPI = module 'lib.luapi'


--[[
> conf (table=lib.luapi.conf)
]]
function LUAPI:init(conf)
  self.conf  = require 'lib.luapi.conf'  (conf)
  self.files = require 'lib.luapi.files' (self)
end


return LUAPI
