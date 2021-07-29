# `lib.object`

Extends: **table**

<details><summary><b>Example</b></summary>

```lua
local Object = require 'lib.object'

local Point = Object:extend 'Point'

Point.scale = 2 -- Class field!

function Point:init(x, y)
  self.x = x or 0
  self.y = y or 0
end

function Point:resize()
  self.x = self.x * self.scale
  self.y = self.y * self.scale
end

function Point.__call()
  return 'called'
end

local Rectangle = Point:extend 'Rectangle'

function Rectangle:resize()
  Rectangle.super.resize(self) -- Extend Point's `resize()`.
  self.w = self.w * self.scale
  self.h = self.h * self.scale
end

function Rectangle:init(x, y, w, h)
  Rectangle.super.init(self, x, y) -- Initialize Point first!
  self.w = w or 0
  self.h = h or 0
end

function Rectangle:__index(key)
  if key == 'width' then return self.w end
  if key == 'height' then return self.h end
end

function Rectangle:__newindex(key, value)
  if key == 'width' then self.w = value
    elseif key == 'height' then self.h = value
  end
end

local rect = Rectangle:new(2, 4, 6, 8)

assert(rect.w == 6)
assert(rect:is(Rectangle))
assert(rect:is 'Rectangle')
assert(not rect:is(Point))
assert(rect:has 'Point' == 1)
assert(Rectangle:has(Object) == 2)
assert(rect() == 'called')

rect.width = 666
assert(rect.w == 666)
assert(rect.height == 8)

for _, t in ipairs({'field', 'method', 'meta'}) do
  rect:each(t, function(k, v) print(t, k, v) end)
end
```

</details>

## Öbject - Base superclass that implements ÖØP

Key features of this library:
+ metamethods inheritance
+ store all metadata in metatables (no `__junk` in actual tables)
+ can subtly identify class membership
+ tiny and fast, readable source

## 📜 Fields

+ **classname : string = "Object"**
+ **super : lib.object|table = {}**

## 💡 Methods

+ **new (...) : instance**
  `Creates an instance of the class`
+ **init (fields)**
  `Initializes the class`
+ **extend (name, ...) : cls**
  `Creates a new class by inheritance`
+ **implement (...)**
  `Sets someone else's methods`
+ **has (Test, limit) : membership_range**
  `Returns the "membership range" between self and the checking class`
+ **is (Test) : result**
  `Identifies affiliation to class`
+ **each (etype, action, ...) : result**
  `Loops through all elements, performing an action on each`

## 🧩 Details

### method `new`

Creates an instance of the class

> A simple call to the class as a function does the same.

✏️ `...` : **any** _[nil]_
`Arguments passed to init`

🔚 `instance` : **lib.object**

### method `init`

Initializes the class

> By default, an object takes a table with fields and applies them to itself,
> but descendants are expected to replace this method with another.

✏️ `fields` : **table** _[nil]_
`New fields`

### method `extend`

Creates a new class by inheritance

✏️ `name` : **string**
`New class name`

✏️ `...` : **table|lib.object** _[nil]_
`Additional properties`

🔚 `cls` : **lib.object**

### method `implement`

Sets someone else's methods

✏️ `...` : **table|lib.object**
`Methods`

### method `has`

Returns the "membership range" between self and the checking class

> Returns `0` if belongs to it or` false` if there is no membership.

✏️ `Test` : **string|lib.object**
`Test class`

✏️ `limit` : **integer** _[nil]_
`Check depth (default unlimited)`

🔚 `membership_range` : **integer|boolean**

### method `is`

Identifies affiliation to class

✏️ `Test` : **string|lib.object**

🔚 `result` : **boolean**

### method `each`

Loops through all elements, performing an action on each

> Can stop at fields, metafields, methods, or all.
> Always skips basic fields and methods inherent from the Object class.

✏️ `etype` : **"field"|"method"|"meta"|"all"**
`Item type`

✏️ `action` : **function:key,value,...**
`Action on each element`

✏️ `...` _[nil]_
`Additional arguments for the action`

🔚 `result` : **integer=table}**
`Results of all actions`

## 🖇️ Links

[Go up](..)
