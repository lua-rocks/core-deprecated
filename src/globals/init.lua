---Setup global variables for production and development modes
---@param conf src.globals-conf
return function (conf)
  -- Core libs can be required globally if you want to
  -- lume    = require 'lib.lume'
  -- Object  = require 'lib.object'
  if conf.production then
    -- Disable asserts for better perfomance
    local function nothing(...) return ... end
    assert = nothing
  else
    inspect = require 'lib.inspect'
    function dump(...) print(inspect(...)) end
  end
end

---@class src.globals-conf
---@field production boolean? Production or development mode
