local S = minetest.get_mod_translator()

minetest.register_craftitem('bones:bonedust', {
	description       = S('Bone Dust'),
	inventory_image   = 'bones_bonedust.png',
	liquids_pointable = false,
	stack_max         = 99,
})

minetest.register_craftitem('bones:bone', {
	description     = S('Bone'),
	inventory_image = 'bones_bone_inv.png',
})

-- As for now, used only for dungeons generation testing
-- Full implementation later
if minetest.settings:get_bool('toggle_dungeons', false) then
	-- Move into main declaration later
	core.override_item('bones:bone', {
		on_place = function(itemstack, placer, pointed_thing)
			local stack  = ItemStack('bones:bone_' .. math.random(1, 1))
			local placed = minetest.item_place(stack, placer, pointed_thing, math.random(0, 3))

			return placed
				and ItemStack('bones:bone ' .. (itemstack:get_count() - (1 - placed:get_count())))
				or  itemstack
		end,
	})

	local px = 1 / 16
	minetest.register_node('bones:bone_1', {
		description       = S('Bone'),
		inventory_image   = 'bones_bone_inv.png',
		wield_image       = 'bones_bone_inv.png',
		paramtype         = 'light',
		paramtype2        = 'facedir',
		is_ground_content = false,
		drawtype          = 'nodebox',
		tiles             = { 'bones_bone.png' },
		groups            = { dig_immediate = 2 },
		drop              = 'bones:bone',
		node_box          = {
			type  = 'fixed',
			fixed = {
				{ -6*px, -8*px, -7*px,  -4*px, -7*px, -5*px },
				{ -7*px, -8*px, -6*px,  -5*px, -7*px, -4*px },

				{  6*px, -8*px,  7*px,   4*px, -7*px,  5*px },
				{  7*px, -8*px,  6*px,   5*px, -7*px,  4*px },

				{ -6*px, -8*px, -6*px,  -4*px, -7*px, -4*px },
				{ -5*px, -8*px, -5*px,  -3*px, -7*px, -3*px },
				{ -4*px, -8*px, -4*px,  -2*px, -7*px, -2*px },
				{ -3*px, -8*px, -3*px,  -1*px, -7*px, -1*px },
				{ -2*px, -8*px, -2*px,   0*px, -7*px,  0*px },
				{ -1*px, -8*px, -1*px,   1*px, -7*px,  1*px },
				{  0*px, -8*px,  0*px,   2*px, -7*px,  2*px },
				{  1*px, -8*px,  1*px,   3*px, -7*px,  3*px },
				{  2*px, -8*px,  2*px,   4*px, -7*px,  4*px },
				{  3*px, -8*px,  3*px,   5*px, -7*px,  5*px },
				{  4*px, -8*px,  4*px,   6*px, -7*px,  6*px },
			},
		},
	})
end

minetest.register_tool('bones:bone_scythe', {
	description       = S('Bone Scythe'),
	inventory_image   = 'bones_scythe.png',
	range             = 7,
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level      = 1,
		groupcaps           = {
			snappy = { times = { [1] = 2.0, [2] = 1.00, [3] = 0.35 }, uses = 30, maxlevel = 3 },
		},
		damage_groups       = { fleshy = 4 },
	},
})
