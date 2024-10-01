local S = minetest.get_translator("lord_money")


--- @param stack ItemStack
--- @param player ObjectRef
--- @return boolean
local function has_wear(stack, player)
	if stack:get_wear() > 0 then
		minetest.chat_send_player(player:get_player_name(),
				S("The item must be wear-free: ") .. stack:get_short_description())
		return true
	end

	return false
end

--- @param inventory InvRef
--- @param list_name string
--- @param player    Player send messages to
local function inv_list_has_wear_items(inventory, list_name, player)
	local has_wear_items = false
	for _, stack in pairs(inventory:get_list(list_name)) do
		if has_wear(stack, player) then
			has_wear_items = true
		end
	end

	return has_wear_items
end

--- @param meta NodeMetaRef
--- @return table
local function get_members_list(meta)
	local list = meta:get_string("members")
	return list:split(" ")
end

--- @param meta NodeMetaRef
--- @param name string
local function add_member(meta, name)
	local members = meta:get_string("members")
	-- Проверка, не внесено ли имя в список:
	if not string.find(" "..members.." ", " "..name.." ") then
		members = members.." "..name
		meta:set_string("members", members)
	end
end

--- @param meta NodeMetaRef
--- @param name string
local function remove_member(meta, name)
	local list = get_members_list(meta)
	local swap_list = table.key_value_swap(list)
	table.remove(list, swap_list[name])
	meta:set_string("members", table.concat(list, " "))
end

local shop = {}
shop.current_shop = {}
shop.formspec = {
	customer = function(pos)
		local list_name = "nodemeta:"..pos.x..","..pos.y..","..pos.z
		local formspec = "size[11,9]"..
		"label[0,-0.35;"..S("Offered:").."]"..
		"list["..list_name..";owner_gives;0,0.1;2,2;]"..

		"label[0,1.95;"..S("Requested:").."]"..
		"list["..list_name..";owner_wants;0,2.4;2,2;]"..

		"label[3,-0.35;"..S("Payment:").."]"..
		"list[current_player;customer_gives;3,0.1;8,2;]"..

		"label[3,1.95;"..S("Recieved:").."]"..
		"list[current_player;customer_gets;3,2.4;8,2;]"..

		"button["..tostring(1.5+0/3).. ", 4.35;"..tostring(8/3).. ",1;exchange;"     ..S("Exchange Once") .."]"..
		"button["..tostring(1.5+8/3).. ", 4.35;"..tostring(8/3).. ",1;exchange_ten;" ..S("Exchange Ten")  .."]"..
		"button["..tostring(1.5+16/3)..",4.35;"..tostring(8/3).. ",1;exchange_all;" ..S("Exchange All")  .."]"..
		"list[current_player;main;1.5,5.3;8,4;]"..

		"listring[current_player;customer_gets]"..
		"listring[current_player;main]"..
		"listring[current_player;customer_gives]"..
		"listring[current_player;main]"

		return formspec
	end,
	configurator_base = function(pos, admin, is_endless)
		local list_name = "nodemeta:"..pos.x..","..pos.y..","..pos.z
		local formspec = "size[11,9]"..
		"label[0,-0.35;"..S("To offer:").."]"..
		"list["..list_name..";owner_gives;0,0.1;2,2;]"..

		"label[0,1.95;"..S("To request:").."]"..
		"list["..list_name..";owner_wants;0,2.4;2,2;]"..

		"label[3,-0.35;"..S("Stock:").."]"..
		"list["..list_name..";stock;3,0.1;8,2;]"..

		"label[3,1.95;"..S("Recieved:").."]"..
		"list["..list_name..";customers_gave;3,2.4;8,2;]"..

		"label[0,4.35;"..S("Configuration Mode is on.\nUse AUX1(default: E)+Place(default: RMB) for Customer Mode.").."]"..
		"list[current_player;main;1.5,5.3;8,4;]"..

		"listring["..list_name..";owner_gives]"..
		"listring[current_player;main]"..
		"listring["..list_name..";stock]"..
		"listring[current_player;main]"..
		"listring["..list_name..";owner_wants]"..
		"listring[current_player;main]"..
		"listring["..list_name..";customers_gave]"..
		"listring[current_player;main]"

		if admin then
			formspec = formspec.."checkbox[8.5,4.35;is_endless;"..S("Infinite Stock")..";" .. tostring( is_endless ) .. "]"
		end

		return formspec
	end,

	configurator = function(pos, admin, is_endless)
		local formspec = shop.formspec.configurator_base(pos, admin, is_endless)

		formspec = formspec.."button[10,6.85;1,1;whitelist_on;>]"
		return formspec
	end,

	configurator_whitelist = function(pos, admin, is_endless, members_list)
		local formspec = shop.formspec.configurator_base(pos, admin, is_endless)

		formspec:replace("size[11,9]", "size[13,9]")
		formspec = formspec.."button[10,6.85;1,1;whitelist_off;<]"..
		"field[11.5,0.5;2.5,.5;add_member;"..S("Add Member")..";]"..
		"field_close_on_enter[add_member;false]"..
		"scroll_container[14,1.5;4,9;members;vertical;]"

		for i, member in ipairs(members_list) do
			formspec = formspec.."button[0,"..i-1 ..";2,1;member_"..member..";"..member.."]"..
			"button[1.75,"..i-1 ..";0.75,1;delete_member_"..member..";x]"
		end

		formspec = formspec.."scroll_container_end[]"..
		"scrollbaroptions[max="..#members_list * 10 .."]"..
		"scrollbar[13.7,1;0.2,8;vertical;members;]"

		formspec = string.gsub(formspec, "size%[11,9%]", "size[14,9]")
		return formspec
	end,

}

