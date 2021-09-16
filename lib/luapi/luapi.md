# LUAPI (WIP)

**LUAPI** is an attempt to bring together the best features of all lua
documentation tools I know, such as: [ldoc][], [luadoc][], [emmylua][] and
[scriptum][].

It generates code documentation in markdown format and also in the future I
really want to add autocomplete support for some IDE(s).

## Demo

Almost all `readme.md` files including this one was generated using `lib.luapi`.
Check out `init.lua` files to see how it works. Some tests you can find
[here](../../etc/luapi_test).

## Tags

+ `>`: function argument or table field
+ `<`: function or module return
+ `=`: set block [type](#types) and name/reqpath (can be only one in block)
+ first word after tag: variable name (or reqpath if tag is `=`)
+ `(parentheses)`: variable type name or parent class reqpath
+ `[square brackets]`: default value of the variable (`nil` makes it _optional_)
+ last words: one line comment (title)

Quick example:

```lua
--[[ Some function title
Some function comment.
Can be multiline.
_Support_ **markdown**.

= src.module.example (function)
> str (string) some string comment (one line and no markdown for such comments)
> num (number) [2] this value becomes 2 if not set
> opt (number) [] empty square brackets means [nil] - optional value 
< con (string) result of concatenation
]]
local function example(str, num, opt)
  num = num or 2
  if opt then num = num + opt end
  return str .. num
end
```

The line `= src.module.example (function)` is not required in "smart" mode
(this data can be parsed from code), but "strict" mode parse only comments
and works faster. Although performance is not an issue, but "strict" mode
is easier to debug and "smart" is still in development.

For more examples see source code of all this project 😉.

## Concept

Storing each module in a separate directory is a very good practice because it
allows you to keep together with the lua files not only the documentation but
also any other files on which this module depends - such as sounds, images, and
whatever else. It makes your modules more portable and independent; also its
pretty nice to see readme exactly under the files in your git-repository
website. That's why documentation generates only from `init.lua` files and saves
output `readme.md` in the same directory. File called `example.lua` will be
included into `readme.md` (you can use such files not only as examples, but also
as simple unit-tests).

You can document all your code, but remember that luapi will only parse
**types** and only write files with **module-types**.

+ **Type** is `--[[...]]` comments block with the tag `=` inside.
+ **Module-type** is the type whose name matches current file reqpath.

If there is no module-types in the file or file name is not `init.lua`, it will
be skipped.

## Types

When declaring a variable type, you can use all the built-in lua types or actual
variable values, plus the types listed below (keep in mind that equal sign works
different in different definitions):

+ **any** for any type
+ **integer** for non float number
+ **list** or **array** _(synonyms)_ for tables with integer keys
+ **list=function|table** list **of** functions **or** tables
+ **{string=number|string}** table with **one** key=value
+ **{1=string,"size"=32}** similar example of two key=values
+ **{string=string...}** any number of key=values
+ **{integer=any...}** this example is equivalent to **list** or **array**

Also you can use your defined module require paths as types:

+ **lib.luapi.block** some class or module
+ **table=lib.luapi.conf** table that has the same fields as class or module,
  but it is not necessarily an instance of it
+ **lib.luapi.type=lib.luapi.block** custom classes can do the same

You **can't** use **ClassNames** as types because they are not unique.

When you use `=` tag, you can mark your type different ways:

+ **lib.luapi>line** `line` is field or method of `lib.luapi`
+ **lib.build<result** `result` is something returned from `lib.build`
+ **lib.luapi#line** `line` is abstract or private type defined in `lib.luapi`

You can use symbol `@` as shorcut for **this file reqpath** anywhere:
`@>field`, `@#private`.

Even for subtypes: `@.subtype>field`

Inside field definition (`>`) you can use `?type_of_name` instead of field name
if your table includes fields with undefined names.

Like this:

```text
> ?integer (@.type) [] Types indexed by integer numbers
> ?string  (@.file) [] Files indexed by names
```

## Style guide

These rules are _optional_, but highly recommended:

+ maximum line number is **80** characters
+ `any` comments must always start with **uppercase** letter
+ `one line` comments (titles) must **not** have a dot or semicolon at the end
+ `muliline` comments (descriptions) must **have** a dot or semicolon at the end

These rules are _important_:

+ never call files in your project `readme.md` because these files will be
  generated automatically; use `current_directory_name.md` or `include.md`
  instead (its content will be included into `readme.md` in the process)

[ldoc]: https://stevedonovan.github.io/ldoc/manual/doc.md.html
[luadoc]: https://keplerproject.github.io/luadoc
[scriptum]: https://github.com/charlesmallah/lua-scriptum
[emmylua]: https://github.com/EmmyLua
