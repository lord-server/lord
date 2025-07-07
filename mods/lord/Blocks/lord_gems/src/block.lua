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
	local node_name = ('lord_gems:'..node_source..'_block')
	local node_description = (capitalize_first(node_source)..' Gem Block')
	local node_inventory_image = ('lord_gems_'..node_source..'_block.png')
	local node_tiles = node_inventory_image
	local node_sound_file = ('footstep_'..node_source..'_block')
	local node_sounds = {
		footstep = { name = node_sound_file,        gain = 0.25 },
		dug      = { name = node_sound_file,        gain = 0.25 },
		place    = { name = node_sound_file,        gain = 0.25 },
		}
	-- Register nodes
	minetest.register_node(node_name, {
		description     = S(node_description),
		inventory_image = node_inventory_image,
		tiles           = { node_tiles },
		sounds          = node_sounds,
		groups = { cracky = 1, level = 3 },
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
	-- Registre revers crafts
	minetest.register_craft({
		output = (name_craftitem..' 9'),
		recipe = {
			{node_name},
        }
	})
end
