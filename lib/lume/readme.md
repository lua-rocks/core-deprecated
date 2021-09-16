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
+ 💡 **[extend][@>extend]** ( function )
	`Copies all the fields from the source tables to the table t`
+ 💡 **split** ( function )
+ 💡 **[each][@>each]** ( function )
	`Does somthing with each table value`
+ 💡 **[all][@>all]** ( function )
	`Returns true if all the values in table are true`
+ 💡 **set** ( function )
+ 💡 **wordwrap** ( function )
+ 💡 **slice** ( function )
+ 💡 **[round][@>round]** ( function )
	`Rounds x to the nearest integer`
+ 💡 **reduce** ( function )
+ 💡 **ripairs** ( function )
+ 💡 **pick** ( function )
+ 💡 **[sort][@>sort]** ( function )
	`Returns a copy of the array t with all its items sorted`
+ 💡 **trace** ( function )
+ 💡 **[pingpong][@>pingpong]** ( function )
	`Ping-pongs the number x between 0 and 1`
+ 💡 **[shuffle][@>shuffle]** ( function )
	`Returns a shuffled copy of the array t`
+ 💡 **[array][@>array]** ( function )
	`Iterates the supplied iterator and returns an array filled with the values`
+ 💡 **[map][@>map]** ( function )
	`Applies the function fn to each value in table t`
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
	`Returns a "weighted" value from list t`
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
+ 💡 **[remove][@>remove]** ( function )
	`Removes the first instance of the value x if it exists in the table t`
+ 💡 **hotswap** ( function )
+ 💡 **trim** ( function )
+ 💡 **count** ( function )
+ 💡 **[clear][@>clear]** ( function )
	`Nils all the values in the table t, this renders the table empty`
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

### extend `(function)`

Copies all the fields from the source tables to the table t.

> If a key exists in multiple tables the right-most table's value is used.
>
> ```lua
> local t = { a = 1, b = 2 }
> lume.extend(t, { b = 4, c = 6 }) -- `t` becomes { a = 1, b = 4, c = 6 }
> ```

Arguments:

+ 📦 **t** ( table )
+ 📦 **...** ( table )

Returns:

+ 📦 **t** ( table )

---

### each `(function)`

Does somthing with each table value.

> Iterates the table `t` and calls the function `fn` on each value followed by
> the supplied additional arguments; if `fn` is a string the method of that name
> is called for each value. The function returns `t` unmodified.
>
> ```lua
> lume.each({1, 2, 3}, print) -- Prints "1", "2", "3" on separate lines
> lume.each({a, b, c}, "move", 10, 20) -- Does x:move(10, 20) on each value
> ```

Arguments:

+ 📦 **t** ( table )
+ 👽 **fn** ( function|string )
+ ❓ _..._ ( any = *nil* )

Returns:

+ 📦 **t** ( table )

---

### pingpong `(function)`

Ping-pongs the number x between 0 and 1.

Arguments:

+ 🧮 **x** ( number )

Returns:

+ 🧮 **x** ( number )

---

### array `(function)`

Iterates the supplied iterator and returns an array filled with the values.

> ```lua
> lume.array(string.gmatch("Hello world", "%a+")) -- Returns {"Hello", "world"}
> ```

Arguments:

+ ❓ **...** ( any )

Returns:

+ 📜 **array** ( array )

---

### map `(function)`

Applies the function fn to each value in table t.

> Returns a new table with the resulting values.
>
> ```lua
> lume.map({1, 2, 3}, function(x) return x * 2 end) -- Returns {2, 4, 6}
> ```

Arguments:

+ 📦 **t** ( table )
+ 💡 **fn** ( function )

Returns:

+ 📦 **map** ( table )

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

Returns a "weighted" value from list t.

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

### clear `(function)`

Nils all the values in the table t, this renders the table empty.

> ```lua
> local t = { 1, 2, 3 }
> lume.clear(t) -- `t` becomes {}
> ```

Arguments:

+ 📦 **t** ( table )

Returns:

+ 📦 **t** ( table )

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

### shuffle `(function)`

Returns a shuffled copy of the array t.

Arguments:

+ 📦 **t** ( table )

Returns:

+ 📦 **shuffled** ( table )

---

### sort `(function)`

Returns a copy of the array t with all its items sorted.

> If `comp` is a function it will be used to compare the items when sorting. If
> `comp` is a string it will be used as the key to sort the items by.
>
> ```lua
> lume.sort({ 1, 4, 3, 2, 5 }) -- Returns { 1, 2, 3, 4, 5 }
> lume.sort({ {z=2}, {z=3}, {z=1} }, "z") -- Returns { {z=1}, {z=2}, {z=3} }
> lume.sort({ 1, 3, 2 }, function(a, b) return a > b end) -- Returns { 3, 2, 1 }
> ```

Arguments:

+ 📦 **t** ( table )
+ 👽 **comp** ( function|string )

Returns:

+ 📦 **sorted** ( table )

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

### remove `(function)`

Removes the first instance of the value x if it exists in the table t.

> ```lua
> local t = { 1, 2, 3 }
> lume.remove(t, 2) -- `t` becomes { 1, 3 }
> ```

Arguments:

+ 📦 **t** ( table )
+ ❓ **x** ( any )

Returns:

+ ❓ **x** ( any )

---

### all `(function)`

Returns true if all the values in table are true.

> If a `fn` function is supplied it is called on each value, true is returned if
> all of the calls to `fn` return true.
>
> ```lua
> lume.all({1, 2, 1}, function(x) return x == 1 end) -- Returns false
> ```

Arguments:

+ 📦 **t** ( table )
+ 💡 _fn_ ( function = *nil* )

Returns:

+ 🔌 **result** ( boolean )

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

[@>lerp]: #lerp-function
[@>isarray]: #isarray-function
[@>map]: #map-function
[@>sign]: #sign-function
[@>remove]: #remove-function
[@>extend]: #extend-function
[@>clear]: #clear-function
[@>smooth]: #smooth-function
[@>angle]: #angle-function
[@>each]: #each-function
[@>vector]: #vector-function
[@]: #liblume-table
[@>distance]: #distance-function
[@>weightedchoice]: #weightedchoice-function
[@>shuffle]: #shuffle-function
[@>clamp]: #clamp-function
[@>push]: #push-function
[@>all]: #all-function
[@>sort]: #sort-function
[@>randomchoice]: #randomchoice-function
[@>pingpong]: #pingpong-function
[@>random]: #random-function
[@>round]: #round-function
[@>array]: #array-function
