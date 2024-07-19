local Event = require("controls.Event")


-- Для перевода микросекунд в секунды
local MICROSECONDS = 1000000

local last_player_controls = {}

local was_pressed = 1
local pressed_at  = 2


minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	if not player_name then return end

	last_player_controls[player_name] = {}
	for key in pairs(player:get_player_control()) do
		last_player_controls[player_name][key] = {
			[was_pressed] = false,
		}
	end
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	if not player_name then return end

	last_player_controls[player_name] = nil
end)


minetest.foreach_player_every(0, function(player, _)
	local player_name   = player:get_player_name()
	local last_controls = last_player_controls[player_name]

	if not player_name or not last_controls then
		return
	end

	local now = minetest.get_us_time()
	for key, is_pressed in pairs(player:get_player_control()) do

		-- Нажатие
		if is_pressed and not last_controls[key][was_pressed] then

			Event.trigger(Event.Type.on_press, player, key)
			last_controls[key] = {
				[was_pressed] = true,
				[pressed_at]  = now,
			}

		-- Удержание
		elseif is_pressed and last_controls[key][was_pressed] then

			local hold_time = (now - last_controls[key][pressed_at]) / MICROSECONDS
			Event.trigger(Event.Type.on_hold, player, key, hold_time)

		-- Отпуск
		elseif not is_pressed and last_controls[key][was_pressed] then

			local hold_time = (now - last_controls[key][pressed_at]) / MICROSECONDS
			Event.trigger(Event.Type.on_release, player, key, hold_time)
			last_controls[key] = {
				[was_pressed] = false,
			}

		end
	end

	last_player_controls[player_name] = last_controls
end)

return {
	--- @type fun(callback:controls.callbacks.OnPress)
	on_press   = Event.on(Event.Type.on_press),
	--- @type fun(callback:controls.callbacks.OnHold)
	on_hold    = Event.on(Event.Type.on_hold),
	--- @type fun(callback:controls.callbacks.OnRelease)
	on_release = Event.on(Event.Type.on_release),
}
