-- ZCG mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local SL = minetest.get_translator("lord_books")

local DEFAULT_LANG = minetest.settings:get("language")
if DEFAULT_LANG == nil or DEFAULT_LANG == "" then DEFAULT_LANG = os.getenv("LANG") end
if DEFAULT_LANG == nil or DEFAULT_LANG == "" then DEFAULT_LANG = "en" end

zcg = {}
zcg.users = {}
zcg.crafts = {}
zcg.itemlist = {}

zcg.items_in_group = function(group)
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

zcg.add_craft = function(input, output, groups)
	if minetest.get_item_group(output, "forbidden") > 0 then
		return
	end
     if minetest.get_item_group(output, "armor_use") > 0 then
		return
	end
     if minetest.get_item_group(output, "armor_crafts") > 0 then
		return
	end
     if minetest.get_item_group(output, "cook_crafts") > 0 then
		return
	end
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
				for _, gi in ipairs(zcg.items_in_group(groupname)) do
					local g2 = groups
					g2[groupname] = gi
					zcg.add_craft({
						width = c.width,
						type = c.type,
						items = table.copy(c.items)
					}, output, g2) -- it is needed to copy the table, else groups won't work right
				end
				return
			end
		end
	end
     if c.type == "cooking" then
          return
     end
	if c.width == 0 then c.width = 3 end
	table.insert(zcg.crafts[output],c)
end

zcg.load_crafts = function(name)
	zcg.crafts[name] = {}
	local _recipes = minetest.get_all_craft_recipes(name)
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
	for name, item in pairs(minetest.registered_items) do
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

zcg.form = {}
--- @type string
zcg.form.NAME = "master_book_form"
--- @param player_name string
--- @param find        string
--- @return string
zcg.form.get_spec = function(player_name, find)
	find = find or "";
	if zcg.need_load_all then zcg.load_all() end
	local page = zcg.users[player_name].page
	local alt = zcg.users[player_name].alt
	local current_item = zcg.users[player_name].current_item
	local formspec =
		"size[8,7.75]" ..
		"button_exit[6,7.25;2,0.5;;"..SL("Exit").."]" ..
		"listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
	if zcg.users[player_name].history.index > 1 then
		formspec = formspec .. "image_button[0,1;1,1;books_previous.png;zcg_previous;;false;false;books_previous_press.png]"
	else
		formspec = formspec .. "image[0,1;1,1;books_previous_inactive.png]"
	end
	if zcg.users[player_name].history.index < #zcg.users[player_name].history.list then
		formspec = formspec .. "image_button[1,1;1,1;books_next.png;zcg_next;;false;false;books_next_press.png]"
	else
		formspec = formspec .. "image[1,1;1,1;books_next_inactive.png]"
	end

	-- Show craft recipe
	if current_item ~= "" then
		if zcg.crafts[current_item] then
			if alt > #zcg.crafts[current_item] then
				alt = #zcg.crafts[current_item]
			end
			if alt > 1 then
				formspec = formspec .. "button[7,0;1,1;zcg_alt:"..(alt-1)..";^]"
			end
			if alt < #zcg.crafts[current_item] then
				formspec = formspec .. "button[7,2;1,1;zcg_alt:"..(alt+1)..";v]"
			end
			local c = zcg.crafts[current_item][alt]
			if c then
				local x = 3
				local y = 0
				for i, item in pairs(c.items) do
					formspec = formspec ..
						"item_image_button[" ..
							((i - 1) % c.width + x) .. "," .. (math.floor((i - 1) / c.width + y)) .. ";" ..
							"1,1;" ..
							item .. ";" ..
							"zcg:" .. item .. ";" ..
						"]"
				end
				if c.type == "normal" or c.type == "cooking" then
					formspec = formspec .. "image[6,2;1,1;books_method_"..c.type..".png]"
				else -- we don't have an image for other types of crafting
					formspec = formspec .. "label[0,2;Method: "..c.type.."]"
				end
				formspec = formspec .. "image[6,1;1,1;books_craft_arrow.png]"
				formspec = formspec .. "item_image_button[7,1;1,1;"..zcg.users[player_name].current_item..";;]"
			end
		end
	end

	-- Filter items by `filter` field value
	formspec = formspec ..
		"field[0.3,3.5;4,0.5;zcg_filter;" .. SL("Search") .. ";" .. minetest.formspec_escape(find) .. "]" ..
		"field_close_on_enter[zcg_filter;false]"

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
					(i % 8) .. "," .. (math.floor(i / 8) + 4) .. ";" ..
					"1,1;" ..
					name .. ";" ..
					"zcg:" .. name .. ";" ..
				"]"
			i = i+1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,7.25;1,.5;zcg_page:"..(page-1)..";<<]"
	end
	if i >= npp then
		formspec = formspec .. "button[1,7.25;1,.5;zcg_page:"..(page+1)..";>>]"
	end
	-- The Y is approximatively the good one to have it centered vertically...
	formspec = formspec .. "label[2,7.25;"..SL("Page").." "..(page+1).."/"..(math.floor(#filtered_list/npp+1)).."]"
	formspec = formspec .. "background[5,5;1,1;books_formbg.png;true]"
	formspec = formspec .. "label[0,0;"..SL("Book of Crafts").."]"
	return formspec
end
--- @param player_name string
--- @param find        string
zcg.form.show = function(player_name, find)
	minetest.show_formspec(player_name, zcg.form.NAME, zcg.form.get_spec(player_name, find))
end


---@param player    Player
---@param form_name string
---@param fields    table
minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zcg.form.NAME then
		return
	end

	local pn = player:get_player_name();
	if zcg.users[pn] == nil then zcg.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
	local search_phrase = fields.zcg_filter or "";
	local new_filter =false
	if fields.key_enter and fields.key_enter_field == "zcg_filter" and fields.zcg_filter then
		new_filter = true
		zcg.users[pn].page = 0
	end
	if fields.zcg or new_filter then
		zcg.form.show(pn, search_phrase)
		return
	elseif fields.zcg_previous then
		if zcg.users[pn].history.index > 1 then
			zcg.users[pn].history.index = zcg.users[pn].history.index - 1
			zcg.users[pn].current_item = zcg.users[pn].history.list[zcg.users[pn].history.index]
			zcg.form.show(pn, search_phrase)
		end
	elseif fields.zcg_next then
		if zcg.users[pn].history.index < #zcg.users[pn].history.list then
			zcg.users[pn].history.index = zcg.users[pn].history.index + 1
			zcg.users[pn].current_item = zcg.users[pn].history.list[zcg.users[pn].history.index]
			zcg.form.show(pn, search_phrase)
		end
	end
	for k, v in pairs(fields) do
		if (k:starts_with("zcg:")) then
			local ni = k:sub(5)
			if zcg.crafts[ni] then
				zcg.users[pn].current_item = ni
				table.insert(zcg.users[pn].history.list, ni)
				zcg.users[pn].history.index = #zcg.users[pn].history.list
				zcg.form.show(pn, search_phrase)
			end
		elseif (k:starts_with("zcg_page:")) then
			zcg.users[pn].page = tonumber(k:sub(10))
			zcg.form.show(pn, search_phrase)
		elseif (k:starts_with("zcg_alt:")) then
			zcg.users[pn].alt = tonumber(k:sub(9))
			zcg.form.show(pn, search_phrase)
		end
	end
end)

minetest.register_tool("lord_books:crafts_book",{
    description = SL("Book of Crafts"),
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
