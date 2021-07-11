--[[ This file is sandbox for testing luapi
@ this.reqpath.will.be.overwritten.by.real.reqpath (table)
> some_field1 (some_type1) [some_default_value1] Some field title1
> some_field2 (some_type2) [some_default_value2] Some field title2
> class2 (etc.sandbox.luapi_test.class2) TODO: Should be parsed as method
]]
local M = {}


--[[ Super-duper method
You no need to describe argument `self` for methods named with colon
(actually you no **need** to describe anything 😉
but of course you can if you want to).
> n    (number)    Spaces between tagged data will be ignored
> x    (integer)   [2]
< self (etc.sandbox.luapi_test) Bli bla
< n    (number)    Blu ble
]]
function M:super_method(n, x)
  return self, n*(x or 2)
end


--[[ Mega-class
@ etc.sandbox.luapi_test.mega
> giga (any) Yay!
]]


--[[ Test class 2
If class is function and you set it as module field, it will be parsed as method
@ etc.sandbox.luapi_test.class2 (function)
> take (string)
< give (integer)
]]


--[[ This comment will be ignored
Because it has no tag @ inside or variable definitions below
]]


--[[ Extra field
@ (number) [3]
]]
M.super_number_field = 3


--[[ Another extra field
@ (table)
> a (number) [1]
> b (integer) [2]
]]
M.super_table_field = {
  a = 1,
  b = 2,
}


return M
