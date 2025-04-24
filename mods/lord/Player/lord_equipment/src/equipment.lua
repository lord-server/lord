local math_random
    = math.random

local detached_inv_equipment_slots = {
	armor    = require("equipment.armor_slots"),
	clothing = require("equipment.clothing_slots"),
}
local S = minetest.get_mod_translator()


local CLOTHING_EQUIPMENT_SIZE = 5
local ARMOR_EQUIPMENT_SIZE    = 5


local function register_equipments()
	equipment.Kind.ARMOR    = "armor"
	equipment.Kind.CLOTHING = "clothing"
	equipment.Kind.register(equipment.Kind.ARMOR,    ARMOR_EQUIPMENT_SIZE)
	equipment.Kind.register(equipment.Kind.CLOTHING, CLOTHING_EQUIPMENT_SIZE)
end

--- @param stack     ItemStack
--- @param player    Player
local function item_wear(stack, slot, player)
	local use = stack:get_definition().groups["armor_use"] or 0
	stack:add_wear(use)

	local armor_inv = minetest.get_inventory({type="detached", name = player:get_player_name().."_armor"})
	if stack:get_count() == 0 then
		local desc = minetest.registered_items[stack:get_name()].description
		if desc then
			minetest.chat_send_player(player:get_player_name(), desc.." ".. S("got destroyed!"))
		end
		armor_inv:set_stack("armor", slot, nil)
		equipment.for_player(player):delete(equipment.Kind.ARMOR, slot)
	else
		armor_inv:set_stack("armor", slot, stack)
		equipment.for_player(player):set(equipment.Kind.ARMOR, slot, stack)
	end
end

--- @param player Player
local function handle_armor_wear(player)
	for slot, stack in equipment.for_player(player):not_empty(equipment.Kind.ARMOR) do
		-- chance that the hit landed on this slot (on this element of the armor)
		if math_random(2) == 1 then
			item_wear(stack, slot, player)
			break -- the hit could get only one element of the armor
		end
	end
end

--- @param player Player
--- @param kind   string
--- @param event  string
local function register_detached_slots(player, kind, event)
	local player_name = player:get_player_name()
	local equip_inv   = minetest.create_detached_inventory(
		equipment.get_inventory_name(player_name, kind), detached_inv_equipment_slots[kind], player_name
	)
	equip_inv:set_size(kind, equipment.Kind.get_size(kind))
	for slot, item in equipment.for_player(player):items(kind) do
		equip_inv:set_stack(kind, slot, item)
	end
end


return {
	init = function()
		-- When server starts we register which kind of equipment LORD have
		register_equipments()

		--- @param player_name string
		equipment.get_inventory_name = function(player_name, kind)
			return player_name .. "_" .. kind
		end

		-- When *any* equipment (armor and clothing) loaded (when player joined),
		-- we need to:
		--   - create detached inventories for each equipment (armor&clothing)
		--       to use it on form of main player inventory
		--   - fill each inventory with equipment items
		equipment.on_load(register_detached_slots)

		minetest.register_on_punchplayer(handle_armor_wear)
	end
}
