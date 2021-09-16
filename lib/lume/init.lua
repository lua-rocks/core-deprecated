--[[ Lume

A collection of functions for Lua, geared towards game development.

= @ (table)
]]
local lume = { _version = "2.3.0" }

local pairs, ipairs = pairs, ipairs
local type, assert, unpack = type, assert, unpack or table.unpack
local tostring, tonumber = tostring, tonumber
local math_floor = math.floor
local math_ceil = math.ceil
local math_atan2 = math.atan2 or math.atan
local math_sqrt = math.sqrt
local math_abs = math.abs

local noop = function()
end

local identity = function(x)
  return x
end

local patternescape = function(str)
  return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
end

local absindex = function(len, i)
  return i < 0 and (len + i + 1) or i
end

local iscallable = function(x)
  if type(x) == "function" then return true end
  local mt = getmetatable(x)
  return mt and mt.__call ~= nil
end

local getiter = function(x)
  if lume.isarray(x) then
    return ipairs
  elseif type(x) == "table" then
    return pairs
  end
  error("expected table", 3)
end

local iteratee = function(x)
  if x == nil then return identity end
  if iscallable(x) then return x end
  if type(x) == "table" then
    return function(z)
      for k, v in pairs(x) do
        if z[k] ~= v then return false end
      end
      return true
    end
  end
  return function(z) return z[x] end
end


--[[ Returns the number x clamped between the numbers min and max

= @>clamp (function)
> x (number)
> min (number)
> max (number)
< clamped (number)
]]
function lume.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end


--[[ Rounds x to the nearest integer

Rounds away from zero if we're midway between two integers. If `increment` is
set then the number is rounded to the nearest increment.

```lua
lume.round(2.3) -- Returns 2
lume.round(123.4567, .1) -- Returns 123.5
```

= @>round (function)
> x (number)
> increment (integer) []
< rounded (integer)
]]
function lume.round(x, increment)
  if increment then return lume.round(x / increment) * increment end
  return x >= 0 and math_floor(x + .5) or math_ceil(x - .5)
end


--[[ Returns 1 if x is 0 or above, returns -1 when x is negative

= @>sign (function)
> x (number)
< sign (integer)
]]
function lume.sign(x)
  return x < 0 and -1 or 1
end


--[[ Returns the linearly interpolated number between a and b

`amount` should be in the range of 0 - 1; if `amount` is outside of this range
it is clamped.

```lua
lume.lerp(100, 200, .5) -- Returns 150
```

= @>lerp (function)
> a (number)
> b (number)
> amount (number)
< interpolated (number)
]]
function lume.lerp(a, b, amount)
  return a + (b - a) * lume.clamp(amount, 0, 1)
end


--[[ Similar to @>lerp but uses cubic interpolation instead of linear

= @>smooth (function)
> a (number)
> b (number)
> amount (number)
< interpolated (number)
]]
function lume.smooth(a, b, amount)
  local t = lume.clamp(amount, 0, 1)
  local m = t * t * (3 - 2 * t)
  return a + (b - a) * m
end


--[[ Ping-pongs the number x between 0 and 1

= @>pingpong (function)
> x (number)
< x (number)
]]
function lume.pingpong(x)
  return 1 - math_abs(1 - x % 2)
end


--[[ Returns the distance between the two points

If `squared` is true then the squared distance is returned.
This is faster to calculate and can still be used when comparing distances.

= @>distance (function)
> x1 (number)
> y1 (number)
> x2 (number)
> y2 (number)
> squared (boolean) []
< distance (number)
]]
function lume.distance(x1, y1, x2, y2, squared)
  local dx = x1 - x2
  local dy = y1 - y2
  local s = dx * dx + dy * dy
  return squared and s or math_sqrt(s)
end


--[[ Returns the angle between the two points

= @>angle (function)
> x1 (number)
> y1 (number)
> x2 (number)
> y2 (number)
< angle (number)
]]
function lume.angle(x1, y1, x2, y2)
  return math_atan2(y2 - y1, x2 - x1)
end


--[[ Given an angle and magnitude, returns a vector

```lua
local x, y = lume.vector(0, 10) -- Returns 10, 0
```

= @>vector (function)
> angle (number)
> magnitude (number)
< x (number)
< y (number)
]]
function lume.vector(angle, magnitude)
  return math.cos(angle) * magnitude, math.sin(angle) * magnitude
