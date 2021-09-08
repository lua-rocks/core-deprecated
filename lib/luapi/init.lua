local Object = require 'lib.object'


--[[ Plans for future
+ FIXME: links id's uses ":" as separator for everything, including locals
+ TODO: Make docs for lume
+ TODO: Save order for all values
+ IDEA: Global links and external module types
+ IDEA: "Smart" mode (parse code)
+ IDEA: Add error handler module
+ IDEA: Compatibility with sumneko LSP
  + Add emmylua tags parser
  + Ask sumneko to support my syntax
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
