# lib.object `(table)`

<details><summary><b>Example</b></summary>

```lua
local Object = require 'lib.object'

-- See [luapi types documentation](lib/luapi/readme.md#types)
local Point = Object:extend 'lib.object#point'

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

local Rectangle = Point:extend 'lib.object#rectangle'

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
assert(rect:is 'lib.object#rectangle')
assert(not rect:is(Point))
assert(rect:has 'lib.object#point' == 1)
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

## Fields

+ 📝 **classname** ( string = *"lib.object"* )
+ 👨‍👦 **super** ( @|table = *{}* )
+ 💡 **[each][@:each]** ( function )
	`Loops through all elements, performing an action on each`
+ 💡 **[extend][@:extend]** ( function )
	`Creates a new class by inheritance`
+ 💡 **[new][@:new]** ( function )
	`Creates an instance of the class`
+ 💡 **[implement][@:implement]** ( function )
	`Sets someone else's methods`
+ 💡 **[init][@:init]** ( function )
	`Initializes the class`
+ 💡 **[is][@:is]** ( function )
	`Identifies affiliation to class`
+ 💡 **[has][@:has]** ( function )
	`Returns the "membership range" between self and the checking class`

## Details

### each `(function)`

Loops through all elements, performing an action on each.

> Can stop at fields, metafields, methods, or all.
> Always skips basic fields and methods inherent from the Object class.

Arguments:

+ 👽 **etype** ( "field"|"method"|"meta"|"all" )
	`Item type`
+ 👨‍👦 **action** ( function:key,value,... )
	`Action on each element`
+ ❓ _..._ ( any = *nil* )
	`Additional arguments for the action`

Returns:

+ 👽 **result** ( integer=table} )
	`Results of all actions`

---

### new `(function)`

Creates an instance of the class.

> A simple call to the class as a function does the same.
> By default it returns the same type if `lib.object.init` has no returns.
>
> For example, you can make class Animal which will return instance of
> Dog or Bird, depending on arguments (have it wings or not),
> but usually class Animal returns instanse of Animal.
>
> You can also return self if you want to stop initialization process
> at the specific line.
>
> Notice: it can't return nil! Use false or exception message instead.

Arguments:

+ ❓ _..._ ( any = *nil* )
	`Arguments passed to init`

Returns:

+ ❓ _instance_ ( any = *nil* )

---

### implement `(function)`

Sets someone else's methods.

Arguments:

+ 👨‍👦 **...** ( table|@ )
	`Methods`

---

### is `(function)`

Identifies affiliation to class.

Arguments:

+ 👨‍👦 **Test** ( string|@ )

Returns:

+ 🔌 **result** ( boolean )

---

### has `(function)`

Returns the "membership range" between self and the checking class.

> Returns `0` if belongs to it or `false` if there is no membership.

Arguments:

+ 👨‍👦 **Test** ( string|@ )
	`Test class`
+ 🧮 _limit_ ( integer = *nil* )
	`Check depth (default unlimited)`

Returns:

+ 👽 **membership_range** ( integer|boolean )

---

### init `(function)`

Initializes the class.

> By default an object takes a table with fields and applies them to itself.
> But you can (and probably should) replace it with your function.
> This method should not return anything, but it can if you really want to.
> See `lib.object.new` for more details.

Arguments:

+ 📦 _fields_ ( table = *nil* )
	`New fields`

---

### extend `(function)`

Creates a new class by inheritance.

Arguments:

+ 📝 **name** ( string )
	`New class name`
+ 👨‍👦 _..._ ( table|@ = *nil* )
	`Additional properties`

Returns:

+ 👨‍👦 **cls** ( @ )

## Navigation

[Back to top of the document](#libobject-table)

[Back to upper directory](..)

[Back to project root](/../..)

[@:is]: #is-function
[@:extend]: #extend-function
[@:implement]: #implement-function
[@]: #libobject-table
[@:new]: #new-function
[@:init]: #init-function
[@:each]: #each-function
[@:has]: #has-function
