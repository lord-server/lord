-- Keep these for backwards compatibility
function hbhunger.save_hunger(player)
	hbhunger.set_hunger_raw(player)
end
function hbhunger.load_hunger(player)
	hbhunger.get_hunger_raw(player)
end

-- wrapper for minetest.item_eat (this way we make sure other mods can't break this one)
local org_eat = core.do_item_eat
core.do_item_eat = function(hp_change, replace_with_item, itemstack, user, pointed_thing)
	local old_itemstack = itemstack
	itemstack = hbhunger.eat(hp_change, replace_with_item, itemstack, user, pointed_thing)
	for _, callback in pairs(core.registered_on_item_eats) do
		local result = callback(hp_change, replace_with_item, itemstack, user, pointed_thing, old_itemstack)
		if result then
			return result
		end
	end
	return itemstack
end

-- food functions
local food = hbhunger.food

function hbhunger.register_food(name, hunger_change, replace_with_item, poisen, heal, sound)
	food[name] = {}
	food[name].saturation = hunger_change	-- hunger points added
	food[name].replace = replace_with_item	-- what item is given back after eating
	food[name].poisen = poisen				-- time its poisening
	food[name].healing = heal				-- amount of HP
	food[name].sound = sound				-- special sound that is played when eating
end

function hbhunger.eat(hp_change, replace_with_item, itemstack, user, pointed_thing)
	local item = itemstack:get_name()
	local def = food[item]
	if not def then
		def = {}
		if type(hp_change) ~= "number" then
			hp_change = 1
			core.log("error", "Wrong on_use() definition for item '" .. item .. "'")
		end
		def.saturation = hp_change * 1.3
		def.replace = replace_with_item
	end
	local func = hbhunger.item_eat(def.saturation, def.replace, def.poisen, def.healing, def.sound)
	return func(itemstack, user, pointed_thing)
end

local function poisenp(tick, poisen, time_left, player)
	local time_full = math.abs(poisen)
	time_left = time_left + tick
	if time_left < time_full then
		minetest.after(tick, poisenp, tick, poisen, time_left, player)
	else
		hbhunger.poisonings[player:get_player_name()] = hbhunger.poisonings[player:get_player_name()] - 1
		if hbhunger.poisonings[player:get_player_name()] <= 0 then
			-- Reset HUD bar color
			hb.change_hudbar(player, "health", nil, nil, "hudbars_icon_health.png", nil, "hudbars_bar_health.png")
		end
	end
	if (player:get_hp()-1 > 0)and(poisen < 0) then
		player:set_hp(player:get_hp() - 1)
	end
end

function hbhunger.item_eat(hunger_change, replace_with_item, poisen, heal, sound)
	return function(itemstack, user, pointed_thing)
		if itemstack:take_item() ~= nil and user ~= nil then
			local name = user:get_player_name()
			local h = tonumber(hbhunger.hunger[name])
			local hp = user:get_hp()
			if h == nil or hp == nil then
				return
			end
			minetest.sound_play({name = sound or "hbhunger_eat_generic", gain = 1}, {pos=user:getpos(), max_hear_distance = 16})

			-- Saturation
			if h < 30 and hunger_change > 0 then
				h = h + hunger_change
				if h > 30 then h = 30 end
				hbhunger.hunger[name] = h
				hbhunger.set_hunger_raw(user)
			elseif hunger_change < 0 then
				h = h + hunger_change
				if h > 30 then h = 30 end
				if h < 0 then h = 0 end --Позволяет юзать отрицательное значение hunger_change 
				hbhunger.hunger[name] = h
				hbhunger.set_hunger_raw(user)
			end
			-- Healing
			if hp < 20 and heal then
				hp = hp + heal
				if hp > 20 then hp = 20 end
				user:set_hp(hp)
			end
			-- Poison
			if poisen then
				-- Set poison bar
				local hotbar_poisen_texture
				if poisen < 0 then 
					hotbar_poisen_texture = "hbhunger_icon_health_poison.png" 
				else 
					hotbar_poisen_texture = "hbhunger_icon_health_regen.png"
				end
				hb.change_hudbar(user, "health", nil, nil, hotbar_poisen_texture, nil, hotbar_poisen_texture)
				hbhunger.poisonings[name] = hbhunger.poisonings[name] + 1
				poisenp(1, poisen, 0, user)
			end

			if itemstack:get_count() == 0 then
				itemstack:add_item(replace_with_item)
			else
				local inv = user:get_inventory()
				if inv:room_for_item("main", replace_with_item) then
					inv:add_item("main", replace_with_item)
				else
					minetest.add_item(user:getpos(), replace_with_item)
				end
			end
		end
		return itemstack
	end
end

hbhunger.register_food("bees:bottle_honey", 2, "vessels:glass_bottle", 3)

hbhunger.register_food("default:apple", 1)

hbhunger.register_food("farming:bread", 8)

if minetest.get_modpath("lottfarming") ~= nil then
	hbhunger.register_food("lottfarming:berries", 1)
	hbhunger.register_food("lottfarming:blue_mushroom", 1, "", -2)
	hbhunger.register_food("lottfarming:brown_mushroom", 1)
	hbhunger.register_food("lottfarming:cabbage", 1)
	hbhunger.register_food("lottfarming:carrot_item", 1)
	hbhunger.register_food("lottfarming:cookie_cracker", 7)
	hbhunger.register_food("lottfarming:ear_of_corn", 2)
	hbhunger.register_food("lottfarming:green_mushroom", 1, "", -2)
	hbhunger.register_food("lottfarming:melon", 1)
	hbhunger.register_food("lottfarming:mushroom_soup", 3, "lottfarming:bowl")
	hbhunger.register_food("lottfarming:potato", 1)
	hbhunger.register_food("lottfarming:potato_cooked", 4)
	hbhunger.register_food("lottfarming:red_mushroom", -8, "", -8)
	hbhunger.register_food("lottfarming:salad", 4, "lottfarming:bowl")
	hbhunger.register_food("lottfarming:tomato_soup", 4, "lottfarming:bowl")
	hbhunger.register_food("lottfarming:tomatoes", 1)
	hbhunger.register_food("lottfarming:tomatoes_cooked", 3)
	hbhunger.register_food("lottfarming:turnips", 1)
	hbhunger.register_food("lottfarming:turnips_cooked", 2)
end

if minetest.get_modpath("lottmobs") ~= nil then
	hbhunger.register_food("lottmobs:chicken_cooked", 8)
	hbhunger.register_food("lottmobs:chicken_raw", 1, "", -4)
	hbhunger.register_food("lottmobs:egg", 1)
	hbhunger.register_food("lottmobs:fish_cooked", 6)
	hbhunger.register_food("lottmobs:fish_raw", 1, "", -2)
	hbhunger.register_food("lottmobs:fried_egg", 2)
	hbhunger.register_food("lottmobs:horsemeat_cooked", 17)
	hbhunger.register_food("lottmobs:horsemeat_raw", 2, "", -3)
	hbhunger.register_food("lottmobs:meat", 6)
	hbhunger.register_food("lottmobs:meat_raw", 1, "", -4)
	hbhunger.register_food("lottmobs:pork_cooked", 19)
	hbhunger.register_food("lottmobs:pork_raw", 2, "", -4)
	hbhunger.register_food("lottmobs:rabbit_cooked", 4)
	hbhunger.register_food("lottmobs:rabbit_raw", 1, "", -4)
	hbhunger.register_food("lottmobs:rotten_meat", -6, "", -6)
end

if minetest.get_modpath("lottores") ~= nil then
	hbhunger.register_food("lottores:salt", 0, "", -2)
	hbhunger.register_food("lottores:salt_block", 0, "", -24)
end

if minetest.get_modpath("lottplants") ~= nil then
	hbhunger.register_food("lottplants:honey", 2)
	hbhunger.register_food("lottplants:plum", 1)
	hbhunger.register_food("lottplants:yavannamirefruit", 15, "", nil, "4")
end

if minetest.get_modpath("lottpotion") ~= nil then
	hbhunger.register_food("lottpotion:ale", 1, "vessels:drinking_glass", 4)
	hbhunger.register_food("lottpotion:beer", 2, "vessels:drinking_glass", 2)
	hbhunger.register_food("lottpotion:cider", 2, "vessels:drinking_glass", 2)
	hbhunger.register_food("lottpotion:mead", 3, "vessels:drinking_glass", 4)
	hbhunger.register_food("lottpotion:wine", 2, "vessels:drinking_glass", 5)
end

-- player-action based hunger changes
function hbhunger.handle_node_actions(pos, oldnode, player, ext)
	-- is_fake_player comes from the pipeworks, we are not interested in those
	if not player or not player:is_player() or player.is_fake_player == true then
		return
	end
	local name = player:get_player_name()
	local exhaus = hbhunger.exhaustion[name]
	if exhaus == nil then return end
	local new = hbhunger.EXHAUST_PLACE
	-- placenode event
	if not ext then
		new = hbhunger.EXHAUST_DIG
	end
	-- assume its send by main timer when movement detected
	if not pos and not oldnode then
		new = hbhunger.EXHAUST_MOVE
	end
	exhaus = exhaus + new
	if exhaus > hbhunger.EXHAUST_LVL then
		exhaus = 0
		local h = tonumber(hbhunger.hunger[name])
		h = h - 1
		if h < 0 then h = 0 end
		hbhunger.hunger[name] = h
		hbhunger.set_hunger_raw(player)
	end
	hbhunger.exhaustion[name] = exhaus
end

minetest.register_on_placenode(hbhunger.handle_node_actions)
minetest.register_on_dignode(hbhunger.handle_node_actions)
