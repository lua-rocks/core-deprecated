#!/bin/lua

require 'src.globals' { production = false }

print 'Running LUAPI test.'

local luapi = require 'lib.luapi' {
  root_path = '/home/luarocks/repo/core',
  path_filters = { 'etc' },
  -- path_filters = { 'lib' },
}

return luapi