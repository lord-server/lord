local S = minetest.get_translator("lord_planks")


local planks = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {}
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { planks = 1 }),
	})
	planks.nodes[node_name] = definition
end

--- @param node_name string       technical node name ("<mod>:<node>").
--- @param hardness  number       how difficult to chop.
--- @param craft     string|table node name to craft from, or table with own recipe.
--- @param groups    table        additional or overwrite groups (default: {choppy = hardness, flammable = 3, wood = 1})
--- @param title     string       prefix to description of nodes or will extracted from `node_bane` (`title`.." Planks")
local function register_planks(node_name, hardness, craft, groups, title)
	local sub_name = node_name:split(":")[2]
	title = title and title:first_to_upper() or sub_name:first_to_upper()
	local texture = node_name:replace(":", "_") .. ".png"
	if not io.file_exists(minetest.get_mod_textures_folder() .. texture) then
		minetest.log("warning", ("Can't find texture: \"%s\". Planks `%s` not registered."):format(texture, node_name))
		return
	end

	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())

	minetest.register_node(node_name, {
		description  = S(title .. " Planks"),
		tiles        = { texture },
		groups       = table.overwrite({ choppy = hardness, flammable = 3, wood = 1, planks = 1 }, groups or {}),
		sounds       = default.node_sound_wood_defaults(),
		paramtype2   = "facedir",
		place_param2 = 0,
	})

	planks.nodes[node_name] = minetest.registered_nodes[node_name]

	local stairs_subname = sub_name
	stairs.register_stair_and_slab(
		stairs_subname,
		node_name,
		table.overwrite({ choppy = hardness, flammable = 3, wooden = 1 }, groups or {}),
		{ texture },
		S(title .. " Wood Stair"),
		S(title .. " Wood Slab"),
		default.node_sound_wood_defaults(),
		false,
		S("Inner " .. title .. " Wood Stair"),
		S("Outer " .. title .. " Wood Stair")
	)

	if craft == nil then
		return
	end
	minetest.register_craft({
		output = node_name .. " 4",
		recipe = type(craft) == "string"
			and { { craft } }
			or craft
	})
end


return {
	add_existing    = add_existing,
	register_planks = register_planks,
	--- @return NodeDefinition[]
	get_nodes       = function() return planks.nodes end,
}
