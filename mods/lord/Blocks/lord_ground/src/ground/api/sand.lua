local S = minetest.get_mod_translator()

local sand = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	lord_nodes = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { sand = 1 }),
	})
	sand.nodes[node_name] = definition
end

--- @param node_name string       technical node name ("<mod>:<node>").
--- @param softness  number       used for `crumbly`; how difficult to dig/crumble.
--- @param title     string       prefix to description of nodes or will extracted from `node_bane` (`title`.." Grass")
local function register_sand(node_name, softness, title)
	local sub_name = node_name:split(":")[2]
	title = title and title:first_to_upper() or sub_name:replace("_", " "):title()

	local texture = node_name:replace(":", "_") .. ".png"
	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())

	minetest.register_node(node_name, {
		description = S(title),
		tiles       = { texture },
		groups      = { crumbly = softness, falling_node = 1, sand = 1 },
		sounds      = default.node_sound_sand_defaults(),
	})

	sand.nodes[node_name]      = minetest.registered_nodes[node_name]
	sand.lord_nodes[node_name] = minetest.registered_nodes[node_name]

end


return {
	add_existing   = add_existing,
	register_sand  = register_sand,
	get_nodes      = function() return sand.nodes end,
	get_lord_nodes = function() return sand.lord_nodes end,
}
