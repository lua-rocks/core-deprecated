# `etc.luapi_test`

Extends: **table**

<details><summary><b>Example</b></summary>

```lua
print(2+2)
```

</details>

## This file is sandbox for testing luapi

The `etc` directory is an experimentation ground and you can remove it
without hesitation, but I advise you to read the contents first. Perhaps you
will find something useful or interesting there.

### How to run

1. cd to the project **root**
2. if `/bin/lua` existed then just run: `etc/luapi_test/run.lua`
3. if your lua binary located in another place, put it before the command above

## 📜 Fields

+ **some_field1 : some_type1 = some_default_value1**
  `Some field title1`
+ **some_field2 : some_type2 = some_default_value2**
  `Some field title2`
+ **class2 : etc.luapi_test.class2**
  `TODO: Should be parsed as method`
+ **super_number_field : number = 3**
  `Extra field`
+ **super_string_field**
  `Extra field #2`
+ **super_table_field : table**
  `Another extra field`

## 💡 Methods

+ **super_method (n, x) : self, n**
  `Super-duper method`

## 👨‍👦 Types

+ **etc.luapi_test.mega**
+ **etc.luapi_test.class2**

## 🧩 Details

### Method `super_method`

Super-duper method

> You no need to describe argument `self` for methods named with colon
> (actually you no **need** to describe anything 😉
> but of course you can if you want to).

→ `n` : **number**
`Spaces between tagged data will be ignored`

→ `x` : **integer** _[2]_

← `self` : **etc.luapi_test**
`Bli bla`

← `n` : **number**
`Blu ble`

## 🖇️ Links

[Go up](..)
