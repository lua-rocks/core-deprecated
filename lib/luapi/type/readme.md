# lib.luapi.type : lib.object `(module)`

## Parsed tagged comment block of any type

## Fields

+ 👨‍👦 **conf** ( lib.luapi.conf )
+ 📝 **name** ( string )
	`First word after tag =`
+ 📝 **parent** ( string )
	`Text in parentheses after tag =`
+ 📝 _title_ ( string = *nil* )
	`Any text at the end of tag = or 1st line in block`
+ 📝 _square_ ( string = *nil* )
	`Text in square brackets after tag =`
+ 📝 _description_ ( string = *nil* )
	`Not tagged lines in block`
+ 👨‍👦 _returns_ ( list=@#line|@ = *nil* )
	`Line after <`
+ 👨‍👦 _fields_ ( list=@#line|@ = *nil* )
	`Line after >`
+ 👨‍👦 _locals_ ( list=@#line|@ = *nil* )
	`Local types (module only)`
+ 👨‍👦 __titles_ ( {string=string,...} = *nil* )
	`Temporary storage for formatted titles`
+ 👨‍👦 __links_ ( {string=string,...} = *nil* )
	`Temporary storage for markdown links`
+ 💡 **parse** ( function )
	`Parse block`
+ 💡 **init** ( function )
	`Take comments block and return a type`
+ 💡 **build_output** ( function )
	`Build markdown output for module-types`
+ 💡 **correct** ( function )
	`Correct parsed block`

## Locals

+ 📦 **line** ( table )
	`One line of tagged block`

## Details

### correct `(function)`

Correct parsed block

> Trim and remove empty strings in table values

Arguments:

+ 📦 **self** ( table )

---

### line `(table)`

One line of tagged block

Fields:

+ 📝 _name_ ( string = *nil* )
	`First word after tag`
+ 📝 _parent_ ( string = *nil* )
	`Text in parentheses`
+ 📝 _title_ ( string = *nil* )
	`Any text at the end`
+ 📝 _square_ ( string = *nil* )
	`Text in square brackets`
+ 🧮 _index_ ( integer = *nil* )
	`Output order`

---

### parse `(function)`

Parse block

Arguments:

+ 👨‍👦 **self** ( @ )
+ 📝 **block** ( string )
+ 📝 _reqpath_ ( string = *nil* )

---

### init `(function)`

Take comments block and return a type

Arguments:

+ 👨‍👦 **self** ( @ )
+ 👨‍👦 **conf** ( lib.luapi.conf )
+ 📝 _block_ ( string = *nil* )
+ 📝 _reqpath_ ( string = *nil* )

---

### build_output `(function)`

Build markdown output for module-types

> There are 2 different templates for composite and simple types:
>
> #### Composite (classes, tables, functions)
>
> + Header
> + Example    (spoiler)
> + Readme
> + Components (short list with links to Details)
> + Locals     (short list with links to Details)
> + Details    (full descriptions for everything)
> + Footer
>
> #### Simple (everything else)
>
> + Header
> + Readme
> + Example   (no spoiler)
> + Footer

Arguments:

+ 👨‍👦 **file** ( lib.luapi.file )

## Navigation

[Back to top of the document](#libluapitype--libobject-module)

[Back to upper directory](..)

[Back to project root](/../..)
