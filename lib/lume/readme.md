# lib.lume `(table)`

## Lume

A collection of functions for Lua, geared towards game development.

## Fields

+ 💡 **merge** ( function )
+ 💡 **format** ( function )
+ 💡 **invert** ( function )
+ 💡 **[lerp][@>lerp]** ( function )
	`Returns the linearly interpolated number between a and b`
+ 💡 **lambda** ( function )
+ 💡 **first** ( function )
+ 💡 **match** ( function )
+ 💡 **[smooth][@>smooth]** ( function )
	`Similar to @>lerp but uses cubic interpolation instead of linear`
+ 💡 **concat** ( function )
+ 💡 **[distance][@>distance]** ( function )
	`Returns the distance between the two points`
+ 💡 **time** ( function )
+ 💡 **[push][@>push]** ( function )
	`Pushes all the given values to the end of the table t`
+ 💡 **extend** ( function )
+ 💡 **split** ( function )
+ 💡 **each** ( function )
+ 💡 **all** ( function )
+ 💡 **set** ( function )
+ 💡 **wordwrap** ( function )
+ 💡 **slice** ( function )
+ 💡 **[round][@>round]** ( function )
	`Rounds x to the nearest integer`
+ 💡 **reduce** ( function )
+ 💡 **ripairs** ( function )
+ 💡 **pick** ( function )
+ 💡 **sort** ( function )
+ 💡 **trace** ( function )
+ 💡 **[pingpong][@>pingpong]** ( function )
	`Ping-pongs the number x between 0 and 1`
+ 💡 **shuffle** ( function )
+ 💡 **array** ( function )
+ 💡 **map** ( function )
+ 💡 **[random][@>random]** ( function )
	`Returns a random number between a and b`
+ 💡 **find** ( function )
+ 💡 **[sign][@>sign]** ( function )
	`Returns 1 if x is 0 or above, returns -1 when x is negative`
+ 💡 **color** ( function )
+ 💡 **[randomchoice][@>randomchoice]** ( function )
	`Returns a random value from list t`
+ 💡 **clone** ( function )
+ 💡 **uuid** ( function )
+ 💡 **[clamp][@>clamp]** ( function )
	`Returns the number x clamped between the numbers min and max`
+ 💡 **memoize** ( function )
+ 💡 **[isarray][@>isarray]** ( function )
	`Returns true if x is an array`
+ 💡 **reject** ( function )
+ 💡 **deserialize** ( function )
+ 💡 **once** ( function )
+ 💡 **combine** ( function )
+ 💡 **chain** ( function )
+ 💡 **last** ( function )
+ 💡 **[weightedchoice][@>weightedchoice]** ( function )
+ 💡 **[angle][@>angle]** ( function )
	`Returns the angle between the two points`
+ 💡 **keys** ( function )
+ 💡 **rgba** ( function )
+ 💡 **fn** ( function )
+ 💡 **[vector][@>vector]** ( function )
	`Given an angle and magnitude, returns a vector`
+ 💡 **dostring** ( function )
+ 💡 **call** ( function )
+ 💡 **filter** ( function )
+ 💡 **any** ( function )
+ 💡 **remove** ( function )
+ 💡 **hotswap** ( function )
+ 💡 **trim** ( function )
+ 💡 **count** ( function )
+ 💡 **clear** ( function )
+ 💡 **serialize** ( function )

## Details

### sign `(function)`

Returns 1 if x is 0 or above, returns -1 when x is negative.

Arguments:

+ 🧮 **x** ( number )

Returns:

+ 🧮 **sign** ( integer )

---

### lerp `(function)`

Returns the linearly interpolated number between a and b.

> `amount` should be in the range of 0 - 1; if `amount` is outside of this range
> it is clamped.
>
> ```lua
> lume.lerp(100, 200, .5) -- Returns 150
> ```

Arguments:

+ 🧮 **a** ( number )
+ 🧮 **b** ( number )
+ 🧮 **amount** ( number )

Returns:

+ 🧮 **interpolated** ( number )

---

### distance `(function)`

Returns the distance between the two points.

> If `squared` is true then the squared distance is returned.
> This is faster to calculate and can still be used when comparing distances.

Arguments:

+ 🧮 **x1** ( number )
+ 🧮 **y1** ( number )
+ 🧮 **x2** ( number )
+ 🧮 **y2** ( number )
+ 🔌 _squared_ ( boolean = *nil* )

Returns:

+ 🧮 **distance** ( number )

---

### pingpong `(function)`

