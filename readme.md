# Core libs - emmylua edition

I originally planned to create this branch for adapting `luapi` to `emmylua`,
for use it in vscode|vscodium together with the `sumneko.lua` extension. But
firstly this is quite a complicated task, and secondly the cheatsheet in the
`doc` directory is enough to get all documentation inside the editor, so if I
continue to develop luapi in this direction, then not in near future.

## An important agreement

Please name your classes according to their require paths
so that they are always unique.

If the file contains several classes, separate the internal ones with a hyphen
("`-`"), in format `reqpath-classname`.

```lua
---@type lib.object
local Object = require 'lib.object'

---@class lib.object.example-point:lib.object
local Point = Object:extend 'lib.object.example-point'
```

Use the `class` snippet for convenience.
