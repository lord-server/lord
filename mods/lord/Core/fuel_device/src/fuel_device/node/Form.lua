

--- @class fuel_device.node.Form
local Form = {
	--- Returns form specification for Fuel Device.
	---
	--- @abstract
	--- @param type         string one of 'active'|'inactive' strings
	--- @param percent      number|nil pass only for active grinder
	--- @param item_percent number|nil pass only for active grinder
	---
	--- @return string form specification
	get_spec = function(type, percent, item_percent)
		error('You need to override method `:get_spec()`')
	end
}


return Form
