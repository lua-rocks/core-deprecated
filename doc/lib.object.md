# `lib.object`

Extends: **table**

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

## new

Creates an instance of the class

> A simple call to the class as a function does the same.

✅ `...` : **any** _[nil]_
`Arguments passed to init`

🔚 `instance` : **lib.object**

## init

Initializes the class

> By default, an object takes a table with fields and applies them to itself,
> but descendants are expected to replace this method with another.

✅ `fields` : **table** _[nil]_
`New fields`

## extend

Creates a new class by inheritance

✅ `name` : **string**
`New class name`

✅ `...` : **table|lib.object** _[nil]_
`Additional properties`

🔚 `cls` : **lib.object**

## implement

Sets someone else's methods

✅ `...` : **table|lib.object**
`Methods`

## has

Returns the "membership range" between self and the checking class

> Returns `0` if belongs to it or` false` if there is no membership.

✅ `Test` : **string|lib.object**
`Test class`

✅ `limit` : **integer** _[nil]_
`Check depth (default unlimited)`

🔚 `membership_range` : **integer|boolean**

## is

Identifies affiliation to class

✅ `Test` : **string|lib.object**

🔚 `result` : **boolean**

## each

Loops through all elements, performing an action on each

> Can stop at fields, metafields, methods, or all.
> Always skips basic fields and methods inherent from the Object class.

✅ `etype` : **"field"|"method"|"meta"|"all"**
`Item type`

✅ `action` : **function:key,value,...**
`Action on each element`

✅ `...` _[nil]_
`Additional arguments for the action`

🔚 `result` : **integer=table}**
`Results of all actions`

## 🖇️ Links

[Back to root](../doc/readme.md)
