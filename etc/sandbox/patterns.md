# Lua patterns cheatsheet

## Find and replace functions

+ string.sub    returns the part at the specified positions
+ string.gsub   replaces all occurrences according to the pattern
+ string.find   finds the first match with the pattern and returns the positions
+ string.match  finds the first match with the pattern and returns the result(s)
+ string.gmatch returns an iterator function to loop through the pattern
+ string.format inserts arguments into itself

## Special characters

There are a bunch of special characters that either escape other characters, or
modify the pattern in some way.

These characters are:

    ^ $ ( ) % . [ ] * + - ?

They can also be used in the pattern as normal characters by prefixing them with
a "%" character, so "%%" becomes "%", "%[" becomes "[", etc.

## Character classes

Character classes represent a set of characters. They can be either predefined
sets or custom sets that can consist of the same predefined sets, ranges or any
single characters.

Available character classes (custom and predefined):

| Class  | Description                                                         |
| ------ | ------------------------------------------------------------------- |
|   .    | any character                                                       |
|   %a   | all letters (from a to z upper and lower case)                      |
|   %c   | all control characters (special characters "\t", "\n", etc.)        |
|   %d   | all digits (from 0 to 9)                                            |
|   %g   | all printable characters except space (same as '[\x21-\x7E]')       |
|   %l   | all lowercase letters (any letter that is lower case)               |
|   %p   | all punctuation characters (".", ",", etc.)                         |
|   %s   | all space characters (a normal space, tab, etc.)                    |
|   %u   | all uppercase letters (any letter that is upper case)               |
|   %w   | all alphanumeric characters (all letters and numbers)               |
|   %x   | all hexadecimal digits (digits 0-9, letters a-f, and letters A-F)   |
|   %z   | the character with representation 0 (the null character "\0")       |
| %char  | escapes a character if it doesn't represent any class (e.g. `%[(%d)%]` matches a digit inside of brackets) |
| [set]  | represents all characters in `set` as a union. You can see this used in the previous section. `[%w_]` will match any letter, digit and an  underscore |
| [^set] | represents the opposite of the union `set`, so `[^%w_]` matches everything that is not a letter, digit or underscore |

+ An upper case version of a predefined character set will represent the
  opposite of that set, so `%A` will match anything that is not a letter,
+ The starting and ending points of a range are separated with a hyphen "-",
  so `0-5` will match a digit from zero to five, `a-c` will match a, b or c.

### Repetition and anchoring

Characters in a string match a pattern in the following ways:

+ a single class will match a single character,
+ a single class followed by "+" will match one or more repetitions of
  characters and will match the longest sequence,
+ a single class followed by "-" will match zero or more repetitions of
  characters and will match the shortest sequence,
+ a single class followed by "*" will match zero or more repetitions of
  characters and will match the longest sequence,
+ a single class followed by "?" will match one or zero characters,
+ %n (where `n` is a digit between 1 and 9) will match the `n`th capture,
+ %bxy will match strings that start with `x` and end with `y`, "%b()" will
  match a string that starts with "(" and ends with ")",
+ %f[`set`] matches an empty string at any position such that the next character
  %belongs to `set` and the previous character does not belong to `set`.
  The beginning %and the end of the subject are handled as if they were the
  character `\0`.

## Captures

Patterns can also contain sub-patterns enclosed in "()". Captures are used in
functions like string.match and string.gsub to return or substitute a specific
match from the pattern. Examples on how to use these can be found below.
