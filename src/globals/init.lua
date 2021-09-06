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
    function assert(...) return ... end
    if asserts then asserts = assert end
  else
    -- Enable debugging functions
    -- dbg is no needed if you have lua debugger in your IDE,
    -- but inspect/dump can be helpful for real-time non-breaking debugging
    -- (maybe it's also possible with normal debugger, I'm not sure).
    -- dbg  = require 'lib.debugger'
    inspect = require 'lib.inspect'
    function dump(...) print(inspect(...)) end
  end
end

--[[ Configuration table
= @#conf (table)
> production (boolean) Production or development mode
]]