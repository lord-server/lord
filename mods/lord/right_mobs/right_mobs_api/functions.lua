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
