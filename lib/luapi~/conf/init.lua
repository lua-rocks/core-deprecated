local Object = require 'lib.object'


--[[ Documentation generator config
> root_path (string)
> path_filters (list) [] Search files only in these subdirs (relative to root)
]]
local Conf = Object:extend 'lib.luapi.conf'


--[[
> conf (table=lib.luapi.conf)
]]
function Conf:init(conf)
  self.root_path    = conf.root_path:gsub('\\\\', '/'):gsub('\\', '/')
  self.path_filters = conf.path_filters
end


return Conf
