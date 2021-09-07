#!/bin/lua

require 'src.globals' { production = false }

print 'Running LUAPI test.'

local luapi = require 'lib.luapi' {
  root_path = '/home/luarocks/repo/core',
  -- path_filters = { 'etc' },
  -- path_filters = { 'lib/object' },
}

if arg[1] == 'dump' then -- dump(luapi)
  local inspect = luapi.files["etc.luapi_test.composite"].module--.fields
  local options = { depth = tonumber(arg[2]) or 2 }
  dump(inspect, options)
end
