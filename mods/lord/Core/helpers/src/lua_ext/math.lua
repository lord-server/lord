local math_min, math_max, math_sqrt
    = math.min, math.max, math.sqrt


--- `math.limit`/`math.clamp` ensures a given number stays within a specified range.
--- If the number is lower than the minimum, the minimum value is returned.
--- If the number is higher than the maximum, the maximum value is returned.
---
--- @param value number
--- @param min   number
--- @param max   number
--- @return number
function math.limit(value, min, max)
	return math_max(min, math_min(max, value))
end

math.clamp = math.limit

--- Just `value > min and value < max` comparison.
--- @param value number
--- @param min   number
--- @param max   number
--- @return boolean
function math.is_within(value, min, max)
	return value > min and value < max
end

--- Just `value >= min and value <= max` comparison.
--- @param value number
--- @param min   number
--- @param max   number
--- @return boolean
function math.is_among(value, min, max)
	return value >= min and value <= max
end

--- Just `value > min and value <= max` comparison.
--- @param value number
--- @param min   number
--- @param max   number
--- @return boolean
function math.is_in_range(value, min, max)
	return value > min and value <= max
end

---
--- @param value number
--- @param near  number
--- @param gap   number
function math.is_near(value, near, gap)
	gap = gap or 1

	return value >= near - gap and value <= near + gap
end

--- Solves the quadratic equation `ax^2 + bx + c = 0`.
--- Returns two roots or `nil` if no real roots.
--- The first root is larger, the second is smaller.
--- Roots can be equal.
--- @param a number
--- @param b number
--- @param c number
--- @return number|nil,number|nil
function math.quadratic_equation_roots(a, b, c)
	local discriminant = b^2 - 4 * a * c
	if discriminant < 0 then
		return nil, nil
	end

	local sqrt_discriminant = math_sqrt(discriminant)

	return
		(-b + sqrt_discriminant) / (2 * a),
		(-b - sqrt_discriminant) / (2 * a)
end
