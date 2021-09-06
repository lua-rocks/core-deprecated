# etc.luapi_test.function `(function)`

## Test function

## Arguments

- 🧮 **a** ( number )
	`will be doubled`
- 📝 **b** ( string )
	`will be concatenated with c`
- 📝 **c** ( string )
	`will be concatenated with b`
- 👨‍👦 **extra** ( etc.luapi_test.function#extra )
	`see description below`
- ❓ _..._ ( any = *nil* )
	`will be printed`

## Returns

- 📝 **bc** ( string )
	`concatenated b and c`
- 🧮 **a2** ( number )
	`doubled a`

## Locals

- 📦 **extra** ( table )
	`Extra type`

## Details

### extra `(table)`

Extra type

Fields:

- 📝 **name** ( string = *"Bob"* )
- 🧮 **age** ( number = *12* )
