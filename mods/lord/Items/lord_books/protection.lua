-- zpc mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local S = core.get_mod_translator()

local book_form = dofile(core.get_modpath(core.get_current_modname()) .. '/book_form.lua')

local has_group = book_form.has_group

local KEY = 'zpc'

zpc = {}
zpc.users = {}
zpc.crafts = {}
zpc.itemlist = {}

zpc.items_in_group = function(group)
	local items = {}

	for name, item in pairs(core.registered_items) do
		-- the node should be in all groups
		local ok = true
		for _, g in ipairs(group:split(',')) do
			if not item.groups[g] then
				ok = false
			end
		end
		if ok then table.insert(items,name) end
	end

	return items
end

--- The book of protection has the recipes of the armor (except forbidden one) only.
local function is_wanted_craft(input, output)
	return (has_group(output, 'armor_use') or has_group(output, 'armor_crafts')) and not has_group(output, 'forbidden')
end

zpc.add_craft = function(input, output, groups)
	book_form.add_craft(zpc, input, output, groups, is_wanted_craft)
end

zpc.load_crafts = function(name)
	zpc.crafts[name] = {}
	local _recipes = core.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
			if (recipe and recipe.items and recipe.type) then
				zpc.add_craft(recipe, name)
			end
		end
	end
	if zpc.crafts[name] == nil or #zpc.crafts[name] == 0 then
		zpc.crafts[name] = nil
	else
		table.insert(zpc.itemlist,name)
	end
end

zpc.need_load_all = true

zpc.load_all = function()
	print("Loading all crafts, this may take some time...")
	local i = 0
	for name, item in pairs(core.registered_items) do
		if (name and name ~= "") then
			zpc.load_crafts(name)
		end
		i = i+1
	end
	table.sort(zpc.itemlist)
	zpc.need_load_all = false
	print("All crafts loaded !")
end

zpc.form = {}
--- @type string
zpc.form.NAME = "protection_book_form"
--- @param player_name string
--- @return string
zpc.form.get_spec = function(player_name)
	if zpc.need_load_all then zpc.load_all() end

	local user     = zpc.users[player_name]
	local formspec = 'size[8,7.5]'
		.. 'button_exit[6,7;2,0.5;;' .. S('Exit') .. ']'
		.. book_form.navigation_buttons(KEY, user.history)
		.. book_form.selected_recipe(KEY, zpc, user)

	local buttons, shown = book_form.item_buttons(KEY, zpc.itemlist, user.page, 3.5)

	return formspec
		.. buttons
		.. book_form.page_buttons(KEY, user.page, shown, '7')
		.. book_form.page_label('6.85', user.page, #zpc.itemlist)
		.. 'label[0,0;' .. S('Book of Protection') .. ']'
		.. 'background[5,5;1,1;books_formbg.png;true]'
end
--- @param player_name string
zpc.form.show = function(player_name)
	core.show_formspec(player_name, zpc.form.NAME, zpc.form.get_spec(player_name))
end


---@param player    Player
---@param form_name string
---@param fields    table
core.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zpc.form.NAME then
		return
	end

	book_form.handle_fields(zpc, KEY, player, fields, false)
end)

core.register_tool("lord_books:protection_book",{
    description = S("Book of Protection"),
    groups = {book=1, paper=1},
    inventory_image = "protection_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1,
    on_use = function(itemstack, player, pointed_thing)
		local pn = player:get_player_name();
		if zpc.users[pn] == nil then zpc.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
		zpc.form.show(pn)
    end,
})
