local Object = require 'lib.object'
local File = require 'lib.luapi.file'


--[[ All files in project (indexed by reqpaths)
= @ (lib.object)
> ?string (lib.luapi.file)
]]
local Files = Object:extend 'lib.luapi.files'


--[[ Get paths, load, read, parse, write
= @:init (function)
> self   (@)
> luapi  (lib.luapi)
]]
function Files:init(luapi)
  assert(tostring(luapi) == 'instance of lib.luapi')

  local filters = luapi.conf.path_filters or {}
  local root = luapi.conf.root_path
  local fullpaths = {}

  --[[ Extract files called `init.lua`
  Add paths of their dirs to `fullpaths`
  > all_files (list)
  ]]
  local function extract_fullpaths(all_files)
    for _, path in ipairs(all_files) do
      if path:find '/init.lua$' then
        table.insert(fullpaths, path:sub(1, -10))
      end
    end
  end

  --[[ Recursively scan directory and return list with each file path
  > path (string)
  < paths (list)
  ]]
  local function extract_subpaths(path, paths)
    paths = paths or {}
    local ostype = package.config:sub(1, 1)
    if ostype == '\\' or ostype == '\\\\' then ostype 'windows'
    else ostype = 'linux' end
    path = path:gsub('\\\\', '/'):gsub('\\', '/')

    -- Files --
    local file
    local command
    if ostype == 'windows' then
      command = 'dir "'..path..'" /b /a-d-h'
    else
      command = 'ls -p "'..path..'" | grep -v /'
    end
    file = io.popen(command)
    for item in file:lines() do
      item = (path .. '/' .. item):gsub('//', '/')
      table.insert(paths, item)
    end
    file:close()

    -- Folders --
    if ostype == 'windows' then
      command = 'dir "' .. path .. '" /b /ad-h'
    else
      command = 'ls -p "' .. path .. '" | grep /'
    end
    file = io.popen(command)
    for item in file:lines() do
      item = item:gsub('\\', '')
      paths = extract_subpaths(path .. '/' .. item, paths)
    end
    file:close()

    return paths
  end

  -- Extract paths
  if #filters == 0 then
    extract_fullpaths(extract_subpaths(root))
  else
    for _, filter in ipairs(filters) do
      extract_fullpaths(extract_subpaths(root .. '/' .. filter))
    end
  end

  -- Load and handle files
  for _, fullpath in ipairs(fullpaths) do
    local reqpath = fullpath:gsub(root .. '/', ''):gsub(root, ''):gsub('/', '.')
    local file = File(reqpath, fullpath, luapi.conf)
    if not file:read() then
      print('Cannot read ' .. reqpath)
    elseif file:parse_module() and file:parse() then
      file:write()
      self[reqpath] = file
    end
    file:cleanup()
  end
end


return Files
