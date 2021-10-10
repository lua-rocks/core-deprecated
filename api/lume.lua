-- luacheck: no max line length
-- luacheck: no unused
-- luacheck: no global

--- A collection of functions for Lua, geared towards game development.
--- ---
--- Several lume functions allow a `table`, `string` or `nil` to be used in place
--- of their iteratee function argument. The functions that provide this behaviour
--- are: `map()`, `all()`, `any()`, `filter()`, `reject()`, `match()` and
--- `count()`.
---
--- If the argument is `nil` then each value will return itself.
--- ```lua
--- lume.filter({ true, true, false, true }, nil) -- { true, true, true }
--- ```
---
--- If the argument is a `string` then each value will be assumed to be a table,
--- and will return the value of the key which matches the string.
--- ``` lua
--- local t = {{ z = "cat" }, { z = "dog" }, { z = "owl" }}
--- lume.map(t, "z") -- Returns { "cat", "dog", "owl" }
--- ```
---
--- If the argument is a `table` then each value will return `true` or `false`,
--- depending on whether the values at each of the table's keys match the
--- collection's value's values.
--- ```lua
--- local t = {
---   { age = 10, type = "cat" },
---   { age = 8,  type = "dog" },
---   { age = 10, type = "owl" },
--- }
--- lume.count(t, { age = 10 }) -- returns 2
--- ```
---@class lume
local lume = { _version = "2.3.0" }

--- Returns the number `x` clamped between the numbers `min` and `max`.
---@param x number
---@param min number
---@param max number
---@return number
function lume.clamp(x, min, max) end

--- Rounds `x` to the nearest integer; rounds away from zero if we're midway
--- between two integers. If `increment` is set then the number is rounded to the
--- nearest increment.
--- ```lua
--- lume.round(2.3) -- Returns 2
--- lume.round(123.4567, .1) -- Returns 123.5
--- ```
---@param x number
---@param increment number
---@return number
function lume.round(x, increment) end

--- Returns `1` if `x` is 0 or above, returns `-1` when `x` is negative.
---@param x number
---@return number
function lume.sign(x) end

--- Returns the linearly interpolated number between `a` and `b`, `amount` should
--- be in the range of 0 - 1; if `amount` is outside of this range it is clamped.
--- ```lua
--- lume.lerp(100, 200, .5) -- Returns 150
--- ```
---@param a number
---@param b number
---@param amount number
---@return number
function lume.lerp(a, b, amount) end

--- Similar to `lume.lerp()` but uses cubic interpolation instead of linear.
---@param a number
---@param b number
---@param amount number
---@return number
---@see Lume#lerp
function lume.smooth(a, b, amount) end

--- Ping-pongs the number `x` between 0 and 1.
---@param x number
---@return number
function lume.pingpong(x) end

--- Returns the distance between the two points. If `squared` is true then the
--- squared distance is returned -- this is faster to calculate and can still be
--- used when comparing distances.
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param squared boolean
---@return number
function lume.distance(x1, y1, x2, y2, squared) end

--- Returns the angle between the two points.
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
function lume.angle(x1, y1, x2, y2) end

--- Given an `angle` and `magnitude`, returns a vector.
--- ```lua
--- local x, y = lume.vector(0, 10) -- Returns 10, 0
--- ```
---@param angle number
---@param magnitude number
---@return number, number
function lume.vector(angle, magnitude) end

--- Returns a random number between `a` and `b`. If only `a` is supplied a number
--- between `0` and `a` is returned. If no arguments are supplied a random number
--- between `0` and `1` is returned.
---@param a number
---@param b number
---@return number
function lume.random(a, b) end

--- Returns a random value from array `t`. If the array is empty an error is
--- raised.
--- ```lua
--- lume.randomchoice({true, false}) -- Returns either true or false
--- ```
---@param t table
---@return any
function lume.randomchoice(t) end

--- Takes the argument table `t` where the keys are the possible choices and the
--- value is the choice's weight. A weight should be 0 or above, the larger the
--- number the higher the probability of that choice being picked.
--- If the table is empty, a weight is below zero or all the weights are 0
--- then an error is raised.
--- ```lua
--- lume.weightedchoice({ ["cat"] = 10, ["dog"] = 5, ["frog"] = 0 })
--- ```
--- Returns either "cat" or "dog" with "cat" being twice as likely to be chosen.
---@param t table
---@return any
function lume.weightedchoice(t) end