end


--[[ Returns a random number between a and b

If only `a` is supplied a number between `0` and `a` is returned. If no
arguments are supplied a random number between `0` and `1` is returned.

= @>random (function)
> a (number)
> b (number)
< random (number)
]]
function lume.random(a, b)
  if not a then a, b = 0, 1 end
  if not b then b = 0 end
  return a + math.random() * (b - a)
end


--[[ Returns a random value from list t

If the list is empty an error is raised.

```lua
lume.randomchoice({true, false}) -- Returns either true or false
```

= @>randomchoice (function)
> t (list)
< value (any)
]]
function lume.randomchoice(t)
  return t[math.random(#t)]
end


--[[ Returns a "weighted" value from list t
= @>weightedchoice (function)

Takes the argument table `t` where the keys are the possible choices and the
value is the choice's weight. A weight should be 0 or above, the larger the
number the higher the probability of that choice being picked. If the table is
empty, a weight is below zero or all the weights are 0 then an error is raised.

```lua
lume.weightedchoice({ ["cat"] = 10, ["dog"] = 5, ["frog"] = 0 })
-- Returns either "cat" or "dog" with "cat" being twice as likely to be chosen.
```

> t ({any=number,...})
< value (any)
]]
function lume.weightedchoice(t)
  local sum = 0
  for _, v in pairs(t) do
    assert(v >= 0, "weight value less than zero")
    sum = sum + v
  end
  assert(sum ~= 0, "all weights are zero")
  local rnd = lume.random(sum)
  for k, v in pairs(t) do
    if rnd < v then return k end
    rnd = rnd - v
  end
end


--[[ Returns true if x is an array

The value is assumed to be an array if it is a table which contains a value at
the index `1`. This function is used internally and can be overridden if you
wish to use a different method to detect arrays.

= @>isarray (function)
> x (any)
< isarray (boolean)
]]
function lume.isarray(x)
  return (type(x) == "table" and x[1] ~= nil) and true or false
end


--[[ Pushes all the given values to the end of the table t

Returns the pushed values. Nil values are ignored.

```lua
local t = { 1, 2, 3 }
lume.push(t, 4, 5) -- `t` becomes { 1, 2, 3, 4, 5 }
```

= @>push (function)
> t (table)
> ... (any)
< ... (any)
]]
function lume.push(t, ...)
  local n = select("#", ...)
  for i = 1, n do
    t[#t + 1] = select(i, ...)
  end
  return ...
end


--[[ Removes the first instance of the value x if it exists in the table t

```lua
local t = { 1, 2, 3 }
lume.remove(t, 2) -- `t` becomes { 1, 3 }
```

= @>remove (function)
> t (table)
> x (any)
< x (any)
]]
function lume.remove(t, x)
  local iter = getiter(t)
  for i, v in iter(t) do
    if v == x then
      if lume.isarray(t) then
        table.remove(t, i)
        break
      else
        t[i] = nil
        break
      end
    end
  end
  return x
end


--[[ Nils all the values in the table t, this renders the table empty

```lua
local t = { 1, 2, 3 }
lume.clear(t) -- `t` becomes {}
```

= @>clear (function)
> t (table)
< t (table)
]]
function lume.clear(t)
  local iter = getiter(t)
  for k in iter(t) do
    t[k] = nil
  end
  return t
end


--[[ Copies all the fields from the source tables to the table t

If a key exists in multiple tables the right-most table's value is used.

```lua
local t = { a = 1, b = 2 }
lume.extend(t, { b = 4, c = 6 }) -- `t` becomes { a = 1, b = 4, c = 6 }
```

= @>extend (function)
> t (table)
> ... (table)
< t (table)
]]
function lume.extend(t, ...)
  for i = 1, select("#", ...) do
    local x = select(i, ...)
    if x then
      for k, v in pairs(x) do
        t[k] = v
      end
    end
  end
  return t
end


--[[ Returns a shuffled copy of the array t

= @>shuffle (function)
> t (table)
< shuffled (table)
]]
function lume.shuffle(t)
  local rtn = {}
  for i = 1, #t do
    local r = math.random(i)
    if r ~= i then
      rtn[i] = rtn[r]
    end
    rtn[r] = t[i]
  end
  return rtn
end


--[[ Returns a copy of the array t with all its items sorted

If `comp` is a function it will be used to compare the items when sorting. If
`comp` is a string it will be used as the key to sort the items by.

```lua
lume.sort({ 1, 4, 3, 2, 5 }) -- Returns { 1, 2, 3, 4, 5 }
lume.sort({ {z=2}, {z=3}, {z=1} }, "z") -- Returns { {z=1}, {z=2}, {z=3} }
lume.sort({ 1, 3, 2 }, function(a, b) return a > b end) -- Returns { 3, 2, 1 }
```

= @>sort (function)
> t (table)
> comp (function|string)
< sorted (table)
]]
function lume.sort(t, comp)
  local rtn = lume.clone(t)
  if comp then
    if type(comp) == "string" then
      table.sort(rtn, function(a, b) return a[comp] < b[comp] end)
    else
      table.sort(rtn, comp)
    end
  else
    table.sort(rtn)
  end
  return rtn
end


--[[ Iterates the supplied iterator and returns an array filled with the values

```lua
lume.array(string.gmatch("Hello world", "%a+")) -- Returns {"Hello", "world"}
```

= @>array (function)
> ... (any)
< array (array)
]]
function lume.array(...)
  local t = {}
  for x in ... do t[#t + 1] = x end
  return t
end


--[[ Does somthing with each table value

Iterates the table `t` and calls the function `fn` on each value followed by
the supplied additional arguments; if `fn` is a string the method of that name
is called for each value. The function returns `t` unmodified.

```lua
lume.each({1, 2, 3}, print) -- Prints "1", "2", "3" on separate lines
lume.each({a, b, c}, "move", 10, 20) -- Does x:move(10, 20) on each value
```

= @>each (function)
> t (table)
> fn (function|string)
> ... (any) []
< t (table)
]]
function lume.each(t, fn, ...)
  local iter = getiter(t)
  if type(fn) == "string" then
    for _, v in iter(t) do v[fn](v, ...) end
  else
    for _, v in iter(t) do fn(v, ...) end
  end
  return t
end


--[[ Applies the function fn to each value in table t

Returns a new table with the resulting values.

```lua
lume.map({1, 2, 3}, function(x) return x * 2 end) -- Returns {2, 4, 6}
```

= @>map (function)
> t (table)
> fn (function)
< map (table)
]]
function lume.map(t, fn)
  fn = iteratee(fn)
  local iter = getiter(t)
  local rtn = {}
  for k, v in iter(t) do rtn[k] = fn(v) end
  return rtn
end


--[[ Returns true if all the values in table are true

If a `fn` function is supplied it is called on each value, true is returned if
all of the calls to `fn` return true.

```lua
lume.all({1, 2, 1}, function(x) return x == 1 end) -- Returns false
```

= @>all (function)
> t (table)
> fn (function) []
< result (boolean)
]]
function lume.all(t, fn)
  fn = iteratee(fn)
  local iter = getiter(t)
  for _, v in iter(t) do
    if not fn(v) then return false end
  end
  return true
end


--[[ Returns true if any of the values in t table are true

If a `fn` function is supplied it is called on each value, true is returned if
any of the calls to `fn` return true.

```lua
lume.any({1, 2, 1}, function(x) return x == 1 end) -- Returns true
```

= @>any (function)
> t (table)
> fn (function) []
< any (boolean)
]]
function lume.any(t, fn)
  fn = iteratee(fn)
  local iter = getiter(t)
  for _, v in iter(t) do
    if fn(v) then return true end
  end
  return false
end


--[[
= @>reduce (function)
]]
function lume.reduce(t, fn, first)
  local acc = first
  local started = first and true or false
  local iter = getiter(t)
  for _, v in iter(t) do
    if started then
      acc = fn(acc, v)
    else
      acc = v
      started = true
    end
  end
  assert(started, "reduce of an empty table with no first value")
  return acc
end


--[[
= @>set (function)
]]
function lume.set(t)
  local rtn = {}
  for k in pairs(lume.invert(t)) do
    rtn[#rtn + 1] = k
  end
  return rtn
end


--[[
= @>filter (function)
]]
function lume.filter(t, fn, retainkeys)
  fn = iteratee(fn)
  local iter = getiter(t)
  local rtn = {}
  if retainkeys then
    for k, v in iter(t) do
      if fn(v) then rtn[k] = v end
    end
  else
    for _, v in iter(t) do
      if fn(v) then rtn[#rtn + 1] = v end
    end
  end
  return rtn
end


--[[
= @>reject (function)
]]
function lume.reject(t, fn, retainkeys)
  fn = iteratee(fn)
  local iter = getiter(t)
  local rtn = {}
  if retainkeys then
    for k, v in iter(t) do
      if not fn(v) then rtn[k] = v end
    end
  else
    for _, v in iter(t) do
      if not fn(v) then rtn[#rtn + 1] = v end
    end
  end
  return rtn
end


--[[
= @>merge (function)
]]
function lume.merge(...)
  local rtn = {}
  for i = 1, select("#", ...) do
    local t = select(i, ...)
    local iter = getiter(t)
    for k, v in iter(t) do
      rtn[k] = v
    end
  end
  return rtn
end


--[[
= @>concat (function)
]]
function lume.concat(...)
  local rtn = {}
  for i = 1, select("#", ...) do
    local t = select(i, ...)
    if t ~= nil then
      local iter = getiter(t)
      for _, v in iter(t) do
        rtn[#rtn + 1] = v
      end
    end
  end
  return rtn
end


--[[
= @>find (function)
]]
function lume.find(t, value)
  local iter = getiter(t)
  for k, v in iter(t) do
    if v == value then return k end
  end
  return nil
end


--[[
= @>match (function)
]]
function lume.match(t, fn)
  fn = iteratee(fn)
  local iter = getiter(t)
  for k, v in iter(t) do
    if fn(v) then return v, k end
  end
  return nil
end


--[[
= @>count (function)
]]
function lume.count(t, fn)
  local count = 0
  local iter = getiter(t)
  if fn then
    fn = iteratee(fn)
    for _, v in iter(t) do
      if fn(v) then count = count + 1 end
    end
  else
    if lume.isarray(t) then
      return #t
    end
    for _ in iter(t) do count = count + 1 end
  end
  return count
end


--[[
= @>slice (function)
]]
function lume.slice(t, i, j)
  i = i and absindex(#t, i) or 1
  j = j and absindex(#t, j) or #t
  local rtn = {}
  for x = i < 1 and 1 or i, j > #t and #t or j do
    rtn[#rtn + 1] = t[x]
  end
  return rtn
end


--[[
= @>first (function)
]]
function lume.first(t, n)
  if not n then return t[1] end
  return lume.slice(t, 1, n)
end


--[[
= @>last (function)
]]
function lume.last(t, n)
  if not n then return t[#t] end
  return lume.slice(t, -n, -1)
end


--[[
= @>invert (function)
]]
function lume.invert(t)
  local rtn = {}
  for k, v in pairs(t) do rtn[v] = k end
  return rtn
end


--[[
= @>pick (function)
]]
function lume.pick(t, ...)
  local rtn = {}
  for i = 1, select("#", ...) do
    local k = select(i, ...)
    rtn[k] = t[k]
  end
  return rtn
end


--[[
= @>keys (function)
]]
function lume.keys(t)
  local rtn = {}
  local iter = getiter(t)
  for k in iter(t) do rtn[#rtn + 1] = k end
  return rtn
end


--[[
= @>clone (function)
]]
function lume.clone(t)
  local rtn = {}
  for k, v in pairs(t) do rtn[k] = v end
  return rtn
end


--[[
= @>fn (function)
]]
function lume.fn(fn, ...)
  assert(iscallable(fn), "expected a function as the first argument")
  local args = { ... }
  return function(...)
    local a = lume.concat(args, { ... })
    return fn(unpack(a))
  end
end


--[[
= @>once (function)
]]
function lume.once(fn, ...)
  local f = lume.fn(fn, ...)
  local done = false
  return function(...)
    if done then return end
    done = true
    return f(...)
  end
end


local memoize_fnkey = {}
local memoize_nil = {}


--[[
= @>memoize (function)
]]
function lume.memoize(fn)
  local cache = {}
  return function(...)
    local c = cache
    for i = 1, select("#", ...) do
      local a = select(i, ...) or memoize_nil
      c[a] = c[a] or {}
      c = c[a]
    end
    c[memoize_fnkey] = c[memoize_fnkey] or {fn(...)}
    return unpack(c[memoize_fnkey])
  end
end


--[[
= @>combine (function)
]]
function lume.combine(...)
  local n = select('#', ...)
  if n == 0 then return noop end
  if n == 1 then
    local fn = select(1, ...)
    if not fn then return noop end
    assert(iscallable(fn), "expected a function or nil")
    return fn
  end
  local funcs = {}
  for i = 1, n do
    local fn = select(i, ...)
    if fn ~= nil then
      assert(iscallable(fn), "expected a function or nil")
      funcs[#funcs + 1] = fn
    end
  end
  return function(...)
    for _, f in ipairs(funcs) do f(...) end
  end
end


--[[
= @>call (function)
]]
function lume.call(fn, ...)
  if fn then
    return fn(...)
  end
end


--[[
= @>time (function)
]]
function lume.time(fn, ...)
  local start = os.clock()
  local rtn = {fn(...)}
  return (os.clock() - start), unpack(rtn)
end


local lambda_cache = {}


--[[
= @>lambda (function)
]]
function lume.lambda(str)
  if not lambda_cache[str] then
    local args, body = str:match([[^([%w,_ ]-)%->(.-)$]])
    assert(args and body, "bad string lambda")
    local s = "return function(" .. args .. ")\nreturn " .. body .. "\nend"
    lambda_cache[str] = lume.dostring(s)
  end
  return lambda_cache[str]
end


local serialize

local serialize_map = {
  [ "boolean" ] = tostring,
  [ "nil"     ] = tostring,
  [ "string"  ] = function(v) return string.format("%q", v) end,
  [ "number"  ] = function(v)
    if      v ~=  v     then return  "0/0"      --  nan
    elseif  v ==  1 / 0 then return  "1/0"      --  inf
    elseif  v == -1 / 0 then return "-1/0" end  -- -inf
    return tostring(v)
  end,
  [ "table"   ] = function(t, stk)
    stk = stk or {}
    if stk[t] then error("circular reference") end
    local rtn = {}
    stk[t] = true
    for k, v in pairs(t) do
      rtn[#rtn + 1] = "[" .. serialize(k, stk) .. "]=" .. serialize(v, stk)
    end
    stk[t] = nil
    return "{" .. table.concat(rtn, ",") .. "}"
  end
}

setmetatable(serialize_map, {
  __index = function(_, k) error("unsupported serialize type: " .. k) end
})

serialize = function(x, stk)
  return serialize_map[type(x)](x, stk)
end


--[[
= @>serialize (function)
]]
function lume.serialize(x)
  return serialize(x)
end


--[[
= @>deserialize (function)
]]
function lume.deserialize(str)
  return lume.dostring("return " .. str)
end


--[[
= @>split (function)
]]
function lume.split(str, sep)
  if not sep then
    return lume.array(str:gmatch("([%S]+)"))
  else
    assert(sep ~= "", "empty separator")
    local psep = patternescape(sep)
    return lume.array((str..sep):gmatch("(.-)("..psep..")"))
  end
end


--[[
= @>trim (function)
]]
function lume.trim(str, chars)
  if not chars then return str:match("^[%s]*(.-)[%s]*$") end
  chars = patternescape(chars)
  return str:match("^[" .. chars .. "]*(.-)[" .. chars .. "]*$")
end


--[[
= @>wordwrap (function)
]]
function lume.wordwrap(str, limit)
  limit = limit or 72
  local check
  if type(limit) == "number" then
    check = function(s) return #s >= limit end
  else
    check = limit
  end
  local rtn = {}
  local line = ""
  for word, spaces in str:gmatch("(%S+)(%s*)") do
    local s = line .. word
    if check(s) then
      table.insert(rtn, line .. "\n")
      line = word
    else
      line = s
    end
    for c in spaces:gmatch(".") do
      if c == "\n" then
        table.insert(rtn, line .. "\n")
        line = ""
      else
        line = line .. c
      end
    end
  end
  table.insert(rtn, line)
  return table.concat(rtn)
end


--[[
= @>format (function)
]]
function lume.format(str, vars)
  if not vars then return str end
  local f = function(x)
    return tostring(vars[x] or vars[tonumber(x)] or "{" .. x .. "}")
  end
  return (str:gsub("{(.-)}", f))
end


--[[
= @>trace (function)
]]
function lume.trace(...)
  local info = debug.getinfo(2, "Sl")
  local t = { info.short_src .. ":" .. info.currentline .. ":" }
  for i = 1, select("#", ...) do
    local x = select(i, ...)
    if type(x) == "number" then
      x = string.format("%g", lume.round(x, .01))
    end
    t[#t + 1] = tostring(x)
  end
  print(table.concat(t, " "))
end


--[[
= @>dostring (function)
]]
function lume.dostring(str)
  return assert((loadstring or load)(str))()
end


--[[
= @>uuid (function)
]]
function lume.uuid()
  local fn = function(x)
    local r = math.random(16) - 1
    r = (x == "x") and (r + 1) or (r % 4) + 9
    return ("0123456789abcdef"):sub(r, r)
  end
  return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end


--[[
= @>hotswap (function)
]]
function lume.hotswap(modname)
  local oldglobal = lume.clone(_G)
  local updated = {}
  local function update(old, new)
    if updated[old] then return end
    updated[old] = true
    local oldmt, newmt = getmetatable(old), getmetatable(new)
    if oldmt and newmt then update(oldmt, newmt) end
    for k, v in pairs(new) do
      if type(v) == "table" then update(old[k], v) else old[k] = v end
    end
  end
  local err = nil
  local function onerror(e)
    for k in pairs(_G) do _G[k] = oldglobal[k] end
    err = lume.trim(e)
  end
  local ok, oldmod = pcall(require, modname)
  oldmod = ok and oldmod or nil
  xpcall(function()
    package.loaded[modname] = nil
    local newmod = require(modname)
    if type(oldmod) == "table" then update(oldmod, newmod) end
    for k, v in pairs(oldglobal) do
      if v ~= _G[k] and type(v) == "table" then
        update(v, _G[k])
        _G[k] = v
      end
    end
  end, onerror)
  package.loaded[modname] = oldmod
  if err then return nil, err end
  return oldmod
end


local ripairs_iter = function(t, i)
  i = i - 1
  local v = t[i]
  if v then return i, v end
end


--[[
= @>ripairs (function)
]]
function lume.ripairs(t)
  return ripairs_iter, t, (#t + 1)
end


--[[
= @>color (function)
]]
function lume.color(str, mul)
  mul = mul or 1
  local r, g, b, a
  r, g, b = str:match("#(%x%x)(%x%x)(%x%x)")
  if r then
    r = tonumber(r, 16) / 0xff
    g = tonumber(g, 16) / 0xff
    b = tonumber(b, 16) / 0xff
    a = 1
  elseif str:match("rgba?%s*%([%d%s%.,]+%)") then
    local f = str:gmatch("[%d.]+")
    r = (f() or 0) / 0xff
    g = (f() or 0) / 0xff
    b = (f() or 0) / 0xff
    a = f() or 1
  else
    error(("bad color string '%s'"):format(str))
  end
  return r * mul, g * mul, b * mul, a * mul
end


--[[
= @>rgba (function)
]]
function lume.rgba(color)
  local a = math_floor((color / 16777216) % 256)
  local r = math_floor((color /    65536) % 256)
  local g = math_floor((color /      256) % 256)
  local b = math_floor((color) % 256)
  return r, g, b, a
end


local chain_mt = {}
chain_mt.__index = lume.map(lume.filter(lume, iscallable, true),
  function(fn)
    return function(self, ...)
      self._value = fn(self._value, ...)
      return self
    end
  end)
chain_mt.__index.result = function(x) return x._value end


--[[
= @>chain (function)
]]
function lume.chain(value)
  return setmetatable({ _value = value }, chain_mt)
end

setmetatable(lume,  {
  __call = function(_, ...)
    return lume.chain(...)
  end
})


return lume
