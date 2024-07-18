local SL = minetest.get_translator("lord_info")

-- используемые файлы в каталоге мира
local info_file = minetest.get_worldpath() .. "/info.txt"
local news_file = minetest.get_worldpath() .. "/news.txt"
local rules_file = minetest.get_worldpath() .. "/rules.txt"

-- дополнительные привилегии (так же используется give)
minetest.register_privilege("info", {
	description = SL("Can edit info"),
	give_to_singleplayer = false,
})
minetest.register_privilege("news", {
	description = SL("Can edit news"),
	give_to_singleplayer = false,
})
minetest.register_privilege("rules", {
	description = SL("Can edit rules"),
	give_to_singleplayer = false,
})

-- размер и фон формы
local form_prop = "size[8,8.5]background[5,5;1,1;info_formbg.png;true]"

-- чтение/запись txt файлов
local function read_info()
	return io.read_from_file(info_file) or SL("info_text")
end
local function write_info(info_text)
	io.write_to_file(info_file, info_text)
end

local function read_news()
	return io.read_from_file(news_file) or SL("news_text")
end
local function write_news(news_text)
	io.write_to_file(news_file, news_text)
end

local function read_rules()
	return io.read_from_file(rules_file) or SL("rules_text")
end
local function write_rules(rules_text)
	io.write_to_file(rules_file, rules_text)
end


local function form_tabs_spec()
	local form =
		"button[0.3 ,0; 2.5,1;btn_info;"..SL("Info").."]"..
		"button[2.75,0; 2.5,1;btn_news;"..SL("News").."]"..
		"button[5.2 ,0; 2.5,1;btn_how;" ..SL("How to play?").."]"

	return form
end

-- описание форм
local function info_form(name)
	local privs = minetest.get_player_privs(name)
	local form = form_prop .. form_tabs_spec()
	form = form.."label[0.3,1.0;"..SL("Admin:").." "..minetest.settings:get("name").."]" --admin
	if minetest.settings:get_bool("enable_pvp") then --pvp
		form = form.."label[0.3,1.5;"..SL("PvP:").." "..SL("On").."]"
	else
		form = form.."label[0.3,1.5;"..SL("PvP:").." "..SL("Off").."]"
	end
	if minetest.settings:get_bool("enable_damage") then --урон
		form = form.."label[0.3,2.0;"..SL("Damage:").." "..SL("On").."]"
	else
		form = form.."label[0.3,2.0;"..SL("Damage:").." "..SL("Off").."]"
	end
	--базовые права
	form = form.."label[0.3,2.5;"..SL("Default privileges:").." "..minetest.settings:get("default_privs").."]"
	form = form.."textarea[0.6,3.5;7.4,4.83;txt_info;"..SL("Info:")..";"..minetest.formspec_escape(read_info()).."]"
	if privs["info"] then
		form = form..
			"button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]button[4.7,7.7;3,1;btn_save;"..SL("Save").."]"
	else
		form = form..
			"button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"
	end
	return form
end
local function news_form(name)
	local privs = minetest.get_player_privs(name)
	local form = form_prop .. form_tabs_spec()
	form = form.."textarea[0.6,1.2;7.4,7.5;txt_news;"..SL("News:")..";"..minetest.formspec_escape(read_news()).."]"
	if privs["news"] then
		form = form..
			"button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]button[4.7,7.7;3,1;btn_save;"..SL("Save").."]"
	else
		form = form..
			"button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"
	end
	return form
end
local function howto_form(name)
	local privs = minetest.get_player_privs(name)
	local form = form_prop .. form_tabs_spec()

	form = form.."label[0.3,1.0;"..SL("Game's rules:").."]"
	form = form.."textarea[0.6,1.5;7.4,7.15;txt_rules;;"..minetest.formspec_escape(read_rules()).."]"
	if privs["rules"] then
		form = form.."button[4.7,7.7;3,1;btn_save;"..SL("Save").."]"
	end
	form = form.."button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"

	return form
