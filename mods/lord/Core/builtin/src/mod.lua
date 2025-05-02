local RequireFactory = require('mod.require')
local LoggerFactory  = require('mod.logger')
local Translator     = require('mod.Translator')
local ModSettings    = require('mod.Settings')

minetest.get_mod_require    = RequireFactory.get_mod_require
minetest.get_mod_logger     = LoggerFactory.get_mod_logger
minetest.get_mod_translator = Translator.get
--- @return Voxrame.mod.Settings
minetest.get_mod_settings   = function(mod_name)
	return ModSettings:new(mod_name)
end


--- @type string
local DS             = os.DIRECTORY_SEPARATOR
local debug_mode     = minetest.settings:get_bool('debug', false)

--- @param sub_folder string
--- @return string
function minetest.get_mod_textures_folder(sub_folder)
	sub_folder     = sub_folder and (sub_folder .. DS) or ''
	local mod_path = minetest.get_modpath(minetest.get_current_modname())

	return mod_path .. DS .. 'textures' .. DS .. sub_folder
end


--- @class minetest.Mod
--- @field name       string                       name of the mod
--- @field path       string                       path of the mad
--- @field debug      boolean                      whether debug mode is enabled for this mod
--- @field require    fun(name:string)             require function for the mod
--- @field translator fun(str: string, ...):string translator for this mod
--- @field logger     helpers.Logger               lazy loaded logger instance for this mod
--- @field settings   Voxrame.mod.Settings         lazy loaded settings for this mod

--- @param mod_init_function fun(mod:minetest.Mod)
function minetest.mod(mod_init_function)
	local mod_name     = minetest.get_current_modname()
	local mod_path     = minetest.get_modpath(mod_name)
	local mod_debug    = minetest.settings:get_bool(mod_name .. '.debug', debug_mode)

	local old_require = require
	require = minetest.get_mod_require(mod_name, mod_path)

	mod_init_function(setmetatable(
		{
			name       = mod_name,
			path       = mod_path,
			debug      = mod_debug,
			require    = require,
			translator = Translator.get()
		}, {
			-- Lazy Loading
			__index = function(self, key)
				if key == 'logger' then
					self.logger = LoggerFactory.get_mod_logger(mod_name)

					return self.logger
				elseif key == 'settings' then
					self.settings = ModSettings:new(mod_name)

					return self.settings
				end

				return self[key]
			end
		}
	))

	require = old_require

	if debug_mode then
		minetest.log(string.format('Mod loaded: [%s]', mod_name))
	end
end
