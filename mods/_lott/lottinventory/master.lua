-- zmc mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local SL = lord.require_intllib()

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

local table_copy = function(table)
	local out = {}
	for k,v in pairs(table) do
		out[k] = v
	end
	return out
end

zmc.add_craft = function(input, output, groups)
	if not groups then groups = {} end
	local c = {}
	c.width = input.width
	c.type = input.type
	c.items = input.items
	if c.items == nil then return end
	for i, item in pairs(c.items) do
		if item:sub(0,6) == "group:" then
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
						items = table_copy(c.items)
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
	local _recipes = minetest.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
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

zmc.formspec = function(pn,find)
	find = find or ""
	if zmc.need_load_all then zmc.load_all() end
	local page = zmc.users[pn].page
	local alt = zmc.users[pn].alt
	local current_item = zmc.users[pn].current_item
	local formspec =
		"size[8,8.5]" ..
		"button_exit[6,8;2,0.5;;"..SL("Exit").."]"
	if zmc.users[pn].history.index > 1 then
		formspec = formspec .. "image_button[0,1;1,1;zcg_previous.png;zmc_previous;;false;false;zcg_previous_press.png]"
	else
		formspec = formspec .. "image[0,1;1,1;zcg_previous_inactive.png]"
	end
	if zmc.users[pn].history.index < #zmc.users[pn].history.list then
		formspec = formspec .. "image_button[1,1;1,1;zcg_next.png;zmc_next;;false;false;zcg_next_press.png]"
	else
		formspec = formspec .. "image[1,1;1,1;zcg_next_inactive.png]"
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
					formspec = formspec .. "image[6,2;1,1;zcg_method_"..c.type..".png]"
				else -- we don't have an image for other types of crafting
					formspec = formspec .. "label[0,2;Method: "..c.type.."]"
				end
				formspec = formspec .. "image[6,1;1,1;zcg_craft_arrow.png]"
				formspec = formspec .. "item_image_button[7,1;1,1;"..zmc.users[pn].current_item..";;]"
			end
		end
	end

	-- Filter items by `filter` field value
	formspec = formspec ..
		"field[0.3,4.25;4,0.5;zmc_filter;" .. SL("Search") .. ";" .. minetest.formspec_escape(find) .. "]" ..
		"field_close_on_enter[zmc_filter;false]"

	local lang_code = minetest.get_player_information(pn).lang_code or DEFAULT_LANG
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
	formspec = formspec .. "background[5,5;1,1;craft_formbg.png;true]"
	return formspec
end

---@param fields table
---@param player Player
minetest.register_on_player_receive_fields(function(player,formname,fields)
	local pn = player:get_player_name();
	if zmc.users[pn] == nil then zmc.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
	local search_phrase = fields.zmc_filter or "";
	local new_filter = false
	if fields.key_enter and fields.key_enter_field == "zmc_filter" and fields.zmc_filter then
		new_filter = true
		zmc.users[pn].page = 0
	end
	if fields.zmc or new_filter then
		inventory_plus.set_inventory_formspec(player, zmc.formspec(pn, search_phrase))
		return
	elseif fields.zmc_previous then
		if zmc.users[pn].history.index > 1 then
			zmc.users[pn].history.index = zmc.users[pn].history.index - 1
			zmc.users[pn].current_item = zmc.users[pn].history.list[zmc.users[pn].history.index]
			inventory_plus.set_inventory_formspec(player,zmc.formspec(pn, search_phrase))
		end
	elseif fields.zmc_next then
		if zmc.users[pn].history.index < #zmc.users[pn].history.list then
			zmc.users[pn].history.index = zmc.users[pn].history.index + 1
			zmc.users[pn].current_item = zmc.users[pn].history.list[zmc.users[pn].history.index]
			inventory_plus.set_inventory_formspec(player,zmc.formspec(pn, search_phrase))
		end
	end
	for k, v in pairs(fields) do
		if (k:sub(0,4)=="zmc:") then
			local ni = k:sub(5)
			if zmc.crafts[ni] then
				zmc.users[pn].current_item = ni
				table.insert(zmc.users[pn].history.list, ni)
				zmc.users[pn].history.index = #zmc.users[pn].history.list
				inventory_plus.set_inventory_formspec(player,zmc.formspec(pn, search_phrase))
			end
		elseif (k:sub(0,9)=="zmc_page:") then
			zmc.users[pn].page = tonumber(k:sub(10))
			inventory_plus.set_inventory_formspec(player,zmc.formspec(pn, search_phrase))
		elseif (k:sub(0,8)=="zmc_alt:") then
			zmc.users[pn].alt = tonumber(k:sub(9))
			inventory_plus.set_inventory_formspec(player,zmc.formspec(pn, search_phrase))
		end
	end
end)

minetest.register_tool("lottinventory:master_book",{
    description = SL("Master Book of Crafts"),
    inventory_image = "lottinventory_master_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
            fleshy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
            snappy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
            choppy={times={[3]=0.90}, uses=20, maxlevel=0}
        }
    },
    groups = {forbidden=1, book=1, paper=1},
    on_use = function(itemstack, player, pointed_thing)
		local pn = player:get_player_name();
		if zmc.users[pn] == nil then zmc.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
		inventory_plus.set_inventory_formspec(player, zmc.formspec(pn))
    end,
})