--- Returns `true` if `x` is an array -- the value is assumed to be an array if it
--- is a table which contains a value at the index `1`.
--- This function is used internally and can be overridden
--- if you wish to use a different method to detect arrays.
---@param x any
---@return boolean
function lume.isarray(x) end

--- Pushes all the given values to the end of the table `t` and returns the pushed
--- values. Nil values are ignored.
--- ```lua
--- local t = { 1, 2, 3 }
--- lume.push(t, 4, 5) -- `t` becomes { 1, 2, 3, 4, 5 }
--- ```
---@param t table
---@return ...
function lume.push(t, ...) end

--- Removes the first instance of the value `x` if it exists in the table `t`.
--- Returns `x`.
--- ```lua
--- local t = { 1, 2, 3 }
--- lume.remove(t, 2) -- `t` becomes { 1, 3 }
--- ```
---@param t table
---@param x any
---@return any
function lume.remove(t, x) end

--- Nils all the values in the table `t`, this renders the table empty. Returns
--- `t`.
--- ```lua
--- local t = { 1, 2, 3 }
--- lume.clear(t) -- `t` becomes {}
--- ```
---@param t table
---@return table
function lume.clear(t) end

--- Copies all the fields from the source tables to the table `t` and returns `t`.
--- If a key exists in multiple tables the right-most table's value is used.
--- ```lua
--- local t = { a = 1, b = 2 }
--- lume.extend(t, { b = 4, c = 6 }) -- `t` becomes { a = 1, b = 4, c = 6 }
--- ```
---@param t table
---@vararg table
---@return table
function lume.extend(t, ...) end

--- Returns a shuffled copy of the array `t`.
---@param t table[]
---@return table[]
function lume.shuffle(t) end

--- Returns a copy of the array `t` with all its items sorted. If `comp` is a
--- function it will be used to compare the items when sorting. If `comp` is a
--- string it will be used as the key to sort the items by.
--- ```lua
--- lume.sort({ 1, 4, 3, 2, 5 }) -- Returns { 1, 2, 3, 4, 5 }
--- lume.sort({ {z=2}, {z=3}, {z=1} }, "z") -- Returns { {z=1}, {z=2}, {z=3} }
--- lume.sort({ 1, 3, 2 }, function(a, b) return a > b end) -- Returns { 3, 2, 1 }
--- ```
---@param t table[]
---@param comp string|function
---@return table[]
function lume.sort(t, comp) end

--- Iterates the supplied iterator and returns an array filled with the values.
--- ```lua
--- lume.array(string.gmatch("Hello world", "%a+")) -- Returns {"Hello", "world"}
--- ```
---@return table[]
function lume.array(...) end

---Iterates the table `t` and calls the function `fn` on each value followed by
---the supplied additional arguments; if `fn` is a string the method of that name
---is called for each value. The function returns `t` unmodified.
---```lua
---lume.each({1, 2, 3}, print) -- Prints "1", "2", "3" on separate lines
---lume.each({a, b, c}, "move", 10, 20) -- Does x:move(10, 20) on each value
---```
---@param t table
---@param fn function
---@return table
function lume.each(t, fn, ...) end

--- Applies the function `fn` to each value in table `t` and returns a new table
--- with the resulting values.
--- ```lua
--- lume.map({1, 2, 3}, function(x) return x * 2 end) -- Returns {2, 4, 6}
--- ```
---@param t table
---@param fn function
---@return table
function lume.map(t, fn) end

--- Returns true if all the values in `t` table are true. If a `fn` function is
--- supplied it is called on each value, true is returned if all of the calls to
--- `fn` return true.
--- ```lua
--- lume.all({1, 2, 1}, function(x) return x == 1 end) -- Returns false
--- ```
---@param t table
---@param fn function
---@return boolean
function lume.all(t, fn) end

--- Returns true if any of the values in `t` table are true. If a `fn` function is
--- supplied it is called on each value, true is returned if any of the calls to
--- `fn` return true.
--- ```lua
--- lume.any({1, 2, 1}, function(x) return x == 1 end) -- Returns true
--- ```
---@param t table
---@param fn function
---@return boolean
function lume.any(t, fn) end

