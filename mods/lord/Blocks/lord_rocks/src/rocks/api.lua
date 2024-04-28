local S = minetest.get_translator("lord_rocks")

local rocks = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { rock = 1 }),
	})
	rocks.nodes[node_name] = {
		softness = definition.groups["cracky"],
		definition = definition,
		existing = true
	}
end

--- @param node_name string technical node name ("<mod>:<node>").
--- @param softness number softness value 1-3.
--- @param definition table NodeDefinition that overrides the default one.
local function register_rock(node_name, softness, definition)
	softness = softness or 2
	definition = definition or {}

	local description = node_name:replace("lord_rocks:", ""):remove_underscores():to_headline()
	local tile  = node_name:replace(":", "_") .. ".png"

	minetest.register_node(node_name, table.overwrite({
		description = S(description),
		tiles       = { tile },
		groups      = { rock = 1, stone = 1, cracky = softness, },
		sounds = default.node_sound_stone_defaults(),
	}, definition))

	return true
end


return {
	add_existing  = add_existing,
	register_rock = register_rock,
	get_nodes     = function() return rocks.nodes end,
}
