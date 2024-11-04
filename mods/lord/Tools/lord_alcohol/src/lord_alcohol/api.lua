local S = minetest.get_mod_translator()


local px = 1/16
local alcohol = {
	--- @type table<string,ItemDefinition>|ItemDefinition[]
	nodes = {},
	--- @type table<string,ItemDefinition>|ItemDefinition[]
	lord_nodes = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { alcohol = 1 }),
	})
	alcohol.nodes[node_name] = definition
end

--- @param node_name string       technical node name ("<mod>:<node>").
--- @param satiety   number       hp of satiety as a food.
--- @param groups    table        additional or overwrite groups (default: {alcohol = 1})
--- @param title     string       prefix to description of nodes or will extracted from `node_bane`
local function register(node_name, satiety, groups, title)
	local sub_name = node_name:split(":")[2]
	title = title and title:first_to_upper() or sub_name:first_to_upper()
	local texture = node_name:replace(":", "_") .. ".png"
	if not io.file_exists(minetest.get_mod_textures_folder() .. texture) then
		minetest.log('warning', ('Can\'t find texture: "%s". Alcohol `%s` not registered.'):format(texture, node_name))
		return
	end

	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())

	minetest.register_node(node_name, {
		description       = S(title),
		inventory_image   = texture .. '^vessels_drinking_glass_inv.png',
		wield_image       = texture .. '^vessels_drinking_glass_inv.png',
		drawtype          = 'plantlike',
		paramtype         = 'light',
		tiles             = { texture .. '^(vessels_drinking_glass.png^[opacity:200)^[opacity:200' },
		use_texture_alpha = 'blend',
		visual_scale      = 0.8,
		selection_box     = {
			type  = 'fixed',
			fixed = { -2.2*px, -8*px, -2.2*px, 2.2*px, 0, 2.2*px } -- 2.2 cause of visual_scale=0.8
		},
		walkable          = false,
		groups            = table.overwrite({ dig_immediate = 3, attached_node = 1, alcohol = 1 }, groups or {}),
		on_use            = minetest.item_eat(satiety),
		_tt_food_hp       = satiety,
		sounds            = default.node_sound_glass_defaults(),
	})

	alcohol.nodes[node_name]      = minetest.registered_nodes[node_name]
	alcohol.lord_nodes[node_name] = minetest.registered_nodes[node_name]
end


return {
	add_existing   = add_existing,
	register       = register,
	--- @return NodeDefinition[]
	get_nodes      = function() return alcohol.nodes end,
	get_lord_nodes = function() return alcohol.lord_nodes end,
}