--- Applies `fn` on two arguments cumulative to the items of the array `t`, from
--- left to right, so as to reduce the array to a single value. If a `first` value
--- is specified the accumulator is initialised to this, otherwise the first value
--- in the array is used. If the array is empty and no `first` value is specified
--- an error is raised.
--- ```lua
--- lume.reduce({1, 2, 3}, function(a, b) return a + b end) -- Returns 6
--- ```
---@param t table[]
---@param fn function
---@param first any
---@return any
function lume.reduce(t, fn, first) end

--- Returns a copy of the `t` array with all the duplicate values removed.
--- ```lua
--- lume.unique({2, 1, 2, "cat", "cat"}) -- Returns {1, 2, "cat"}
--- ```
---@param t table
---@return table
function lume.unique(t) end

--- Calls `fn` on each value of `t` table. Returns a new table with only the values
--- where `fn` returned true. If `retainkeys` is true the table is not treated as
--- an array and retains its original keys.
--- ```lua
--- lume.filter({1, 2, 3, 4}, function(x) return x % 2 == 0 end) -- Returns {2, 4}
--- ```
---@param t table
---@param fn function
---@param retainkeys boolean
---@return table
function lume.filter(t, fn, retainkeys) end

--- The opposite of `lume.filter()`: Calls `fn` on each value of `t` table; returns
--- a new table with only the values where `fn` returned false. If `retainkeys` is
--- true the table is not treated as an array and retains its original keys.
--- ```lua
--- lume.reject({1, 2, 3, 4}, function(x) return x % 2 == 0 end) -- Returns {1, 3}
--- ```
---@param t table
---@param fn function
---@param retainkeys boolean
---@return table
function lume.reject(t, fn, retainkeys) end

--- Returns a new table with all the given tables merged together. If a key exists
--- in multiple tables the right-most table's value is used.
--- ```lua
--- lume.merge({a=1, b=2, c=3}, {c=8, d=9}) -- Returns {a=1, b=2, c=8, d=9}
--- ```
---@vararg table
---@return table
function lume.merge(...) end

--- Returns a new array consisting of all the given arrays concatenated into one.
--- ```lua
--- lume.concat({1, 2}, {3, 4}, {5, 6}) -- Returns {1, 2, 3, 4, 5, 6}
--- ```
---@vararg table[]
---@return table[]
function lume.concat(...) end

--- Returns the index/key of `value` in `t`. Returns `nil` if that value does not
--- exist in the table.
--- ```lua
--- lume.find({"a", "b", "c"}, "b") -- Returns 2
--- ```
---@param t table
---@param value any
---@return any
function lume.find(t, value) end

--- Returns the value and key of the value in table `t` which returns true when
--- `fn` is called on it. Returns `nil` if no such value exists.
--- ```lua
--- lume.match({1, 5, 8, 7}, function(x) return x % 2 == 0 end) -- Returns 8, 3
--- ```
---@param t table
---@param fn function
---@return any, any
function lume.match(t, fn) end

--- Counts the number of values in the table `t`. If a `fn` function is supplied it
--- is called on each value, the number of times it returns true is counted.
--- ```lua
--- lume.count({a = 2, b = 3, c = 4, d = 5}) -- Returns 4
--- lume.count({1, 2, 4, 6}, function(x) return x % 2 == 0 end) -- Returns 3
--- ```
---@param t table
---@param fn function
---@return number
function lume.count(t, fn) end

--- Mimics the behaviour of Lua's `string.sub`, but operates on an array rather
--- than a string. Creates and returns a new array of the given slice.
--- ```lua
--- lume.slice({"a", "b", "c", "d", "e"}, 2, 4) -- Returns {"b", "c", "d"}
--- ```
---@param t table[]
---@param i number
---@param j number
---@return table[]
function lume.slice(t, i, j) end

--- Returns the first element of an array or nil if the array is empty. If `n` is
--- specificed an array of the first `n` elements is returned.
--- ```lua
--- lume.first({"a", "b", "c"}) -- Returns "a"
--- ```
---@param t table[]
---@param n number
---@return any
function lume.first(t, n) end