shop.player_has_access = function(player, shop_pos)
	local meta = minetest.get_meta(shop_pos)
	local owner_name = meta:get_string("owner")
	local members = meta:get_string("members")
	local player_name = player:get_player_name()
	local is_admin = minetest.get_player_privs(player_name).server
	return player_name == owner_name or is_admin or string.find(" "..members.." ", " "..player_name.." ") , is_admin
end

minetest.register_node("lord_money:shop", {
	description = S("Exchange Shop"),
	tiles = { "shop_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_lock.png" },
	paramtype2 = "facedir",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1 },
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer, _)
		local owner = placer:get_player_name()
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Exchange Shop (owned by @1)", tostring(owner)))
		meta:set_string("owner", owner)
		meta:set_string("is_endless", "false")
		meta:set_string("members")
		local inv = meta:get_inventory()
		inv:set_size("customers_gave", 8*2)
		inv:set_size("stock", 8*2)
		inv:set_size("owner_wants", 2*2)
		inv:set_size("owner_gives", 2*2)
	end,

		on_rightclick = function(pos, _, clicker, _)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			meta:set_string("infotext", S("Exchange Shop (owned by @1)", tostring(owner)))
		local user_name = clicker:get_player_name()
		shop.current_shop[user_name] = pos
		local has_access, is_admin = shop.player_has_access(clicker, pos)
		local is_endless = (meta:get_string("is_endless") == "true")

		if has_access and not clicker:get_player_control().aux1 then
			local inv = meta:get_inventory()
			inv:set_size("customers_gave", 8*2)
			inv:set_size("stock", 8*2)
			minetest.show_formspec(user_name,"lord_money:shop_formspec", shop.formspec.configurator(pos, is_admin, is_endless))
		else
			clicker:get_inventory():set_size("customer_gives", 8*2)
			clicker:get_inventory():set_size("customer_gets", 8*2)
			minetest.show_formspec(user_name, "lord_money:shop_formspec", shop.formspec.customer(pos))
		end
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, _, _, count, player)
		if not shop.player_has_access(player, pos) then
			return 0
		end

		local stack_from = minetest.get_meta(pos):get_inventory():get_stack(from_list, from_index)
		if has_wear(stack_from, player) then
			return 0
		end

		return count
	end,

	--- @param stack ItemStack
	allow_metadata_inventory_put = function(pos, _, _, stack, player)
		if not shop.player_has_access(player, pos) or has_wear(stack, player) then
			return 0
		end
		if has_wear(stack, player) then
			return 0
		end

		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, _, _, stack, player)
		if shop.player_has_access(player, pos) then
			return stack:get_count()
		end
		return 0
	end,

	can_dig = function(pos, _)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()

		return inv:is_empty("stock") and
			inv:is_empty("customers_gave") and
			inv:is_empty("owner_wants") and
			inv:is_empty("owner_gives")
	end
})

minetest.register_craftitem("lord_money:license", {
	description = S("Trade License"),
	inventory_image = "shop_license.png",
	groups = { not_in_creative_inventory=1, book=1, paper=1 },
})

minetest.register_craft({
	type = "shapeless",
	output = "lord_money:shop",
	recipe = { "lord_money:license", "default:chest_locked" }
})

local function is_selling(name, pos, shop_inv)
	-- ПРОВЕРКА НАЛИЧИЯ ЦЕНЫ И ПРЕДЛОЖЕНИЯ
	if shop_inv:is_empty("owner_wants") or shop_inv:is_empty("owner_gives") then
		minetest.log("action", string.format(
			"магазин %s - игрок %s пытался совершить обмен, "..
			"но в магазине пусты ячейки цены или предложения.", pos, name))
		minetest.chat_send_player(name, S("Exchange shop is out of service, please contact the seller"))
		return
	end
	return true
