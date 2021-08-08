# Lua Core Bundle (WIP)

This repository contains a minimal set of the first needed lua libraries
which I use in my projects as a skeleton.

**Attention!** I plan to cover every library with documentation, but since my
[luapi][] is still quite raw, not everything is documented yet and visually it
doesn't look as good as I'd like it to be. If you fork me and help with
something, I'd be incredibly grateful!

I don't use libraries like `busted` or `lpeg` because I don't like to
unnecessarily complicate things. I'm 100% happy with the default asserts and
patterns, and I hope you are too, but if not - no one forbids you to add them.

Target lua version: `5+` (i.e. any version), including `luajit`, `love` etc.

Each file in this project is distributed under the free `MIT` license.

## The list of libraries

Some of the libraries were not written by me and you can go to the repository of
their author, by clicking on its name, but if the author is not listed, then
they are mine and this repository is native to them.

+ [öbject][] & [mödule][] - OOP
+ [luapi][] - documentation (**WIP**)
+ [asserts][] - multiple assertions
+ [lume][] - a set of various goodies by `rxi`
+ [ansicolors][] - multicolor terminal output by `hoelzro` and `kikito`

[öbject]: lib/object
[mödule]: lib/module
[luapi]: lib/luapi
[asserts]: lib/asserts
[lume]: https://github.com/rxi/lume
[ansicolors]: https://github.com/kikito/ansicolors.lua

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

## Highly recommended VSCode extensions

```sh
# Core
code --install-extension gruntfuggly.todo-tree

# Lua
code --install-extension changnet.lua-tags
code --install-extension dwenegar.vscode-luacheck
code --install-extension tomblind.local-lua-debugger-vscode

# Markdown
code --install-extension yzhang.markdown-all-in-one
code --install-extension fcrespo82.markdown-table-formatter
code --install-extension jayfidev.tablegenerator
code --install-extension davidanson.vscode-markdownlint
code --install-extension marvhen.reflow-markdown
code --install-extension zaaack.markdown-editor
```
