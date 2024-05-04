local S = minetest.get_translator("lord_planks")

local dirt = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	lord_nodes = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { dirt = 1 }),
	})
	dirt.nodes[node_name] = definition
end

--- @param node_name string       technical node name ("<mod>:<node>").
--- @param hardness  number       used for `crumbly`; how difficult to dig/crumble.
--- @param craft     string|table node name to craft from, or table with own recipe.
--- @param groups    table        additional or overwrite groups (default: {crumbly = hardness, dirt = 1})
--- @param title     string       prefix to description of nodes or will extracted from `node_bane` (`title`.." Grass")
local function register_dirt(node_name, hardness, craft, groups, title)
	local sub_name = node_name:split(":")[2]
	title = title and title:first_to_upper() or sub_name:first_to_upper()
	local texture = node_name:replace(":", "_") .. ".png"
	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())

	minetest.register_node(node_name, {
		-- TODO: забрать сюда скомбинированный definition из:
		-- mods/lord/World/Generation/lottmapgen/nodes.lua:246
		-- mods/lord/_overwrites/MTG/farming/init.lua:7
	})

	-- TODO: Добавить ?ABM? по озеленению, если он сюда нормально вписывается

	dirt.nodes[node_name]      = minetest.registered_nodes[node_name]
	dirt.lord_nodes[node_name] = minetest.registered_nodes[node_name]

end


return {
	add_existing   = add_existing,
	register_dirt  = register_dirt,
	get_nodes      = function() return dirt.nodes end,
	get_lord_nodes = function() return dirt.lord_nodes end,
}
