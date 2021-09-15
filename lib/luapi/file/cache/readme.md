# lib.luapi.file.cache : lib.object `(module)`

## Temporary data

Gets removed after File:write() attempt.

## Fields

+ 📝 _content_ ( string = *nil* )
	`full content of this file`
+ 📝 _code_ ( string = *nil* )
	`uncommented content of this file`
+ 📝 _example_ ( string = *nil* )
	`example.lua`
+ 📝 _readme_ ( string = *nil* )
	`dirname.lua`
+ 👨‍👦 **head** ( @#output )
+ 👨‍👦 **body** ( @#output )
+ 👨‍👦 **foot** ( @#output )
+ 📝 **escaped_reqpath** ( string )
+ 💡 **[init][@:init]** ( function )
	`Initialize`

## Locals

+ 📦 **[output][@#output]** ( table )
	`Element of output model`
+ 💡 **[output.add][@#output.add]** ( function )
	`Add text to output field`

## Details

### init `(function)`

Initialize.

Arguments:

+ 👨‍👦 **file** ( lib.luapi.file )

### output `(table)`

Element of output model.

Fields:

+ 📝 **text** ( string )
+ 👨‍👦 **add** ( @#output.add )

---

### output.add `(function)`

Add text to output field.

Arguments:

+ 👨‍👦 **self** ( @#output )
+ 📝 **text** ( string )

Returns:

+ 👨‍👦 **self** ( @#output )

## Navigation

[Back to top of the document](#libluapifilecache--libobject-module)

[Back to upper directory](..)

[Back to project root](/../..)

[@#output.add]: #outputadd-function
[@:init]: #init-function
[@#output]: #output-table
[@]: #libluapifilecache--libobject-module
