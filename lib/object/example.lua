local Object = require 'lib.object'

---@class lib.object.example-point:lib.object
---@field super lib.object
local Point = Object:extend 'lib.object.example-point'

Point.scale = 2 -- Class field!

function Point:init(x, y)
  self.x = x or 0
  self.y = y or 0
end

function Point:resize()
  self.x = self.x * self.scale
  self.y = self.y * self.scale
end

function Point.__call()
  return 'called'
end

---@class lib.object.example-rect:lib.object.example-point
---@field super lib.object.example-point
---@field width integer
---@field height integer
local Rectangle = Point:extend('lib.object.example-rect')

function Rectangle:resize()
  Rectangle.super.resize(self) -- Extend Point's `resize()`.
  self.w = self.w * self.scale
  self.h = self.h * self.scale
end

function Rectangle:init(x, y, w, h)
  Rectangle.super.init(self, x, y) -- Initialize Point first!
  self.w = w or 0
  self.h = h or 0
end

function Rectangle:__index(key)
  if key == 'width' then return self.w end
  if key == 'height' then return self.h end
end

function Rectangle:__newindex(key, value)
  if key == 'width' then self.w = value
    elseif key == 'height' then self.h = value
  end
end

local rect = Rectangle:new(2, 4, 6, 8)

assert(rect.w == 6)
assert(rect:is(Rectangle))
assert(rect:is 'lib.object.example-rect')
assert(not rect:is(Point))
assert(rect:has 'lib.object.example-point' == 1)
assert(Rectangle:has(Object) == 2)
assert(rect() == 'called')

rect.width = 666
assert(rect.w == 666)
assert(rect.height == 8)

for _, t in ipairs({'field', 'method', 'meta'}) do
  rect:each(t, function(k, v) print(t, k, v) end)
end
