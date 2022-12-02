local S = minetest.get_translator("arrows")

--- @generic
arrows = {}

function arrows:register_arrow(name, definition)
	local drop = true
	if definition.drop ~= nil then
		drop = definition.drop
	end
	local dop = true
	if definition.drop_on_punch ~= nil then
		dop = definition.drop_on_punch
	end
	throwing:register_arrow(name, {
		visual = definition.visual,
		visual_size = {x=0.1, y=0.1},
		textures = {definition.texture},
		velocity = definition.velocity,
		mass = definition.mass,
		kfr = definition.kfr,
		damage_coefficient = definition.damage_coefficient or 0.1,
		drop = drop,
		drop_on_punch = dop,
		arrow_type = definition.arrow_type,
		hit_mob = definition.hit_mob,
		hit_player = definition.hit_player,
		hit_node = definition.hit_node,
		ttl = definition.ttl or 400,
		fly_sound = definition.fly_sound,
	})
end

local player_shoot_throwing_weapon = function(item, player, _)

	local playerpos = player:get_pos()
	local dir = player:get_look_dir()

	throwing:shoot(player, "player", item:get_name(), {x = playerpos.x, y = playerpos.y + 1.5, z = playerpos.z}, dir, 0)

	if not minetest.is_creative_enabled(player) then
		item:take_item()
	end
	return item
end

--- @param dc number damage coefficient
--- @param mass number
--- @param initial_velocity number
function arrows.get_max_damage(dc, mass, initial_velocity)
	return mass * initial_velocity ^ 2 / 2 * dc
end

function arrows:register_throwing_weapon(name, definition)
	local arrow_def        = definition.arrow
	local craftitem_def    = definition.craftitem

	craftitem_def._tt_help = S(
		'Max damage: @1',
		arrows.get_max_damage(arrow_def.damage_coefficient, arrow_def.mass, arrow_def.velocity)
	)
	craftitem_def.on_use   = player_shoot_throwing_weapon

	arrows:register_arrow(name, arrow_def)
	minetest.register_craftitem(name, craftitem_def)
end

dofile(minetest.get_modpath("arrows").."/arrows.lua")
dofile(minetest.get_modpath("arrows").."/magic.lua")
dofile(minetest.get_modpath("arrows").."/axe.lua")

