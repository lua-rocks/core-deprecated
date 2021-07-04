local module = require 'lib.module'


--[[ Documentation generator config
> root_path (string)
> out_path (string)   ['doc'] (Relative to root)
> path_filters (list) [] Search files only in these subdirs (relative to root)
> index_name (string) ['readme.md'] Name of the index file
]]
local Conf = module 'lib.luapi.conf'


--[[
> conf (table=lib.luapi.conf)
]]
function Conf:init(conf)
  self.root_path    = conf.root_path:gsub('\\\\', '/'):gsub('\\', '/')
  self.out_path     = conf.out_path or 'doc'
  self.path_filters = conf.path_filters
  self.index_name   = conf.index_name or 'readme.md'
end


return Conf
