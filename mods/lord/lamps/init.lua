local S = minetest.get_translator("lamps")

local function register_candle_lamp(material, desc, ingot)
	local upTx = "lamps_candle_lamp_"..material.."_up.png"
	local sideTx = "lamps_candle_lamp_"..material.."_side.png^lamps_light_candle_lamp.png"
	local chainA = "lamps_chain_"..material.."_a.png"
	local chainB = "lamps_chain_"..material.."_b.png"

	-- Лампа-итем.
	minetest.register_craftitem("lamps:"..material.."_item_candle_lamp", {
		description = S(desc.." candle lamp"),
		inventory_image = sideTx,
		on_place = function(itemstack, placer, pointed_thing)
			minetest.item_place_node(itemstack, placer, pointed_thing, 0)
			if pointed_thing.above.y ~= pointed_thing.under.y-1 then
				-- Если блок, который поставил игрок не ниже блока,
				-- который он выделил, то напольная лампа.
				itemstack:set_name("lamps:"..material.."_candle_lamp")
				minetest.item_place_node(itemstack, placer, pointed_thing, 0)
			else
				-- Если блок, который поставил игрок ниже блока,
				-- который он выделил, то потолочная лампа.
				itemstack:set_name("lamps:"..material.."_hanging_candle_lamp")
				minetest.item_place_node(itemstack, placer, pointed_thing, 0)
			end
			itemstack:set_name("lamps:"..material.."_item_candle_lamp")
		return itemstack
		end
	})

	-- Напольная лампа.
	minetest.register_node("lamps:"..material.."_candle_lamp", {
		description = desc.." candle lamp",
		tiles = {
			upTx,
			upTx,
			sideTx},
		use_texture_alpha = "clip",
		groups = {cracky = 2, not_in_creative_inventory = 1},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},
				{-0.1875, -0.4375, -0.1875, 0.1875, 0.0625, 0.1875},
				{-0.25, 0.0625, -0.25, 0.25, 0.125, 0.25},
				{-0.1875, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
				{-0.0625, 0.1875, -0.0625, 0.0625, 0.25, .0625},
			},
		},
		light_source = 10,
		{not_in_creative_inventory = 1, choppy = 2},
		drop = "lamps:"..material.."_item_candle_lamp",
	})

	-- Потолочная лампа.
	minetest.register_node("lamps:"..material.."_hanging_candle_lamp", {
		description = desc.." hanging candle lamp",
		tiles = {
			upTx,
			upTx,
			sideTx.."^"..chainA,
			sideTx.."^"..chainA,
			sideTx.."^"..chainB},
		use_texture_alpha = "clip",
		groups = {cracky = 2, not_in_creative_inventory = 1},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},
				{-0.1875, -0.4375, -0.1875, 0.1875, 0.0625, 0.1875},
				{-0.25, 0.0625, -0.25, 0.25, 0.125, 0.25},
				{-0.1875, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
				{-0.0625, 0.1875, -0.0625, 0.0625, 0.25, .0625},
				{-0.125, 0.25, 0, 0.125, 0.5, 0},
				{0, 0.25, -0.125, 0, 0.5, 0.125}
			},
		},
		light_source = 10,
		drop = "lamps:"..material.."_item_candle_lamp",
	})

	minetest.register_craft({
	output = "lamps:"..material.."_item_candle_lamp",
	recipe = {
		{"", ingot, ""},
		{"default:glass", "lord_homedecor:candle", "default:glass"},
		{"", ingot, ""}},
	})
end

register_candle_lamp("gold", "Gold", "default:gold_ingot")
register_candle_lamp("bronze", "Bronze", "default:bronze_ingot")
register_candle_lamp("steel", "Steel", "default:steel_ingot")
register_candle_lamp("silver", "Silver", "lottores:silver_ingot")
register_candle_lamp("tin", "Tin", "lottores:tin_ingot")