--- Returns the last element of an array or nil if the array is empty. If `n` is
--- specificed an array of the last `n` elements is returned.
--- ```lua
--- lume.last({"a", "b", "c"}) -- Returns "c"
--- ```
---@param t table[]
---@param n number
---@return any
function lume.last(t, n) end

--- Returns a copy of the table where the keys have become the values and the
--- values the keys.
--- ```lua
--- lume.invert({a = "x", b = "y"}) -- returns {x = "a", y = "b"}
--- ```
---@param t table
---@return table
function lume.invert(t) end

--- Returns a copy of the table filtered to only contain values for the given keys.
--- ```lua
--- lume.pick({ a = 1, b = 2, c = 3 }, "a", "c") -- Returns { a = 1, c = 3 }
--- ```
---@param t table
---@return table
function lume.pick(t, ...) end

--- Returns an array containing each key of the table.
---@param t table
---@return table[]
function lume.keys(t) end

--- Returns a shallow copy of the table `t`.
---@param t table
---@return table
function lume.clone(t) end

--- Creates a wrapper function around function `fn`, automatically inserting the
--- arguments into `fn` which will persist every time the wrapper is called. Any
--- arguments which are passed to the returned function will be inserted after the
--- already existing arguments passed to `fn`.
--- ```lua
--- local f = lume.fn(print, "Hello")
--- f("world") -- Prints "Hello world"
--- ```
---@param fn function
---@return function
function lume.fn(fn, ...) end

--- Returns a wrapper function to `fn` where the results for any given set of
--- arguments are cached. `lume.memoize()` is useful when used on functions with
--- slow-running computations.
--- ```lua
--- fib = lume.memoize(function(n) return n < 2 and n or fib(n-1) + fib(n-2) end)
--- ```
---@param fn function
---@return function
function lume.once(fn, ...) end

--- Creates a wrapper function which calls each supplied argument in the order they
--- were passed to `lume.combine()`; nil arguments are ignored. The wrapper
--- function passes its own arguments to each of its wrapped functions when it is
--- called.
--- ```lua
--- local f = lume.combine(function(a, b) print(a + b) end,
--- function(a, b) print(a * b) end)
--- f(3, 4) -- Prints "7" then "12" on a new line
--- ```
---@vararg function
---@return function
function lume.combine(...) end

--- Calls the given function with the provided arguments and returns its values. If
--- `fn` is `nil` then no action is performed and the function returns `nil`.
--- ```lua
--- lume.call(print, "Hello world") -- Prints "Hello world"
--- ```
---@param fn function
---@return function
function lume.call(fn, ...) end

--- Inserts the arguments into function `fn` and calls it. Returns the time in
--- seconds the function `fn` took to execute followed by `fn`'s returned values.
--- ```lua
--- lume.time(function(x) return x end, "hello") -- Returns 0, "hello"
--- ```
---@param fn function
---@return number
function lume.time(fn, ...) end

--- Takes a string lambda and returns a function. `str` should be a list of
--- comma-separated parameters, followed by `->`, followed by the expression which
--- will be evaluated and returned.
--- ```lua
--- local f = lume.lambda "x,y -> 2*x+y"
--- f(10, 5) -- Returns 25
--- ```
---@param str string
---@return function
function lume.lambda(str) end

--- Serializes the argument `x` into a string which can be loaded again using
--- `lume.deserialize()`. Only booleans, numbers, tables and strings can be
--- serialized. Circular references will result in an error; all nested tables are
--- serialized as unique tables.
--- ```lua
--- lume.serialize({a = "test", b = {1, 2, 3}, false})
--- -- Returns "{[1]=false,["a"]="test",["b"]={[1]=1,[2]=2,[3]=3,},}"
--- ```
---@param x any
---@return string
function lume.serialize(x) end

--- Deserializes a string created by `lume.serialize()` and returns the resulting
--- value. This function should not be run on an untrusted string.
--- ```lua
--- lume.deserialize("{1, 2, 3}") -- Returns {1, 2, 3}
--- ```
---@param str string
---@return any
function lume.deserialize(str) end

--- Returns an array of the words in the string `str`. If `sep` is provided it is
--- used as the delimiter, consecutive delimiters are not grouped together and will
--- delimit empty strings.
--- ```lua
--- lume.split("One two three") -- Returns {"One", "two", "three"}
--- lume.split("a,b,,c", ",") -- Returns {"a", "b", "", "c"}
--- ```
---@param str string
---@param sep string
---@return table[]
function lume.split(str, sep) end

