local ARMOR_EQUIPMENT_SIZE = 5
equipment.Kind.ARMOR       = "armor"

return {
	init = function()
		equipment.Kind.register(equipment.Kind.ARMOR, ARMOR_EQUIPMENT_SIZE)
	end
}
