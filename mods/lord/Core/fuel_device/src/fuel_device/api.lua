local Device    = require('fuel_device.Device')
local Processor = require('fuel_device.Processor')
local node      = require('fuel_device.node')


return {
	Device    = Device,
	Processor = Processor,
	register  = node.register,
}