Ping-pongs the number x between 0 and 1.

Arguments:

+ 🧮 **x** ( number )

Returns:

+ 🧮 **x** ( number )

---

### randomchoice `(function)`

Returns a random value from list t.

> If the list is empty an error is raised.
>
> ```lua
> lume.randomchoice({true, false}) -- Returns either true or false
> ```

Arguments:

+ 📜 **t** ( list )

Returns:

+ ❓ **value** ( any )

---

### vector `(function)`

Given an angle and magnitude, returns a vector.

> ```lua
> local x, y = lume.vector(0, 10) -- Returns 10, 0
> ```

Arguments:

+ 🧮 **angle** ( number )
+ 🧮 **magnitude** ( number )

Returns:

+ 🧮 **x** ( number )
+ 🧮 **y** ( number )

---

### clamp `(function)`

Returns the number x clamped between the numbers min and max.

Arguments:

+ 🧮 **x** ( number )
+ 🧮 **min** ( number )
+ 🧮 **max** ( number )

Returns:

+ 🧮 **clamped** ( number )

---

### isarray `(function)`

Returns true if x is an array.

> The value is assumed to be an array if it is a table which contains a value at
> the index `1`. This function is used internally and can be overridden if you
> wish to use a different method to detect arrays.

Arguments:

+ ❓ **x** ( any )

Returns:

+ 🔌 **isarray** ( boolean )

---

### weightedchoice `(function)`

> Takes the argument table `t` where the keys are the possible choices and the
> value is the choice's weight. A weight should be 0 or above, the larger the
> number the higher the probability of that choice being picked. If the table is
> empty, a weight is below zero or all the weights are 0 then an error is raised.
>
> ```lua
> lume.weightedchoice({ ["cat"] = 10, ["dog"] = 5, ["frog"] = 0 })
> -- Returns either "cat" or "dog" with "cat" being twice as likely to be chosen.
> ```

Arguments:

+ 👨‍👦 **t** ( {any=number,...} )

Returns:

+ ❓ **value** ( any )

---

### angle `(function)`

Returns the angle between the two points.

Arguments:

+ 🧮 **x1** ( number )
+ 🧮 **y1** ( number )
+ 🧮 **x2** ( number )
+ 🧮 **y2** ( number )

Returns:

+ 🧮 **angle** ( number )

---

### random `(function)`

Returns a random number between a and b.

> If only `a` is supplied a number between `0` and `a` is returned. If no
> arguments are supplied a random number between `0` and `1` is returned.

Arguments:

+ 🧮 **a** ( number )
+ 🧮 **b** ( number )

Returns:

+ 🧮 **random** ( number )

---

### round `(function)`

Rounds x to the nearest integer.

> Rounds away from zero if we're midway between two integers. If `increment` is
> set then the number is rounded to the nearest increment.
>
> ```lua
> lume.round(2.3) -- Returns 2
> lume.round(123.4567, .1) -- Returns 123.5
> ```

Arguments:

+ 🧮 **x** ( number )
+ 🧮 _increment_ ( integer = *nil* )

Returns:

+ 🧮 **rounded** ( integer )

---

### push `(function)`

Pushes all the given values to the end of the table t.

> Returns the pushed values. Nil values are ignored.
>
> ```lua
> local t = { 1, 2, 3 }
> lume.push(t, 4, 5) -- `t` becomes { 1, 2, 3, 4, 5 }
> ```

Arguments:

+ 📦 **t** ( table )
+ ❓ **...** ( any )

Returns:

+ ❓ **...** ( any )

---

### smooth `(function)`

Similar to @>lerp but uses cubic interpolation instead of linear.

Arguments:

+ 🧮 **a** ( number )
+ 🧮 **b** ( number )
+ 🧮 **amount** ( number )

Returns:

+ 🧮 **interpolated** ( number )

## Navigation

[Back to top of the document](#liblume-table)

[Back to upper directory](..)

[Back to project root](/../..)

[@>angle]: #angle-function
[@>pingpong]: #pingpong-function
[@>vector]: #vector-function
[@]: #liblume-table
[@>distance]: #distance-function
[@>weightedchoice]: #weightedchoice-function
[@>clamp]: #clamp-function
[@>push]: #push-function
[@>sign]: #sign-function
[@>smooth]: #smooth-function
[@>randomchoice]: #randomchoice-function
[@>isarray]: #isarray-function
[@>random]: #random-function
[@>round]: #round-function
[@>lerp]: #lerp-function
