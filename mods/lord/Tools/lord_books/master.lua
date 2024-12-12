-- zmc mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local SL = minetest.get_mod_translator()

local DEFAULT_LANG = minetest.settings:get("language")
if DEFAULT_LANG == nil or DEFAULT_LANG == "" then DEFAULT_LANG = os.getenv("LANG") end
if DEFAULT_LANG == nil or DEFAULT_LANG == "" then DEFAULT_LANG = "en" end

zmc = {}
zmc.users = {}
zmc.crafts = {}
zmc.itemlist = {}

zmc.items_in_group = function(group)
	local items = {}

	for name, item in pairs(minetest.registered_items) do
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

zmc.add_craft = function(input, output, groups)
	if not groups then groups = {} end
	local c = {}
	c.width = input.width
	c.type = input.type
	c.items = input.items
	if c.items == nil then return end
	for i, item in pairs(c.items) do
		if item:starts_with("group:") then
			local groupname = item:sub(7)
			if groups[groupname] ~= nil then
				c.items[i] = groups[groupname]
			else
				for _, gi in ipairs(zmc.items_in_group(groupname)) do
					local g2 = groups
					g2[groupname] = gi
					zmc.add_craft({
						width = c.width,
						type = c.type,
						items = table.copy(c.items)
					}, output, g2) -- it is needed to copy the table, else groups won't work right
				end
				return
			end
		end
	end
	if c.width == 0 then c.width = 3 end
	table.insert(zmc.crafts[output],c)
end

