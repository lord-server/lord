local S    = minetest.get_mod_translator()
local form = require('grinder.definition.node.form')


---
--- @class Grinder: fuel_device.Device
---
local Grinder = fuel_device.Device:extended({
	--- @static
	--- @type string
	NAME       = S('Grinder'),
	--- @static
	---
	form       = form,
	--- @static
	--- @type {inactive:string,active:string}
	node_name  = {
		inactive = 'grinder:grinder',
		active   = 'grinder:grinder_active',
	},
})


return Grinder
