local S = minetest.get_translator("lamps")

local chains = {}

local candle_lamp_node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},
			{-0.1875, -0.4375, -0.1875, 0.1875, 0.0625, 0.1875},
			{-0.25, 0.0625, -0.25, 0.25, 0.125, 0.25},
			{-0.1875, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
			{-0.0625, 0.1875, -0.0625, 0.0625, 0.25, .0625},
		},
	}

local function register_candle_lamp(material, desc, ingot)
	local upTx = "lamps_candle_lamp_"..material.."_up.png"
	local sideTx = "lamps_light_candle_lamp.png^lamps_candle_lamp_"..material.."_side.png"
	local chain = "lamps_chains_"..material..".png"

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
			sideTx},
		use_texture_alpha = "clip",
		groups = {cracky = 2, not_in_creative_inventory = 1},
		drawtype = "mesh",
		paramtype = "light",
		paramtype2 = "facedir",
		mesh = "lamps_candle_lamp.obj",
		visual_scale = 6.25,
		collision_box = candle_lamp_node_box,
		selection_box = candle_lamp_node_box,
		light_source = 10,
		{not_in_creative_inventory = 1, choppy = 2},
		drop = "lamps:"..material.."_item_candle_lamp",
	})

	-- Потолочная лампа.
	minetest.register_node("lamps:"..material.."_hanging_candle_lamp", {
		description = desc.." hanging candle lamp",
		tiles = {
			upTx,
			sideTx,
			chain},
		use_texture_alpha = "clip",
		groups = {cracky = 2, not_in_creative_inventory = 1},
		drawtype = "mesh",
		paramtype = "light",
		paramtype2 = "facedir",
		mesh = "lamps_hanging_candle_lamp.obj",
		visual_scale = 6.25,
		collision_box = candle_lamp_node_box,
		selection_box = candle_lamp_node_box,
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

-- Цепи
local function register_chains(material, desc, ingot)
	local veticalTx = "lamps_chains_"..material..".png"
	local diagonalTx = "lamps_chains_diagonal_"..material..".png"
	local diagonal2Tx = "lamps_chains_diagonal_2_"..material..".png"
	local itemTx = "lamps_chains_item_"..material..".png"

	local vertical_name = "lamps:chains_vertical_"..material
	local diagonal_name = "lamps:chains_diagonal_"..material
	local diagonal_2_name = "lamps:chains_diagonal_2_"..material

	chains[vertical_name] = diagonal_name
	chains[diagonal_name] = diagonal_2_name
	chains[diagonal_2_name] = vertical_name

	-- Вертикальная цепь
	minetest.register_node(vertical_name, {
		description = S(desc.." chains"),
		inventory_image = itemTx,
		wield_image = itemTx,
		tiles = {veticalTx},
		use_texture_alpha = "clip",
		drawtype = "mesh",
		mesh = "lamps_chains.obj",
		groups = {cracky = 3},
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		place_param2 = 0,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			},
		},
	})

	-- Диагональная по грани цепь
	minetest.register_node(diagonal_name, {
		description = S(desc.." diagonal chains"),
		inventory_image = itemTx,
		wield_image = itemTx,
		tiles = {diagonalTx},
		use_texture_alpha = "clip",
		drawtype = "mesh",
		mesh = "lamps_chains_diagonal.obj",
		groups = {cracky = 3},
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
			},
		},
		drop = vertical_name,
	})

	-- Диагональная по кубу цепь
	minetest.register_node(diagonal_2_name, {
		description = S(desc.." diagonal chains type 2"),
		inventory_image = itemTx,
		wield_image = itemTx,
		tiles = {diagonal2Tx},
		use_texture_alpha = "clip",
		drawtype = "mesh",
		mesh = "lamps_chains_diagonal_2.obj",
		groups = {cracky = 3},
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		drop = vertical_name,
	})

	minetest.register_craft({
		output = vertical_name,
		recipe = {
			{ingot, ""},
			{"", ingot},
			{ingot, ""}},
	})

	minetest.register_craft({
		output = vertical_name,
		recipe = {
			{"", ingot},
			{ingot, ""},
			{"", ingot}},
	})
end

