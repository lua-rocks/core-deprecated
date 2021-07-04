# `lib.module`

Extends: **table**

## Mödules are neutered Öbjects (without any ÖØP feautures)

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

## 🖇️ Links

[Back to root](../doc/readme.md)
