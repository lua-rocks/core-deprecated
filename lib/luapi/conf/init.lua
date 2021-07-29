local module = require 'lib.module'


--[[ Documentation generator config
> root_path (string)
> path_filters (list) [] Search files only in these subdirs (relative to root)
]]
local Conf = module 'lib.luapi.conf'


--[[
> conf (table=lib.luapi.conf)
]]
function Conf:init(conf)
  self.root_path    = conf.root_path:gsub('\\\\', '/'):gsub('\\', '/')
  self.path_filters = conf.path_filters
end


return Conf
