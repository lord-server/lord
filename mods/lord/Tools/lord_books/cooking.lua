-- zcc mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local SL           = minetest.get_mod_translator()

zcc                = {}
zcc.users          = {}
zcc.crafts         = {}
zcc.itemlist       = {}

zcc.items_in_group = function(group)
	local items = {}

	for name, item in pairs(minetest.registered_items) do
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

zcc.add_craft      = function(input, output, groups)
	if minetest.get_item_group(output, "forbidden") > 0 then
		return
	end
	if minetest.get_item_group(output, "armor_use") > 0 then
		return
	end
	if minetest.get_item_group(output, "armor_crafts") > 0 then
		return
	end
	if not groups then groups = {} end
	local c = {}
	c.width = input.width
	c.type  = input.type
	c.items = input.items
	if minetest.get_item_group(output, "cook_crafts") > 0 or c.type == "cooking" then
		if c.items == nil then return end
		for i, item in pairs(c.items) do
			if item:starts_with("group:") then
				local groupname = item:sub(7)
				if groups[groupname] ~= nil then
					c.items[i] = groups[groupname]
				else
					for _, gi in ipairs(zcc.items_in_group(groupname)) do
						local g2      = groups
						g2[groupname] = gi
						zcc.add_craft({
							width = c.width,
							type  = c.type,
							items = table.copy(c.items)
						}, output, g2) -- it is needed to copy the table, else groups won't work right
					end
					return
				end
			end
		end
		if c.width == 0 then c.width = 3 end
		table.insert(zcc.crafts[output], c)
	end
end

zcc.load_crafts    = function(name)
	zcc.crafts[name] = {}
	local _recipes   = minetest.get_all_craft_recipes(name)
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
	for name, item in pairs(minetest.registered_items) do
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
zcc.form.get_spec  = function(player_name)
	if zcc.need_load_all then
		zcc.load_all()
	end
	local page         = zcc.users[player_name].page
	local alt          = zcc.users[player_name].alt
	local current_item = zcc.users[player_name].current_item
	local formspec     = "size[8,7.5]"
		.. "button_exit[6,7;2,0.5;;" .. SL("Exit") .. "]"
	if zcc.users[player_name].history.index > 1 then
		formspec = formspec .. "image_button[0,1;1,1;books_previous.png;zcc_previous;;false;false;books_previous_press.png]"
	else
		formspec = formspec .. "image[0,1;1,1;books_previous_inactive.png]"
	end
	if zcc.users[player_name].history.index < #zcc.users[player_name].history.list then
		formspec = formspec .. "image_button[1,1;1,1;books_next.png;zcc_next;;false;false;books_next_press.png]"
	else
		formspec = formspec .. "image[1,1;1,1;books_next_inactive.png]"
	end
	-- Show craft recipe
	if current_item ~= "" then
		if zcc.crafts[current_item] then
			if alt > #zcc.crafts[current_item] then
				alt = #zcc.crafts[current_item]
			end
			if alt > 1 then
				formspec = formspec .. "button[7,0;1,1;zcc_alt:" .. (alt - 1) .. ";^]"
			end
			if alt < #zcc.crafts[current_item] then
				formspec = formspec .. "button[7,2;1,1;zcc_alt:" .. (alt + 1) .. ";v]"
			end
			local c = zcc.crafts[current_item][alt]
			if c then
				local x = 3
				local y = 0
				for i, item in pairs(c.items) do
					formspec = formspec ..
						"item_image_button[" ..
							((i - 1) % c.width + x) .. "," .. (math.floor((i - 1) / c.width + y)) .. ";" ..
							"1,1;" .. item .. ";" ..
							"zcc:" .. item .. ";" ..
						"]"
				end
				if c.type == "normal" or c.type == "cooking" then
					formspec = formspec .. "image[6,2;1,1;books_method_" .. c.type .. ".png]"
				else
					-- we don't have an image for other types of crafting
					formspec = formspec .. "label[0,2;Method: " .. c.type .. "]"
				end
				formspec = formspec .. "image[6,1;1,1;books_craft_arrow.png]"
				formspec = formspec .. "item_image_button[7,1;1,1;" .. zcc.users[player_name].current_item .. ";;]"
			end
		end
	end

	-- Node list
	local npp = 8 * 3 -- nodes per page
	local i   = 0 -- for positionning buttons
	local s   = 0 -- for skipping pages
	for _, name in ipairs(zcc.itemlist) do
		if s < page * npp then s = s + 1 else
			if i >= npp then break end
			formspec = formspec ..
				"item_image_button[" ..
					(i % 8) .. "," .. (math.floor(i / 8) + 3.5) .. ";" ..
					"1,1;" ..
					name .. ";" ..
					"zcc:" .. name .. ";" ..
				"]"
			i        = i + 1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,7;1,.5;zcc_page:" .. (page - 1) .. ";<<]"
	end
	if i >= npp then
		formspec = formspec .. "button[1,7;1,.5;zcc_page:" .. (page + 1) .. ";>>]"
	end
	formspec = formspec ..
		-- The Y is approximatively the good one to have it centered vertically...
		"label[2,6.85;" .. SL("Page") .. " " .. (page + 1) .. "/" .. (math.floor(#zcc.itemlist / npp + 1)) .. "]" ..
		"background[5,5;1,1;books_formbg.png;true]" ..
		"label[0,0;" .. SL("Book of Cooking") .. "]"
	return formspec
end
--- @param player_name string
zcc.form.show      = function(player_name)
	minetest.show_formspec(player_name, zcc.form.NAME, zcc.form.get_spec(player_name))
end

---@param player    Player
---@param form_name string
---@param fields    table
minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zcc.form.NAME then
		return
	end

	local pn = player:get_player_name();
	if zcc.users[pn] == nil then
		zcc.users[pn] = { current_item = "", alt = 1, page = 0, history = { index = 0, list = {} } }
	end
	if fields.zcc then
		zcc.form.show(pn)
		return
	elseif fields.zcc_previous then
		if zcc.users[pn].history.index > 1 then
			zcc.users[pn].history.index = zcc.users[pn].history.index - 1
			zcc.users[pn].current_item  = zcc.users[pn].history.list[zcc.users[pn].history.index]
			zcc.form.show(pn)
		end
	elseif fields.zcc_next then
		if zcc.users[pn].history.index < #zcc.users[pn].history.list then
			zcc.users[pn].history.index = zcc.users[pn].history.index + 1
			zcc.users[pn].current_item  = zcc.users[pn].history.list[zcc.users[pn].history.index]
			zcc.form.show(pn)
		end
	end
	for k, v in pairs(fields) do
		if (k:starts_with("zcc:")) then
			local ni = k:sub(5)
			if zcc.crafts[ni] then
				zcc.users[pn].current_item = ni
				table.insert(zcc.users[pn].history.list, ni)
				zcc.users[pn].history.index = #zcc.users[pn].history.list
				zcc.form.show(pn)
			end
		elseif (k:starts_with("zcc_page:")) then
			zcc.users[pn].page = tonumber(k:sub(10))
			zcc.form.show(pn)
		elseif (k:starts_with("zcc_alt:")) then
			zcc.users[pn].alt = tonumber(k:sub(9))
			zcc.form.show(pn)
		end
	end
end)

minetest.register_tool("lord_books:cooking_book", {
	description     = SL("Book of Cooking"),
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
