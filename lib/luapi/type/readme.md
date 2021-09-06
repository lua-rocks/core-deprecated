# lib.luapi.type : lib.object `(module)`

## Parsed tagged comment block of any type

## Fields

- 📝 **name** ( string )
	`First word after tag =`
- 📝 **parent** ( string )
	`Text in parentheses after tag =`
- 📝 **title** ( string = *nil* )
	`Any text at the end of tag = or 1st line in block`
- 📝 **square** ( string = *nil* )
	`Text in square brackets after tag =`
- 📝 **description** ( string = *nil* )
	`Not tagged lines in block`
- 👨‍👦 **returns** ( list=lib.luapi.type#line|lib.luapi.type = *nil* )
	`Line after <`
- 👨‍👦 **fields** ( list=lib.luapi.type#line|lib.luapi.type = *nil* )
	`Line after >`
- 👨‍👦 **locals** ( list=lib.luapi.type#line|lib.luapi.type = *nil* )
	`Local types (module only)`
- 💡 **parse** ( function )
	`Parse block`
- 💡 **init** ( function )
	`Take comments block and return a type`
- 💡 **build_output** ( function )
	`Build markdown output for module-types`
- 💡 **correct** ( function )
	`Correct parsed block`

## Locals

- 📦 **line** ( table )
	`One line of tagged block`

## Details

### line `(table)`

One line of tagged block

Fields:

- 📝 **name** ( string = *nil* )
	`First word after tag`
- 📝 **parent** ( string = *nil* )
	`Text in parentheses`
- 📝 **title** ( string = *nil* )
	`Any text at the end`
- 📝 **square** ( string = *nil* )
	`Text in square brackets`
- 🧮 **index** ( integer = *nil* )
	`Output order`

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

- 👨‍👦 **file** ( lib.luapi.file )

---

### parse `(function)`

Parse block

Arguments:

- 👨‍👦 **self** ( lib.luapi.type )
- 📝 **block** ( string )
- 📝 **reqpath** ( string = *nil* )

---

### init `(function)`

Take comments block and return a type

Arguments:

- 👨‍👦 **self** ( lib.luapi.type )
- 📝 **block** ( string = *nil* )
- 📝 **reqpath** ( string = *nil* )

---

### correct `(function)`

Correct parsed block

> Trim and remove empty strings in table values

Arguments:

- 📦 **self** ( table )
