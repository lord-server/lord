-- Для перевода микросекунд в секунды
local MICROSECONDS         = 1000000

lord.registered_on_press   = {}
lord.registered_on_release = {}
lord.registered_on_hold    = {}

---
--- Регистрирует обратный вызов на нажатие кнопки из списка controls.
---
--- @param func fun(player:Player, control_name:string)
--- Принимает функцию колбека со след параметрами:
---  * `player` - игрок
---  * `control_name` - кнопка из списка controls
lord.register_on_press     = function(func)
	table.insert(lord.registered_on_press, func)
end

---
--- Регистрирует обратный вызов на отпуск кнопки из списка controls
---
--- @param func fun(player:Player, control_name:string, release_time)
--- Принимает функцию колбека со след параметрами:
---  * `player` - игрок
---  * `control_name` - кнопка из списка controls
---  * `release_time` - время удержания кнопки до того, как её отпустили
lord.register_on_release   = function(func)
	table.insert(lord.registered_on_release, func)
end

---
--- Регистрирует обратный вызов на удержании кнопки из списка controls
---
--- @param func fun(player, control_name, hold_time, dtime)
--- Принимает функцию колбека со след параметрами:
---  * `player` - игрок
---  * `control_name` - кнопка из списка controls
---  * `hold_time` - время удержания кнопки
---  * `dtime` - время между прошлым и нынешним вызовом
lord.register_on_hold      = function(func)
	table.insert(lord.registered_on_hold, func)
end



-- Вызов каллбэков нажатия клавиши
local function call_press(player, player_last_controls, control_name)
	-- Время, когда была нажата кнопка
	local press_time = minetest.get_us_time() / MICROSECONDS

	for _, func in pairs(lord.registered_on_press) do
		func(player, control_name)
	end
	player_last_controls[control_name] = { true, press_time }
end

-- Вызов каллбэков удержания клавиши
local function call_hold(player, player_last_controls, control_name, dtime)
	-- Время, когда была нажата кнопка вычитается из текущего, чтобы получить длительность нажатия
	local hold_time = minetest.get_us_time() / MICROSECONDS - player_last_controls[control_name][2]

	for _, func in pairs(lord.registered_on_hold) do
		func(player, control_name, hold_time, dtime)
	end
end

-- Вызов каллбэков отпуска кнопки
local function call_release(player, player_last_controls, control_name)
	-- Время, сколько была нажата кнопка
	local release_time = minetest.get_us_time() / MICROSECONDS - player_last_controls[control_name][2]

	for _, func in pairs(lord.registered_on_release) do
		func(player, control_name, release_time)
	end
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

	lord.players[player_name].controls = nil
end)

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()

	if not player_name then
		return
	end

	if lord.players[player_name] == nil then
		lord.players[player_name] = {}
	end
	lord.players[player_name].controls = {
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
	local player_name  = player:get_player_name()
	local player_last_ = lord.players[player_name]

	if player_name ~= nil and player_last_ ~= nil then
		local player_last_controls    = player_last_.controls
		local player_controls         = player:get_player_control()

		for control_name, control_value in pairs(player_controls) do
			if not player_last_controls then
				break
			end
			notify_subscribers(player, control_name, control_value, player_last_controls, delta_time)
		end

		-- Вызов каллбэков смены индекса предмета в руке
		lord.players[player_name].controls    = player_last_controls
	end
end)


