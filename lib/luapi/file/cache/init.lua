local Object  = require 'lib.object'

--[[ Temporary data
Gets removed after File:write() attempt.
= @ (lib.object)
> content (string) [] full content of this file
> code    (string) [] uncommented content of this file
> example (string) [] example.lua
> readme  (string) [] dirname.lua
> head (@#output)
> body (@#output)
> foot (@#output)
]]
local Cache = Object:extend 'lib.luapi.file.cache'


--[[ Element of output model
= @#output (table)
> text (string)
> add (@#output.add)
]]


--[[ Add text to output field
= @#output.add (function)
> self (@#output)
> text (string)
< self (@#output)
]]


function Cache:init()
  local add = function(add, text) add.text = add.text .. text; return add end
  for _, key in ipairs { 'head', 'body', 'foot' } do
    self[key] = { text = '', add = add }
  end
end


return Cache
