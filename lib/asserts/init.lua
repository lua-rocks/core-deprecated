--[[ Multiple assertions
Tests all its arguments through the first one, similar to `assert`.
The first argument must be a function, through which the rest are passed.
This function takes one argument and returns any number.
If it returns nil or false, the test will be considered to have failed.
The test will also fail if an error occurs during the test.
= @ (function)
> f (function|string) []
> ... (any) []
< f (function|string) []
< ... (any) []
]]

--[[ Множественные ассерты
Тестирует все свои аргументы через первый, аналогично `assert`.
Первым аргументом должна быть функция, через которую пропускаются остальные.
Эта функция принимает один аргумент и возвращает любое количество.
Если она вернёт nil или false, то тест будет считаться проваленным.
Также тест будет провален, если в процессе тестирования произойдёт ошибка.
]]

return function(f, ...)
  if type(f) ~= 'function' then
    error('function expected, got ' .. type(f), 2)
  end
  for i = 1, select("#", ...) do
    for _, pass in ipairs({ pcall(f, select(i, ...)) }) do
      if not pass then error('assertion #' .. i .. ' failed', 2) end
    end
  end
  return f, ...
end
