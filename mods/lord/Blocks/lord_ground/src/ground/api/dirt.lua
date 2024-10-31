local S = minetest.get_mod_translator()

local dirt = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	biome_nodes = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	mixed_nodes = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { dirt = 1 }),
	})
	dirt.nodes[node_name] = definition
end

--- @param node_name  string technical node name ("<mod>:<node>").
--- @param softness   number used for `crumbly`; how difficult to dig/crumble.
--- @param title      string overwrite title. Default extracts from `node_name`("Dirt with <extracted> Grass")
--- @param definition string overwrite definition.
local function register_biome_dirt(node_name, softness, title, definition)
	local sub_name = node_name:split(":")[2]
	title = title
		and title:first_to_upper()
		or  sub_name:replace("_", " "):title():replace("Dirt", "Dirt with") .. " Grass"

	local texture      = node_name:replace(":", "_") .. ".png"
	local texture_side = node_name:replace(":", "_") .. "_side.png"
	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. ", " .. texture_side .. " at " .. __FILE_LINE__())

	minetest.register_node(node_name, table.overwrite({
		description       = S(title),
		tiles             = {
			texture,
			"default_dirt.png",
			{ name = "default_dirt.png^"..texture_side, tileable_vertical = false }
		},
		is_ground_content = true,
		groups            = {
			crumbly = softness, soil = 1, not_in_creative_inventory = 1, dirt = 1, spreading_dirt_type = 1
		},
		soil              = { base = node_name, dry = "farming:soil", wet = "farming:soil_wet", },
		drop              = 'default:dirt',
		sounds            = default.node_sound_dirt_defaults({
			footstep = { name = "default_grass_footstep", gain = 0.25 },
		}),
	}, definition))

	dirt.nodes[node_name]       = minetest.registered_nodes[node_name]
	dirt.biome_nodes[node_name] = minetest.registered_nodes[node_name]
end

--- @param node_name  string technical node name ("<mod>:<node>").
--- @param craft_from string name of node which mixes with "default:dirt" to craft this one.
--- @param softness   number used for `crumbly`; how difficult to dig/crumble.
--- @param title      string overwrite title. Default extracts from `node_name` (after `:` to upper: `"Node Name"`)
--- @param definition string overwrite definition.
local function register_mixed_dirt(node_name, craft_from, softness, title, definition)
	local sub_name = node_name:split(":")[2]
	title = title and title:first_to_upper() or sub_name:replace("_", " "):title()

	local overlay = node_name:replace(":", "_") .. "_overlay.png"
	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. overlay .. " at " .. __FILE_LINE__())

	minetest.register_node(node_name, table.overwrite({
		description       = S(title),
		tiles             = { "default_dirt.png^" .. overlay, },
		is_ground_content = true,
		groups            = { crumbly = softness, },
		sounds            = default.node_sound_dirt_defaults(),
	}, definition))

	minetest.register_craft({
		output = node_name .. " 4",
		recipe = {
			{ "default:dirt", craft_from },
			{ craft_from, "default:dirt"},
		}
	})
	minetest.register_craft({
		output = node_name .. " 4",
		recipe = {
			{ craft_from, "default:dirt"},
			{ "default:dirt", craft_from },
		}
	})
	dirt.nodes[node_name]       = minetest.registered_nodes[node_name]
	dirt.mixed_nodes[node_name] = minetest.registered_nodes[node_name]
end


return {
	add_existing        = add_existing,
	register_biome_dirt = register_biome_dirt,
	register_mixed_dirt = register_mixed_dirt,
	get_nodes           = function() return dirt.nodes end,
	get_biome_nodes     = function() return dirt.biome_nodes end,
	get_mixed_nodes     = function() return dirt.mixed_nodes end,
}
