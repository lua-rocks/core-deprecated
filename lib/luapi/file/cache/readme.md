# lib.luapi.file.cache : lib.object `(module)`

## Temporary data

Gets removed after File:write() attempt.

## Fields

+ 📝 *content* ( string = *nil* )
	`full content of this file`
+ 📝 *code* ( string = *nil* )
	`uncommented content of this file`
+ 📝 *example* ( string = *nil* )
	`example.lua`
+ 📝 *readme* ( string = *nil* )
	`dirname.lua`
+ 👨‍👦 **head** ( @#output )
+ 👨‍👦 **body** ( @#output )
+ 👨‍👦 **foot** ( @#output )
+ 📝 **escaped_reqpath** ( string )
+ 👨‍👦 **conf** ( lib.luapi.conf )

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
[@#output]: #output-table
[@>init]: #init-function
[@]: #libluapifilecache--libobject-module
