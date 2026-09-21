-- ZCG mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local S = core.get_mod_translator()

local book_form = dofile(core.get_modpath(core.get_current_modname()) .. '/book_form.lua')

local has_group = book_form.has_group

local KEY = 'zcg'

local DEFAULT_LANG = core.settings:get("language")
if DEFAULT_LANG == nil or DEFAULT_LANG == "" then DEFAULT_LANG = os.getenv("LANG") end
if DEFAULT_LANG == nil or DEFAULT_LANG == "" then DEFAULT_LANG = "en" end

zcg = {}
zcg.users = {}
zcg.crafts = {}
zcg.itemlist = {}

zcg.items_in_group = function(group)
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

--- The book of crafts has all the recipes, except forbidden, armor and cooking ones.
local function is_wanted_craft(input, output)
	if has_group(output, 'forbidden') or has_group(output, 'armor_use')
		or has_group(output, 'armor_crafts') or has_group(output, 'cook_crafts') then
		return false
	end

	return input.type ~= 'cooking'
end

zcg.add_craft = function(input, output, groups)
	book_form.add_craft(zcg, input, output, groups, is_wanted_craft)
end

zcg.load_crafts = function(name)
	zcg.crafts[name] = {}
	local _recipes = core.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
			if (recipe and recipe.items and recipe.type) then
				zcg.add_craft(recipe, name)
			end
		end
	end
	if zcg.crafts[name] == nil or #zcg.crafts[name] == 0 then
		zcg.crafts[name] = nil
	else
		table.insert(zcg.itemlist,name)
	end
end

zcg.need_load_all = true

zcg.load_all = function()
	print("Loading all crafts, this may take some time...")
	local i = 0
	for name, item in pairs(core.registered_items) do
		if (name and name ~= "") then
			zcg.load_crafts(name)
		end
		i = i+1
	end
	table.sort(zcg.itemlist)
	zcg.need_load_all = false
	print("All crafts loaded !")
end

---@param find string
---@return table
local function filter_by_search(find, lang_code)
	if find == "" then
		return zcg.itemlist
	end
	find = string.lower(find)
	local filtered_list = {}
	for _, name in pairs(zcg.itemlist) do
		local description_en = core.registered_items[name].description
		local description_player_lang = core.get_translated_string(lang_code, description_en)

		if
			string.find(name, find, nil, true) or
			string.find(string.lower(description_en), find, nil, true) or
			string.find(string.lower(description_player_lang), find, nil, true)
		then
			table.insert(filtered_list, name)
		end
	end

	return filtered_list
end

zcg.form = {}
--- @type string
zcg.form.NAME = "master_book_form"
--- @param player_name string
--- @param find        string
--- @return string
zcg.form.get_spec = function(player_name, find)
	find = find or ''
	if zcg.need_load_all then zcg.load_all() end

	local user     = zcg.users[player_name]
	local formspec = 'size[8,7.75]'
		.. 'button_exit[6,7.25;2,0.5;;' .. S('Exit') .. ']'
		.. book_form.navigation_buttons(KEY, user.history)
		.. book_form.selected_recipe(KEY, zcg, user)

	-- Filter items by `filter` field value
	formspec = formspec ..
		'field[0.3,3.5;4,0.5;' .. KEY .. '_filter;' .. S('Search') .. ';' .. core.formspec_escape(find) .. ']' ..
		'field_close_on_enter[' .. KEY .. '_filter;false]'

	local lang_code     = core.get_player_information(player_name).lang_code or DEFAULT_LANG
	local filtered_list = filter_by_search(find, lang_code)

	local buttons, shown = book_form.item_buttons(KEY, filtered_list, user.page, 4)

	return formspec
		.. buttons
		.. book_form.page_buttons(KEY, user.page, shown, '7.25')
		.. book_form.page_label('7.25', user.page, #filtered_list)
		.. 'background[5,5;1,1;books_formbg.png;true]'
		.. 'label[0,0;' .. S('Book of Crafts') .. ']'
end
--- @param player_name string
--- @param find        string
zcg.form.show = function(player_name, find)
	core.show_formspec(player_name, zcg.form.NAME, zcg.form.get_spec(player_name, find))
end


---@param player    Player
---@param form_name string
---@param fields    table
core.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zcg.form.NAME then
		return
	end

	book_form.handle_fields(zcg, KEY, player, fields, true)
end)

core.register_tool("lord_books:crafts_book",{
    description = S("Book of Crafts"),
    groups = {book=1, paper=1},
    inventory_image = "crafts_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1,
    on_use = function(itemstack, player, pointed_thing)
		local pn = player:get_player_name();
		if zcg.users[pn] == nil then zcg.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
		zcg.form.show(pn)
    end,
})
