-- lord_money/shop.lua

-- Load support for MT game translation
local S = minetest.get_translator("lord_money")

local function has_wear(listname, stack, player)
	if listname == "owner_gives" or listname == "stock"  then --проверка износа в "Предложение" и "Склад"
		if stack:get_wear() > 0 then
			minetest.chat_send_player(player:get_player_name(), S("This item must be wear-free: ") .. stack:get_description())
			return true
		end
	end
	return false
end

local shop = {}
shop.current_shop = {}
shop.formspec = {
	customer = function(pos)
		local list_name = "nodemeta:"..pos.x..","..pos.y..","..pos.z
		local formspec = "size[8,9]"..
		"label[0,-0.35;"..S("Owner gives").."]"..
		"list["..list_name..";owner_gives;0,0.1;2,2;]"..

		"label[0,1.95;"..S("Owner wants").."]"..
		"list["..list_name..";owner_wants;0,2.4;2,2;]"..

		"label[3,-0.35;"..S("Customer gives (pay here !)").."]"..
		"list[current_player;customer_gives;3,0.1;5,2;]"..

		"label[3,1.95;"..S("Customer gets").."]"..
		"list[current_player;customer_gets;3,2.4;5,2;]"..

		"button[0,4.35;8,1;exchange;"..S("Exchange").."]"..
		"list[current_player;main;0,5.3;8,4;]"..

		"listring[current_player;customer_gets]"..
		"listring[current_player;main]"..
		"listring[current_player;customer_gives]"..
		"listring[current_player;main]"

		return formspec
	end,
	configurator = function(pos, admin, is_endless)
		local list_name = "nodemeta:"..pos.x..","..pos.y..","..pos.z
		local formspec = "size[8,9]"..
		"label[0,-0.35;"..S("In exchange, you give:").."]"..
		"list["..list_name..";owner_gives;0,0.1;2,2;]"..

		"label[0,1.95;"..S("You want:").."]"..
		"list["..list_name..";owner_wants;0,2.4;2,2;]"..

		"label[3,-0.35;"..S("Your stock:").."]"..
		"list["..list_name..";stock;3,0.1;5,2;]"..

		"label[3,1.95;"..S("Customers gave:").."]"..
		"list["..list_name..";customers_gave;3,2.4;5,2;]"..

		"label[0,4.35;"..S("Owner, Use(E)+Place(RMB) for customer interface").."]"..
		"list[current_player;main;0,5.3;8,4;]"..

		"listring["..list_name..";owner_gives]"..
		"listring[current_player;main]"..
		"listring["..list_name..";stock]"..
		"listring[current_player;main]"..
		"listring["..list_name..";owner_wants]"..
		"listring[current_player;main]"..
		"listring["..list_name..";customers_gave]"..
		"listring[current_player;main]"

		if admin then
			formspec = formspec.."checkbox[5,4.35;is_endless;"..S("Endless Store")..";" .. tostring( is_endless ) .. "]"
		end

		return formspec
	end,

}

shop.player_has_access = function(player, shop_pos)
	local owner_name = minetest.get_meta(shop_pos):get_string("owner")
	local player_name = player:get_player_name()
	local is_admin = minetest.get_player_privs(player_name).server
	return player_name == owner_name or is_admin, is_admin
end

