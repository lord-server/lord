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

--- @class minetest.Mod
--- @field name string name of mod
--- @field path string path of mad

--- @param mod_init_function fun(mod:minetest.Mod)
function minetest.mod(mod_init_function)
	local mod_name = minetest.get_current_modname()
	local mod_path = minetest.get_modpath(mod_name)

	mod_init_function({
		name = mod_name,
		path = mod_path,
	})

	if debug_mode then
		minetest.log("info", string.format("Mod loaded: [%s]", mod_name))
	end
end
