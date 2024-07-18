local package_loaded, dofile
	= package.loaded, dofile

if not package_loaded then
	package_loaded = {}
	package.loaded = package_loaded
end

local DS = os.DIRECTORY_SEPARATOR
local mod_requires = {}


local function create_require_for_mod(mod_name, mod_path)
	--- @param name string
	--- @return any
	return function(name)
		local full_name = mod_name .. ".." .. name

		local module = package_loaded[full_name]
		if module ~= nil then
			return module
		end

		local result = dofile(mod_path .. DS .. "src" .. DS .. name:gsub("%.", DS) .. ".lua")

		if result ~= nil then
			package_loaded[full_name] = result
		else
			package_loaded[full_name] = true
		end

		return package_loaded[full_name]
	end
end


return {
	--- @param mod_name string
	--- @param mod_path string
	--- @return fun(name:string):any
	get_mod_require = function(mod_name, mod_path)
		mod_name = mod_name or minetest.get_current_modname()
		mod_path = mod_path or minetest.get_modpath(mod_name)

		return mod_requires[mod_name]
			and mod_requires[mod_name]
			or  create_require_for_mod(mod_name, mod_path)
	end
}
