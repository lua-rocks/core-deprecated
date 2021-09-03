-- Temporary stop parsing code, so tag `=` MUST be always used

--[[ This file is sandbox for testing luapi
= @ (table)
> some_field1 (some_type1) [some_default_value1] Some field title1
> some_field2 (some_type2) [some_default_value2] Some field title2
> class2      (@:type2) IDEA: Should be writed as method
]]
local M = {}


--[[ Super-duper method
You no need to describe argument `self` for methods named with colon
(actually you no **need** to describe anything 😉
but of course you can if you want to).
= @:super_method (function)
> n    (number)    Spaces between tagged data will be ignored
> x    (integer)   [2]
< self (@)         Bli bla
< n    (number)    Blu ble
]]
function M:super_method(n, x)
  return self, n*(x or 2)
end


--[[ Mega-field
= @:mega (lib.object)
> giga (any) Yay!
]]


--[[ Test type 2
If type is function and you set it as module field, it will be parsed as method
= @:type2 (function)
> take (@#tbl) abstract type desribed below
< give (integer)
]]


--[[ Abstract type
Symbol `#` used to define [private|abstract|local] type
= @#tbl (table)
> foo (string)
> bar (string)
]]


--[[ This comment will be ignored
Because it has no tag = inside or variable definitions below
]]


return M
