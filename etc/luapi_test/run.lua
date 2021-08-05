#!/bin/lua

require 'src.globals' { production = false }

print 'Running example application.'

dbg()

local luapi = require 'lib.luapi' {
  root_path = '/home/luarocks/repo/core',
  -- path_filters = { 'etc' },
  -- path_filters = { 'lib' },
}

dbg()

if arg[1] == 'dump' then dump(luapi) end
