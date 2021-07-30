local module = require 'lib.module'


--[[ Documentation generator
+ IDEA: Add error handler module
+ IDEA: Support `atom-autocomplete`
+ IDEA: Clean markdown (no `markdownlint` warnings)
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
