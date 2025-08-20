local S    = minetest.get_mod_translator()
local spec = minetest.formspec
local e    = spec.escape

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

--- @param definition ItemDefinition
--- @return string[] array of `"<name>=<value>"` strings
local function get_groups_list(definition)
	local groups = definition and definition.groups or {}
	local groups_list = {}
	for name, value in pairs(groups) do
		table.insert(groups_list, name .. " = " .. value)
	end

	return groups_list
end

--- @param name         string
--- @param select_id    number
--- @param search_query string
--- @return string
local function list_form(name, select_id, search_query)
	local width   = 10
	local height  = 11
	local padding = { x = 0.25, y = 0.3 }
	local field_h = 0.65
	local row_h   = field_h + padding.y
	local label_h = padding.y

	local list = get_filtered_list(search_query)
	table.sort(list)
	-- moving ghost items to the end of the list:
	move_ghost_to_end(list)

	local item_name       = list[select_id]
	local item_definition = minetest.registered_items[item_name]
	local stack_max       = item_definition and item_definition.stack_max or 0

	local list_h  = 4
	local details = {
		label_y = padding.y + row_h + list_h + padding.y,
		pos_x1  = padding.x,
		pos_x2  = width/3 + padding.x/2,
		pos_y   = padding.y + row_h + list_h + padding.y + label_h,
		width1  = width/3 - 1.5*padding.x,
		width2  = width*2/3 - 1.5*padding.x,
		height  = 4
	}
	local d = details

	local last_row_y = height - padding.y - field_h

	return ""
		.. spec.formspec_version(4)
		.. spec.size(width, height)
		.. spec.box(padding.x, padding.y, 3, field_h, '#000')
		.. spec.field(padding.x, padding.y, 3, field_h, "txt_filter", "", e(search_query))
		.. spec.button(width - padding.x - 2, padding.y, 2, field_h, "btn_find", S("Find"))
		.. spec.field_close_on_enter("txt_filter", false)

		.. --[[ скрытое поле ]] spec.field(3, 3, 0, 0, "txt_select", "", item_name)
		--.. spec.label(padding.x, 1, S("Objects:"))
		.. spec.textlist(padding.x, padding.y + row_h, width - 2*padding.x, list_h, "lst_objs", list, select_id, "")
		.. spec.label(d.pos_x1, d.label_y, S("Groups:"))
		.. spec.label(d.pos_x2, d.label_y, S("Definition:"))
		.. spec.box(d.pos_x2, d.pos_y, d.width2, d.height, '#000')
		.. spec.textlist(d.pos_x1, d.pos_y, d.width1, d.height, "lst_groups", get_groups_list(item_definition))
		.. spec.textarea(d.pos_x2, d.pos_y, d.width2, d.height, "txt_definition", "", e(dump(item_definition)))
		.. spec.button_exit(padding.x, last_row_y, 3, field_h, "btn_exit", S("Exit"))
		.. spec.label(width - padding.x - 4, last_row_y + field_h/2, S("To inventory:"))
		.. (item_name
			and
				spec.item_image_button(width - padding.x - 2, last_row_y - 0.1, 0.8, 0.8, item_name, "btn_giveme", 1) ..
				spec.item_image_button(width - padding.x - 1, last_row_y - 0.1, 0.8, 0.8, item_name, "btn_giveme_m", stack_max)
			or
				""
		)
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

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "list_form" then
		return
	end

	handle_list_form(player, formname, fields)
end)
