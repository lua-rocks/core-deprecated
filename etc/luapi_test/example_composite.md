# lib.test (table)

Requires( **none**

<details><summary><b>Example</b></summary>

```lua
print 'hello world'
```

</details>

## Title (optional)

Import and run with start()

```lua
local module = require "testmodule"
module.start()
```

```text
I`m <not> a [code
```

## 📜 Components

Fields or Arguments:

- 📦 `files` ( **{string=table...} = {}** )
  `[files paths] = <parsed> (file) tables`
- 📝 `test` ( **string = _nil_** )
  `some module field`
- 🧮 `testNumber` ( **5** )
  `Test table field`
- 💡 `startModule` ( **function** )
  `My function for documentation`

Returns:

- 🧮 `success` ( **boolean** )
`fail will be handled gracefully and return false`
- 🔒 `test` ( **ololo!** )
`ddd`

## 👨‍👦 Types

- 👨‍👦 `lib.test.testclass1` ( **[table][]** )
  `some comment maybe`
  - 📦 `someField` ( **{string=table...} = {}** )
  `bla bla bla`
  - 💡 `doSomething` ( **function** )
- 👨‍👦 `lib.test.testclass2` ( **lib.test** )
  - 📦 `someField` ( **{string=table...} = {}** )
  - 💡 `doSomething` ( **function** )
- 📝 `str` ( **string** )
- 🧮 `num` ( **number|boolean** )
- 💡 `fn` ( **function** )
- 📦 `tb` ( **table** )
- 🧵 `thr` ( **thread** )
- 🔒 `usr` ( **userdata** )

## 🧩 Details

### Function `startModule`

My function for documentation

> Additional **muliline** description
> in `markdown` _format_ supported in any block.

Fields:

- 📝 `name` ( **string** )
`file will be created and overwritten`
- 🧮 `verbose` ( **boolean** _[optional]_ )
`more output if true`

Returns:

- 🧮 `success` ( **boolean** )
`fail will be handled gracefully and return false`
- 🔒 `test` ( **ololo!** )
`ddd`

## 🖇️ Links

[Back to root](../readme.md)

[string]: https://www.lua.org/manual/5.1/manual.html#5.4
[table]: https://www.lua.org/manual/5.1/manual.html#5.5

[startModule]: #method-startmodule
