# `etc.sandbox.luapi_test`

Extends: **table**

<details><summary><b>Example</b></summary>

```lua
print(2+2)
```

</details>

## This file is sandbox for testing luapi

Content of `luapi_test.md` will be included into `readme.md`.

Heading #1 from `luapi_test.md` will be used as title only if there is no module
title in `init.lua`.

### Some heading

All headings levels will be automatically increased to +1 in `readme.md`.

## 📜 Fields

+ **some_field1 : some_type1 = some_default_value1**
  `Some field title1`
+ **some_field2 : some_type2 = some_default_value2**
  `Some field title2`
+ **class2 : etc.sandbox.luapi_test.class2**
  `TODO: Should be parsed as method`
+ **super_number_field : number = 3**
  `Extra field`
+ **super_table_field : table**
  `Another extra field`

## 💡 Methods

+ **super_method (n, x) : self, n**
  `Super-duper method`

## 🧩 Details

### Method `super_method`

Super-duper method

> You no need to describe argument `self` for methods named with colon
> (actually you no **need** to describe anything 😉
> but of course you can if you want to).

✏️ `n` : **number**
`Spaces between tagged data will be ignored`

✏️ `x` : **integer** _[2]_

🔚 `self` : **etc.sandbox.luapi_test**
`Bli bla`

🔚 `n` : **number**
`Blu ble`

## 🖇️ Links

[Go up](..)
