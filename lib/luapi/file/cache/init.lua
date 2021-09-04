local Object  = require 'lib.object'
local lume    = require 'lib.lume'

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
> escaped_reqpath (string)
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


--[[ Initialize
= @:init (function)
> file (lib.luapi.file)
]]
function Cache:init(file)
  local add = function(add, text, vars)
    if vars then
      add.text = add.text .. lume.format(text, vars)
    else
      add.text = add.text .. text
    end
    return add
  end
  for _, key in ipairs { 'head', 'body', 'foot' } do
    self[key] = { text = '', add = add }
  end
  self.escaped_reqpath = file.reqpath:gsub('%p', '%%%1')
end


return Cache
