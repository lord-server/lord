-- mechanics throwing

-- Таблица для сохранения скорости игрока до натягивания титевы, чтобы не было багов с зельями.
local players_physics = {}

local throwing = {}
local CONTROL_CHARGE = "RMB"
local PLAYER_SLOWDOWN_SPEED = 0.25

-- Заряд лука у игрока
throwing.charges = {}

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()

	if not name then
		return
	end

	if not throwing.charges[name] then
		throwing.charges[name] = 0
	end
end)

-- Стадии зарядки деревянного лука
throwing.bow_wooden_stages = {
	stages = {
			"lord_bows:bow_wooden",
			"lord_bows:bow_wooden_2",
			"lord_bows:bow_wooden_3",
			"lord_bows:bow_wooden_4",
	},
	charging_time = { 0, 1, 2, 3 },
}

-- Таблица снарядов итем = сущность, скорость
throwing.projectile_arrow = {
	["lord_bows:arrow"] = {"lord_bows:arrow", 10},
}

-- Зарядка лука одного вида
local function bow_charge(stack, hold_time, bow_stages, player)
	local name = player:get_player_name()

	if not name then
		return
	end

	for key, value in pairs(bow_stages.stages) do
		if stack:get_name() == value then
			if (hold_time >= bow_stages.charging_time[key]) and (#bow_stages.stages >= key+1) then
				stack:set_name(bow_stages.stages[key+1])
				throwing.charges[name] = throwing.charges[name]+1
				return stack
			end
		end
	end
	return false
end

-- Разрядка лука одного вида
local function bow_discharge(stack, bow_stages)
	stack:set_name(bow_stages.stages[1])
	return stack
end

-- Замедление игрока
local function player_slowdown(player)
	local physics = player:get_physics_override()

	if not physics then
		return
	end

	if physics.speed ~= PLAYER_SLOWDOWN_SPEED then
		players_physics[player:get_player_name()] = physics.speed
	end

	physics.speed = PLAYER_SLOWDOWN_SPEED
	player:set_physics_override(physics)
end

-- Сброс замедления игрока
local function player_reset_slowdown(player)
	local physics = player:get_physics_override()

	if not physics then
		return
	end

	physics.speed = players_physics[player:get_player_name()]
	player:set_physics_override(physics)
end

-- Выстрел
local function arrow_shot(player)
	local inv = player:get_inventory()
	local look_dir = player:get_look_dir()
	local player_pos = player:get_pos()
	local arrow_pos = {x = player_pos.x, y = player_pos.y+1.5, z = player_pos.z}
	local charge = throwing.charges[player:get_player_name()]
	for key, value in pairs(throwing.projectile_arrow) do
		if inv:contains_item("main", key) then
			local arrow = minetest.add_entity(arrow_pos, value[1])
			arrow:add_velocity({
				x = look_dir.x*value[2]*charge,
				y = look_dir.y*value[2]*charge,
				z = look_dir.z*value[2]*charge,
			})
			arrow:set_acceleration({x = 0, y = GRAVITY*(-1), z = 0})
			inv:remove_item("main", key)
			return
		end
	end
end

-- Есть ли в инвентаре стрелы?
local function there_is_arrows(player)
	local inv = player:get_inventory()
	for key, _ in pairs(throwing.projectile_arrow) do
		if inv:contains_item("main", key) then return true end
	end
end

-- Зарядка лука по удержанию
lord.register_on_hold(function(player, control_name, hold_time)
	-- Зарядка на клавишу СONTROL_CHARGE
	if control_name ~= CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()

	-- Если предмет не лук
	if not stack:get_definition().groups.bow then
		return
	end

	if not there_is_arrows(player) then
		return
	end

	player_slowdown(player)
	local new_stack = bow_charge(stack, hold_time, throwing.bow_wooden_stages, player)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Разрядка лука при отпуске клавиши
lord.register_on_release(function(player, control_name)
	if control_name ~= CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()

	if not stack:get_definition().groups.bow then
		return
	end

	arrow_shot(player)

	throwing.charges[player:get_player_name()] = 0

	player_reset_slowdown(player)
	local new_stack = bow_discharge(stack, throwing.bow_wooden_stages)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Если лук заряжался, а итем в руке сменился, то надо разрядить лук (без выстрела)
lord.register_on_wield_index_change(function(player, player_wield_index, player_last_wield_index)
	local inv = player:get_inventory()
	local stack = inv:get_stack("main", player_last_wield_index)

	if not stack:get_definition().groups.bow then return end

	throwing.charges[player:get_player_name()] = 0

	player_reset_slowdown(player)
	local new_stack = bow_discharge(stack, throwing.bow_wooden_stages)
	if new_stack then
		inv:set_stack("main", player_last_wield_index, new_stack)
	end
end)

-- Регистрация снаряда-стрелы (entities_projectiles)
projectiles.register_projectile_arrow_type("lord_bows:arrow", "lord_bows:arrow", {
	textures = {"projectile_arrow.png"},
	damage = 10,
})

