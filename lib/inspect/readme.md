# lib.inspect `(function)`

## Any lua variable inspector

Returns any lua variable in human-readable format.

## Arguments

- ❓ **variable** ( any )
- 👨‍👦 _options_ ( lib.inspect#options = *nil* )

## Returns

- 📝 **result** ( string )

## Locals

- 📦 **options** ( table )

## Details

### options `(table)`

Fields:

- 🧮 _depth_ ( integer = *nil* )
	`sets the maximum depth that will be printed out`
- 📝 _newline_ ( string = *"\n"* )
	`add a newline each level of a table`
- 📝 _indent_ ( string = *2 spaces* )
	`add an indent each level of a table`
