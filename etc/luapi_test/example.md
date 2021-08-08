# lib.test

Extends: **[table][]**

Requires: **none**

<details><summary><b>Example</b></summary>

```lua
print 'hello world'
```

</details>

## Test Module

Import and run with start()

```lua
local module = require "testmodule"
module.start()
```

```text
I`m <not> a [code
```

## 📜 Fields

- 📦 **files : {string=table...} = {}**
  `[files paths] = <parsed> (file) tables`
- 📝 **test : string = _nil_**
  `some module field`
- 🧮 **testNumber : 5**
  `Test table field`

## 💡 Methods

- 💡 **[startModule][] (name\*, verbose) : boolean, ololo**
  `My function for documentation`

## 👨‍👦 Types

- 👨‍👦 **lib.test.testclass1 : [table][]**
  `some comment maybe`
  - 📦 **someField : {string=table...} = {}**
  `bla bla bla`
  - 💡 **doSomething (name\*, verbose) : boolean, ololo**
- 👨‍👦 **lib.test.testclass2 : lib.test**
  - 📦 **someField : {string=table...} = {}**
  - 💡 **doSomething (name\*, verbose) : boolean, ololo**
- 📝 **str : string**
- 🧮 **num : number|boolean**
- 💡 **fn : function**
- 📦 **tb : table**
- 🧵 **thr : thread**
- 🔒 **usr : userdata**

## 🧩 Details

### Method `startModule`

My function for documentation

> Additional **muliline** description
> in `markdown` _format_ supported in any block.

→ `name` : **typindg**
`file will be created and overwritten`

→ `verbose` : **boolean** _[optional]_
`more output if true`

← `success` : **boolean**
`fail will be handled gracefully and return false`

← `test` : **ololo!**
`ddd`

## 🖇️ Links

[Back to root](../readme.md)

[string]: https://www.lua.org/manual/5.1/manual.html#5.4
[table]: https://www.lua.org/manual/5.1/manual.html#5.5

[startModule]: #method-startmodule
