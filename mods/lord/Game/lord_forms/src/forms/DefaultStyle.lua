local config = require('forms.DefaultStyle.config')


--- @class forms.DefaultStyle
local DefaultStyle = {}

--- @param name string
--- @return minetest.FormSpec.Style
function DefaultStyle.get(name)
	return config[name]
end

--- @param name  string
--- @param style minetest.FormSpec.Style
--- @return forms.DefaultStyle
function DefaultStyle.set(name, style)
	config[name] = style

	return DefaultStyle
end

---@return fun(tbl: table<string, minetest.FormSpec.Style>):string, minetest.FormSpec.Style
function DefaultStyle.list()
	return pairs(config)
end


return DefaultStyle
