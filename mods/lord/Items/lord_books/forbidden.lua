-- zfc mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local S = core.get_mod_translator()

local book_form = dofile(core.get_modpath(core.get_current_modname()) .. '/book_form.lua')

local has_group = book_form.has_group

local KEY = 'zfc'

zfc = {}
zfc.users = {}
zfc.crafts = {}
zfc.itemlist = {}

zfc.items_in_group = function(group)
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

--- The book of forbidden crafts has the recipes of the forbidden items only.
local function is_wanted_craft(input, output)
	return has_group(output, 'forbidden')
end

zfc.add_craft = function(input, output, groups)
	book_form.add_craft(zfc, input, output, groups, is_wanted_craft)
end

zfc.load_crafts = function(name)
	zfc.crafts[name] = {}
	local _recipes = core.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
			if (recipe and recipe.items and recipe.type) then
				zfc.add_craft(recipe, name)
			end
		end
	end
	if zfc.crafts[name] == nil or #zfc.crafts[name] == 0 then
		zfc.crafts[name] = nil
	else
		table.insert(zfc.itemlist,name)
	end
end

zfc.need_load_all = true

zfc.load_all = function()
	print("Loading all crafts, this may take some time...")
	local i = 0
	for name, item in pairs(core.registered_items) do
		if (name and name ~= "") then
			zfc.load_crafts(name)
		end
		i = i+1
	end
	table.sort(zfc.itemlist)
	zfc.need_load_all = false
	print("All crafts loaded !")
end

zfc.form = {}
--- @type string
zfc.form.NAME = "forbidden_crafts_book_form"
--- @param player_name string
--- @return string
zfc.form.get_spec = function(player_name)
	if zfc.need_load_all then zfc.load_all() end

	local user     = zfc.users[player_name]
	local formspec = 'size[8,7.5]'
		.. 'button_exit[6,7;2,0.5;;' .. S('Exit') .. ']'
		.. book_form.navigation_buttons(KEY, user.history)
		.. book_form.selected_recipe(KEY, zfc, user)

	local buttons, shown = book_form.item_buttons(KEY, zfc.itemlist, user.page, 3.5)

	return formspec
		.. buttons
		.. book_form.page_buttons(KEY, user.page, shown, '7')
		.. book_form.page_label('6.85', user.page, #zfc.itemlist)
		.. 'label[0,0;' .. S('Book of Forbidden Crafts') .. ']'
		.. 'background[5,5;1,1;books_formbg.png;true]'
end
--- @param player_name string
zfc.form.show = function(player_name)
	core.show_formspec(player_name, zfc.form.NAME, zfc.form.get_spec(player_name))
end


---@param player    Player
---@param form_name string
---@param fields    table
core.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zfc.form.NAME then
		return
	end

	book_form.handle_fields(zfc, KEY, player, fields, false)
end)

core.register_tool("lord_books:forbidden_crafts_book",{
    description = S("Book of Forbidden Crafts"),
    inventory_image = "forbidden_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1,
    groups = {armor_crafts=1, book=1, paper=1},
    on_use = function(itemstack, player, pointed_thing)
		local pn = player:get_player_name();
		if zfc.users[pn] == nil then zfc.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
		zfc.form.show(pn)
    end,
})
