local S = minetest.get_mod_translator()


local alcohol = {
	--- @type table<string,ItemDefinition>|ItemDefinition[]
	items = {},
	--- @type table<string,ItemDefinition>|ItemDefinition[]
	lord_items = {},
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_items[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { alcohol = 1 }),
	})
	alcohol.items[node_name] = definition
end

--- @param item_name string       technical node name ("<mod>:<node>").
--- @param satiety   number       hp of satiety as a food.
--- @param groups    table        additional or overwrite groups (default: {alcohol = 1})
--- @param title     string       prefix to description of nodes or will extracted from `node_bane`
local function register(item_name, satiety, groups, title)
	local sub_name = item_name:split(":")[2]
	title = title and title:first_to_upper() or sub_name:first_to_upper()
	local texture = item_name:replace(":", "_") .. ".png"
	if not io.file_exists(minetest.get_mod_textures_folder() .. texture) then
		minetest.log("warning", ("Can't find texture: \"%s\". Alcohol `%s` not registered."):format(texture, item_name))
		return
	end

	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())

	minetest.register_craftitem( item_name, {
		description     = S(title),
		inventory_image = texture,
		wield_image     = texture,
		on_use          = minetest.item_eat(satiety),
		_tt_food_hp     = satiety,
	})

	alcohol.items[item_name]      = minetest.registered_items[item_name]
	alcohol.lord_items[item_name] = minetest.registered_items[item_name]
end


return {
	add_existing   = add_existing,
	register       = register,
	--- @return NodeDefinition[]
	get_nodes      = function() return alcohol.items end,
	get_lord_nodes = function() return alcohol.lord_items end,
}
