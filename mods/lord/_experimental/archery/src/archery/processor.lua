local api = require("archery.api")

-- Archery item charge on hold
controls.on_hold(function(player, key, hold_time)
	-- Charging on holding api.CONTROL_CHARGE
	if key ~= api.CONTROL_CHARGE then
		return
	end

	-- Check if wielded item is not an archery_item
	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()
	if not stack_def.groups.archery_item then
		--minetest.chat_send_all("HERE")
		return
	end

	if not api.find_matching_projectile(player, stack) then
		--minetest.chat_send_all("HERE2")
		return
	end
	--minetest.chat_send_all("ONE")

	api.player_slowdown(player)

	local new_stack = api.charge(stack, hold_time, api.reg_from_archery_item(stack:get_name()).stage_conf, player)
	if new_stack then
		--minetest.chat_send_all("THREE")
		player:set_wielded_item(new_stack)
	end
end)

-- Charged crossbow discharge on release
controls.on_press(function(player, key)
	if key ~= api.CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()

	if not stack_def.groups.crossbow_charged then
		return
	end

	minetest.sound_play(stack:get_definition()["_sound_on_release"], {object = player})

	local power = api.calculate_power(stack, nil, true)
	api.projectile_shoot(player, stack, power)

	api.player_reset_slowdown(player)
	local new_stack = api.discharge(stack)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Bow discharge on release
controls.on_release(function(player, key, hold_time)
	if key ~= api.CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()

	if not (stack_def.groups.charged and stack_def.groups.bow) then
		return
	end

	local projectile = api.find_matching_projectile(player, stack)

	local power = api.calculate_power(stack, hold_time)

	if projectile and api.projectile_shoot(player, stack, power) then
		minetest.sound_play(stack:get_definition()["_sound_on_release"], { object = player })
	end

	api.player_reset_slowdown(player)
	local new_stack = api.discharge(stack)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- If the wielded item changed while bow was charging, discharge without shooting the arrow
wield_item.on_index_change(function(player, player_wield_index, player_last_wield_index)
	local inv   = player:get_inventory()
	local stack = inv:get_stack("main", player_last_wield_index)

	if not stack:get_definition().groups.allow_hold_abort then
		return
	end

	api.player_reset_slowdown(player)
	local new_stack = api.discharge(stack)
	if new_stack then
		inv:set_stack("main", player_last_wield_index, new_stack)
	end
end)
