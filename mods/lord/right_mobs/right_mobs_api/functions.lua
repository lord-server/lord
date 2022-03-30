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

right_mobs_api.calculate_damage = function(tool_capabilities, tflp)
	local damage = {}
	local usage

	for group, tool_damage in pairs( (tool_capabilities.damage_groups or {}) ) do
		usage = tflp / (tool_capabilities.full_punch_interval or 1.4)

		if usage < 0 then
			usage = 0.0
		elseif usage > 1 then
			usage = 1.0
		end

		damage[group] = tool_damage * usage
	end

	return damage
end
