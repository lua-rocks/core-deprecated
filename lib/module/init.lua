--[[ Mödules are neutered Öbjects (without any ÖØP feautures)
If you use öbjects to describe mödules, just replace this:
```lua
local File = Object:extend 'lib.luapi.file'
```

with this:
```lua
local File = module 'lib.luapi.file'
```

And the internal structure of your application will become much lighter!

The same way you can easily upgrade it to öbject later if you change your mind.
@ lib.module (table)
]]
return setmetatable({}, {
  __tostring = function() return 'Module' end,
  __call = function(_, name)
    return setmetatable({}, {
      __tostring = function() return 'module ' .. name end,
      __call = function(self, ...)
        local instance = {}
        for key, value in pairs(self) do instance[key] = value end
        instance.init = nil
        instance = setmetatable(instance, {
          __tostring = function() return 'instance of ' .. name end,
        })
        self.init(instance, ...)
        return instance
      end
    })
  end
})
