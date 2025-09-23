--- @diagnostic disable: missing-return


--- Get the hypotenuse of a triangle with legs x and y. Useful for distance calculation.
---
--- @param x number
--- @param y number
---
--- @return number
function math.hypot(x, y) end

--- Get the sign of given number `x`.
--- - returns `-1`, `0` or `1`
--- - if the absolute value of x is within the tolerance or x is NaN, 0 is returned.
---
--- @param x          number
--- @param tolerance? number default: `0.0`
---
--- @return number
function math.sign(x, tolerance) end

--- Returns the factorial of `x`.
---
--- @param x number
---
--- @return number
function math.factorial(x) end

--- Returns x rounded to the nearest integer.
--- - At a multiple of 0.5, rounds away from zero.
---
--- @param x number
---
--- @return number
function math.round(x) end
