local CLOTHING_EQUIPMENT_SIZE = 5
equipment.Kind.CLOTHING       = "clothing"

return {
	init = function()
		equipment.Kind.register(equipment.Kind.CLOTHING, CLOTHING_EQUIPMENT_SIZE)
	end
}
