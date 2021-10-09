local Object = require 'lib.object'
local lume = require 'lib.lume'


--[[ Parsed tagged comment block of any type
= @ (lib.object)
> name        (string)         First word after tag =
> parent      (string)         Text in parentheses after tag =
> title       (string)      [] Any text at the end of tag = or 1st line in block
> square      (string)      [] Text in square brackets after tag =
> description (string)      [] Not tagged lines in block
> returns   (list=@#line|@) [] Line after <
> fields    (list=@#line|@) [] Line after >
> locals    (list=@#line|@) [] Local types (module only)
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
= @>init  (function)
> self    (@)
> block   (string) []
> reqpath (string) []
> parser_mode (lib.luapi.conf>parser) []
]]
function Type:init(block, reqpath, parser_mode)
  if not block then return false end
  assert(type(block) == 'string')
  self.parse = require('lib.luapi.type.parser.' .. parser_mode)
  if block then
    self:parse(block, reqpath):correct()
  end
  if not self.name or not self.parent then return false end
end


--[[ Parse block
= @>parse (function)
> self    (@)
> block   (string)
> reqpath (string) []
]]


--[[ Correct parsed block
Trim and remove empty strings in table values
= @>correct (function)
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

= @>build_output (function)
> file (lib.luapi.file)
]]
function Type:build_output(file)
  local _links = {}
  local _titles = {}
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
      ['array']    = '📜',
      ['any']      = '❓',
    }
    local found = basic[str]
    if found then return found end
    if str:find '%.' then return '👨‍👦' end
    return '👽'
  end

  local function make_links_and_titles(t, tag)
    local name = t.name
    local parent = t.parent
    local esc_name = name:gsub('%.', '')
    local esc_parent = parent:gsub('%.', '')
    local id = '@'
    if tag then id = tag .. name end
    if parent:find '%.' then
      _links[id] = lume.format('#{1}--{2}-module', { esc_name, esc_parent })
      _titles[id] = lume.format('{1} : {2} `(module)`', { name, parent })
    else
      _links[id] = lume.format('#{1}-{2}', { esc_name, esc_parent })
      _titles[id] = lume.format('{1} `({2})`', { name, parent })
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

  local function out_list_of(t, to, prefix, postfix)
    prefix = prefix or ''
    postfix = postfix or ''
    local indexed = {}
    for key, value in pairs(t) do
      local index = value.index
      if index then indexed[index] = value
      else indexed[key] = value end
    end
    for _, value in pairs(indexed) do
      local emo = emoji(value.parent)
      local name
      local id = prefix .. value.name .. postfix
      if _links[id] then
        name = '[' .. value.name .. '][' .. id .. ']'
      else
        name = value.name
      end
      if value.square and ('|'..value.square..'|'):match '%Wnil%W' then
        name = '*' .. name .. '*'
      else
        name = '**' .. name .. '**'
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
    local function main_loop(components, tag)
      local first = true
      for _, component in pairs(components) do
        local component_is_empty =
          not component.description and
          not component.fields and
          not component.returns
        if component_is_empty then goto next end
        make_links_and_titles(component, tag)
        if not first then body:add '\n---\n' end
        body:add('\n### {1}\n', {_titles[tag .. component.name]})
        if component.title then
          body:add('\n{1}.\n', {component.title})
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
    end

    if self.fields then
      main_loop(self.fields, '@>')
      if self.parent == 'function' then
        head:add '\n## Arguments\n'
      else
        head:add '\n## Fields\n'
      end
      out_list_of(self.fields, head, '@>')
    end
    if self.returns then
      main_loop(self.returns, '@<')
      head:add '\n## Returns\n'
      out_list_of(self.returns, head, '@<')
    end
    if self.locals then
      main_loop(self.locals, '@#')
      head:add '\n## Locals\n'
      out_list_of(self.locals, head, '@#')
    end
    if body.text ~= '' then head:add '\n## Details\n' end
  end

  local function out_footer()
    local function get_root_path()
      if file.conf.publish == 'github' then return '/../..' end
      local path = '..'
      local _, level = self.name:gsub('%.', '')
      if not level or level == 0 then return path end
      for _=1, level do path = path .. '/..' end
      return path
    end
    foot:add '\n## Navigation\n'
    foot:add('\n[Back to top of the document]({1})\n', { _links['@'] })
    foot:add '\n[Back to upper directory](..)\n'
    foot:add('\n[Back to project root]({1})\n', { get_root_path() })
    if next(_links) then
      for key, value in pairs(_links) do
        foot:add('\n[{1}]: {2}', {
          key, -- key:gsub(file.cache.escaped_reqpath, '@'),
          value
        })
      end
      foot:add '\n'
    end
  end

  do -- everything
    make_links_and_titles(self)
    head:add('# {1}\n', {_titles['@']})
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
end


return Type
