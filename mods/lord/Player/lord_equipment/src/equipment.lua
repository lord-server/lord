local math_random
    = math.random

local SL = minetest.get_translator("lord_equipment")

local CLOTHING_EQUIPMENT_SIZE = 5
local ARMOR_EQUIPMENT_SIZE    = 5


--- @param stack     ItemStack
--- @param player    Player
local function item_wear(stack, slot, player)
	local use = stack:get_definition().groups["armor_use"] or 0
	stack:add_wear(use)

	local armor_inv = minetest.get_inventory({type="detached", name = player:get_player_name().."_armor"})
	if stack:get_count() == 0 then
		local desc = minetest.registered_items[stack:get_name()].description
		if desc then
			minetest.chat_send_player(player:get_player_name(), desc.." "..SL("got destroyed!"))
		end
		armor_inv:set_stack("armor", slot, nil)
		equipment.for_player(player):delete(equipment.Kind.ARMOR, slot)
	else
		armor_inv:set_stack("armor", slot, stack)
		equipment.for_player(player):set(equipment.Kind.ARMOR, slot, stack)
	end
end

local function handle_armor_wear(player)
	for slot, stack in equipment.for_player(player):not_empty(equipment.Kind.ARMOR) do
		-- chance that the hit landed on this slot (on this element of the armor)
		if math_random(2) == 1 then
			item_wear(stack, slot, player)
			break -- the hit could get only one element of the armor
		end
	end
end


return {
	init = function()
		equipment.Kind.ARMOR    = "armor"
		equipment.Kind.CLOTHING = "clothing"
		equipment.Kind.register(equipment.Kind.ARMOR,    ARMOR_EQUIPMENT_SIZE)
		equipment.Kind.register(equipment.Kind.CLOTHING, CLOTHING_EQUIPMENT_SIZE)
		minetest.register_on_punchplayer(handle_armor_wear)
	end
}
