-- zmc mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local S = core.get_mod_translator()

local book_form = dofile(core.get_modpath(core.get_current_modname()) .. '/book_form.lua')

local KEY = 'zmc'

local DEFAULT_LANG = core.settings:get("language")
if DEFAULT_LANG == nil or DEFAULT_LANG == "" then DEFAULT_LANG = os.getenv("LANG") end
if DEFAULT_LANG == nil or DEFAULT_LANG == "" then DEFAULT_LANG = "en" end

zmc = {}
zmc.users = {}
zmc.crafts = {}
zmc.itemlist = {}

zmc.items_in_group = function(group)
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

--- The master book has all the recipes.
local function is_wanted_craft(input, output)
	return true
end

zmc.add_craft = function(input, output, groups)
	book_form.add_craft(zmc, input, output, groups, is_wanted_craft)
end

--- Check if something went wrong.
--- For ex., while refactor for using MTG/default as git submodule, recipe for the `default:sign_wall` was gone (#1127),
--- but there still was one for `default:sign_wall_wood` alias and its not displayed in book.
--- If so, adds recipe to book & writes warning to log.
--- @param name string
--- @return table|nil recipes of the item and of its aliases
local function get_recipes_with_aliases(name)
	local recipes = core.get_all_craft_recipes(name)

	local aliases = table.keys_of(core.registered_aliases, name)
	if not aliases then
		return recipes
	end

	local aliases_recipes = {}
	for _, alias in pairs(aliases) do
		local alias_recipes = core.get_all_craft_recipes(alias)
		if alias_recipes then
			aliases_recipes = table.merge_values(aliases_recipes, alias_recipes)
		end
	end
	if #aliases_recipes == 0 then
		return recipes
	end

	if not recipes then
		core.log("warning", "Recipe exists only for alias: " .. dump(aliases_recipes))
	else
		core.log("warning", "Extra recipe for alias: " .. dump(aliases_recipes))
	end

	return table.merge_values(recipes, aliases_recipes)
end

zmc.load_crafts = function(name)
	zmc.crafts[name] = {}

	local recipes = get_recipes_with_aliases(name)
	if recipes then
		for _, recipe in pairs(recipes) do
			if (recipe and recipe.items and recipe.type) then
				zmc.add_craft(recipe, name)
			end
		end
	end
	if zmc.crafts[name] == nil or #zmc.crafts[name] == 0 then
		zmc.crafts[name] = nil
	else
		table.insert(zmc.itemlist,name)
	end
end

zmc.need_load_all = true

zmc.load_all = function()
	print("Loading all crafts, this may take some time...")
	local i = 0
	for name, item in pairs(core.registered_items) do
		if (name and name ~= "") then
			zmc.load_crafts(name)
		end
		i = i+1
	end
	table.sort(zmc.itemlist)
	zmc.need_load_all = false
	print("All crafts loaded !")
end

---@param find string
---@return table
local function filter_by_search(find, lang_code)
	if find == "" then
		return zmc.itemlist
	end
	find = string.lower(find)
	local filtered_list = {}
	for _, name in pairs(zmc.itemlist) do
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

zmc.form = {}
--- @type string
zmc.form.NAME = "master_book_form"
--- @param player_name string
--- @param find        string
--- @return string
zmc.form.get_spec = function(player_name, find)
	find = find or ''
	if zmc.need_load_all then zmc.load_all() end

	local user     = zmc.users[player_name]
	local formspec = 'size[8,8.5]'
		.. 'button_exit[6,8;2,0.5;;' .. S('Exit') .. ']'
		.. book_form.navigation_buttons(KEY, user.history)
		.. book_form.selected_recipe(KEY, zmc, user)

	-- Filter items by `filter` field value
	formspec = formspec ..
		'field[0.3,4.25;4,0.5;' .. KEY .. '_filter;' .. S('Search') .. ';' .. core.formspec_escape(find) .. ']' ..
		'field_close_on_enter[' .. KEY .. '_filter;false]'

	local lang_code     = core.get_player_information(player_name).lang_code or DEFAULT_LANG
	local filtered_list = filter_by_search(find, lang_code)

	local buttons, shown = book_form.item_buttons(KEY, filtered_list, user.page, 4.75)

	return formspec
		.. buttons
		.. book_form.page_buttons(KEY, user.page, shown, '8')
		.. book_form.page_label('8', user.page, #filtered_list)
		.. 'button[0,2.8;2,0.5;potions;' .. S('Potions') .. ']'
		.. 'button[0,2.1;2,0.5;brews;' .. S('Brewing') .. ']'
		.. 'label[0,0;' .. S('Master Book of Crafts') .. ']'
		.. 'background[5,5;1,1;books_formbg.png;true]'
end
--- @param player_name string
--- @param find        string
zmc.form.show = function(player_name, find)
	core.show_formspec(player_name, zmc.form.NAME, zmc.form.get_spec(player_name, find))
end


---@param player    Player
---@param form_name string
---@param fields    table
core.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zmc.form.NAME then
		return
	end

	-- HACK: обработка кнопок `potions` и `brews` происходит в обработчиках форм книг
	--       `lord_books:potions_book` и `lord_books:brewing_book` соответственно.
	--       см. "HACK" в `potions.lua` и `alcohol.lua`.

	book_form.handle_fields(zmc, KEY, player, fields, true)
end)

core.register_tool("lord_books:master_book",{
    description = S("Master Book of Crafts"),
    inventory_image = "master_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1,
    groups = {forbidden=1, book=1, paper=1},
    on_use = function(itemstack, player, pointed_thing)
		local pn = player:get_player_name();
		if zmc.users[pn] == nil then zmc.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
		zmc.form.show(pn)
    end,
})
