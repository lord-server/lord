local require_module = require("require")

--- @type string
local DS = os.DIRECTORY_SEPARATOR
local debug_mode = minetest.settings:get_bool("debug", false)

--- @param sub_folder string
--- @return string
function minetest.get_mod_textures_folder(sub_folder)
	sub_folder = sub_folder and (sub_folder .. DS) or ""
	local mod_path = minetest.get_modpath(minetest.get_current_modname())
	return mod_path .. DS .. "textures" .. DS .. sub_folder
end

minetest.get_mod_require = require_module.get_mod_require

--- @class minetest.Mod
--- @field name    string           name of mod
--- @field path    string           path of mad
--- @field require fun(name:string) require function for mod

--- @param mod_init_function fun(mod:minetest.Mod)
function minetest.mod(mod_init_function)
	local mod_name = minetest.get_current_modname()
	local mod_path = minetest.get_modpath(mod_name)
	local mod_debug = minetest.settings:get_bool(mod_name .. ".debug", debug_mode)

	local old_require = require
	require = minetest.get_mod_require(mod_name, mod_path)

	mod_init_function({
		name    = mod_name,
		path    = mod_path,
		debug   = mod_debug,
		require = require,
	})

	require = old_require

	if debug_mode then
		minetest.log(string.format("Mod loaded: [%s]", mod_name))
	end
end
