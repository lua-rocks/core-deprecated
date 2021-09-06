local Object = require 'lib.object'


--[[ Plans for future
+ IDEA: Add error handler module
+ IDEA: Support some IDE
]]


--[[ Documentation generator
= @     (lib.object)
> conf  (lib.luapi.conf)
> files (lib.luapi.files)
]]
local LUAPI = Object:extend 'lib.luapi'


--[[
= @:init (function)
> self   (@)
> conf   (table=lib.luapi.conf)
]]
function LUAPI:init(conf)
  self.conf  = require 'lib.luapi.conf'  (conf)
  self.files = require 'lib.luapi.files' (self)
end


return LUAPI
