local trunks          = require('tree.trunks')
local MiasmaParticles = require('tree.trunks.infected.MiasmaParticles')

local S = minetest.get_mod_translator()


local INFECTED_TRUNKS_GROUP = 'infected'
local INFECTED_BY           = { 'lottfarming:orc_food' }

--- @class InfectedTrunkDefinition: TrunkDefinition
--- @field _healthy_node_name string  technical name of not infected (healthy) tree trunk.

--- @param parent_node_name string  technical name of not infected tree, which ends with 'tree' ("<mod>:<node>tree").
--- @param tree_height      number
--- @param leaves_radius    number
--- @param register_young   boolean
--- @param def_override     table
local function register_infected_trunk(parent_node_name, tree_height, leaves_radius, register_young, def_override)
	local parent_tree_definition = trunks.get_nodes()[parent_node_name]
	assert(
		parent_tree_definition,
		'Parent tree trunk must be registered: use `tree.trunk.register()` or `tree.trunk.add_existing()`'
	)

	local node_name = parent_node_name
	-- @legacy
	if node_name == 'default:tree'       then  node_name = 'lord_trees:apple_tree' end
	if node_name == 'default:jungletree' then  node_name = 'lord_trees:mirk_tree'  end
	-- /@legacy
	node_name    = node_name:replace(':', ':infected_')

	local softness     = parent_tree_definition.groups.choppy
	local texture_side = parent_node_name:replace(':', '_') .. '.png^' .. node_name:replace(':', '_') .. '.png'
	local texture_top  = parent_node_name:replace(':', '_') .. '_top.png^(lord_trees_infected_top.png^[opacity:200)'

	node_name = not node_name:starts_with('lord_trees:') and ':' .. node_name or node_name

	local parent_groups = table.copy(parent_tree_definition.groups)
	parent_groups.infected_tree   = 1
	parent_groups.tree            = nil -- not use in crafts with `"group:tree"`
	parent_groups.wall_connected  = 1
	parent_groups.fence_connected = 1

	trunks.register(node_name, softness, tree_height, leaves_radius, register_young, {
		tiles              = { texture_top, texture_top, texture_side },
		groups             = parent_groups,
		_is_infected       = true,
		_healthy_node_name = parent_node_name,
	}, INFECTED_TRUNKS_GROUP)

	minetest.override_item(parent_node_name, {
		_is_infected        = false,
		_infected_node_name = node_name,
		on_rightclick       = function(pos, node, clicker, itemstack, pointed_thing)
			local player_name = clicker:get_player_name()
			pd(minetest.is_protected(pos, player_name), minetest.check_player_privs(player_name, "protection_bypass"))
			if
				minetest.is_protected(pos, player_name) and
				not minetest.check_player_privs(player_name, "protection_bypass")
			then
				minetest.record_protection_violation(pos, player_name)
				return itemstack
			end

			if not itemstack:get_name():is_one_of(INFECTED_BY) then
				if not clicker:get_player_control().sneak then
					return minetest.item_place_node(itemstack, clicker, pointed_thing)
				end

				return itemstack
			end

			itemstack:take_item(1)
			minetest.set_node(pos, { name = node_name })

			return itemstack
		end,
	})

	return node_name
end

--- @param original_node_name string name of infected tree
local function register_infected_trunk_slab(original_node_name)
	local definition = minetest.registered_nodes[original_node_name]
	assertf(
		definition._is_infected,
		'Can\'n register infected slab: original node `%s` is not infected.',
		original_node_name
	)
	assertf(definition.tiles[3], 'Can\'n register infected slab: definition must have `tiles[3]` texture of trunk side.')

	local texture_side = definition.tiles[3]

	stairs.register_slab(
		original_node_name:remove('lord_trees:'),
		original_node_name,
		{ tree_slab = 1, choppy = definition.groups.choppy, flammable = 2 },
		{ texture_side, },
		S('Infected ' .. original_node_name:remove('lord_trees:infected_'):remove('_tree$'):title() ..' Trunk Slab'),
		default.node_sound_wood_defaults(),
		false
	)
end

-- lord_trees:infected_alder_tree       | lord_trees:infected_alder_trunk
-- lord_trees:infected_beech_tree       | lord_trees:infected_beech_trunk
-- lord_trees:infected_birch_tree       | lord_trees:infected_birch_trunk
-- lord_trees:infected_cherry_tree      | lord_trees:infected_cherry_trunk
-- lord_trees:infected_culumalda_tree   | lord_trees:infected_culumalda_trunk
-- lord_trees:infected_elm_tree         | lord_trees:infected_elm_trunk
-- lord_trees:infected_fir_tree         | lord_trees:infected_fir_trunk
-- lord_trees:infected_lebethron_tree   | lord_trees:infected_lebethron_trunk
-- lord_trees:infected_mallorn_tree     | lord_trees:infected_mallorn_trunk
-- lord_trees:infected_pine_tree        | lord_trees:infected_pine_trunk
-- lord_trees:infected_plum_tree        | lord_trees:infected_plum_trunk
-- lord_trees:infected_white_tree       | lord_trees:infected_white_trunk
-- lord_trees:infected_yavannamire_tree | lord_trees:infected_yavannamire_trunk
for node_name, trunk_definition in pairs(trunks.get_nodes()) do
	register_infected_trunk_slab(
		register_infected_trunk(node_name, trunk_definition._tree_height, trunk_definition._leaves_radius)
	)
end

minetest.register_abm({
	label     = 'Trees trunks Infection spreading',
	nodenames = { 'group:infected_tree' },
	interval  = 5,
	chance    = 40,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local found_at, found_node_table = minetest.find_node_near_except(pos, 1, 'group:tree', 'group:infected_tree', false)
		if not found_at then
			return
		end

		--- @type TrunkDefinition
		local found_node = minetest.registered_nodes[found_node_table.name]
		if found_node._is_infected or not found_node._infected_node_name then
			return
		end

		minetest.set_node(found_at, { name = found_node._infected_node_name })
	end
})

minetest.register_abm({
	nodenames = { 'group:infected_tree' },
	interval  = 1,
	chance    = 10,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local air_pos = minetest.find_node_near(pos, 1, 'air')
		if not air_pos then
			return
		end

		MiasmaParticles.spawn(pos, air_pos)
	end
})


return {
	register      = register_infected_trunk,
	register_slab = register_infected_trunk_slab,
}
