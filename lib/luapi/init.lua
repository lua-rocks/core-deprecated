local Object = require 'lib.object'


--[[ Plans for future
+ TODO: Make docs for lume
+ TODO: Links in type description
+ IDEA: Global links
+ IDEA: Show inharited fields
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
= @>init (function)
> self   (@)
> conf   (table=lib.luapi.conf)
]]
function LUAPI:init(conf)
  self.conf  = require 'lib.luapi.conf'  (conf)
  self.files = require 'lib.luapi.files' (self)
end


return LUAPI
