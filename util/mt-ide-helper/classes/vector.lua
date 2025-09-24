--- @diagnostic disable: missing-return

--- @class vector: Position
--- @operator eq         : boolean
--- @operator unm        : vector
--- @operator add(vector): vector
--- @operator sub(vector): vector
--- @operator mul(number): vector
--- @operator div(number): vector
vector = {}

--- Creates a new vector `(a, b, c)`.
--- * Deprecated: `vector.new()` does the same as `vector.zero()` and
---   `vector.new(v)` does the same as `vector.copy(v)`
--- @param x  number|Position
--- @param y? number
--- @param z? number
--- @return vector
function vector.new(x, y, z) end

--- Returns a new vector (0, 0, 0).
--- @return vector
function vector.zero() end

--- Returns a new vector of length 1, pointing into a direction chosen uniformly at random.
--- @return vector
function vector.random_direction() end

--- Returns a copy of the vector.
--- @return vector
function vector:copy() end

--- Returns `v, np`, where `v` is a vector read from the given string `s` and
---   `np` is the next position in the string after the vector.
--- Returns `nil` on failure.
--- `str`: Has to begin with a substring of the form `"(x, y, z)"`. Additional
---        spaces, leaving away commas and adding an additional comma to the end
---        is allowed.
--- `from_position`: If given starts looking for the vector at this string index.
---
--- @param str string
--- @param from_position? integer # If given starts looking for the vector at this string index
--- @return vector?, integer
function vector.from_string(str, from_position) end

--- Returns a string of the form `"(x, y, z)"`.
---  `tostring(v)` does the same.
--- @return string
function vector:to_string() end
--- Returns a string of the form `"(x, y, z)"`.
--- @deprecated Use `vector:to_string()` instead.
--- @return string
function vector:tostring() end

--- Returns a vector of length 1 with direction `p1` to `p2`.
--- If `p1` and `p2` are identical, returns `(0, 0, 0)`.
--- @param p1 Position
--- @param p2 Position
--- @return vector
function vector.direction(p1, p2) end

--- Returns the distance between `p1` and `p2`.
--- @param p1 Position
--- @param p2 Position
--- @return number # Returns zero or a positive number, the distance between `p1` and `p2`.
function vector.distance(p1, p2) end

--- Returns the length of the vector.
--- @return number # Returns zero or a positive number, the length of the vector.
function vector:length() end

--- - Returns a normalized copy of the vector.
---   *(Returns a vector of length 1 with direction of vector).*
--- - If vector has zero length, returns (0, 0, 0).
--- @return vector
function vector:normalize() end

--- Returns a vector, each dimension rounded down.
--- @return vector
function vector:floor() end

--- Returns a vector, each dimension rounded up.
--- @return vector
function vector:ceil() end

--- Returns a vector, each dimension rounded to the nearest integer.
--- At a multiple of 0.5, rounds away from zero.
--- @return vector
function vector:round() end

--- Returns a vector where `math.sign` was called for each component.
--- See [Helper functions](https://api.luanti.org/helper-functions/) for details.
function vector:sign() end

--- Returns a vector with absolute values for each component.
function vector:abs() end

--- Applies a function to each component of the vector and returns a new vector.
--- Additional arguments are passed to the function.
--- @param func fun(number, ...): number # Function to apply. First argument is the component value.
--- @param ...  any                      # Additional arguments passed to `func`.
--- @return vector # New vector with modified components.
function vector:apply(func, ...) end

--- Returns a vector where the function func has combined both components of v and w for each component.
--- @param v2   vector                      # Second vector to combine with.
--- @param func fun(number, number): number
--- @return vector # New vector with combined components.
function vector:combine(v2, func) end

--- Returns a boolean, true if the vectors are identical.
--- @param other vector
--- @return boolean
function vector:equals(other) end

--- Returns in order minp, maxp vectors of the cuboid defined by `v1`, `v2`.
--- @param v1 vector
--- @param v2 vector
--- @return vector minp, vector maxp
function vector.sort(v1, v2) end

--- Returns the angle between vectors in radians.
--- @param other vector
function vector:angle(other) end

--- Calculates the dot product (скалярное произведение) with another vector.
--- @param other vector
--- @return number
function vector:dot(other) end

--- Calculates the cross product (векторное произведение) with another vector.
--- @param other vector
--- @return vector
function vector:cross(other) end

--- Returns a new vector with the offset applied.
--- *(Returns the sum of the vector and v(x, y, z).)*
--- @param x number
--- @param y number
--- @param z number
--- @return vector
function vector:offset(x, y, z) end

--- - Returns a boolean value indicating whether the vector is a real vector, eg. created by a `vector.*` function.
--- - Returns `false` for anything else, including tables like `{ x = 3, y = 1, z = 4 }`.
--- @return boolean
function vector:check() end

--- Returns a boolean value indicating if `pos` is inside area formed by `min` and `max`.
--- - `min` and `max` are inclusive.
--- - If `min` is bigger than `max` on some axis, function always returns `false`.
--- - You can use `vector.sort` if you have two vectors and don't know which are the minimum and the maximum.
--- @param pos Position
--- @param min Position
--- @param max Position
--- @return boolean
function vector.in_area(pos, min, max) end

--- Returns a random integer position in area formed by `min` and `max`.
--- - `min` and `max` are inclusive.
--- - You can use `vector.sort` if you have two vectors and don't know which are the minimum and the maximum.
--- @param min Position
--- @param max Position
--- @return vector
function vector.random_in_area(min, max) end

--- Returns a vector.
--- - If `x` is a vector: Returns the sum of the vector and `x`.
--- - If `x` is a number: Adds `x` to each component of the vector.
--- @param x vector|number
--- @return vector
function vector:add(x) end

--- Returns a vector.
--- - If `x` is a vector: Returns the difference of the vector and `x`.
--- - If `x` is a number: Subtracts `x` from each component of the vector.
--- @param x vector|number
--- @return vector
function vector:subtract(x) end

--- Returns a scaled vector.
--- - Deprecated: If `scalar` is a vector: Returns the Schur product.
--- @param self   vector
--- @param scalar number|vector
--- @return vector
function vector.multiply(self, scalar) end

--- Returns a scaled vector.
--- - Deprecated: If `scalar` is a vector: Returns the Schur quotient.
--- @param scalar number
--- @return vector
function vector:divide(scalar) end

--- Applies the rotation `rotation` to the vector and returns the result vector.
--- - Uses (extrinsic) Z-X-Y rotation order and is right-handed, consistent with `ObjectRef:set_rotation`.
--- - `vector.rotate(vector.new(0, 0, 1), rotation)` and `vector.rotate(vector.new(0, 1, 0), rotation)`
---    return vectors pointing forward and up relative to an entity's rotation `rotation`.
--- @param rotation vector
--- @return vector
function vector:rotate(rotation) end

--- Rotates the vector around `axis` by `angle` radians according to the right hand rule
---   and returns the result vector.
--- @param axis  vector
--- @param angle number # Angle in radians
--- @return vector
function vector:rotate_around_axis(axis, angle) end

--- Returns a rotation vector for `direction` pointing forward using `up` as the up vector.
--- - If `up` is omitted, the roll of the returned vector defaults to zero.
--- - Otherwise `direction` and `up` need to be vectors in a 90 degree angle to each other.
--- @param direction vector
--- @param up?       vector
--- @return vector
function vector.dir_to_rotation(direction, up) end