register_candle_lamp("gold", "Gold", "default:gold_ingot")
register_candle_lamp("bronze", "Bronze", "default:bronze_ingot")
register_candle_lamp("steel", "Steel", "default:steel_ingot")
register_candle_lamp("silver", "Silver", "lottores:silver_ingot")
register_candle_lamp("tin", "Tin", "lottores:tin_ingot")

register_chains("gold", "Gold", "default:gold_ingot")
register_chains("bronze", "Bronze", "default:bronze_ingot")
register_chains("steel", "Steel", "default:steel_ingot")
register_chains("silver", "Silver", "lottores:silver_ingot")
register_chains("tin", "Tin", "lottores:tin_ingot")

-- Гаечный ключ
minetest.register_tool("lamps:wrench", {
	description = S("Wrench") .. "\n" .. S("(left click to tilt the chain)"),
	inventory_image = "lamps_wrench.png",
	groups = {tool = 1},
	on_use = function(itemstack, user, pointed_thing)
		if not user then return end

		if not pointed_thing.under then return end

		local node = minetest.get_node(pointed_thing.under)

		if not node then return end

		-- Имя для нового блока, если блок не является цепью, то nill
		local name = chains[node.name]

		if not name then return end

		node.name = name

		minetest.swap_node(pointed_thing.under, node)

		itemstack:add_wear(500)

		return itemstack
	end,
})

minetest.register_craft({
	output = "lamps:wrench",
	recipe = {
		{"default:steel_ingot"},
		{"default:steel_ingot"}
	}
})

minetest.register_node("lamps:dungeon_lamp", {
	description = S("Dungeon lamp"),
	use_texture_alpha = "clip",
	mesh = "lamps_dungeon_lamp.obj",
	tiles = {"lamps_dungeon_lamp_top.png", "lamps_dungeon_lamp_side.png", "lamps_dungeon_lamp_candle.png"},
	groups = {cracky = 2},
	drawtype = "mesh",
	paramtype = "light",
	light_source = 9,
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {
		{-1/16*3, -0.5, -1/16*3, 1/16*3, 1/16, 1/16*3},
		{-1/16*2, 1/16, -1/16*2, 1/16*2, 1/16*2, 1/16*2},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
		{-1/16*3, -0.5, -1/16*3, 1/16*3, 1/16, 1/16*3},
		{-1/16*2, 1/16, -1/16*2, 1/16*2, 1/16*2, 1/16*2},
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above.y ~= pointed_thing.under.y-1 then
			-- Если блок, который поставил игрок не ниже блока,
			-- который он выделил, то обычная лампа.
			itemstack:set_name("lamps:dungeon_lamp")
			minetest.item_place_node(itemstack, placer, pointed_thing, 0)
		else
			-- Если блок, который поставил игрок ниже блока,
			-- который он выделил, то потолочная лампа.
			itemstack:set_name("lamps:dungeon_lamp_hanging")
			minetest.item_place_node(itemstack, placer, pointed_thing, 0)
		end
		itemstack:set_name("lamps:dungeon_lamp")
		return itemstack
	end,
})

minetest.register_node("lamps:dungeon_lamp_hanging", {
	description = S("Dungeon hanging lamp"),
	use_texture_alpha = "clip",
	mesh = "lamps_dungeon_lamp_hanging.obj",
	tiles = {"lamps_dungeon_lamp_top.png",
		"lamps_dungeon_lamp_side.png",
		"lamps_dungeon_lamp_candle.png",
		"lamps_chains_steel.png"},
	groups = {cracky = 2, not_in_creative_inventory = 1},
	drawtype = "mesh",
	paramtype = "light",
	light_source = 9,
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {
		{-1/16*3, -0.5, -1/16*3, 1/16*3, 1/16, 1/16*3},
		{-1/16*2, 1/16, -1/16*2, 1/16*2, 0.5, 1/16*2},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
		{-1/16*3, -0.5, -1/16*3, 1/16*3, 1/16, 1/16*3},
		{-1/16*2, 1/16, -1/16*2, 1/16*2, 0.5, 1/16*2},
		},
	},
	drop = "lamps:dungeon_lamp",
})

minetest.register_craft({
	output = "lamps:dungeon_lamp",
	recipe = {
		{"default:steel_ingot"},
		{"lord_homedecor:candle"},
		{"default:steel_ingot"}},
})
