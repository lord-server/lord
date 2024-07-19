local Event = require("controls.Event")


-- Для перевода микросекунд в секунды
local MICROSECONDS = 1000000

local last_player_controls = {}


-- Вызов каллбэков нажатия клавиши
local function call_press(player, player_last_controls, control_name)
	-- Время, когда была нажата кнопка
	local press_time = minetest.get_us_time() / MICROSECONDS

	Event.trigger(Event.Type.on_press, player, control_name)

	player_last_controls[control_name] = { true, press_time }
end

-- Вызов каллбэков удержания клавиши
local function call_hold(player, player_last_controls, control_name, dtime)
	-- Время, когда была нажата кнопка вычитается из текущего, чтобы получить длительность нажатия
	local hold_time = minetest.get_us_time() / MICROSECONDS - player_last_controls[control_name][2]

	Event.trigger(Event.Type.on_hold, player, control_name, hold_time, dtime)
end

-- Вызов каллбэков отпуска кнопки
local function call_release(player, player_last_controls, control_name)
	-- Время, сколько была нажата кнопка
	local release_time = minetest.get_us_time() / MICROSECONDS - player_last_controls[control_name][2]

	Event.trigger(Event.Type.on_release, player, control_name, release_time)

	player_last_controls[control_name] = { false, 0 }
end


---notify_subscribers
---@param player Player
---@param control_name string
---@param control_value table
---@param player_last_controls Entity
---@param dtime number
local function notify_subscribers(player, control_name, control_value, player_last_controls, dtime)
	-- Нажатие
	if (control_value == true) and (player_last_controls[control_name][1] == false) then
		call_press(player, player_last_controls, control_name)
	-- Удержание
	elseif (control_value == true) and (player_last_controls[control_name][1] == true) then
		call_hold(player, player_last_controls, control_name, dtime)
	-- Отпуск
	elseif (control_value == false) and (player_last_controls[control_name][1] == true) then
		call_release(player, player_last_controls, control_name)
	end
end


minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	if not player_name then
		return
	end

	last_player_controls[player_name] = nil
end)

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()

	if not player_name then
		return
	end

	last_player_controls[player_name] = {
		jump  = { false, 0 },
		right = { false, 0 },
		left  = { false, 0 },
		LMB   = { false, 0 },
		RMB   = { false, 0 },
		sneak = { false, 0 },
		aux1  = { false, 0 },
		down  = { false, 0 },
		up    = { false, 0 },
		zoom  = { false, 0 },
		dig   = { false, 0 },
		place = { false, 0 },
	}
end)


minetest.foreach_player_every(0, function(player, delta_time)
	local player_name   = player:get_player_name()
	local last_controls = last_player_controls[player_name]

	if not player_name or not last_controls then
		return
	end

	local player_controls = player:get_player_control()
	for control_name, control_value in pairs(player_controls) do
		notify_subscribers(player, control_name, control_value, last_controls, delta_time)
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