end

local function check_enough_items_in_wants(name, pos, player_inv, wants)
	-- ПРОВЕРКА СООТВЕТСТВИЯ ОПЛАТЫ ЦЕНЕ
	for _, stack in pairs(wants) do
		if not player_inv:contains_item("customer_gives", stack, true) then --If false, only the items' names are compared
			minetest.log("action", string.format("магазин %s - игрок %s пытался совершить "..
				"обмен, но его оплата не соответствует цене.", pos, name))
			minetest.chat_send_player(name, S("Unable to perform the exchange: not enough required items."))
			return
		end
	end
	return true
end

local function check_empty_slots_in_gives(name, pos, player_inv, gives)
	-- ПРОВЕРКА НАЛИЧИЯ СВОБОДНОГО МЕСТА В СТЭКЕ "Приобретённый товар"
	for _, stack in pairs(gives) do
		if not player_inv:room_for_item("customer_gets", stack) then
			minetest.log("action", string.format("магазин %s - игрок %s пытался совершить "..
				"обмен, но у него не оказалось свободного места.", pos, name))
			minetest.chat_send_player(name, S("Unable to perform the exchange: nowhere to put your revenue, "..
			 "please clear the 'Recieved' inventory."))
			return
		end
	end
	return true
end

local function check_stock(name, pos, shop_inv, gives, mail)
	-- ПРОВЕРКА НАЛИЧИЯ ТОВАРА НА СКЛАДЕ
	for _, stack in pairs(gives) do
		if not shop_inv:contains_item("stock", stack, true) then --If false, only the items' names are compared
			minetest.log("action", string.format("магазин %s - игрок %s пытался совершить"..
				"обмен, но товар на складе кончился.", pos, name))
			minetest.chat_send_player(name, S("Unable to perform an exchange: the shop is out of stock."))
			if mail ~= nil and mail ~= "" then
				local report = S("Your shop at (@1) is out of stock.", tostring(pos))
				os.execute("echo '"..report.."' | mail -s 'store' "..mail)
			end
			return
		end
	end
	return true
end

local function check_storage(name, pos, shop_inv, wants, mail)
	-- ПРОВЕРКА НАЛИЧИЯ СВОБОДНОГО МЕСТА НА СКЛАДЕ
	for _, stack in pairs(wants) do
		if not shop_inv:room_for_item("customers_gave", stack) then
			minetest.log("action", string.format("магазин %s - игрок %s пытался совершить"..
				"обмен, но на складе недостаточно свободного места.", pos, name))
			minetest.chat_send_player(name, S("Unable to perform an exchange: the storage is full."))
			if mail ~= nil and mail ~= "" then
				local report = S("Your shop at (@1) is full: no storage left.", tostring(pos))
				os.execute("echo '"..report.."' | mail -s 'store' "..mail)
			end
			return
		end
	end
	return true
end

local function take_items(player_inv, is_endless, shop_inv, wants)
	for _, stack in pairs(wants) do -- для всех стеков "Цена"
		player_inv:remove_item("customer_gives", stack) -- забираем у игрока из "Оплата"
		if not is_endless then
			shop_inv:add_item("customers_gave", stack) -- помещаем в "Выручка"
		end
	end
end

local function give_items(player_inv, is_endless, shop_inv, gives)
	for _, stack in pairs(gives) do -- для всех стеков "Предложение"
		if not is_endless then
			shop_inv:remove_item("stock", stack) -- забираем со "Склад"
		end
		player_inv:add_item("customer_gets", stack) -- добавляем игроку в "Приобретённый товар"
	end
end

local function exchange(sender, name, pos, meta, player_inv, is_endless)
	local mail = ""
	if minetest.get_modpath("mail_list") then -- если есть мод взаимодействия с e-mail
		mail = get_mail(meta:get_string("owner")) -- адрес владельца
	end
	local shop_inv = meta:get_inventory() -- инвентари магазина
	local wants    = shop_inv:get_list("owner_wants") -- цена
	local gives    = shop_inv:get_list("owner_gives") -- товар

	if      not is_selling(name, pos, shop_inv) or
			inv_list_has_wear_items(player_inv, "customer_gives", sender) or
			not check_enough_items_in_wants(name, pos, player_inv, wants) or
			not check_empty_slots_in_gives(name, pos, player_inv, gives) or (
			not is_endless and (
			not check_stock(name, pos, shop_inv, gives, mail) or
			not check_storage(name, pos, shop_inv, wants, mail))) then
		return
	end

	-- ВРОДЕ ВСЁ НОРМАЛЬНО, ПРОИЗВОДИМ ОБМЕН
	take_items(player_inv, is_endless, shop_inv, wants)
	give_items(player_inv, is_endless, shop_inv, gives)

	minetest.log("action", string.format("магазин %s - игрок %s успешно произвёл обмен.",
			pos, name))
	return true
