# lib.asserts `(function)`

## Multiple assertions

Tests all its arguments through the first one, similar to `assert`.
The first argument must be a function, through which the rest are passed.
This function takes one argument and returns any number.
If it returns nil or false, the test will be considered to have failed.
The test will also fail if an error occurs during the test.

## Arguments

- 👽 _f_ ( function|string = *nil* )
- ❓ _..._ ( any = *nil* )

## Returns

- 👽 _f_ ( function|string = *nil* )
- ❓ _..._ ( any = *nil* )
