--[[ Öbject - Base superclass that implements ÖØP
Key features of this library:

+ metamethods inheritance
+ store all metadata in metatables (no `__junk` in actual tables)
+ can subtly identify class membership
+ tiny and fast, readable source

= @ (table)
> classname (string) ["lib.object"]
> super (@|table) [{}]
]]
local Object = {
  classname = 'lib.object',
  super = {}
}


--[[ Adds all metamethods from itself and all parents to the specified table
Maintains the order of the hierarchy: Rect > Point > Object.
> self (@) Apply from
> apply_here (table) Apply to
]]
local function apply_meta_from_parents(self, apply_here)
  local applied = {}
  self:each('meta', function(key, value)
    if not applied[key] then
      apply_here[key] = value
      applied[key] = true
    end
  end)
end


--[[ Adds __index metamethods from itself or closest parent to the table
> self (lib.object) Apply from
> apply_here (table) Apply to
]]
local function apply_meta_index_from_parents(self, apply_here)
  local i = self.__index
  if i == nil then apply_here.__index = self return end
  local t = type(i)
  local v
  apply_here.__index = function(instance, key)
    if t == 'function' then v = i(instance, key)
      elseif t == 'table' then v = i[key]
      else error('"__index" must be a function or table', 2)
    end
    if v ~= nil then return v end
    return self[key]
  end
end


--[[ Creates an instance of the class
A simple call to the class as a function does the same.
By default it returns the same type if `lib.object.init` has no returns.

For example, you can make class Animal which will return instance of
Dog or Bird, depending on arguments (have it wings or not),
but usually class Animal returns instanse of Animal.

You can also return self if you want to stop initialization process
at the specific line.

Notice: it can't return nil! Use false or exception message instead.
= @>new (function)
> ... (any) [] Arguments passed to init
< instance (any) []
]]
function Object:new(...)
  local obj_mt = {
    __index = self,
    __tostring = function() return 'instance of ' .. self.classname end
  }
  local obj = setmetatable({}, obj_mt)
  local result = obj:init(...)
  if result ~= nil and result ~= obj then return result end
  apply_meta_from_parents(self, obj_mt)
  apply_meta_index_from_parents(self, obj_mt)
  return setmetatable(obj, obj_mt)
end


--[[ Initializes the class
By default an object takes a table with fields and applies them to itself.
But you can (and probably should) replace it with your function.
This method should not return anything, but it can if you really want to.
See `lib.object.new` for more details.
= @>init (function)
> fields (table) [] New fields
]]
function Object:init(fields)
  local t = type(fields)
  if t ~= 'table' then
    error('"Object:init()" expected a table, but got ' .. t, 3)
  end
  for key, value in pairs(fields) do self[key] = value end
end


--[[ Creates a new class by inheritance
= @>extend (function)
> name (string) New class name
> ... (table|lib.object) [] Additional properties
< cls (lib.object)
]]
function Object:extend(name, ...)
  if type(name) ~= 'string' then error('class must have a name', 2) end

  local cls, cls_mt = {}, {}
  for key, value in pairs(getmetatable(self)) do cls_mt[key] = value end
  for _, extra in ipairs{...} do
    for key, value in pairs(extra) do cls[key] = value end
  end

  cls.classname = name
  cls.super = self
  cls_mt.__index = self
  cls_mt.__tostring = function() return 'class ' .. name end
  setmetatable(cls, cls_mt)
  return cls
end


--[[ Sets someone else's methods
= @>implement (function)
> ... (table|lib.object) Methods
]]
function Object:implement(...)
  for _, cls in pairs({...}) do
    for key, value in pairs(cls) do
      if self[key] == nil and type(value) == 'function' then
        self[key] = value
      end
    end
  end
end


--[[ Returns the "membership range" between self and the checking class
Returns `0` if belongs to it or `false` if there is no membership.
= @>has (function)
> Test (string|lib.object) Test class
> limit (integer) [] Check depth (default unlimited)
< membership_range (integer|boolean)
]]
function Object:has(Test, limit)
  local t = type(Test)
  local searchedname
  if t == 'string' then
    searchedname = Test
  else
    if t ~= 'table' then return false end
    searchedname = Test.classname
  end

  local i = 0
  while self.super do
    if self.classname == searchedname then return i end
    if i == limit then return false end
    self = self.super
    i = i + 1
  end
  return false
end


--[[ Identifies affiliation to class
= @>is (function)
> Test (string|lib.object)
< result (boolean)
]]
function Object:is(Test)
  return self:has(Test, 0) == 0
end


--[[ Loops through all elements, performing an action on each
Can stop at fields, metafields, methods, or all.
Always skips basic fields and methods inherent from the Object class.
= @>each (function)
> etype ("field"|"method"|"meta"|"all") Item type
> action (function:key,value,...) Action on each element
> ... [] Additional arguments for the action
< result (integer=table}) Results of all actions
]]
function Object:each(etype, action, ...)
  local results, checks = {}, {}
  local function meta(key) return key:find('__') == 1 end
  local function func(value) return type(value) == 'function' end
  function checks.all() return true end
  function checks.meta(key) return meta(key) end
  function checks.method(key, value) return func(value) and not meta(key) end
  function checks.field(key, value) return not func(value) and not meta(key) end
  checks.methods = checks.method
  checks.fields = checks.field
  if not checks[etype] then error('wrong etype: ' .. tostring(etype)) end
  while self ~= Object do
    for key, value in pairs(self) do
      if not Object[key] and checks[etype](key, value) then
        table.insert(results, { action(key, value, ...) })
      end
    end
    self = self.super
  end
  return results
end


return setmetatable(Object, {
  __tostring = function(self) return 'class ' .. self.classname end,
  __call = Object.new
})
