# Lua Core Bundle (WIP)

This repository contains a minimal set of the first needed lua libraries
which I use in my projects as a skeleton.

**Attention!** I plan to cover every library with documentation, but since my
[luapi][] is still quite raw, not everything is documented yet and visually it
doesn't look as good as I'd like it to be. If you fork me and help with
something, I'd be incredibly grateful!

**Attention (2)!** Keep in mind that [luapi][] curently in hard development
and from time to time I can **totally break everything**! That's a normal
behavior until version 1.0 will be officialy released.

I don't use libraries like `busted` or `lpeg` because I don't like to
unnecessarily complicate things. I'm 100% happy with the default asserts and
patterns, and I hope you are too, but if not - no one forbids you to add them.

Target versions are *latest* for **lua** (`5.4`) and **luajit** (`2.1`).

Target OS: **Linux**. I do not support proprietary software but theoretically
on Windows and Mac everything should work fine too.

Each file in this project is distributed under the free `MIT` license.

## The list of libraries

Some of the libraries were not written by me and you can go to the repository of
their author, by clicking on its name, but if the author is not listed, then
they are mine and this repository is native to them.

+ [luapi][] - documentation (**WIP**)
+ [asserts][] - multiple assertions
+ [lume][] - a set of various goodies by `rxi`
+ [inspect][] - variable inspector by `kikito`
+ [ansicolors][] - multicolor terminal output by `hoelzro` and `kikito`
+ [debugger][] - simple and colorful debugger by `slembcke`

[öbject]: lib/object
[luapi]: lib/luapi
[asserts]: lib/asserts
[lume]: https://github.com/rxi/lume
[inspect]: https://github.com/kikito/inspect.lua
[ansicolors]: https://github.com/kikito/ansicolors.lua
[debugger]: https://github.com/slembcke/debugger.lua

## Code style

Follow these rules to make your code enjoyable to work with:

+ unambiguity and brevity: the code must be understandable even for
  drunken child
+ each module must be able to work separately from the application
+ maximum line length = **80** characters
+ use two spaces as indents
+ filenames in `snake_case`
+ class names in `CamelCase`, all other variables in `snake_case`
+ prefer single quotes in the code and double quotes in the text to read
+ you must not have any `CONSTANT` because theoretically every module is a
  constant and in this case, half of the code should be written in caps, but
  practically lua is a very flexible language and we can never be 100% sure of
  the constancy of anything
+ always check the types of data you get and cover the code with basic tests
  (don't worry about a lot of asserts creating an unnecessary load; the `assert`
  function itself can easily be replaced by a pacifier function in production)

## Highly recommended VSCodium extensions

```sh
# Lua
codium --install-extension changnet.lua-tags
codium --install-extension dwenegar.vscode-luacheck
codium --install-extension tomblind.local-lua-debugger-vscode

# Markdown
codium --install-extension yzhang.markdown-all-in-one
codium --install-extension fcrespo82.markdown-table-formatter
codium --install-extension jayfidev.tablegenerator
codium --install-extension davidanson.vscode-markdownlint
codium --install-extension marvhen.reflow-markdown
codium --install-extension zaaack.markdown-editor

# Other
codium --install-extension gruntfuggly.todo-tree
```
