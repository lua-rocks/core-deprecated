# etc.luapi_test.composite : lib.object `(module)`

## This file is sandbox for testing luapi

Some readme...

## Fields

+ 👽 **some_field1** ( some_type1 = *some_default_value1* )
	`Some field title1`
+ 👽 **some_field2** ( some_type2 = *some_default_value2* )
	`Some field title2`
+ 👨‍👦 **class2** ( @>type2 )
	`IDEA: Should be writed as method`
+ 👨‍👦 **[mega][@>mega]** ( lib.object )
	`Mega-field`
+ 💡 **[super_method][@>super_method]** ( function )
	`Super-duper method`
+ 💡 **[type2][@>type2]** ( function )
	`Test type 2`

## Returns

+ 🔌 _lol_ ( boolean = *nil* )

## Locals

+ 📦 **[tbl][@#tbl]** ( table )
	`Abstract type`

## Details

### mega : lib.object `(module)`

Mega-field.

Fields:

+ ❓ **giga** ( any )
	`Yay!`

---

### type2 `(function)`

Test type 2.

> If type is function and you set it as module field, it will be parsed as method

Arguments:

+ 👨‍👦 **take** ( @#tbl )
	`abstract type desribed below`

Returns:

+ 🧮 **give** ( integer )

---

### super_method `(function)`

Super-duper method.

> You no need to describe argument `self` for methods named with colon
> (actually you no **need** to describe anything 😉
> but of course you can if you want to).

Arguments:

+ 🧮 **n** ( number )
	`Spaces between tagged data will be ignored`
+ 🧮 **x** ( integer = *2* )

Returns:

+ 👨‍👦 **self** ( @ )
	`Bli bla`
+ 🧮 **n** ( number )
	`Blu ble`

### tbl `(table)`

Abstract type.

> Symbol `#` used to define [private|abstract|local] type

Fields:

+ 📝 **foo** ( string )
+ 📝 **bar** ( string )

## Navigation

[Back to top of the document](#etcluapi_testcomposite--libobject-module)

[Back to upper directory](..)

[Back to project root](/../..)

[@>mega]: #mega--libobject-module
[@]: #etcluapi_testcomposite--libobject-module
[@>type2]: #type2-function
[@>super_method]: #super_method-function
[@#tbl]: #tbl-table