minetest.register_node("lord_money:shop", {
	description = S("Shop Chest"),
	tiles = {"shop_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_lock.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2, wooden=1},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer, itemstack)
		local owner = placer:get_player_name()
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Exchange shop (owned by").." "..owner..")")
		meta:set_string("owner",owner)
		meta:set_string("is_endless","false")
		local inv = meta:get_inventory()
		inv:set_size("customers_gave", 5*2)
		inv:set_size("stock", 5*2)
		inv:set_size("owner_wants", 2*2)
		inv:set_size("owner_gives", 2*2)
	end,

	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		local user_name = clicker:get_player_name()
		shop.current_shop[user_name] = pos
		local has_access, is_admin = shop.player_has_access(clicker, pos)
		local is_endless = (meta:get_string("is_endless") == "true")

		if has_access and not clicker:get_player_control().aux1 then
			minetest.show_formspec(user_name,"lord_money:shop_formspec",shop.formspec.configurator(pos, is_admin, is_endless))
		else
			clicker:get_inventory():set_size("customer_gives", 5*2)
			clicker:get_inventory():set_size("customer_gets", 5*2)
			minetest.show_formspec(user_name,"lord_money:shop_formspec",shop.formspec.customer(pos))
		end
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if shop.player_has_access(player, pos) then
			local stack_from = minetest.get_meta(pos):get_inventory():get_stack(from_list, from_index)
			if has_wear(to_list, stack_from, player) then
				return 0
			else
				return count
			end
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if shop.player_has_access(player, pos) then
			if has_wear(listname, stack, player) then
				return 0
			else
				return stack:get_count()
			end
		end
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if shop.player_has_access(player, pos) then
			return stack:get_count()
		end
		return 0
	end,

	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()

		return inv:is_empty("stock") and
			inv:is_empty("customers_gave") and
			inv:is_empty("owner_wants") and
			inv:is_empty("owner_gives")
	end
})

minetest.register_craftitem("lord_money:license", {
	description = S("License"),
	inventory_image = "shop_license.png",
	groups = {not_in_creative_inventory=1, book=1, paper=1},
})

minetest.register_craft({
	type = "shapeless",
	output = "lord_money:shop",
	recipe = {"lord_money:license", "default:chest_locked"}
})


minetest.register_on_player_receive_fields(
	function(sender, formname, fields)
		if formname ~= "lord_money:shop_formspec" then return end-- проверка соответсвия формы
		local name = sender:get_player_name() -- имя покупателя
		local pos = minetest.pos_to_string(shop.current_shop[name]) -- координаты магазина для логов type string
		local meta = minetest.get_meta(shop.current_shop[name]) -- метаданные магазина
		local pinv = sender:get_inventory() --инвентари покупателя

		if fields.is_endless then
			meta:set_string("is_endless", fields.is_endless)
		end

		if fields.exchange then -- нажата кнопка "купить"
			local is_endless = (meta:get_string("is_endless") == "true")
			local mail = ""
			if minetest.get_modpath("mail_list") then -- если есть мод взаимодействия с e-mail
				mail = get_mail(meta:get_string("owner")) -- адрес владельца
			end
			local minv = meta:get_inventory() -- инвентари магазина
			local wants = minv:get_list("owner_wants") -- цена
			local gives = minv:get_list("owner_gives") -- товар

			-- ПРОВЕРКА НАЛИЧИЯ ЦЕНЫ И ПРЕДЛОЖЕНИЯ
			if minv:is_empty("owner_wants") or minv:is_empty("owner_gives") then -- защита от бесплатного прилавка
				minetest.log("action", string.format("магазин %s - игрок %s пытался совершить обмен, но в магазине " ..
					"пусты ячейки цены или предложения.", pos, name))
				minetest.chat_send_player(name, S("Exchange shop is not working, please contact the seller"))
				return
			end

			-- ПРОВЕРКА СООТВЕТСТВИЯ ОПЛАТЫ ЦЕНЕ
			for _, stack in pairs(wants) do
				if not pinv:contains_item("customer_gives", stack, true) then --If false, only the items' names are compared
					minetest.log("action", string.format("магазин %s - игрок %s пытался совершить обмен, но его " ..
						"оплата не соответствует цене.", pos, name))
					minetest.chat_send_player(name, S("Exchange can not be done, check if you put all items!"))
					return
				end
			end

			-- ПРОВЕРКА НАЛИЧИЯ СВОБОДНОГО МЕСТА В СТЭКЕ "Приобретённый товар"
			for _, stack in pairs(gives) do
				if not pinv:room_for_item("customer_gets", stack) then
					minetest.log("action", string.format("магазин %s - игрок %s пытался совершить обмен, но у него " ..
						"не оказалось свободного места.", pos, name))
					minetest.chat_send_player(name, S("Exchange can not be done, check if you have place!"))
					return
				end
			end

			-- ПРОВЕРКИ ДЛЯ ОБЫЧНЫХ ПРИЛАВКОВ
			if not is_endless then
				-- ПРОВЕРКА НАЛИЧИЯ ТОВАРА НА СКЛАДЕ
				for _, stack in pairs(gives) do
					if not minv:contains_item("stock", stack, true) then --If false, only the items' names are compared
						minetest.log("action", string.format("магазин %s - игрок %s пытался совершить обмен, но " ..
							"но товар на складе кончился.", pos, name))
						minetest.chat_send_player(name, S("Exchange can not be done, ended goods."))
						if mail ~= nil and mail ~= "" then
							local report = S("In your store").." "..pos.." "..S("ended goods.")
							os.execute("echo '"..report.."' | mail -s 'store' "..mail)
						end
						return
					end
				end
				-- ПРОВЕРКА НАЛИЧИЯ СВОБОДНОГО МЕСТА НА СКЛАДЕ
				for _, stack in pairs(wants) do
					if not minv:room_for_item("customers_gave", stack) then
						if mail ~= nil and mail ~= "" then
							local report = S("In your store").." "..pos.." "..S("ended place.")
							os.execute("echo '"..report.."' | mail -s 'store' "..mail)
						end
						minetest.log("action", string.format("магазин %s - игрок %s пытался совершить обмен, но на " ..
							"складе недостаточно свободного места.", pos, name))
						minetest.chat_send_player(name, S("Exchange can not be done, ended place."))
						return
					end
				end
			end

			-- ВРОДЕ ВСЁ НОРМАЛЬНО, ПРОИЗВОДИМ ОБМЕН
				for _, stack in pairs(wants) do -- для всех стеков "Цена"
					pinv:remove_item("customer_gives", stack) -- забираем у игрока из "Оплата"
					if not is_endless then
						minv:add_item("customers_gave", stack) -- помещаем в "Выручка"
					end
				end
				for _, stack in pairs(gives) do -- для всех стеков "Предложение"
					if not is_endless then
						minv:remove_item("stock", stack) -- забираем со "Склад"
					end
					pinv:add_item("customer_gets", stack) -- добавляем игроку в "Приобретённый товар"
				end
				minetest.log("action", string.format("магазин %s - игрок %s успешно произвёл обмен.", pos, name))
				minetest.chat_send_player(name, S("Exchanged!"))


		elseif fields.quit then -- выход с формы, возвращаем остатки игроку в инвентарь
			for _,list in pairs({"customer_gives", "customer_gets"}) do
				if not pinv:is_empty(list) then
					for i, stack in ipairs(pinv:get_list(list)) do
						if pinv:room_for_item("main", stack) then
							pinv:add_item("main", stack) -- если помещается, кидаем в main,
						else
							minetest.log("action", string.format("магазин %s - игрок %s инвентарь полон, товар %s " ..
								"бросили рядом", pos, name, stack:get_name()))
							minetest.item_drop(stack, sender, sender:get_pos()) -- если нет - кидаем на пол
						end
						pinv:set_stack(list, i, nil) -- Удаляем элемент i из list
					end
				end
			end
		end

	end
)
