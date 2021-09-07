--[[ Setup global variables for production and development modes
= @ (function)
> conf (@#conf)
]]
return function (conf)
  -- Core libs can be required globally if you want to
  -- lume    = require 'lib.lume'
  -- asserts = require 'lib.asserts'
  -- module  = require 'lib.module'
  -- Object  = require 'lib.object'
  if conf.production then
    -- Disable asserts for better perfomance
    local function nothing(...) return ... end
    assert = nothing
    if asserts then asserts = nothing end
  else
    inspect = require 'lib.inspect'
    function dump(...) print(inspect(...)) end
  end
end

--[[ Configuration table
= @#conf (table)
> production (boolean) Production or development mode
]]
