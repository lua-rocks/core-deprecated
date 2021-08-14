local Object = require 'lib.object'
local File = require 'lib.luapi.file'


--[[ All files in project (indexed by reqpaths)
@ lib.luapi.files
> =string (lib.luapi.file...)
]]
local Files = Object:extend 'lib.luapi.files'


--[[ Get paths, load, read, parse, write ]]--
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
    local file = File(reqpath, fullpath)
    if not file:read() then
      print('Cannot read ' .. reqpath)
    elseif not file:parse() then
      print('Cannot parse ' .. reqpath)
    else
      file:write()
      self[reqpath] = file
    end
    file:cleanup()
  end

  -- IDEA: Write index
  -- Temporary disabled
  -- self:write(out_path)
end


--[[ Write `readme.md` for entire project
> index_path (string)
< success (lib.luapi.files|nil)

function Files:write(index_path)
  local index_file = io.open(index_path, 'w+')
  if not index_file then
    print('error: failed to create "' .. index_path .. '"')
    return nil
  end

  local out = '# Project Code Documentation\n\n'
  local sorted_paths = {}
  for path in pairs(self) do table.insert(sorted_paths, path) end
  table.sort(sorted_paths)
  out = out .. '| File | Title |\n| ---- | ----- |\n'
  local links = ''
  for _, path in pairs(sorted_paths) do
    local file = self[path]
    if tostring(file) == 'instance of lib.luapi.file' and file[1] then
      local title = file[1].title
      if title then title = title .. ' ' else title = '' end
      out = out .. '| [' .. path .. '][] | ' .. title .. '|\n'
      links = links .. '['  .. path ..  ']: ' .. file.reqpath .. '.md\n'
    end
  end
  out = out .. '\n' .. links

  index_file:write(out)
  index_file:close()
  return self
end
]]


return Files
