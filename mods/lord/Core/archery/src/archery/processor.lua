local api = require("archery.processor.processing_api")
local S = minetest.get_translator("archery")

-- Archery item charge on hold
controls.on_hold(function(player, key, hold_time)
	-- Charging on holding api.CONTROL_CHARGE
	if key ~= api.CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()

	-- Check if wielded item is not an archery_item
	if not stack_def.groups.archery_item then
		return
	end

	local meta = stack:get_meta()

	if not meta:contains("loaded_projectile") then
		return
	end

	api.player_slowdown(player)

	local new_stack = api.charge(stack, hold_time, api.reg_from_archery_item(stack:get_name()).stage_conf, player)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Bow loading on starting holding
controls.on_press(function(player, key)
	if key ~= api.CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()

	if not stack_def.groups.bow or stack_def.groups.is_loaded then
		return
	end

	local inv = player:get_inventory()
	local meta = stack:get_meta()
	local wield_index = player:get_wield_index()

	local projectile_item = api.find_matching_projectile(player, stack)

	if projectile_item and not meta:contains("loaded_projectile") then
		inv:remove_item("main", projectile_item)
		meta:set_string("loaded_projectile", projectile_item)
		inv:set_stack("main", wield_index, stack)
		return
	end
end)

-- Bow discharge on release
controls.on_release(function(player, key, hold_time)
	if key ~= api.CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()

	if not (stack_def.groups.bow and stack_def.groups.is_loaded) then
		return
	end

	local inv = player:get_inventory()
	local meta = stack:get_meta()
	local wield_index = player:get_wield_index()

	local power = api.calculate_power(stack, hold_time)

	local projectile_item = meta:get_string("loaded_projectile")
	if projectile_item and api.projectile_shoot(player, ItemStack(projectile_item), power) then
		minetest.sound_play(stack:get_definition()["_sound_on_release"], { object = player })
		local uses = api.reg_from_archery_item(stack:get_name()).definition.uses
		stack:add_wear(65535/uses)
	end

	api.player_reset_slowdown(player)
	local new_stack = api.discharge(stack)
	if new_stack then
		local new_meta = new_stack:get_meta()
		if new_meta:contains("loaded_projectile") then
			new_meta:set_string("loaded_projectile", "")
		end
		api.player_reset_slowdown(player)
		inv:set_stack("main", wield_index, new_stack)
	end
end)

-- Crossbow loading on starting holding
controls.on_press(function(player, key)
	if key ~= api.CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()

	if not stack_def.groups.crossbow or stack_def.groups.is_loaded then
		return
	end

	local inv = player:get_inventory()
	local meta = stack:get_meta()
	local wield_index = player:get_wield_index()

	local projectile_item = api.find_matching_projectile(player, stack)

	if projectile_item and not meta:contains("loaded_projectile") then
		inv:remove_item("main", projectile_item)
		meta:set_string("loaded_projectile", projectile_item)
		inv:set_stack("main", wield_index, stack)
		return
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

	local inv = player:get_inventory()
	local meta = stack:get_meta()
	local wield_index = player:get_wield_index()

	local projectile_item = meta:get_string("loaded_projectile")
	local power = api.calculate_power(stack, nil, true)
	if projectile_item and projectile_item ~= "" and api.projectile_shoot(player, ItemStack(projectile_item), power) then
		minetest.sound_play(stack:get_definition()["_sound_on_release"], { object = player })
		local uses = api.reg_from_archery_item(stack:get_name()).definition.uses
		stack:add_wear(65535/uses)
	end

	local new_stack = api.discharge(stack)
	if new_stack then
		player:set_wielded_item(new_stack)
		if not meta:contains("loaded_projectile") then
			minetest.chat_send_player(player, S("No projectile loaded, discharged safely."))
		end
		meta:set_string("loaded_projectile", "")
		inv:set_stack("main", wield_index, new_stack)
	end
end)

-- Unload crossbow if charging is interrupted
controls.on_release(function(player, key)
	if key ~= api.CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()

	if not (stack_def.groups.crossbow and stack_def.groups.allow_hold_abort) then
		return
	end

	local meta = stack:get_meta()
	if not meta:contains("loaded_projectile") then
		return
	end

	local inv = player:get_inventory()
	local wield_index = player:get_wield_index()

	local new_stack = api.discharge(stack)
	if new_stack then
		local new_meta = new_stack:get_meta()
		if new_meta:contains("loaded_projectile") then
			local projectile_item = new_meta:get_string("loaded_projectile")
			minetest.give_or_drop(player, projectile_item)
			new_meta:set_string("loaded_projectile", "")
		end
		api.player_reset_slowdown(player)
		inv:set_stack("main", wield_index, new_stack)
	end
end)

-- Throwable item throw on release
controls.on_release(function(player, key, hold_time)
	if key ~= api.CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()
	local stack_def = stack:get_definition()

	if not stack_def.groups.throwable then
		return
	end

	local stage_conf = api.reg_from_archery_item(stack:get_name()).stage_conf

	if hold_time < stage_conf.charging_time[1] then
		return
	end

	local inv = player:get_inventory()
	--local meta = stack:get_meta()
	local wield_index = player:get_wield_index()

	local power = api.calculate_power(stack, hold_time)
	local new_stack = ItemStack(table.copy(stack:to_table()))

	local uses = api.reg_from_archery_item(new_stack:get_name()).definition.uses
	if uses then
		new_stack:add_wear(65535/uses)
	end

	local projectile_item = archery.get_throwables()[stack:get_name()].entity_name
	if projectile_item and api.projectile_shoot(player, new_stack, power) then
		minetest.sound_play(stack:get_definition()["_sound_on_release"], { object = player })
		stack:take_item(1)
	end

	api.player_reset_slowdown(player)
	inv:set_stack("main", wield_index, stack)
end)

-- If the wielded item changed while bow was charging, discharge without shooting the arrow
wield_item.on_index_change(function(player, _, player_last_wield_index)
	local inv = player:get_inventory()
	local stack = inv:get_stack("main", player_last_wield_index)

	if not stack:get_definition().groups.allow_hold_abort then
		return
	end

	api.player_reset_slowdown(player)
	local new_stack = api.discharge(stack)
	if new_stack then
		local meta = new_stack:get_meta()
		if meta:contains("loaded_projectile") then
			local projectile_item = meta:get_string("loaded_projectile")
			minetest.give_or_drop(player, projectile_item)
			meta:set_string("loaded_projectile", "")
		end
		inv:set_stack("main", player_last_wield_index, stack)
	end
end)
