# lib.luapi.type : lib.object `(module)`

## Parsed tagged comment block of any type

## Fields

+ 📝 **name** ( string )
	`First word after tag =`
+ 📝 **parent** ( string )
	`Text in parentheses after tag =`
+ 💡 **[init][@>init]** ( function )
	`Take comments block and return a type`
+ 💡 **[parse][@>parse]** ( function )
	`Parse block`
+ 📝 _description_ ( string = *nil* )
	`Not tagged lines in block`
+ 💡 **[build_output][@>build_output]** ( function )
	`Build markdown output for module-types`
+ 👨‍👦 _fields_ ( list=@#line|@ = *nil* )
	`Line after >`
+ 👨‍👦 _locals_ ( list=@#line|@ = *nil* )
	`Local types (module only)`

## Locals

+ 📦 **[line][@#line]** ( table )
	`One line of tagged block`

## Details

### build_output `(function)`

Build markdown output for module-types.

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

---

### correct `(function)`

Correct parsed block.

> Trim and remove empty strings in table values

Arguments:

+ 📦 **self** ( table )

---

### parse `(function)`

Parse block.

Arguments:

+ 👨‍👦 **self** ( @ )
+ 📝 **block** ( string )
+ 📝 _reqpath_ ( string = *nil* )

---

### init `(function)`

Take comments block and return a type.

Arguments:

+ 👨‍👦 **self** ( @ )
+ 📝 _block_ ( string = *nil* )
+ 📝 _reqpath_ ( string = *nil* )

### line `(table)`

One line of tagged block.

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

## Navigation

[Back to top of the document](#libluapitype--libobject-module)

[Back to upper directory](..)

[Back to project root](/../..)

[@>correct]: #correct-function
[@]: #libluapitype--libobject-module
[@>build_output]: #build_output-function
[@#line]: #line-table
[@>init]: #init-function
[@>parse]: #parse-function
