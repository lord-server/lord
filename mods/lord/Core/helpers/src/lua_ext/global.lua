

--- Terminates the last protected function called and returns `message` as the
--- error object. Function `errorf` never returns. Usually, `errorf` adds some
--- information about the error position at the beginning of the message, if the
--- message is a string.
---@param message string format string for `string.format()`
function errorf(message, ...)  -- luacheck: ignore unused global variable errorf
	error(string.format(message, ...), 2)
end

--- Terminates the last protected function called and returns `message` as the
--- error object. Function `error` never returns. Usually, `error` adds some
--- information about the error position at the beginning of the message, if the
--- message is a string. The `level` argument specifies how to get the error
--- position. With level 1 (the default), the error position is where the
--- `error` function was called. Level 2 points the error to where the function
--- that called `error` was called; and so on. Passing a level 0 avoids the
--- addition of error position information to the message.
---@param message string  format string for `string.format()`
---@param level   number  traceback depth
function errorlf(message, level, ...)  -- luacheck: ignore unused global variable errorlf
	error(string.format(message, ...), level)
end

--- Calls errorf if the value of its argument `v` is false (i.e., **nil** or **false**)
--- @param v any
--- @param message string format string for `string.format()`
function assertf(v, message, ...)  -- luacheck: ignore unused global variable assertf
	if not v then
		errorlf(message, 2, ...)
	end
end
