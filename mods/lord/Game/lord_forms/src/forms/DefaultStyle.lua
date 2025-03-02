local config = require('forms.DefaultStyle.config')


--- @class forms.DefaultStyle
local DefaultStyle = {}

--- @param name string element name.
--- @return minetest.FormSpec.Style
function DefaultStyle.get(name)
	return config.elements[name]
end

--- @param name  string element name.
--- @param style minetest.FormSpec.Style
--- @return forms.DefaultStyle
function DefaultStyle.set(name, style)
	config.elements[name] = style

	return DefaultStyle
end

--- @param name string  style directive (`bgcolor`, `listcolors`,..).
--- @param raw  boolean whether to return table (not unpacked into `...`). Default `false`.
--- @return any|table params or table of params; you can use it as `spec.bgcolor( params )`.
function DefaultStyle.get_params_for(name, raw)
	raw = raw == nil and false

	if raw then
		return config.params[name]
	else
		return unpack(config.params[name])
	end
end

--- Returns `pairs()` of styles for elements or `pairs()` of params for style directives (`bgcolor`, `listcolors`,..).
---
--- @generic style: minetest.FormSpec.Style
--- @generic params: table
---
--- @param name string list name: `"elements"` or `"params"`. Default: `"elements"`.
---
--- @return fun(tbl: table<string,style>):string,style|fun(tbl: table<string,params>):string,params
function DefaultStyle.list(name)
	name = name or 'elements'
	assert(name:is_one_of({ 'elements', 'params' }))

	return pairs(config[name])
end


return DefaultStyle
