#!/bin/lua

require 'src.globals' { production = false }

print 'Running example application.'

local luapi = require 'lib.luapi' {
  root_path = '/home/luarocks/repo/core',
  path_filters = { 'etc' },
  -- path_filters = { 'lib' },
}

if arg[1] == 'dump' then -- dump(luapi)
  dump(luapi.files['etc.luapi_test'], { depth = 2 })
end
