-- TODO: Add all core types as separate classmodules in true OOP style.
-- TODO: parse abstract (#) types

local module = require 'lib.module'


--[[ One line of tagged block
@ lib.luapi.block#line (table)
> name    (string) [] First word after tag
> title   (string) [] Any text at the end
> parent  (string) [] Text in parentheses
> square  (string) [] Text in square brackets
]]


--[[ Parsed tagged comment block of any type
@ lib.luapi.block (table)
> title       (string) []
> description (string) []
> name        (string) []
> codename    (string) [] Real name in code
> codeargs    (list=string) [] Real function arguments
> fields      (list=lib.luapi.block#line) [] Line after >
> returns     (list=lib.luapi.block#line) [] Line after <
> typeset     (lib.luapi.block#line)      [] Line after @
]]
local Block = module 'lib.luapi.block'


--[[ Take comments block and create structured data block
> block (string) []
]]
function Block:init(block)
  if not block then return self end
  require "lib.luapi.block._parse" (self, block)
end


return Block
