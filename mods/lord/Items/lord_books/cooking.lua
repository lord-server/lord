-- zcc mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local S = core.get_mod_translator()

local book_form = dofile(core.get_modpath(core.get_current_modname()) .. '/book_form.lua')

local has_group = book_form.has_group

local KEY = 'zcc'

zcc                = {}
zcc.users          = {}
zcc.crafts         = {}
zcc.itemlist       = {}

zcc.items_in_group = function(group)
	local items = {}

	for name, item in pairs(core.registered_items) do
		-- the node should be in all groups
		local ok = true
		for _, g in ipairs(group:split(',')) do
			if not item.groups[g] then
				ok = false
			end
		end
		if ok then table.insert(items, name) end
	end

	return items
end

--- The book of cooking has only the cooking recipes.
local function is_wanted_craft(input, output)
	if has_group(output, 'forbidden') or has_group(output, 'armor_use') or has_group(output, 'armor_crafts') then
		return false
	end

	return has_group(output, 'cook_crafts') or input.type == 'cooking'
end

zcc.add_craft = function(input, output, groups)
	book_form.add_craft(zcc, input, output, groups, is_wanted_craft)
end

zcc.load_crafts    = function(name)
	zcc.crafts[name] = {}
	local _recipes   = core.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
			if (recipe and recipe.items and recipe.type) then
				zcc.add_craft(recipe, name)
			end
		end
	end
	if zcc.crafts[name] == nil or #zcc.crafts[name] == 0 then
		zcc.crafts[name] = nil
	else
		table.insert(zcc.itemlist, name)
	end
end

zcc.need_load_all  = true

zcc.load_all       = function()
	print("Loading all crafts, this may take some time...")
	local i = 0
	for name, item in pairs(core.registered_items) do
		if (name and name ~= "") then
			zcc.load_crafts(name)
		end
		i = i + 1
	end
	table.sort(zcc.itemlist)
	zcc.need_load_all = false
	print("All crafts loaded !")
end

zcc.form           = {}
--- @type string
zcc.form.NAME      = "cooking_book_form"
--- @param player_name string
--- @return string
zcc.form.get_spec = function(player_name)
	if zcc.need_load_all then
		zcc.load_all()
	end

	local user     = zcc.users[player_name]
	local formspec = 'size[8,7.5]'
		.. 'button_exit[6,7;2,0.5;;' .. S('Exit') .. ']'
		.. book_form.navigation_buttons(KEY, user.history)
		.. book_form.selected_recipe(KEY, zcc, user)

	local buttons, shown = book_form.item_buttons(KEY, zcc.itemlist, user.page, 3.5)

	return formspec
		.. buttons
		.. book_form.page_buttons(KEY, user.page, shown, '7')
		.. book_form.page_label('6.85', user.page, #zcc.itemlist)
		.. 'background[5,5;1,1;books_formbg.png;true]'
		.. 'label[0,0;' .. S('Book of Cooking') .. ']'
end
--- @param player_name string
zcc.form.show      = function(player_name)
	core.show_formspec(player_name, zcc.form.NAME, zcc.form.get_spec(player_name))
end

---@param player    Player
---@param form_name string
---@param fields    table
core.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zcc.form.NAME then
		return
	end

	book_form.handle_fields(zcc, KEY, player, fields, false)
end)

core.register_tool("lord_books:cooking_book", {
	description     = S("Book of Cooking"),
	groups          = { book = 1, paper = 1 },
	inventory_image = "cooking_book.png",
	wield_image     = "",
	wield_scale     = { x = 1, y = 1, z = 1 },
	stack_max       = 1,
	on_use          = function(itemstack, player, pointed_thing)
		local pn = player:get_player_name();
		if zcc.users[pn] == nil then
			zcc.users[pn] = { current_item = "", alt = 1, page = 0, history = { index = 0, list = {} } }
		end
		zcc.form.show(pn)
	end,
})
