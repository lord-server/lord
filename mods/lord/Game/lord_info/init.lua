local S = minetest.get_mod_translator()


--- @param search_query string
--- @return table
local function get_filtered_list(search_query)
	local list = {} -- filtered result
	search_query = string.lower(search_query)
	for id, def in pairs(minetest.registered_items) do
		if
			(id ~= '') and -- skip the "hand" item
			(
				(search_query == "") or
				(string.find(string.lower(id), search_query)) or
				(string.find(string.lower(def.description), search_query)) or
				(string.find(string.lower(minetest.get_translated_string("ru", def.description)), search_query))
			)
		then
			table.insert(list, id)
		end
	end

	return list
end

--- Moves ghost items (`defaults:*`) to the end of the `list`
--- @param list table
local function move_ghost_to_end(list)
	local ghost_prefix = "defaults:"
	local ghosts_list = {}
	local iter = 1; while iter <= #list do -- `while` loop used instead of `for` for dynamic loop variable
		local item = list[iter]
		if string.sub(item, 1, string.len(ghost_prefix)) == ghost_prefix then -- startswith check
			table.remove(list, iter)
			table.insert(ghosts_list, item)
			iter = iter - 1 -- HACK: to re-read the same cell due to a shift after table.remove
		end
		iter = iter + 1
	end
	for _, item in ipairs(ghosts_list) do
		table.insert(list, item)
	end
end


local function list_form(name, select_id, search_query)
	local form = "size[8,8.5]background[5,5;1,1;info_formbg.png;true]"
	form = form..
		"label[0.3,0.3;".. S("Objects:").."]"..
		"field_close_on_enter[txt_filter;false]"..
		"field[3.0,0.3;2.5,1;txt_filter;;"..minetest.formspec_escape(search_query).."]"..
		"button[5.2,0;2.5,1;btn_find;".. S("Find").."]"

	local list = get_filtered_list(search_query)

	if #list == 0 then
		form = form.."textlist[0.3,0.8;7.2,3.6;lst_objs;;;]"
		form = form.."label[0.3,4.5;".. S("Groups:").."]"
		form = form.."textlist[0.3,5.0;7.2,1.0;lst_groups;;;]"
		form = form.."textarea[0.6,6.5;7.4,1.5;txt_description;".. S("Description:")..";]"
		form = form.."button_exit[0.3,7.7;3,1;btn_exit;".. S("Exit").."]"
	else
		-- sorting
		table.sort(list)

		-- moving ghost items to the end of the list:
		move_ghost_to_end(list)

		-- form construction step-by-step
		local item_name = list[select_id]
		form = form.."field[3,3;0,0;txt_select;;"..item_name.."]" -- скрыто
		form = form.."textlist[0.3,0.8;7.2,3.6;lst_objs;"..table.concat(list, ",")..";"..tostring(select_id)..";]"
		form = form.."label[0.3,4.5;".. S("Groups:").."]"
		local groups = {}
		for i, j in pairs(minetest.registered_items[list[select_id]].groups) do
			table.insert(groups, i.." = "..tostring(j))
		end
		groups = table.concat(groups, ",")
		form = form.."textlist[0.3,5.0;7.2,1.0;lst_groups;"..groups..";;]"
		local description = minetest.registered_items[list[select_id]].description
		if (description == nil)or(description == "") then description = S("no description") end
		description = minetest.formspec_escape(description)
		form = form.."textarea[0.6,6.5;7.4,1.5;txt_description;".. S("Description:")..";"..description.."]"
		form = form.."button_exit[0.3,7.7;3,1;btn_exit;".. S("Exit").."]"
		form = form.."label[4.0,7.9;".. S("To invenory:").."]"
		form = form.."item_image_button[5.7,7.7;1,1;"..item_name..";btn_giveme;1]"
		local stack_max = minetest.registered_items[list[select_id]].stack_max
		form = form.."item_image_button[6.7,7.7;1,1;"..item_name..";btn_giveme_m;"..tostring(stack_max).."]"
	end
	return form
end

-- чат-команды
local list_command_definition = {
	description = S("Show list of registered objects"),
	privs = {give = true},
	func = function(name)
		minetest.show_formspec(name, "list_form", list_form(name, 1, ""))
	end,
}
minetest.register_chatcommand("list", list_command_definition)
minetest.register_chatcommand("l", list_command_definition)


--- @param player    Player
--- @param form_name string
--- @param fields    table  form fields values received from client
local function handle_list_form(player, form_name, fields)
	local player_name = player:get_player_name()

	if fields.lst_objs then
		local chg = fields.lst_objs
		chg = string.replace(chg, "CHG:", "")
		chg = string.replace(chg, "DCL:", "")
		chg = tonumber(chg)
		minetest.show_formspec(player_name, "list_form", list_form(player_name, chg, fields.txt_filter))
	end
	if fields.btn_giveme or fields.btn_giveme_m then
		local count = (fields.btn_giveme)or(fields.btn_giveme_m)
		local item_name = fields.txt_select
		local item_stack = item_name.." "..count
		local inv = player:get_inventory()
		if inv:room_for_item("main", item_stack) then
			inv:add_item("main", item_stack)
			minetest.chat_send_player(player_name, S("Item successfully added!"))
		else
			minetest.chat_send_player(player_name, S("Error: Inventory is full!"))
		end
	end
	if fields.btn_find or (fields.key_enter_field == "txt_filter") then
		minetest.show_formspec(player_name, "list_form", list_form(player_name, 1, fields.txt_filter))
	end
end

-- обработка событий на формах
-- TODO: register separate handlers
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "list_form" then
		return
	end

	handle_list_form(player, formname, fields)
end)
