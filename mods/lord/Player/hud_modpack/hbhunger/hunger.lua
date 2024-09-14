-- Keep these for backwards compatibility
function hbhunger.save_hunger(player)
	hbhunger.set_hunger_raw(player)
end
function hbhunger.load_hunger(player)
	hbhunger.get_hunger_raw(player)
end

-- wrapper for minetest.item_eat (this way we make sure other mods can't break this one)
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

function hbhunger.register_food(name, hunger_change, replace_with_item, poison, heal, sound)
	food[name] = {}
	food[name].saturation = hunger_change	-- hunger points added
	food[name].replace = replace_with_item	-- what item is given back after eating
	food[name].poison = poison				-- time its poisoning
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
		def.saturation = hp_change
		def.replace = replace_with_item
	end
	local func = hbhunger.item_eat(def.saturation, def.replace, def.poison, def.healing, def.sound)
	return func(itemstack, user, pointed_thing)
end

local function poisonp(tick, poison, time_left, player, player_name)
	local time_full = math.abs(poison)
	time_left = time_left + tick
	if time_left < time_full then
		minetest.after(tick, poisonp, tick, poison, time_left, player, player_name)
	else
		hbhunger.poisonings[player_name] = hbhunger.poisonings[player_name] - 1
		if hbhunger.poisonings[player_name] <= 0 then
			-- Reset HUD bar color
			hb.change_hudbar(player, "health", nil, nil, "hudbars_icon_health.png", nil, "hudbars_bar_health.png")
		end
	end

	local hp = player:get_hp()
	if hp and (hp-1 > 0) and (poison < 0) then
		player:set_hp(hp - 1)
	end
end

function hbhunger.item_eat(hunger_change, replace_with_item, poison, heal, sound)
	return function(itemstack, user, pointed_thing)
		if itemstack:take_item() ~= nil and user ~= nil then
			local name = user:get_player_name()
			local h = tonumber(hbhunger.hunger[name])
			local hp = user:get_hp()
			if h == nil or hp == nil then
				return
			end
			minetest.sound_play({name = sound or "hbhunger_eat_generic", gain = 1}, {pos=user:get_pos(), max_hear_distance = 16})

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
			if poison then
				-- Set poison bar
				local hotbar_poison_texture
				if poison < 0 then
					hotbar_poison_texture = "hbhunger_icon_health_poison.png"
				else
					hotbar_poison_texture = "hbhunger_icon_health_regen.png"
				end
				hb.change_hudbar(user, "health", nil, nil, hotbar_poison_texture, nil, hotbar_poison_texture)
				hbhunger.poisonings[name] = hbhunger.poisonings[name] + 1
				poisonp(1, poison, 0, user, user:get_player_name())
			end

			if itemstack:get_count() == 0 then
				itemstack:add_item(replace_with_item)
			else
				local inv = user:get_inventory()
				if inv:room_for_item("main", replace_with_item) then
					inv:add_item("main", replace_with_item)
				else
					minetest.add_item(user:get_pos(), replace_with_item)
				end
			end
		end
		return itemstack
	end
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
