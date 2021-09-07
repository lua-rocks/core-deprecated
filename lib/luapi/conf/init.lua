local Object = require 'lib.object'


--[[ Documentation generator config
= @ (lib.object)
> root_path (string)
> path_filters (list) [] Search files only in these subdirs (relative to root)
> publish (string) ['local'] Correct links to publish locally or on github
]]
local Conf = Object:extend 'lib.luapi.conf'


--[[
= @:init (function)
> conf (table=lib.luapi.conf)
]]
function Conf:init(conf)
  self.publish      = conf.publish or 'local'
  self.root_path    = conf.root_path:gsub('\\\\', '/'):gsub('\\', '/')
  self.path_filters = conf.path_filters
end


return Conf
