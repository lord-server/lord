local game = minetest.get_game_info().title


--- @type table<string, helpers.Logger>
local mod_loggers = {}

--- @static
--- @class helpers.Logger
--- @field error   fun(message:string, ...)
--- @field warning fun(message:string, ...)
--- @field action  fun(message:string, ...)
--- @field info    fun(message:string, ...)
--- @field verbose fun(message:string, ...)
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

--- @param mod_name string
--- @return helpers.Logger
local function create_logger_for_mod(mod_name)
	return setmetatable({ prefix = "[" .. mod_name .. "] "}, Logger)
end


return {
	--- @param mod_name string?
	--- @return helpers.Logger
	get_mod_logger = function(mod_name)
		mod_name = mod_name or minetest.get_current_modname()

		if mod_loggers[mod_name] then
			return mod_loggers[mod_name]
		end

		mod_loggers[mod_name] = create_logger_for_mod(mod_name)

		return mod_loggers[mod_name]
	end
}