end

local function on_close_shop(sender, player_inv)
	for _, list in pairs({ "customer_gives", "customer_gets" }) do
		if not player_inv:is_empty(list) then
			for i, stack in ipairs(player_inv:get_list(list)) do
				minetest.give_or_drop(sender, stack)
				player_inv:set_stack(list, i, nil) -- Удаляем элемент i из list
			end
		end
	end
end

local function show_whitelist(name, pos, meta, is_admin, is_endless)
	if name == meta:get_string("owner") or minetest.get_player_privs(name).server then
		minetest.show_formspec(name,"lord_money:shop_formspec",
			shop.formspec.configurator_whitelist(minetest.string_to_pos(pos), is_admin, is_endless,  get_members_list(meta))
		)
	else
		minetest.chat_send_player(name, S("You are not the owner of this shop!"))
	end
end

local function hide_whitelist(name, pos, is_admin, is_endless)
	minetest.show_formspec(name,"lord_money:shop_formspec",
				shop.formspec.configurator(minetest.string_to_pos(pos), is_admin, is_endless)
			)
end

local function whitelist_add_member(name, pos, meta, is_admin, is_endless, fields)
	if name == meta:get_string("owner") or minetest.get_player_privs(name).server then
		add_member(meta, fields.add_member)
		minetest.show_formspec(name,"lord_money:shop_formspec",
			shop.formspec.configurator_whitelist(minetest.string_to_pos(pos), is_admin, is_endless,  get_members_list(meta))
		)
	else
		minetest.chat_send_player(name, S("You are not the owner of this shop!"))
	end

end

local function whitelist_handle(name, pos, meta, is_admin, is_endless, fields)
	if fields.whitelist_on then -- Показать белый список
		show_whitelist(name, pos, meta, is_admin, is_endless)
	elseif fields.whitelist_off then -- Скрыть белый список
		hide_whitelist(name, pos, is_admin, is_endless)
	elseif fields.add_member then -- Добавить игрока в список
		whitelist_add_member(name, pos, meta, is_admin, is_endless, fields)
	end
end

local function delete_members(name, pos, meta, is_admin, is_endless, fields)
	for field, _ in pairs(fields) do
		if string.find(field, "delete_member_") and (
			name == meta:get_string("owner") or minetest.get_player_privs(name).server
		) then
			local member = string.replace(field, "delete_member_", "")
			remove_member(meta, member)
			minetest.show_formspec(name,"lord_money:shop_formspec",
				shop.formspec.configurator_whitelist(minetest.string_to_pos(pos), is_admin, is_endless,  get_members_list(meta))
			)
		end
	end
end

local function exchange_handle(sender, name, pos, meta, player_inv, is_endless, fields)
	if fields.exchange then -- нажата кнопка "купить"
		exchange(sender, name, pos, meta, player_inv, is_endless)
		minetest.chat_send_player(name, S("Exchanged 1!"))
	elseif fields.exchange_ten then -- нажата кнопка "купить 10"
		for i = 1, 10 do
			if not exchange(sender, name, pos, meta, player_inv, is_endless) then
				minetest.chat_send_player(name, S("Exchanged @1!", tostring(i)))
				return
			end
			if i == 10 then
				minetest.chat_send_player(name, S("Exchanged @1!", tostring(i)))
			end
		end
	elseif fields.exchange_all then -- нажата кнопка "купить всё"
		while true do
			if not exchange(sender, name, pos, meta, player_inv, is_endless) then
				minetest.chat_send_player(name, S("Everything is exchanged!"))
				return
			end
		end
	end
end

minetest.register_on_player_receive_fields(
	function(sender, formname, fields)
		if formname ~= "lord_money:shop_formspec" then return end-- проверка соответсвия формы
		local name       = sender:get_player_name() -- имя покупателя
		local pos        = minetest.pos_to_string(shop.current_shop[name]) -- коорд-ы магазина для логов
		local meta       = minetest.get_meta(shop.current_shop[name]) -- метаданные магазина
		local player_inv = sender:get_inventory() --инвентари покупателя
		local is_endless = (meta:get_string("is_endless") == "true")
		local is_admin   = minetest.get_player_privs(name).server

		if fields.is_endless then
			meta:set_string("is_endless", fields.is_endless)
		end

		if fields.quit then -- выход с формы, возвращаем остатки игроку
			on_close_shop(sender, player_inv)
		end

		exchange_handle(sender, name, pos, meta, player_inv, is_endless, fields)
		whitelist_handle(name, pos, meta, is_admin, is_endless, fields)
		delete_members(name, pos, meta, is_admin, is_endless, fields)
	end
)
