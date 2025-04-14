local area_id = tonumber(minetest.settings:get("sauron_curse_area"))

local effects = {
	decrease_hp = {},
	sauron_eye  = {},
}

local dmg_timer = 5
--local eye_t = 10

local function decrease_hp()
	for _, player in pairs(effects.decrease_hp) do
		if player:get_hp() >= 2 then
			player:set_hp(player:get_hp() - 2)
		end
	end
	minetest.after(dmg_timer, decrease_hp)
end

local function check_player_pos(player, _)
	local pos = vector.round(player:get_pos())
	local player_areas = areas:getAreasAtPos(pos)
	local player_name = player:get_player_name()
	if player_areas[area_id] and races.get_race(player) == "hobbit" then
		effects.decrease_hp[player_name] = player
	else
		if effects.decrease_hp[player_name] then
			effects.decrease_hp[player_name] = nil
		end
	end
end

---------------------------------------------------------------------------
---                   Регистрируем функционал                           ---
---------------------------------------------------------------------------
-- если нет конфига, выходим - не регистрируем дальнейший ф-ционал
if not area_id then
	return
end

minetest.after(dmg_timer, decrease_hp)
--minetest.after(eye_t, sauron_eye)

-- не нагружаем сервер, а проверяем только раз в секунду
minetest.foreach_player_every(1, check_player_pos)
