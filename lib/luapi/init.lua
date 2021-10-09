local Object = require 'lib.object'


--[[ Plans for future
+ TODO: Add lib.luapi.type.parser
  + "strict" (default)
  + "smart" (parse code)
  + "emmy" (compatibility with sumneko LSP)
    + Ask sumneko to support my syntax
+ IDEA: Global links
  + IDEA: Links in type description
  + IDEA: Show inharited fields
+ IDEA: Add error handler module
+ IDEA: Make docs for lume
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
