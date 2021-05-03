Y1 = 30000 -- верхняя граница
Y2 = -50 -- нижняя граница

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local y = player:getpos().y
		if y > Y1 then -- космос
			player:set_sky(
				{r=0x13, g=0x01, b=0x24},
				"skybox",
				{
					"galaxybox_1.png^[transform6",
					"galaxybox_2.png",
					"galaxybox_3.png^[transform7",
					"galaxybox_4.png^[transform1",
					"galaxybox_5.png^[transform4",
					"galaxybox_6.png",
				}
			)
			player:override_day_night_ratio(0.25)
		elseif y < Y2 then -- подземка
			player:set_sky({r=0, g=0, b=0}, "plain")
			player:override_day_night_ratio(0.1)
		else -- дефолтный skybox
			player:set_sky({r=0, g=0, b=0}, "regular")
			player:override_day_night_ratio(nil)
		end
	end
end)
