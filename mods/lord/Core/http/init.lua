local DS          = os.DIRECTORY_SEPARATOR
local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. DS .. "src" .. DS .. name:gsub("%.", DS) .. ".lua") end


local http_api = minetest.request_http_api()
if not http_api then
	minetest.log("error", "You should add mod `http` into `secure.http_mods` setting in your `minetest.conf`.")
	return
end
require("http").init(http_api)


require = old_require
