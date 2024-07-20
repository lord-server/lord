local game   = minetest.get_game_info().title


--- @type helpers.Logger[]
local mod_loggers = {}

--- @static
--- @class helpers.Logger
--- @field error   fun(message:string, ...)
--- @field warning fun(message:string, ...)
--- @field action  fun(message:string, ...)
--- @field info    fun(message:string, ...)
--- @field verbose fun(message:string, ...)

--- @type helpers.Logger
local Logger = {
	prefix = "[" .. game .. "] ",
	__index = function(self, level)
		return function(message, ...)
			minetest.log(level, self.prefix .. string.format(message, ...))
		end
	end
}

--- @param level   string
--- @param message string
function Logger.log(level, message)
	Logger[level](message)
end

--- @static
--- @param result HTTPRequestResult
function Logger.log_api_error(result)
	Logger.error("API call error: [%s] %s", result.code, dump(result))
end

--- @param mod_name string
--- @return helpers.Logger
local function create_logger_for_mod(mod_name)
	return setmetatable({ prefix = "[" .. mod_name .. "] "}, Logger)
end


return {
	--- @param mod_name string
	--- @return helpers.Logger
	get_mod_logger = function(mod_name)
		mod_name = mod_name or minetest.get_current_modname()

		return mod_loggers[mod_name]
			and mod_loggers[mod_name]
			or  create_logger_for_mod(mod_name)
	end
}
