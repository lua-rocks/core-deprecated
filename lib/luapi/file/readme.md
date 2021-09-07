# lib.luapi.file : lib.object `(module)`

## Single lua file

## Fields

- 📝 **reqpath** ( string )
- 📝 **fullpath** ( string )
- 👨‍👦 _module_ ( lib.luapi.type = *nil* )
- 👨‍👦 _cache_ ( @.cache = *nil* )
	`Gets removed after File:write() attempt`
- 💡 **write** ( function )
	`Write @#output to the file and clean up file cache`
- 💡 **read** ( function )
	`Read file`
- 💡 **parse** ( function )
	`Parse file`
- 💡 **init** ( function )
	`Init file but don't read it`
- 💡 **cleanup** ( function )
	`Remove cache`
- 💡 **get_type** ( function )
	`Try to get access to type in this file by path`

## Details

### write `(function)`

Write @#output to the file and clean up file cache

Arguments:

- 👨‍👦 **self** ( @ )

Returns:

- 👨‍👦 **self** ( @ )

---

### get_type `(function)`

Try to get access to type in this file by path

Arguments:

- 👨‍👦 **self** ( @ )
- 📝 **path** ( string )

Returns:

- 👨‍👦 **result** ( lib.luapi.type|string )

---

### parse `(function)`

Parse file

Arguments:

- 👨‍👦 **self** ( @ )

Returns:

- 👨‍👦 _success_ ( @ = *nil* )

---

### init `(function)`

Init file but don't read it

Arguments:

- 👨‍👦 **self** ( @ )
- 📝 **reqpath** ( string )
- 📝 **fullpath** ( string )
- 👨‍👦 **conf** ( lib.luapi.conf )

---

### cleanup `(function)`

Remove cache

Arguments:

- 👨‍👦 **self** ( @ )

---

### read `(function)`

Read file

Arguments:

- 👨‍👦 **self** ( @ )

Returns:

- 👨‍👦 _success_ ( @ = *nil* )

## Navigation

[Back to top of the document](#libluapifile--libobject-module)

[Back to upper directory](..)

[Back to project root](/../..)