--- Trims the whitespace from the start and end of the string `str` and returns the
--- new string. If a `chars` value is set the characters in `chars` are trimmed
--- instead of whitespace.
--- ```lua
--- lume.trim("  Hello  ") -- Returns "Hello"
--- ```
---@param str string
---@param chars string
---@return string
function lume.trim(str, chars) end

--- Returns `str` wrapped to `limit` number of characters per line, by default
--- `limit` is `72`. `limit` can also be a function which when passed a string,
--- returns `true` if it is too long for a single line.
--- ```lua
--- -- Returns "Hello world\nThis is a\nshort string"
--- lume.wordwrap("Hello world. This is a short string", 14)
--- ```
---@param str string
---@param limit number
---@return string
function lume.wordwrap(str, limit) end

--- Returns a formatted string. The values of keys in the table `vars` can be
--- inserted into the string by using the form `"{key}"` in `str`; numerical keys
--- can also be used.
--- ```lua
--- lume.format("{b} hi {a}", {a = "mark", b = "Oh"}) -- Returns "Oh hi mark"
--- lume.format("Hello {1}!", {"world"}) -- Returns "Hello world!"
--- ```
---@param str string
---@param vars table
---@return string
function lume.format(str, vars) end

--- Prints the current filename and line number followed by each argument separated
--- by a space.
--- ```lua
--- -- Assuming the file is called "example.lua" and the next line is 12:
--- lume.trace("hello", 1234) -- Prints "example.lua:12: hello 1234"
--- ```
function lume.trace(...) end

--- Executes the lua code inside `str`.
--- ```lua
--- lume.dostring("print('Hello!')") -- Prints "Hello!"
--- ```
---@param str string
---@return any Assert.
function lume.dostring(str) end

--- Generates a random UUID string; version 4 as specified in
--- [RFC 4122](http://www.ietf.org/rfc/rfc4122.txt).
---@return string
function lume.uuid() end

--- Reloads an already loaded module in place, allowing you to immediately see the
--- effects of code changes without having to restart the program. `modname` should
--- be the same string used when loading the module with require(). In the case of
--- an error the global environment is restored and `nil` plus an error message is
--- returned.
--- ```lua
--- lume.hotswap("lume") -- Reloads the lume module
--- assert(lume.hotswap("inexistant_module")) -- Raises an error
--- ```
---@param modname string
---@return table
function lume.hotswap(modname) end

--- Performs the same function as `ipairs()` but iterates in reverse; this allows
--- the removal of items from the table during iteration without any items being
--- skipped.
--- ```lua
--- for i, v in lume.ripairs({ "a", "b", "c" }) do
---   print(i .. "->" .. v)
--- end
--- ```
--- Prints "3->c", "2->b" and "1->a" on separate lines
---@param t table
---@return function, table, number
function lume.ripairs(t) end

--- Takes color string `str` and returns 4 values, one for each color channel (`r`,
--- `g`, `b` and `a`). By default the returned values are between 0 and 1; the
--- values are multiplied by the number `mul` if it is provided.
--- ```lua
--- lume.color("#ff0000")               -- Returns 1, 0, 0, 1
--- lume.color("rgba(255, 0, 255, .5)") -- Returns 1, 0, 1, .5
--- lume.color("#00ffff", 256)          -- Returns 0, 256, 256, 256
--- lume.color("rgb(255, 0, 0)", 256)   -- Returns 256, 0, 0, 256
--- ```
---@param str string
---@param mul number
---@return number, number, number, number
function lume.color(str, mul) end

--- Returns a wrapped object which allows chaining of lume functions. The function
--- result() should be called at the end of the chain to return the resulting
--- value.
--- ```lua
--- lume.chain({1, 2, 3, 4})
---   :filter(function(x) return x % 2 == 0 end)
---   :map(function(x) return -x end)
---   :result() -- Returns { -2, -4 }
--- ```
--- The table returned by the `lume` module, when called, acts in the same manner
--- as calling `lume.chain()`.
--- ```lua
--- lume({1, 2, 3}):each(print) -- Prints 1, 2 then 3 on separate lines
--- ```
---@param value any
---@return table
function lume.chain(value) end

return lume