zmc.load_crafts = function(name)
	zmc.crafts[name] = {}
	local recipes = minetest.get_all_craft_recipes(name)

	-- Check if something went wrong.
	-- For ex., while refactor for using MTG/default as git submodule, recipe for the `default:sign_wall` was gone (#1127),
	-- but there still was one for `default:sign_wall_wood` alias and its not displayed in book.
	-- If so, adds recipe to book & writes warning to log.
	local aliases = table.keys_of(minetest.registered_aliases, name)
	if aliases then
		local aliases_recipes = {}
		for _, alias in pairs(aliases) do
			local alias_recipes = minetest.get_all_craft_recipes(alias)
			if alias_recipes then
				aliases_recipes = table.merge_values(aliases_recipes, alias_recipes)
			end
		end
		if #aliases_recipes ~= 0 then
			if not recipes then
				minetest.log("warning", "Recipe exists only for alias: " .. dump(aliases_recipes))
			else
				minetest.log("warning", "Extra recipe for alias: " .. dump(aliases_recipes))
			end
			recipes = table.merge_values(recipes, aliases_recipes)
		end
	end

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
	for name, item in pairs(minetest.registered_items) do
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
		local description_en = minetest.registered_items[name].description
		local description_player_lang = minetest.get_translated_string(lang_code, description_en)

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
	find = find or ""
	if zmc.need_load_all then zmc.load_all() end
	local page = zmc.users[player_name].page
	local alt = zmc.users[player_name].alt
	local current_item = zmc.users[player_name].current_item
	local formspec =
		"size[8,8.5]" ..
		"button_exit[6,8;2,0.5;;"..SL("Exit").."]"
	if zmc.users[player_name].history.index > 1 then
		formspec = formspec .. "image_button[0,1;1,1;books_previous.png;zmc_previous;;false;false;books_previous_press.png]"
	else
		formspec = formspec .. "image[0,1;1,1;books_previous_inactive.png]"
	end
	if zmc.users[player_name].history.index < #zmc.users[player_name].history.list then
		formspec = formspec .. "image_button[1,1;1,1;books_next.png;zmc_next;;false;false;books_next_press.png]"
	else
		formspec = formspec .. "image[1,1;1,1;books_next_inactive.png]"
	end

	-- Show craft recipe
	if current_item ~= "" then
		if zmc.crafts[current_item] then
			if alt > #zmc.crafts[current_item] then
				alt = #zmc.crafts[current_item]
			end
			if alt > 1 then
				formspec = formspec .. "button[7,0;1,1;zmc_alt:"..(alt-1)..";^]"
			end
			if alt < #zmc.crafts[current_item] then
				formspec = formspec .. "button[7,2;1,1;zmc_alt:"..(alt+1)..";v]"
			end
			local c = zmc.crafts[current_item][alt]
			if c then
				local x = 3
				local y = 0
				for i, item in pairs(c.items) do
					formspec = formspec ..
						"item_image_button[" ..
							((i - 1) % c.width + x) .. "," .. (math.floor((i - 1) / c.width + y)) .. ";" ..
							"1,1;" ..
							item .. ";" ..
							"zmc:" .. item .. ";" ..
						"]"
				end
				if c.type == "normal" or c.type == "cooking" then
					formspec = formspec .. "image[6,2;1,1;books_method_"..c.type..".png]"
				else -- we don't have an image for other types of crafting
					formspec = formspec .. "label[0,2;Method: "..c.type.."]"
				end
				formspec = formspec .. "image[6,1;1,1;books_craft_arrow.png]"
				formspec = formspec .. "item_image_button[7,1;1,1;"..zmc.users[player_name].current_item..";;]"
			end
		end
	end

	-- Filter items by `filter` field value
	formspec = formspec ..
		"field[0.3,4.25;4,0.5;zmc_filter;" .. SL("Search") .. ";" .. minetest.formspec_escape(find) .. "]" ..
		"field_close_on_enter[zmc_filter;false]"

	local lang_code = minetest.get_player_information(player_name).lang_code or DEFAULT_LANG
	local filtered_list = filter_by_search(find, lang_code)

	-- Node list
	local npp = 8*3 -- nodes per page
	local i = 0 -- for positionning buttons
	local s = 0 -- for skipping pages
	for _, name in ipairs(filtered_list) do
		if s < page*npp then s = s+1 else
			if i >= npp then break end
			formspec = formspec ..
				"item_image_button[" ..
					(i % 8) .. "," .. (math.floor(i / 8) + 4.75) .. ";" ..
					"1,1;" ..
					name .. ";" ..
					"zmc:" .. name .. ";" ..
				"]"
			i = i+1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,8;1,.5;zmc_page:"..(page-1)..";<<]"
	end
	if i >= npp then
		formspec = formspec .. "button[1,8;1,.5;zmc_page:"..(page+1)..";>>]"
	end
	-- The Y is approximatively the good one to have it centered vertically...
	formspec = formspec .. "label[2,8;"..SL("Page").." "..(page+1).."/"..(math.floor(#filtered_list/npp+1)).."]"
	formspec = formspec .. "button[0,2.8;2,0.5;potions;"..SL("Potions").."]"
	formspec = formspec .. "button[0,2.1;2,0.5;brews;"..SL("Brewing").."]"
	formspec = formspec .. "label[0,0;"..SL("Master Book of Crafts").."]"
	formspec = formspec .. "background[5,5;1,1;books_formbg.png;true]"
	return formspec
end
--- @param player_name string
--- @param find        string
zmc.form.show = function(player_name, find)
	minetest.show_formspec(player_name, zmc.form.NAME, zmc.form.get_spec(player_name, find))
end


---@param player    Player
---@param form_name string
---@param fields    table
minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zmc.form.NAME then
		return
	end

	-- HACK: обработка кнопок `potions` и `brews` происходит в обработчиках форм книг
	--       `lord_books:potions_book` и `lord_books:brewing_book` соответственно.
	--       см. "HACK" в `potions.lua` и `alcohol.lua`.

	local pn = player:get_player_name();
	if zmc.users[pn] == nil then zmc.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
	local search_phrase = fields.zmc_filter or "";
	local new_filter = false
	if fields.key_enter and fields.key_enter_field == "zmc_filter" and fields.zmc_filter then
		new_filter = true
		zmc.users[pn].page = 0
	end
	if fields.zmc or new_filter then
		zmc.form.show(pn, search_phrase)
		return
	elseif fields.zmc_previous then
		if zmc.users[pn].history.index > 1 then
			zmc.users[pn].history.index = zmc.users[pn].history.index - 1
			zmc.users[pn].current_item = zmc.users[pn].history.list[zmc.users[pn].history.index]
			zmc.form.show(pn, search_phrase)
		end
	elseif fields.zmc_next then
		if zmc.users[pn].history.index < #zmc.users[pn].history.list then
			zmc.users[pn].history.index = zmc.users[pn].history.index + 1
			zmc.users[pn].current_item = zmc.users[pn].history.list[zmc.users[pn].history.index]
			zmc.form.show(pn, search_phrase)
		end
	end
	for k, v in pairs(fields) do
		if (k:starts_with("zmc:")) then
			local ni = k:sub(5)
			if zmc.crafts[ni] then
				zmc.users[pn].current_item = ni
				table.insert(zmc.users[pn].history.list, ni)
				zmc.users[pn].history.index = #zmc.users[pn].history.list
				zmc.form.show(pn, search_phrase)
			end
		elseif (k:starts_with("zmc_page:")) then
			zmc.users[pn].page = tonumber(k:sub(10))
			zmc.form.show(pn, search_phrase)
		elseif (k:starts_with("zmc_alt:")) then
			zmc.users[pn].alt = tonumber(k:sub(9))
			zmc.form.show(pn, search_phrase)
		end
	end
end)

minetest.register_tool("lord_books:master_book",{
    description = SL("Master Book of Crafts"),
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
