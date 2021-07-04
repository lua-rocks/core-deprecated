#!/bin/lua

print 'Running example application.'

require 'src.globals' { production = false }

local luapi = require 'lib.luapi' {
  root_path = '/home/luarocks/repo/core',
  -- path_filters = { 'etc' },
  path_filters = { 'lib' },
}

if arg[1] == 'dump' then dump(luapi) end
