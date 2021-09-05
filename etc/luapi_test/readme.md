# Module `etc.luapi_test` : `lib.object`

<details><summary><b>Example</b></summary>

```lua
print(2+2)
```

</details>

## This file is sandbox for testing luapi

Some readme...

The `etc` directory is an experimentation ground and you can remove it
without hesitation, but I advise you to read the contents first. Perhaps you
will find something useful or interesting there.

### How to run

1. cd to the project **root**
2. if `/bin/lua` existed then just run: `etc/luapi_test/run.lua`
3. if your lua binary located in another place, put it before the command above

## Fields

- 👨‍👦 **mega** ( lib.object )
	`Mega-field`
- 👨‍👦 **class2** ( etc.luapi_test:type2 )
	`IDEA: Should be writed as method`
- 💡 **type2** ( function )
	`Test type 2`
- 💡 **super_method** ( function )
	`Super-duper method`
- 👽 **some_field1** ( some_type1 = *some_default_value1* )
	`Some field title1`
- 👽 **some_field2** ( some_type2 = *some_default_value2* )
	`Some field title2`

## Returns

- 🔌 **lol** ( boolean = *nil* )

## Details

### Module `mega` : `lib.object`

Fields:

- 👽 **giga** ( any )
	`Yay!`

### Function `type2`

If type is function and you set it as module field, it will be parsed as method

Fields:

- 👨‍👦 **take** ( etc.luapi_test#tbl )
	`abstract type desribed below`

Returns:

- 👽 **give** ( integer )

### Function `super_method`

You no need to describe argument `self` for methods named with colon
(actually you no **need** to describe anything 😉
but of course you can if you want to).

Fields:

- 👽 **x** ( integer = *2* )
- 🧮 **n** ( number )
	`Spaces between tagged data will be ignored`

Returns:

- 🧮 **n** ( number )
	`Blu ble`
- 👨‍👦 **self** ( etc.luapi_test )
	`Bli bla`

## 🖇️ Links
