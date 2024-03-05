local S = minetest.get_translator("lottplants")

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
--- @param title     string       will be added to description of nodes.
--- @param hardness  number       how difficult to chop.
--- @param craft     string|table node name to craft from, or table with own recipe.
--- @param groups    table        additional or overwrite groups (default: {choppy = hardness, flammable = 3, wood = 1})
local function register_planks(node_name, title, hardness, craft, groups)
	title = title:first_to_upper()
	local texture = node_name:replace(":", "_") .. ".png"
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

	local stairs_subname = node_name:split(":")[2]
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

--- Also we use:
---  - Apple tree planks from MTG (default:wood)
---  - Jungle tree planks from MTG (default:junglewood)
add_existing("default:wood")
add_existing("default:junglewood")

register_planks("lottplants:alderwood", "Alder", 2, "lottplants:aldertree")
register_planks("lottplants:birchwood", "Birch", 3, "lottplants:birchtree")
register_planks("lottplants:pinewood",  "Pine",  3, "lottplants:pinetree")
register_planks("lottplants:lebethronwood", "Lebethron", 1, "lottplants:lebethrontree")
register_planks("lottplants:mallornwood", "Mallorn", 1, "lottplants:mallorntree")
register_planks("lottplants:hardwood", "Hardwood", 1, nil, { flammable = 1 })
register_planks("lottplants:firwood", "Fir", 3, "lottplants:firtree")
minetest.register_alias("lord_homedecor:hardwood", "lottplants:hardwood")

-- Crafting
-- additional craft from young mallorn
minetest.register_craft({
	output = 'lottplants:mallornwood 2',
	recipe = {
		{ 'lottplants:mallorntree_young' },
	}
})
-- different crafts for hardwood
minetest.register_craft({
	output = 'lottplants:hardwood 2',
	recipe = {
		{"default:wood", "default:junglewood"},
		{"default:junglewood", "default:wood"},
	}
})
minetest.register_craft({
	output = 'lottplants:hardwood 2',
	recipe = {
		{"default:junglewood", "default:wood"},
		{"default:wood", "default:junglewood"},
	}
})

-- hardwood burned slower, than group:wood
minetest.register_craft({
	type = "fuel",
	recipe = "lottplants:hardwood",
	burntime = 28,
})

--- @class lottplants.Planks_API
local Planks_API = {
	add_existing = add_existing,
	get_nodes    = function() return planks.nodes end
}


return Planks_API
