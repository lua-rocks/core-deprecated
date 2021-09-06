--[[ Test function
= @ (function)
> a (number)   will be doubled
> b (string)   will be concatenated with c
> c (string)   will be concatenated with b
> extra (@#extra) see description below
> ... (any) [] will be printed
< a2 (number)  doubled a
< bc (string)  concatenated b and c
]]
return function(a, b, c, extra, ...)
  print(extra.name, ...)
  return a*2, b .. c
end


--[[ Extra type
= @#extra (table)
> name (string) ["Bob"]
> age (number) [12]
]]
