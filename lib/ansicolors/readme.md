# lib.ansicolors `(table)`

<details><summary><b>Example</b></summary>

```lua
local colors = require 'lib.ansicolors'

print(colors('%{red}hello'))
print(colors('%{redbg}hello%{reset}'))
print(colors('%{bright red underline}hello'))
```

</details>

## Colorize string

The colors function makes sure that color attributes are reset at each end of
the generated string. If you want to generate complex strings piece-by-piece,
use `colors.noReset`, which works exactly the same, but without adding the reset
codes at each end of the string.

Misc. attributes:

+ reset
+ bright
+ dim
+ underline
+ blink
+ reverse
+ hidden

Foreground colors:

+ black
+ red
+ green
+ yellow
+ blue
+ magenta
+ cyan
+ white

Background colors:

+ blackbg
+ redbg
+ greenbg
+ yellowbg
+ bluebg
+ magentabg
+ cyanbg
+ whitebg

## Fields

- 👨‍👦 **__call** ( lib.ansicolors#__call )
- 👨‍👦 **noReset** ( function=lib.ansicolors#__call )

## Locals

- 💡 **__call** ( function )

## Details

### __call `(function)`

Arguments:

- 📝 **str** ( string )

Returns:

- 📝 **str** ( string )

## Navigation

[Back to top of the document](#libansicolors-table)

[Back to upper directory](..)

[Back to project root](/../..)
