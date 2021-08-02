--[[ Configuration table
@ src.globals.conf (table)
> production (boolean) Production or development mode
]]

--[[ Setup global variables for production and development modes
> conf (src.globals.conf)
]]
return function (conf)
  -- Core libs can be required globally if you want to
  -- lume    = require 'lib.lume'
  -- asserts = require 'lib.asserts'
  -- module  = require 'lib.module'
  -- Object  = require 'lib.object'
  if conf.production then
    -- Disable asserts for better perfomance
    function assert(...) return ... end
    if asserts then asserts = assert end
  else
    -- Enable debugging functions
    inspect = require 'lib.inspect'
    function dump(...) print(inspect(...)) end
  end
end
