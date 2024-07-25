

--- Terminates the last protected function called and returns `message` as the
--- error object. Function `errorf` never returns. Usually, `errorf` adds some
--- information about the error position at the beginning of the message, if the
--- message is a string.
---@param message string format string for `string.format()`
function _G.errorf(message, ...)
	error(string.format(message, ...))
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
function _G.errorlf(message, level, ...)
	error(string.format(message, level, ...))
end
