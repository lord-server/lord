
local S        = core.get_mod_translator()
local colorize = core.colorize
local grey     = '#aaa'


--- @type table<integer,string>
local ranks = {
	item_rank.Type.ADVANCED,
	item_rank.Type.RARE,
	item_rank.Type.EPIC,
}


--- @param level 1|2|3
--- @return NodeDefinition
return function(level)
	return {
		description   = S('Smelter') .. ' ' .. colorize(grey, S('(Level: @1)', level)),
		_rank         = ranks[level],
		stack_max     = 1,
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
				core.set_node(pos, { name = 'lord_smelter:smelter_' .. level, param2 = face_dir })
			else
				core.remove_node(pos)
				return true
			end
		end,
		groups          = { cracky = 3 },
		sounds          = default.node_sound_stone_defaults(),
	}
end
