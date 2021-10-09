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
+ 📝 *description* ( string = *nil* )
	`Not tagged lines in block`
+ 💡 **[build_output][@>build_output]** ( function )
	`Build markdown output for module-types`
+ 👨‍👦 *fields* ( list=@#line|@ = *nil* )
	`Line after >`
+ 👨‍👦 *locals* ( list=@#line|@ = *nil* )
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
+ 📝 *reqpath* ( string = *nil* )

---

### init `(function)`

Take comments block and return a type.

Arguments:

+ 👨‍👦 **self** ( @ )
+ 📝 *block* ( string = *nil* )
+ 📝 *reqpath* ( string = *nil* )
+ 👨‍👦 *parser_mode* ( lib.luapi.conf>parser = *nil* )

### line `(table)`

One line of tagged block.

Fields:

+ 📝 *name* ( string = *nil* )
	`First word after tag`
+ 📝 *parent* ( string = *nil* )
	`Text in parentheses`
+ 📝 *title* ( string = *nil* )
	`Any text at the end`
+ 📝 *square* ( string = *nil* )
	`Text in square brackets`
+ 🧮 *index* ( integer = *nil* )
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
