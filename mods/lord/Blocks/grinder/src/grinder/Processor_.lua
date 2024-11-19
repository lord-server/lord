local Grinder = require('grinder.Grinder_')


---
--- @class Processor: fuel_device.Processor
---
local Processor = fuel_device.Processor:extended({
	--- @static
	--- @type fuel_device.Device
	DeviceClass = Grinder,
	--- @static
	--- @type string
	craft_method = minetest.CraftMethod.GRINDER,
})


return Processor
