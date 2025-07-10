local S = minetest.get_mod_translator()


local list_gems_blocks = {
	'blue',
	'red',
	'white',
	'purple',}

local function capitalize_first(s)
  return s:gsub('^%l', string.upper)
end

for _, node_source in pairs(list_gems_blocks) do
	local node_name            = ('lord_gems:'..node_source..'_block')
	local node_description     = (capitalize_first(node_source)..' Gem Block')
	local node_tiles           = ('lord_gems_'..node_source..'_block.png'..'^[opacity:150')
	local node_sound_file      = ('footstep_'..node_source..'_block')
	local node_sounds = {
		footstep = { name = node_sound_file,        gain = 1.0 },
		dug      = { name = "default_break_glass",  gain = 1.0 },
		dig      = { name = node_sound_file,        gain = 1.0 },
		place    = { name = node_sound_file,        gain = 1.0 },
		}

	-- Register nodes
	minetest.register_node(node_name, {
		description         = S(node_description),
		tiles               = { node_tiles },
		drawtype            = "nodebox",
		use_texture_alpha   = "blend",
		paramtype           = "light",
		sunlight_propagates = true,
		is_ground_content   = false,
		sounds              = node_sounds,
		on_punch = function (pos)
			minetest.sound_play( node_sound_file, { gain = 3, pos = pos, max_hear_distance = 10 }, true )
		end,
		groups              = { cracky = 1, level = 3 },
	})

	-- Register crafts
	local name_craftitem = ('lord_gems:'..node_source)
	minetest.register_craft({
		output = node_name,
		recipe = {
			{name_craftitem, name_craftitem, name_craftitem},
			{name_craftitem, name_craftitem, name_craftitem},
			{name_craftitem, name_craftitem, name_craftitem},
		}
	})

	-- Register reverse crafts
	minetest.register_craft({
		output = (name_craftitem..' 9'),
		recipe = {
			{node_name},
        }
	})
end
