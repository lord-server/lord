local S = core.get_mod_translator()

-- Mobs spawners for buildings
-- Mordor

core.register_node("lottother:mordorms", {
	description = S("Mordor Mob Spawner"),
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 4) == 2 then
			core.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:orc")
		elseif math.random(1, 5) == 3 then
			core.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:uruk_hai")
		elseif math.random(1, 11) == 4 then
			core.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:battle_troll")
		end
		core.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

-- Rohan

core.register_node("lottother:rohanms", {
	description = S("Rohan Mob Spawner"),
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 3) == 2 then
			core.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:rohan_guard")
		end
		core.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

-- Elf

core.register_node("lottother:elfms", {
	description = S("Elf Mob Spawner"),
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 2) == 2 then
			core.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:elf")
		end
		core.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Hobbit

core.register_node("lottother:hobbitms", {
	description = S("Hobbit Mob Spawner"),
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 2) == 2 then
			core.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:hobbit")
		end
		core.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Gondor

core.register_node("lottother:gondorms", {
	description = S("Gondor Mob Spawner"),
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 3) == 2 then
			core.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:gondor_guard")
		end
		core.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Angmar

core.register_node("lottother:angmarms", {
	description = S("Angmar Mob Spawner"),
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 2) == 2 then
			core.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:half_troll")
		end
		core.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

core.register_alias("lottother:gondorms_on", "lottother:gondorms")
core.register_alias("lottother:gondorms_off", "lottother:gondorms")
core.register_alias("lottother:rohanms_on", "lottother:rohanms")
core.register_alias("lottother:rohanms_off", "lottother:rohanms")
core.register_alias("lottother:angmarms_on", "lottother:angmarms")
core.register_alias("lottother:angmarms_off", "lottother:angmarms")
core.register_alias("lottother:hobbitms_on", "lottother:hobbitms")
core.register_alias("lottother:hobbitms_off", "lottother:hobbitms")
core.register_alias("lottother:elfms_on", "lottother:elfms")
core.register_alias("lottother:elfms_off", "lottother:elfms")
core.register_alias("lottother:mordorms_on", "lottother:mordorms")
core.register_alias("lottother:mordorms_off", "lottother:mordorms")
