local S = minetest.get_mod_translator()

local rocks = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes      = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	lord_nodes = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	rocks      = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	lord_rocks = {},
}

--- @param node_name        string         technical node name ("<mod>:<node>").
--- @param not_rock         boolean        don't register in "rocks" lists (only in "nodes" lists). Default: `false`.
--- @param softness         number         softness value 1-3.
--- @param definition       NodeDefinition registered node definition.
--- @param orig_description string         original node description (before it was modified by another mod - `tt_base`)
local function register_in_lists(node_name, not_rock, softness, definition, orig_description)
	rocks.nodes[node_name] = {
		softness             = softness,
		definition           = definition,
		original_description = orig_description
	}
	rocks.lord_nodes[node_name] = {
		softness             = softness,
		definition           = definition,
		original_description = orig_description
	}

	if not not_rock then
		rocks.rocks[node_name] = {
			softness             = softness,
			definition           = definition,
			original_description = orig_description
		}
		rocks.lord_rocks[node_name] = {
			softness             = softness,
			definition           = definition,
			original_description = orig_description
		}
	end
end

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	local softness   = definition.groups["cracky"] or 2

	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { rock = 1, stone = 1 }),
	})

	rocks.nodes[node_name] = {
		softness   = softness,
		definition = definition,
	}
end

--- @param node_name       string         technical node name ("<mod>:<node>").
--- @param softness        number         softness value 1-3.
--- @param definition      NodeDefinition that overrides the default one.
--- @param register_stairs boolean        whether to register stairs or not. Default: `false`.
--- @param not_rock        boolean        don't register in "rocks" lists (only in "nodes" lists). Default: `false`.
local function register_rock(node_name, softness, definition, register_stairs, not_rock)
	softness        = softness or 2
	definition      = definition or {}
	register_stairs = register_stairs or false
	not_rock        = not_rock or false

	local description = definition.description or node_name:replace("lord_rocks:", ""):remove_underscores():to_headline()
	local tiles       = definition.tiles or { node_name:replace(":", "_") .. ".png" }

	definition.description = S(description)
	definition.tiles       = tiles

	for _, texture in ipairs(tiles) do
		minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())
	end

	minetest.register_node(node_name, table.overwrite({
		description       = S(description),
		tiles             = tiles,
		groups            = { rock = 1, stone = 1, cracky = softness, },
		is_ground_content = true,
		sounds            = default.node_sound_stone_defaults(),
	}, definition))

	if register_stairs == true then
		stairs.register_stair_and_slab(
			node_name:replace("lord_rocks:", ""),
			node_name,
			{ cracky = softness, },
			tiles,
			S(description .. " Stair"),
			S(description .. " Slab"),
			definition.sounds or default.node_sound_stone_defaults(),
			true,
			S("Inner " .. description .. " Stair"),
			S("Outer " .. description .. " Stair")
		)
	end

	register_in_lists(node_name, not_rock, softness, definition, description)

	return true
end


return {
	add_existing   = add_existing,
	register_rock  = register_rock,
	get_nodes      = function() return rocks.nodes end,
	get_lord_nodes = function() return rocks.lord_nodes end,
	get_rocks      = function() return rocks.rocks end,
	get_lord_rocks = function() return rocks.lord_rocks end,
}
