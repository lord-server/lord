--- @type string
local DS = os.DIRECTORY_SEPARATOR

--- @param sub_folder string
--- @return string
function minetest.get_mod_textures_folder(sub_folder)
	sub_folder = sub_folder and (sub_folder .. DS) or ""
	local mod_path = minetest.get_modpath(minetest.get_current_modname())
	return mod_path .. DS .. "textures" .. DS .. sub_folder
end

