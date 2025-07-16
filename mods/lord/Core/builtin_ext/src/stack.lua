local ipairs, pi, math_random, math_point_on_circle
    = ipairs, math.pi, math.random, math.point_on_circle
local hypot = math.hypot

--- Places an item in the inventory of the specified player
---   or drops it on the ground nearby, if there is not enough space in the inventory.
--- @param player Player
--- @param stack  ItemStack|ItemStackString
--- @return boolean `true` if the item is put into inventory, and `false` if the item is dropped to the world.
function minetest.give_or_drop(player, stack)
	local inv = player:get_inventory()
	if inv:room_for_item("main", stack) then
		inv:add_item("main", stack)
		return true
	else
		minetest.item_drop(stack, player, player:get_pos())
		return false
	end
end

--- Function of drops random items into world.
--- @param lootnode_pos Position          position of loot throw node.
--- @param player_pos   Position            position of player.
--- @param player_look  number              radians angle of get_look_horizontal.
--- @param items        remains.drop.config list of items to drop to world as loot.
--- @param scenario     "random_distance"|"default"|nil
--- 'default' or nil - drop loot on a circle with calc radius node<->player,
--- 'random_distance' - drop loot on a circle with fixed random range radius
function drop_items_to_world(lootnode_pos, player_pos, player_look, items, scenario)
	local radian_offset = 0        -- initial offset
	local angle = pi - player_look -- mirrired angle of player_look
	local sign_offset = 1          -- displacement sign, for alternating left-right drops
	local coefficient_offset = 0.3 -- coefficient of angle offset
	local drop_direction = {
		x = (player_pos.x - lootnode_pos.x),
		y = (player_pos.y - lootnode_pos.y + 4.5),
		z = (player_pos.z - lootnode_pos.z),
	}
	local radius
	if scenario == nil or scenario == 'default' then
		radius = hypot(drop_direction.x, drop_direction.z)
	end
	if scenario == 'random_distance' then
		radius = 2.5
	end
	local function coefficient_radius()
		if scenario == nil or scenario == 'default' then
			return 0.8
		end
		if scenario == 'random_distance' then
			return 0.1*math_random(6,10)
		end
	end
	for _, loot in ipairs(items) do
		if loot then
			--- @type Entity
			local item = minetest.add_item(lootnode_pos, loot)
			if item then
				drop_direction.x, drop_direction.z = math_point_on_circle(radius*coefficient_radius(), angle)
				item:set_velocity(drop_direction)
				radian_offset = radian_offset + coefficient_offset
				angle = sign_offset * radian_offset + angle
				sign_offset = -1 * sign_offset
			end
		end
	end
end
