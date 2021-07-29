#!/bin/lua
--[[ Lua patterns sandbox
Run this file using lua pattern as argument to highlight mathcing parts.
]]

local colors = require 'lib.ansicolors'

local text =
[[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla condimentum in
massa tincidunt vestibulum. Donec1 lacinia 2+2 😝 ipsum vitae lacus sollicitudin
imperdiet. Donec et bibendum justo, non congue ligula. Morbi bibendum sapien et
ante dictum consectetur. Donec urna est, egestas et ullamcorper ac, lacinia non
ligula. Aenean at odio sem. Maecenas porta ыЫ -_- ante at iaculis. Pellentesque
habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.
Aenean eget nibh ullamcorper, 3 tempor erat ornare, gravida ex. Duis et est at
turpis posuere placerat sit amet id lorem. Sed aliquet ipsum interdum, ultrices
lectus in, efficitur nibh. Nullam lacinia elementum lectus a pharetra.]]

local pattern = arg[1] or ''

local replaced, found = text:gsub(pattern, colors '%{reverse}%1')

if found == 0 then
  found = colors('%{redbg}' .. found)
else
  found = colors('%{greenbg}' .. found)
end

print(replaced, found)