end

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
	local form = form_prop
	form = form..
		"label[0.3,0.3;"..SL("Objects:").."]"..
		"field_close_on_enter[txt_filter;false]"..
		"field[3.0,0.3;2.5,1;txt_filter;;"..minetest.formspec_escape(search_query).."]"..
		"button[5.2,0;2.5,1;btn_find;"..SL("Find").."]"

	local list = get_filtered_list(search_query)

	if #list == 0 then
		form = form.."textlist[0.3,0.8;7.2,3.6;lst_objs;;;]"
		form = form.."label[0.3,4.5;"..SL("Groups:").."]"
		form = form.."textlist[0.3,5.0;7.2,1.0;lst_groups;;;]"
		form = form.."textarea[0.6,6.5;7.4,1.5;txt_description;"..SL("Description:")..";]"
		form = form.."button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"
	else
		-- sorting
		table.sort(list)

		-- moving ghost items to the end of the list:
		move_ghost_to_end(list)

		-- form construction step-by-step
		local item_name = list[select_id]
		form = form.."field[3,3;0,0;txt_select;;"..item_name.."]" -- скрыто
		form = form.."textlist[0.3,0.8;7.2,3.6;lst_objs;"..table.concat(list, ",")..";"..tostring(select_id)..";]"
		form = form.."label[0.3,4.5;"..SL("Groups:").."]"
		local groups = {}
		for i, j in pairs(minetest.registered_items[list[select_id]].groups) do
			table.insert(groups, i.." = "..tostring(j))
		end
		groups = table.concat(groups, ",")
		form = form.."textlist[0.3,5.0;7.2,1.0;lst_groups;"..groups..";;]"
		local description = minetest.registered_items[list[select_id]].description
		if (description == nil)or(description == "") then description = SL("no description") end
		description = minetest.formspec_escape(description)
		form = form.."textarea[0.6,6.5;7.4,1.5;txt_description;"..SL("Description:")..";"..description.."]"
		form = form.."button_exit[0.3,7.7;3,1;btn_exit;"..SL("Exit").."]"
		form = form.."label[4.0,7.9;"..SL("To invenory:").."]"
		form = form.."item_image_button[5.7,7.7;1,1;"..item_name..";btn_giveme;1]"
		local stack_max = minetest.registered_items[list[select_id]].stack_max
		form = form.."item_image_button[6.7,7.7;1,1;"..item_name..";btn_giveme_m;"..tostring(stack_max).."]"
	end
	return form
end

-- чат-команды
minetest.register_chatcommand("info", {
	description = SL("Show information about the server"),
	func = function(name)
		minetest.show_formspec(name, "info_form", info_form(name))
	end,
})
minetest.register_chatcommand("news", {
	description = SL("Show the server's news"),
	func = function(name)
		minetest.show_formspec(name, "news_form", news_form(name))
	end,
})
local list_command_definition = {
	description = SL("Show list of registered objects"),
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
local function handle_info_forms(player, form_name, fields)
	local player_name = player:get_player_name()

	-- Tabs switching
	if fields.btn_info then
		minetest.show_formspec(player_name, "info_form", info_form(player_name))
	elseif fields.btn_news then
		minetest.show_formspec(player_name, "news_form", news_form(player_name))
	elseif fields.btn_how then
		minetest.show_formspec(player_name, "howto_form", howto_form(player_name))
	end

	-- Save
	if fields.btn_save then
		if form_name == "info_form" then
			write_info(fields.txt_info)
			minetest.chat_send_player(player_name, SL("Info successfully written!"))
		elseif form_name == "news_form" then
			write_news(fields.txt_news)
			minetest.chat_send_player(player_name, SL("News successfully written!"))
		elseif form_name == "howto_form" then
			write_rules(fields.txt_rules)
			minetest.chat_send_player(player_name, SL("Rules successfully written!"))
		end
	end
end

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
			minetest.chat_send_player(player_name, SL("Item successfully added!"))
		else
			minetest.chat_send_player(player_name, SL("Error: Inventory is full!"))
		end
	end
	if fields.btn_find or (fields.key_enter_field == "txt_filter") then
		minetest.show_formspec(player_name, "list_form", list_form(player_name, 1, fields.txt_filter))
	end
end

-- обработка событий на формах
-- TODO: register separate handlers
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname:is_one_of({"info_form", "news_form", "howto_form"}) then
		handle_info_forms(player, formname, fields)
	end

	if formname == "list_form" then
		handle_list_form(player, formname, fields)
	end
end)
