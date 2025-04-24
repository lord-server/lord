
--- @class Voxrame.mod.Translator
local Translator = {}

--- @static
--- @overload fun():fun(str: string, ...):string
--- @param mod_name string|nil
--- @return fun(str: string, ...):string
function Translator.get(mod_name)
	return minetest.get_translator(mod_name or minetest.get_current_modname())
end


return Translator
