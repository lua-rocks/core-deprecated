local Object = require 'lib.object'
local lume = require 'lib.lume'


--[[ Parsed tagged comment block of any type
= @ (lib.object)
> conf (lib.luapi.conf)
> name        (string)         First word after tag =
> parent      (string)         Text in parentheses after tag =
> title       (string)      [] Any text at the end of tag = or 1st line in block
> square      (string)      [] Text in square brackets after tag =
> description (string)      [] Not tagged lines in block
> returns   (list=@#line|@) [] Line after <
> fields    (list=@#line|@) [] Line after >
> locals    (list=@#line|@) [] Local types (module only)
> _titles ({string=string,...}) [] Temporary storage for formatted titles
> _links  ({string=string,...}) [] Temporary storage for markdown links
]]
local Type = Object:extend 'lib.luapi.type'


--[[ One line of tagged block
= @#line (table)
> name   (string)  [] First word after tag
> parent (string)  [] Text in parentheses
> title  (string)  [] Any text at the end
> square (string)  [] Text in square brackets
> index  (integer) [] Output order
]]


--[[ Take comments block and return a type
= @:init  (function)
> self    (@)
> conf    (lib.luapi.conf)
> block   (string) []
> reqpath (string) []
]]
function Type:init(conf, block, reqpath)
  assert(conf:is('lib.luapi.conf'))
  if not block then return false end
  assert(type(block) == 'string')
  self.conf = conf
  self._links = {}
  self._titles = {}
  if block then
    self:parse(block, reqpath):correct()
  end
  if not self.name or not self.parent then return false end
end


--[[ Parse block
= @:parse (function)
> self    (@)
> block   (string)
> reqpath (string) []
]]
function Type:parse(block, reqpath)
  assert(type(block) == 'string')
  -- Parse block line by line
  local line_index = 1
  for line in block:gmatch '\n(%C*)' do
    local tag = line:sub(1, 1)
    if tag == '>' or tag == '<' or tag == '=' then
      local tagged_line = line:sub(3, -1)
      if reqpath then tagged_line = tagged_line:gsub('@', reqpath) end
      local comment_start_at = math.max(
        (tagged_line:find '%s' or 0),
        (tagged_line:find '%)' or 0),
        (tagged_line:find '%]' or 0)
      ) + 1
      local square = tagged_line:match '%[(.-)%]'
      if square == '' or square == 'opt' then square = 'nil' end
      local parsed_line = {
        name = lume.trim((tagged_line .. '\n'):match '^(.-)[%s\n]' or ''),
        title = lume.trim(tagged_line:sub(comment_start_at, -1)),
        parent = tagged_line:match '%((.-)%)' or 'any',
        square = square,
      }
      if parsed_line.name:find '[%[%(]' then parsed_line.name = nil end
      for short, long in pairs({ ['>'] = 'fields', ['<'] = 'returns' }) do
        if tag == short then
          self[long] = self[long] or {}
          self[long][parsed_line.name] = parsed_line
          self[long][parsed_line.name].index = line_index
          line_index = line_index + 1
        end
      end
      if tag == '=' then
        for key, value in pairs(parsed_line) do
          self[key] = value
        end
      end
    elseif line ~= ']]' then
      local description = self.description or ''
      if line ~= '' or description:sub(-2) ~= '\n\n' then
        description = description .. line .. '\n'
      end
      self.description = description
    end
  end
  if not self.title or self.title == '' then
    self.title = block:match '%-%-%[%[(.-)%]%]':gsub('\n.*', '')
  end
  return self
end


--[[ Correct parsed block
Trim and remove empty strings in table values
= @:correct (function)
> self      (table)
]]
function Type:correct()
  assert(type(self) == 'table')
  for key, value in pairs(self) do
    if type(value) == 'table' then Type.correct(value)
    elseif type(value) == 'string' then
      value = lume.trim(value)
      if value == '' then value = nil end
      self[key] = value
    end
  end
  return self
end


--[[ Build markdown output for module-types
There are 2 different templates for composite and simple types:

#### Composite (classes, tables, functions)

+ Header
+ Example    (spoiler)
+ Readme
+ Components (short list with links to Details)
+ Locals     (short list with links to Details)
+ Details    (full descriptions for everything)
+ Footer

#### Simple (everything else)

+ Header
+ Readme
+ Example   (no spoiler)
+ Footer

= @:build_output (function)
> file (lib.luapi.file)
]]
function Type:build_output(file)
  local head, body, foot = file.cache.head, file.cache.body, file.cache.foot

  local is_simple = true
  if self.parent == 'table'
  or self.parent == 'function'
  or self.parent:find '%.' then is_simple = false end

  local function emoji(str)
    local basic = {
      ['string']   = '📝',
      ['char']     = '📝',
      ['number']   = '🧮',
      ['integer']  = '🧮',
      ['boolean']  = '🔌',
      ['function'] = '💡',
      ['table']    = '📦',
      ['thread']   = '🧵',
      ['userdata'] = '🔒',
      ['list']     = '📜',
      ['any']      = '❓',
    }
    local found = basic[str]
    if found then return found end
    if str:find '%.' then return '👨‍👦' end
    return '👽'
  end

  local function make_links_and_titles(t)
    local name = t.name
    local parent = t.parent
    local esc_name = name:gsub('%.', '')
    local esc_parent = parent:gsub('%.', '')
    if parent:find '%.' then
      self._links[name] = lume.format('#{1}--{2}-module', {esc_name,esc_parent})
      self._titles[name] = lume.format('{1} : {2} `(module)`', { name, parent })
    else
      self._links[name] = lume.format('#{1}-{2}', { esc_name, esc_parent })
      self._titles[name] = lume.format('{1} `({2})`', { name, parent })
    end
  end

  local function out_example_spoiler()
    local example = file.cache.example
    if example then head
      :add '\n<details><summary><b>Example</b></summary>\n\n```lua\n'
      :add (example)
      :add '```\n\n</details>\n'
    end
  end

  local function out_example_topic()
    local example = file.cache.example
    if example then head
      :add '\n## Example\n\n```lua\n'
      :add (example)
      :add '```\n'
    end
  end

  local function out_title_and_readme()
    local readme = file.cache.readme
    if readme then
      if not self.title then
        self.title = readme:match '\n#%s(.-)\n'
      end
      readme = readme
        :gsub('\n#%s.-\n', '') -- remove title header
        :gsub('\n#', '\n##') -- increase all headers level
    end
    if self.title then head:add('\n## {1}\n', {self.title}) end
    if self.description then head:add('\n{1}\n', {self.description}) end
    if readme then head:add(readme) end
  end

  local function out_list_of(t, to)
    local indexed = {}
    for key, value in pairs(t) do
      local index = value.index
      if index then indexed[index] = value
      else indexed[key] = value end
    end
    for _, value in pairs(indexed) do
      local emo = emoji(value.parent)
      local name = '**' .. value.name .. '**'
      if value.square
      and ('|'..value.square..'|'):match '%Wnil%W' then -- optional
        name = '_' .. value.name .. '_'
      end
      to:add('\n+ {1} {2} ( {3}', {
        emo,
        name,
        value.parent:gsub(file.cache.escaped_reqpath, '@')
      })
      if value.square then to:add(' = *{1}*', {value.square}) end
      to:add ' )'
      if value.title then to:add('\n\t`{1}`', {value.title}) end
    end
    to:add '\n'
  end

  local function out_components()
    local components = {}
    lume.extend(components, self.fields, self.returns, self.locals)
    local first = true
    for _, component in pairs(components) do
      local component_is_empty =
        not component.description and
        not component.fields and
        not component.returns
      if component_is_empty then goto next end
      make_links_and_titles(component)
      if not first then body:add '\n---\n' end
      body:add('\n### {1}\n', {self._titles[component.name]})
      if component.title then
        body:add('\n{1}\n', {component.title})
      end
      if component.description then
        body:add('\n> {1}\n', {
          component.description
            :gsub('\n', '\n> ')
            :gsub('\n>%s\n', '\n>\n')
        })
      end
      if component.fields then
        if component.parent == 'function' then
          body:add '\nArguments:\n'
        else
          body:add '\nFields:\n'
        end
        out_list_of(component.fields, body)
      end
      if component.returns then
        body:add '\nReturns:\n'
        out_list_of(component.returns, body)
      end
      first = false
      ::next::
    end
    if self.fields then
      if self.parent == 'function' then
        head:add '\n## Arguments\n'
      else
        head:add '\n## Fields\n'
      end
      out_list_of(self.fields, head)
    end
    if self.returns then
      head:add '\n## Returns\n'
      out_list_of(self.returns, head)
    end
    if self.locals then
      head:add '\n## Locals\n'
      out_list_of(self.locals, head)
    end
    if body.text ~= '' then head:add '\n## Details\n' end
  end

  local function out_footer()
    local function get_root_path()
      if self.conf.publish == 'github' then return '/../..' end
      local path = '..'
      local _, level = self.name:gsub('%.', '')
      if not level or level == 0 then return path end
      for _=1, level do path = path .. '/..' end
      return path
    end
    foot:add '\n## Navigation\n'
    foot:add('\n[Back to top of the document]({1})\n',
      { self._links[self.name] })
    foot:add '\n[Back to upper directory](..)\n'
    foot:add('\n[Back to project root]({1})\n', { get_root_path() })
  end

  do -- everything
    make_links_and_titles(self)
    head:add('# {1}\n', {self._titles[self.name]})
    if is_simple then
      if self.square then
        head:add('\n{1} Default: **{2}**\n', {emoji(self.parent), self.square})
        out_title_and_readme()
        out_example_topic()
      end
    else
      out_example_spoiler()
      out_title_and_readme()
      out_components()
    end
    out_footer()
  end

  self._links  = nil
  self._titles = nil
end


return Type
