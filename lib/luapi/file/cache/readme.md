# lib.luapi.file.cache : lib.object `(module)`

## Temporary data

Gets removed after File:write() attempt.

## Fields

- 📝 **content** ( string = *nil* )
	`full content of this file`
- 📝 **code** ( string = *nil* )
	`uncommented content of this file`
- 📝 **example** ( string = *nil* )
	`example.lua`
- 📝 **readme** ( string = *nil* )
	`dirname.lua`
- 👨‍👦 **head** ( lib.luapi.file.cache#output )
- 👨‍👦 **body** ( lib.luapi.file.cache#output )
- 👨‍👦 **foot** ( lib.luapi.file.cache#output )
- 📝 **escaped_reqpath** ( string )
- 💡 **init** ( function )
	`Initialize`

## Locals

- 📦 **output** ( table )
	`Element of output model`
- 💡 **output.add** ( function )
	`Add text to output field`

## Details

### output.add `(function)`

Add text to output field

Arguments:

- 👨‍👦 **self** ( lib.luapi.file.cache#output )
- 📝 **text** ( string )

Returns:

- 👨‍👦 **self** ( lib.luapi.file.cache#output )

---

### output `(table)`

Element of output model

Fields:

- 📝 **text** ( string )
- 👨‍👦 **add** ( lib.luapi.file.cache#output.add )

---

### init `(function)`

Initialize

Arguments:

- 👨‍👦 **file** ( lib.luapi.file )
