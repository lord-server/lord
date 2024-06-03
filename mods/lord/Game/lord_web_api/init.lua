local DS          = os.DIRECTORY_SEPARATOR
local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. DS .. "src" .. DS .. name:gsub("%.", DS) .. ".lua") end


if not rawget(_G, "http") then
	minetest.log(
		"warning",
		"Can't initialize `lord_web_api`: Global variable `http` not found: mod `http` not loaded or not initialized."
	)
	return
end
require("web_api").init()


require = old_require
