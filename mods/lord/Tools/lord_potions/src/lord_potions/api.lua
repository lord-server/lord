local S = minetest.get_translator('lord_potion')

local potions = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	all_items = {},
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	lord_items = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { potions = 1 }),
	})
	potions.all_items[node_name] = definition
end

--- default groups: default: { dig_immediate = 3, attached_node = 1, vessel = 1, potions = 1 }
--- @param item_name string       technical item/node name ("<mod>:<node>").
--- @param groups    table        additional or overwrite groups
--- @param title     string       prefix to description of item or will extracted from `item_name` (`title`.." Potion")
local function register_potion(item_name, groups, title)
	local sub_name = item_name:split(":")[2]
	title = title and title:first_to_upper() or sub_name:first_to_upper()
	local texture = item_name:replace(":", "_") .. ".png"
	--if not io.file_exists(minetest.get_mod_textures_folder() .. texture) then
	--	minetest.log("warning", ("Can't find texture: \"%s\". Potion `%s` not registered."):format(texture, node_name))
	--	return
	--end

	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())

	minetest.register_node(item_name, {
		description  = S(title .. " Potion"),
		tiles        = { texture },
		groups       = table.overwrite({ dig_immediate = 3, attached_node = 1, vessel = 1, potions = 1 }, groups or {}),
		sounds       = default.node_sound_glass_defaults(),
		walkable     = false,
		drawtype     = "plantlike",
		paramtype    = "light",
		on_use = function(itemstack, user, pointed_thing)
			effects.for_player(user):apply(lord_effects.SPEED, 3, 1 * 60)
		end
	})

	potions.all_items[item_name]  = minetest.registered_nodes[item_name]
	potions.lord_items[item_name] = minetest.registered_nodes[item_name]

end


return {
	add_existing    = add_existing,
	register_potion = register_potion,
	--- @return NodeDefinition[]
	get_nodes       = function() return potions.all_items end,
	get_lord_nodes  = function() return potions.lord_items end,
}
