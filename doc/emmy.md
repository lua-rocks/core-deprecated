# EmmyLua annotations

[EmmyLua](https://github.com/EmmyLua) annotations are doc comments similar to [LDoc](https://stevedonovan.github.io/ldoc/manual/doc.md.html) tags, but besides adding documentation they are used to improve features like code completion and signature information. Also refer to the [official documentation](https://emmylua.github.io/annotation.html) and [Luanalysis](https://github.com/Benjamin-Dobell/IntelliJ-Luanalysis#static-analysis-features) (EmmyLua fork), although Sumneko's implementation might not necessarily be the same.

![example](https://user-images.githubusercontent.com/1073877/111884243-a337c780-89c0-11eb-856e-b6c3b1042810.gif)

## Table of Contents

* Annotations
  * [@param](#param)
  * [@return](#return)
  * [@class](#class)
  * [@field](#field)
  * [Types and @type](#types-and-type)
  * [Comments](#Comments)
  * [Optional Params](#optional-params)
  * [@vararg](#vararg)
  * [@alias](#alias)
  * [@overload](#overload)
  * [@generic](#generic)
  * [@diagnostic](#diagnostic)
  * [@version](#version)
  * [@deprecated](#deprecated)
  * [@meta](#meta)
  * [@see](#see)
* Options
  * [Completion: Display Context](#completion-display-context)
* [References](#references)

## Annotations

### `@param`

Specifies the type of function params.

```lua
---@param r number
---@param g number
---@param b number
function SetColor(r, g, b) end
```

### `@return`

Specifies the type of function returns. Note that the return name is optional.

```lua
---@return string firstName
---@return string middleName
---@return string lastName
function GetName() end
```

```lua
---@return string, string, string 
function GetName() end
```

```lua
---@return string firstName, string middleName, string lastName
function GetName() end
```

### `@class`

Simulates classes, supporting OOP inheritance.

```lua
---@class Animal
---@field legs number
local Animal = {}
function Animal:Walk() end

---@class Pet
---@field ownerName string
local Pet = {}

---@class Cat : Animal, Pet
local Cat = {}

---@type Cat
local gamercat = {}

```

![example](https://user-images.githubusercontent.com/1073877/114530434-3627f280-9c4b-11eb-9f8d-358e9aadde87.png)

### `@field`

Declares a field on a class. For example a table/structure can be annotated as a class with fields.

```lua
---@param id number
---@return BNetAccountInfo accountInfo
function GetAccountInfoByID(id) end

---@class BNetAccountInfo
---@field accountName string
---@field isFriend boolean
---@field gameAccountInfo BNetGameAccountInfo

---@class BNetGameAccountInfo
---@field gameAccountID number
---@field characterName string

local info = GetAccountInfoByID(1)
print(info.gameAccountInfo.characterName)
```

![example](https://user-images.githubusercontent.com/1073877/114519513-c6146f00-9c40-11eb-8866-9ab6f6df5a27.png)

![example](https://user-images.githubusercontent.com/1073877/114520809-19d38800-9c42-11eb-9bbe-4310e5b0b986.gif)

### Types and `@type`

Known types are: `nil, any, boolean, string, number, integer, function, table, thread, userdata, lightuserdata`

* Classes can be [used](EmmyLua-Annotations#class) and passed or [returned](EmmyLua-Annotations#field) as a type.
* Multiple types are separated with `|`

```lua
---@param nameOrIndex string|number
---@return table|nil info
function GetQuestInfo(nameOrIndex) end
```

![example](https://user-images.githubusercontent.com/1073877/114528298-2c9d8b00-9c49-11eb-9d37-9219f8df5a0d.png)

* `@type` specifies the type of a variable.
* Arrays are indicated with a `[]`

```lua
---@type string[]
local msg = {"hello", "world"}
```

* Tables are formatted as `table<KEY_TYPE, VALUE_TYPE>`

```lua
---@type table<string, number>
local CalendarStatus = {
	Invited = 0,
	Available = 1,
	Declined = 2,
	Confirmed = 3,
}
```

* Functions are formatted as `fun(param: VALUE_TYPE): RETURN_TYPE` and are used in e.g. [@overload](EmmyLua-Annotations#overload)

```lua
fun(x: number): number
```

### Comments

There are multiple ways to format comments. The `@` and `#` symbols can be used to (explicitly) begin an annotation comment. This is useful for `@return` if you don't want to specify a param name but do want to add a comment.

```lua
---@param apple string hello 1
---@return string banana hello 2
---@return string @hello 3
---@return string #hello 4
function Foo(apple) end
```

![example](https://user-images.githubusercontent.com/1073877/118131122-66a3ad80-b3fe-11eb-8f14-7c05e539078b.png)

Comments support [Markdown](https://www.markdownguide.org/) formatting. To create a line break, use two trailing spaces ([#526](https://github.com/sumneko/lua-language-server/issues/526)), note it will trigger the `trailing-space` diagnostic hint.

```lua
--this is a **valid** comment  
---this is *also* valid and on a newline
---
--- this is a new paragraph
--- [Click me](https://www.google.com/)
--- ```
--- for i, v in ipairs(tbl) do
--- 	-- do stuff
--- end
--- ```
--- - item 1
---   - level 2
---@param tbl table comment for `tbl`
function Foo(tbl) end
```

![example](https://user-images.githubusercontent.com/1073877/118130952-38be6900-b3fe-11eb-8534-974c38f677d1.png)

### Optional Params

Appending a question mark (after the first word) marks a param optional/nilable. Another option is to instead use `|nil` as a second type.

```lua
---@param prog  string
---@param mode? string
---@return file*?
---@return string? errmsg
function io.popen2(prog, mode) end
```

![example](https://user-images.githubusercontent.com/1073877/114528633-7be3bb80-9c49-11eb-8d34-a66db3c9e449.png)

### `@vararg`

Indicates a function has multiple variable arguments.

```lua
---@vararg string
---@return string
function strconcat(...) end
```

For returning a vararg you can use `...` as a type.

```lua
---@vararg string
---@return ...
function tostringall(...) end
```

### `@alias`

Aliases are useful for reusing param types e.g. a function or string literals.

```lua
---@alias exitcode2 '"exit"' | '"signal"'

---@return exitcode2
function io.close2() end

---@return exitcode2
function file:close2() end
```

String literals for an alias can be listed on multiple lines and commented with `#`

```lua
---@alias popenmode3
---| '"r"' # Read data from this program by `file`.
---| '"w"' # Write data to this program by `file`.

---@param prog string
---@param mode popenmode3
function io.popen3(prog, mode) end
```

![example](https://user-images.githubusercontent.com/1073877/114529340-252ab180-9c4a-11eb-8f08-f34a3e94957b.png)

### `@overload`

Specifies multiple signatures.

```lua
---@param tbl table
---@param name string
---@param hook function
---@overload fun(name: string, hook: function)
function hooksecurefunc(tbl, name, hook) end
```

![example](https://user-images.githubusercontent.com/1073877/114531962-a84d0700-9c4c-11eb-90ef-ea1fdddb9137.png)

### `@generic`

Simulates generics.

```lua
---@class Foo
local Foo = {}
function Foo:Bar() end

---@generic T
---@param name `T`
---@return T
function Generic(name) end

local v = Generic("Foo") -- v is an object of Foo
```

![example](https://user-images.githubusercontent.com/1073877/114521804-0d9bfa80-9c43-11eb-81cb-61aa9d281f40.png)

### `@diagnostic`

Controls diagnostics for errors, warnings, information and hints ([script/proto/define.lua](https://github.com/sumneko/lua-language-server/blob/1.19.0/script/proto/define.lua))

* `disable-next-line` - Disables diagnostics for the next line.
* `disable-line`
* `disable` - Disables diagnostics for the file.
* `enable` - Enables diagnostics for the file.

```lua
---@diagnostic disable-next-line: unused-local
function hello(test) end
```

![example](https://user-images.githubusercontent.com/1073877/112365313-cc659a00-8cd7-11eb-99be-722fa32d4491.gif)

![example](https://user-images.githubusercontent.com/1073877/112364413-c4f1c100-8cd6-11eb-88a0-e45a56953e76.gif)

The diagnostics state behaves as a toggle.

![example](https://user-images.githubusercontent.com/1073877/114522605-d0843800-9c43-11eb-878b-c5c67166260f.png)

### `@version`

Marks if a function or class is exclusive to specific Lua versions: `5.1, 5.2, 5.3, 5.4, JIT`. Requires configuring `Diagnostics: Needed File Status` ([#494](https://github.com/sumneko/lua-language-server/issues/494)).

![example](https://user-images.githubusercontent.com/75196080/115882223-3dbe7700-a455-11eb-892c-6b67ce17029f.png)

```lua
---@version >5.2,JIT
function hello() end
```

```lua
---@version 5.4
function Hello() end

print(Hello())
```

![example](https://user-images.githubusercontent.com/1073877/117734858-a008cd00-b1f4-11eb-9113-8392129e2b5c.png)

### `@deprecated`

Visibly marks a function as deprecated.

![example](https://user-images.githubusercontent.com/75196080/112711806-35b5fa80-8edc-11eb-9a06-41a41545c686.gif)

### `@see`

Functionally the same as an annotation comment.

### `@meta`

This is for internal use by Sumneko. The mark will have some details on the impact, and may continue to increase in the future. Currently they are:

* comletion will not display context in a meta file
* hover of `require` a meta file shows `[[meta]]` instead of absolute path
* find reference ignores results in a meta file

## Settings

There are a few notable EmmyLua options one should consider.

### Completion: Display Context

![example](https://user-images.githubusercontent.com/1073877/117556717-2e9e1280-b06c-11eb-8cde-48c594933933.png)

`"Lua.completion.displayContext": 6` (default)

![example](https://user-images.githubusercontent.com/1073877/117555567-95b5ca00-b060-11eb-90d3-576aa0fa0d42.png)

`"Lua.completion.displayContext": 0`

![example](https://user-images.githubusercontent.com/1073877/117555531-5a1b0000-b060-11eb-915c-d3c5f43a1664.png)

### References

* EmmyLua: <https://emmylua.github.io/annotation.html>
* Examples: <https://github.com/sumneko/lua-language-server/tree/master/meta>
* Tests: <https://github.com/sumneko/lua-language-server/blob/master/test/definition/luadoc.lua>
* Issues: <https://github.com/sumneko/lua-language-server/issues?q=label%3AEmmyLua>
* Discussion: <https://github.com/sumneko/lua-language-server/discussions/470>
