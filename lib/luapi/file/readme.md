# lib.luapi.file : lib.object `(module)`

## Single lua file

## Fields

+ 📝 **reqpath** ( string )
+ 💡 **[init][@>init]** ( function )
	`Init file but don't read it`
+ 💡 **[read][@>read]** ( function )
	`Read file`
+ 👨‍👦 *cache* ( @.cache = *nil* )
	`Gets removed after File:write() attempt`
+ 💡 **[parse][@>parse]** ( function )
	`Parse file`
+ 💡 **[write][@>write]** ( function )
	`Write @#output to the file and clean up file cache`
+ 💡 **[get_type][@>get_type]** ( function )
	`Try to get access to type in this file by path`
+ 💡 **[cleanup][@>cleanup]** ( function )
	`Remove cache`

## Details

### write `(function)`

Write @#output to the file and clean up file cache.

Arguments:

+ 👨‍👦 **self** ( @ )

Returns:

+ 👨‍👦 **self** ( @ )

---

### get_type `(function)`

Try to get access to type in this file by path.

Arguments:

+ 👨‍👦 **self** ( @ )
+ 📝 **path** ( string )

Returns:

+ 👨‍👦 **result** ( lib.luapi.type|string )

---

### parse `(function)`

Parse file.

Arguments:

+ 👨‍👦 **self** ( @ )

Returns:

+ 👨‍👦 *success* ( @ = *nil* )

---

### init `(function)`

Init file but don't read it.

Arguments:

+ 👨‍👦 **self** ( @ )
+ 📝 **reqpath** ( string )
+ 📝 **fullpath** ( string )
+ 👨‍👦 **conf** ( lib.luapi.conf )

---

### cleanup `(function)`

Remove cache.

Arguments:

+ 👨‍👦 **self** ( @ )

---

### read `(function)`

Read file.

Arguments:

+ 👨‍👦 **self** ( @ )

Returns:

+ 👨‍👦 *success* ( @ = *nil* )

## Navigation

[Back to top of the document](#libluapifile--libobject-module)

[Back to upper directory](..)

[Back to project root](/../..)

[@>write]: #write-function
[@>cleanup]: #cleanup-function
[@]: #libluapifile--libobject-module
[@>parse]: #parse-function
[@>read]: #read-function
[@>init]: #init-function
[@>get_type]: #get_type-function
