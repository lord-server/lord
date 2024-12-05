local S = minetest.get_mod_translator()


local px = 1/16

local common_definition = {
	drawtype          = 'nodebox',
	tiles             = {
		'benches_cauldron_top.png', 'benches_cauldron_side.png', 'benches_cauldron_side.png',
		'benches_cauldron_side.png', 'benches_cauldron_side.png', 'benches_cauldron_side.png',
	},
	use_texture_alpha = 'blend',
	paramtype         = 'light',
	paramtype2        = 'facedir',
	groups            = { cracky = 1 },
	node_box          = {
		type  = 'fixed',
		fixed = {
			{ -8*px, -8*px, -8*px,  -6*px,  8*px, -6*px },
			{  6*px, -8*px, -8*px,   8*px,  8*px, -6*px },
			{  6*px, -8*px,  6*px,   8*px,  8*px,  8*px },
			{ -8*px, -8*px,  6*px,  -6*px,  8*px,  8*px },
			{ -6*px, -6*px, -6*px,   6*px, -5*px,  6*px },
			{ -8*px, -6*px, -6*px,  -6*px,  7*px,  6*px },
			{  6*px, -6*px, -6*px,   8*px,  7*px,  6*px },
			{ -6*px, -6*px,  6*px,   6*px,  7*px,  8*px },
			{ -6*px, -6*px, -8*px,   6*px,  7*px, -6*px },
			-- [10] = <water level>
		}
	},
}
--- @param player    Player
--- @param position  Position
--- @param change_to string
local function fill_bottle(player, position, change_to)
	local player_inv = player:get_inventory()
	local itemstack  = player:get_wielded_item()
	if itemstack:get_name() == 'vessels:glass_bottle' then
		minetest.set_node(position, { name = change_to })
		if player_inv:room_for_item('main', 1) then
			itemstack:take_item(1)
			player_inv:add_item('main', 'lord_vessels:glass_bottle_water')
		end
		player:set_wielded_item(itemstack)
	end
end

minetest.register_node('cauldron:cauldron_3_3', table.merge(common_definition, {
	description = S('Filled Cauldron'),
	node_box    = { fixed = { [10] = { -6*px,  4*px, -6*px,   6*px,  5*px,  6*px }, } },
	on_punch    = function(pos, node, player)
		fill_bottle(player, pos, 'cauldron:cauldron_2_3')
	end,
}))
minetest.register_node('cauldron:cauldron_2_3', table.merge(common_definition, {
	description = S('Two Third Filled Cauldron'),
	groups      = { not_in_creative_inventory = 1 },
	node_box    = { fixed = { [10] = { -6*px,  1*px, -6*px,   6*px,  2*px,  6*px }, } },
	on_punch    = function(pos, node, player)
		fill_bottle(player, pos, 'cauldron:cauldron_1_3')
	end,
}))
minetest.register_node('cauldron:cauldron_1_3', table.merge(common_definition, {
	description = S('One Third Filled Cauldron'),
	groups      = { not_in_creative_inventory = 1 },
	node_box    = { fixed = { [10] = { -6*px, -2*px, -6*px,   6*px, -1*px,  6*px }, } },
	on_punch    = function(pos, node, player)
		fill_bottle(player, pos, 'cauldron:cauldron_0_3')
	end,
}))

common_definition.tiles = nil
minetest.register_node('cauldron:cauldron_0_3', table.merge(common_definition, {
	description   = S('Empty Cauldron'),
	tiles         = {
		'benches_cauldron_top_empty.png', 'benches_cauldron_side.png', 'benches_cauldron_side.png',
		'benches_cauldron_side.png', 'benches_cauldron_side.png', 'benches_cauldron_side.png',
	},
	groups        = { level = 2 },
	node_box      = { fixed = { [10] = { -6*px, -2*px, -6*px,   6*px, -4*px,  6*px }, }, },
	on_rightclick = function(pos, node, clicker, itemstack)
		if itemstack:get_name() == 'bucket:bucket_water' then
			minetest.set_node(pos, { name = 'cauldron:cauldron_3_3' })
			return { name = 'bucket:bucket_empty' }
		end
	end
}))

minetest.register_craft({
	output = 'cauldron:cauldron_0_3',
	recipe = {
		{ 'default:steel_ingot', '', 'default:steel_ingot' },
		{ 'default:steel_ingot', '', 'default:steel_ingot' },
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
	}
})


return {
	--- @param mod minetest.Mod
	init = function(mod)
		-- all things done upper
	end,
}
