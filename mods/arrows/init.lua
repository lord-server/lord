
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

local shoot_throwing_weapon = function(item, player, pointed_thing)

	local playerpos = player:getpos()
	local dir = player:get_look_dir()

	throwing:shoot(player, item:get_name(), {x = playerpos.x, y = playerpos.y + 1.5, z = playerpos.z}, dir, -0.1)

	if not minetest.settings:get_bool("creative_mode") then
		item:take_item()
	end
	return item
end

function arrows:register_throwing_weapon(name, definition)
	arrows:register_arrow(name, definition.arrow)
	local def = definition.craftitem
	def.on_use = shoot_throwing_weapon
	minetest.register_craftitem(name, def)
end

dofile(minetest.get_modpath("arrows").."/arrows.lua")
dofile(minetest.get_modpath("arrows").."/magic.lua")
dofile(minetest.get_modpath("arrows").."/axe.lua")

