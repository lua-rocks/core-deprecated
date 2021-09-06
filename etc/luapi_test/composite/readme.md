# etc.luapi_test.composite : lib.object `(module)`

## This file is sandbox for testing luapi

Some readme...

## Fields

- 👽 _some_field1_ ( some_type1 = *some_default_value1* )
	`Some field title1`
- 👽 _some_field2_ ( some_type2 = *some_default_value2* )
	`Some field title2`
- 👨‍👦 **class2** ( etc.luapi_test.composite:type2 )
	`IDEA: Should be writed as method`
- 👨‍👦 **mega** ( lib.object )
	`Mega-field`
- 💡 **super_method** ( function )
	`Super-duper method`
- 💡 **type2** ( function )
	`Test type 2`

## Returns

- 🔌 _lol_ ( boolean = *nil* )

## Locals

- 📦 **tbl** ( table )
	`Abstract type`

## Details

### mega : lib.object `(module)`

Mega-field

Fields:

- ❓ **giga** ( any )
	`Yay!`

---

### super_method `(function)`

Super-duper method

> You no need to describe argument `self` for methods named with colon
> (actually you no **need** to describe anything 😉
> but of course you can if you want to).

Arguments:

- 🧮 **n** ( number )
	`Spaces between tagged data will be ignored`
- 🧮 _x_ ( integer = *2* )

Returns:

- 👨‍👦 **self** ( etc.luapi_test.composite )
	`Bli bla`
- 🧮 **n** ( number )
	`Blu ble`

---

### tbl `(table)`

Abstract type

> Symbol `#` used to define [private|abstract|local] type

Fields:

- 📝 **foo** ( string )
- 📝 **bar** ( string )

---

### type2 `(function)`

Test type 2

> If type is function and you set it as module field, it will be parsed as method

Arguments:

- 👨‍👦 **take** ( etc.luapi_test.composite#tbl )
	`abstract type desribed below`

Returns:

- 🧮 **give** ( integer )
