right_mobs_api.drop_items = function(drops, pos)
    local obj
	drops = drops or {} -- error check

	for n = 1, #drops do

		if random(1, drops[n].chance) == 1 then

			obj = minetest.add_item(pos,
				ItemStack(drops[n].name .. " "
					.. random(drops[n].min, drops[n].max)))

			if obj then

				obj:set_velocity({
					x = random(-10, 10) / 9,
					y = 6,
					z = random(-10, 10) / 9,
				})
			end
		end
	end
end

right_mobs_api.calculate_damage = function(armor, tool_capabilities, tflp)
	local damage = 0
	local tmp

	print(dump(armor))
	print(dump(tool_capabilities))
	print(tflp)

	for group,_ in pairs( (tool_capabilities.damage_groups or {}) ) do

		tmp = tflp / (tool_capabilities.full_punch_interval or 1.4)

		if tmp < 0 then
			tmp = 0.0
		elseif tmp > 1 then
			tmp = 1.0
		end

		damage = damage + (tool_capabilities.damage_groups[group] or 0)
			* tmp * ((armor[group] or 0) / 100.0)
	end

	return damage
end
