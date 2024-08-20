local math_min, math_max
    = math.min, math.max


--- `math.limit`/`math.clamp` ensures a given number stays within a specified range.
--- If the number is lower than the minimum, the minimum value is returned.
--- If the number is higher than the maximum, the maximum value is returned.
---
--- @param value number
--- @param min   number
--- @param max   number
function math.limit(value, min, max)
	return math_max(min, math_min(max, value))
end

math.clamp = math.limit
