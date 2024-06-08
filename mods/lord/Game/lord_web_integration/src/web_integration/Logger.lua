
--- @static
--- @class web_integration.Logger
--- @field error   fun(message:string, ...)
--- @field warning fun(message:string, ...)
--- @field action  fun(message:string, ...)
--- @field info    fun(message:string, ...)
--- @field verbose fun(message:string, ...)
local Logger = {
	prefix = "[web-integration] ",
}
setmetatable(Logger, {
	prefix = "[lord] ",
	__index = function(self, level)
		return function(message, ...)
			minetest.log(level, self.prefix .. string.format(message, ...))
		end
	end
})


--- @param level   string
--- @param message string
function Logger.log(level, message)
	Logger[level](message)
end

--- @static
--- @param result HTTPRequestResult
function Logger.log_api_error(result)
	Logger.error(string.format("API call error: [%s] %s", result.code, dump(result)))
end


return Logger
