local math_random, type, pairs, ipairs, table_copy
    = math.random, type, pairs, ipairs, table.copy
local pi, cos, sin, math_sqrt = math.pi, math.cos, math.sin, math.sqrt


local sound = {
	walk = { name = 'walk_on_bones',        gain = 0.25 },
	loot = { name = 'drop_loot_of_remains', gain = 3.0 },
}

--- @param count number              total max count of items to select from `items`.
--- @param items remains.drop.config list of items to select from.
local function get_random_items(count, items)
	local result_items = {}
	for _, row in pairs(items) do
		if math_random(row.rarity) == 1 then
			result_items[#result_items + 1] = type(row.item) == 'table'
				and row.item[math_random(#(row.item))]
				or  row.item
		end
		if #result_items == count then
			break
		end
	end


	return result_items
end

--- Расчет гипотенузы (радиуса)
--- c = math.sqrt(a^2+b^2)
---
--- @param a number                        right triangle catheter
--- @param b number                        other right triangle catheter
--- @return number                         calculated gipotenuse
local function gipotenuse_calc(a,b)
	local c = math_sqrt( a ^ 2 + b ^ 2 )

	return c
end

--- Функция расчета точки на окружности, где центром является "лутоброс" (например останки рудокопа)
--- radius - радиус от предмета до игрока
--- angle угол смещения от игрока по окружности в радианах
--- Для понимания:
---    Ось Z(в minetest) это ось X на тригонометрическом круге
---    Ось X(в minetest) это ось Y на тригонометрическом круге
---    Угол - зеркальное отражение вектора player_look (куда смотрит игрок)
--- @param radius number                   calculated by theoreme of Pifagor
--- @param angle any                       mirror reflection of the player_look angle in radian
local function around_drop(radius,angle)
	local z_point, x_point
	z_point = radius*cos(angle)
	x_point = radius*sin(angle)

	return x_point, z_point
end

--- фукниция выбрасывания лута в мир
--- Drops random items into world.
---
--- @param remains_pos Position            position of remains node.
--- @param player_pos  Position            position of player.
--- @param items       remains.drop.config list of items to drop to world as loot.
local function drop_items_to_world(remains_pos, player_pos, player_look, items)
	local drop_pos       = table_copy(remains_pos)
	drop_pos.y           = remains_pos.y + 1
	local drop_direction = {
		x = (player_pos.x - drop_pos.x),
		y = (player_pos.y - drop_pos.y + 3.5),
		z = (player_pos.z - drop_pos.z),
	}
	local random_loot = get_random_items(5, items)
	local radius = gipotenuse_calc(drop_direction.x, drop_direction.z)
	local radian_offset = 0
	local angle = pi - player_look
	local sign_offset = 1	-- знак смещения, для поочередного выброса влево-вправо
	for _, loot in ipairs(random_loot) do
		if loot then
			--- @type Entity
			local item = minetest.add_item(drop_pos, loot)
			if item then
				drop_direction.x, drop_direction.z = around_drop(
					radius, angle)
				item:set_velocity(drop_direction)
				radian_offset = radian_offset + 0.4
				angle = sign_offset * radian_offset + angle
				sign_offset = -1 * sign_offset
			end
		end
	end
end

local function sound_of_drop_loot()
	return {
		footradian_offset = sound.walk,
		dug      = sound.loot,
		place    = sound.walk,
	}
end

local function sound_of_dig_remains()
	return {
		footradian_offset = sound.walk,
		dug      = sound.walk,
		dig      = sound.walk,
		place    = sound.walk,
	}
end


return {
	get_random_items    = get_random_items,
	drop_items_to_world = drop_items_to_world,
	sound_of_drop_loot  = sound_of_drop_loot,
	sound_of_dig_remains = sound_of_dig_remains
}
