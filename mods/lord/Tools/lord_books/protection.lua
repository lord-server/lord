-- zpc mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

local SL = minetest.get_mod_translator()

zpc = {}
zpc.users = {}
zpc.crafts = {}
zpc.itemlist = {}

zpc.items_in_group = function(group)
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

zpc.add_craft = function(input, output, groups)
	if minetest.get_item_group(output, "armor_use") > 0 or minetest.get_item_group(output, "armor_crafts") > 0 then
     if minetest.get_item_group(output, "forbidden") > 0 then
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
				for _, gi in ipairs(zpc.items_in_group(groupname)) do
					local g2 = groups
					g2[groupname] = gi
					zpc.add_craft({
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
	table.insert(zpc.crafts[output],c)
end
end

zpc.load_crafts = function(name)
	zpc.crafts[name] = {}
	local _recipes = minetest.get_all_craft_recipes(name)
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
	for name, item in pairs(minetest.registered_items) do
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
	local page = zpc.users[player_name].page
	local alt = zpc.users[player_name].alt
	local current_item = zpc.users[player_name].current_item
	local formspec =
		"size[8,7.5]" ..
		"button_exit[6,7;2,0.5;;"..SL("Exit").."]"
	if zpc.users[player_name].history.index > 1 then
		formspec = formspec .. "image_button[0,1;1,1;books_previous.png;zpc_previous;;false;false;books_previous_press.png]"
	else
		formspec = formspec .. "image[0,1;1,1;books_previous_inactive.png]"
	end
	if zpc.users[player_name].history.index < #zpc.users[player_name].history.list then
		formspec = formspec .. "image_button[1,1;1,1;books_next.png;zpc_next;;false;false;books_next_press.png]"
	else
		formspec = formspec .. "image[1,1;1,1;books_next_inactive.png]"
	end
	-- Show craft recipe
	if current_item ~= "" then
		if zpc.crafts[current_item] then
			if alt > #zpc.crafts[current_item] then
				alt = #zpc.crafts[current_item]
			end
			if alt > 1 then
				formspec = formspec .. "button[7,0;1,1;zpc_alt:"..(alt-1)..";^]"
			end
			if alt < #zpc.crafts[current_item] then
				formspec = formspec .. "button[7,2;1,1;zpc_alt:"..(alt+1)..";v]"
			end
			local c = zpc.crafts[current_item][alt]
			if c then
				local x = 3
				local y = 0
				for i, item in pairs(c.items) do
					formspec = formspec ..
						"item_image_button[" ..
							((i - 1) % c.width + x) .. "," .. (math.floor((i - 1) / c.width + y)) .. ";" ..
							"1,1;" ..
							item .. ";" ..
							"zpc:" .. item .. ";" ..
						"]"
				end
				if c.type == "normal" or c.type == "cooking" then
					formspec = formspec .. "image[6,2;1,1;books_method_"..c.type..".png]"
				else -- we don't have an image for other types of crafting
					formspec = formspec .. "label[0,2;Method: "..c.type.."]"
				end
				formspec = formspec .. "image[6,1;1,1;books_craft_arrow.png]"
				formspec = formspec .. "item_image_button[7,1;1,1;"..zpc.users[player_name].current_item..";;]"
			end
		end
	end

	-- Node list
	local npp = 8*3 -- nodes per page
	local i = 0 -- for positionning buttons
	local s = 0 -- for skipping pages
	for _, name in ipairs(zpc.itemlist) do
		if s < page*npp then s = s+1 else
			if i >= npp then break end
			formspec = formspec ..
				"item_image_button[" ..
					(i % 8) .. "," .. (math.floor(i / 8) + 3.5) .. ";" ..
					"1,1;" ..
					name .. ";" ..
					"zpc:" .. name .. ";" ..
				"]"
			i = i+1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,7;1,.5;zpc_page:"..(page-1)..";<<]"
	end
	if i >= npp then
		formspec = formspec .. "button[1,7;1,.5;zpc_page:"..(page+1)..";>>]"
	end
	-- The Y is approximatively the good one to have it centered vertically...
	formspec = formspec .. "label[2,6.85;"..SL("Page").." "..(page+1).."/"..(math.floor(#zpc.itemlist/npp+1)).."]"
	formspec = formspec .. "label[0,0;"..SL("Book of Protection").."]"
	formspec = formspec .. "background[5,5;1,1;books_formbg.png;true]"
	return formspec
end
--- @param player_name string
zpc.form.show = function(player_name)
	minetest.show_formspec(player_name, zpc.form.NAME, zpc.form.get_spec(player_name))
end


---@param player    Player
---@param form_name string
---@param fields    table
minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= zpc.form.NAME then
		return
	end

	local pn = player:get_player_name();
	if zpc.users[pn] == nil then zpc.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
	if fields.zpc then
		zpc.form.show(pn)
		return
	elseif fields.zpc_previous then
		if zpc.users[pn].history.index > 1 then
			zpc.users[pn].history.index = zpc.users[pn].history.index - 1
			zpc.users[pn].current_item = zpc.users[pn].history.list[zpc.users[pn].history.index]
			zpc.form.show(pn)
		end
	elseif fields.zpc_next then
		if zpc.users[pn].history.index < #zpc.users[pn].history.list then
			zpc.users[pn].history.index = zpc.users[pn].history.index + 1
			zpc.users[pn].current_item = zpc.users[pn].history.list[zpc.users[pn].history.index]
			zpc.form.show(pn)
		end
	end
	for k, v in pairs(fields) do
		if (k:starts_with("zpc:")) then
			local ni = k:sub(5)
			if zpc.crafts[ni] then
				zpc.users[pn].current_item = ni
				table.insert(zpc.users[pn].history.list, ni)
				zpc.users[pn].history.index = #zpc.users[pn].history.list
				zpc.form.show(pn)
			end
		elseif (k:starts_with("zpc_page:")) then
			zpc.users[pn].page = tonumber(k:sub(10))
			zpc.form.show(pn)
		elseif (k:starts_with("zpc_alt:")) then
			zpc.users[pn].alt = tonumber(k:sub(9))
			zpc.form.show(pn)
		end
	end
end)

minetest.register_tool("lord_books:protection_book",{
    description = SL("Book of Protection"),
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
