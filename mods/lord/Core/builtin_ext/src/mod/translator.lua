
--- @overload fun():fun(str: string, ...):string
--- @param mod_name string|nil
--- @return fun(str: string, ...):string
function minetest.get_mod_translator(mod_name)
	return minetest.get_translator(mod_name or minetest.get_current_modname())
end


return {
	get = minetest.get_mod_translator
}
