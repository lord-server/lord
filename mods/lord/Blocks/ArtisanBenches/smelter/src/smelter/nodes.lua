
local S = core.get_mod_translator()


--- @type NodeDefinition
local common_node_definition = {
	description   = S('Smelter'),
	drawtype      = 'mesh',
	mesh          = 'lord_smelter_1.obj',
	paramtype     = 'light',
	selection_box = {
		type  = 'fixed',
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
	},
	collision_box = {
		type  = 'fixed',
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 },
	},
	after_place_node = function(pos, placer, item_stack, pointed_thing)
		local node_above = core.get_node(pos:above())

		if node_above.name == 'air' then
			local face_dir = core.get_node(pos).param2
			core.set_node(pos, { name = 'lord_smelter:smelter_1', param2 = face_dir })
		else
			core.remove_node(pos)
			return true
		end
	end,
	groups          = { cracky = 3 },
	sounds          = default.node_sound_stone_defaults(),
}


return common_node_definition
