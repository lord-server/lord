local S = minetest.get_translator("lord_boats")

-- Load files
local default_path = minetest.get_modpath("lord_boats")
dofile(default_path.."/functions.lua")


-- Registering boats
lord_boats.register_boat("lord_boats:row_boat", {
	initial_properties = {
		physical = true,
		-- Warning: Do not change the position of the collisionbox top surface,
		-- lowering it causes the boat to fall through the world if underwater
		collisionbox = { -0.6, -0.25, -0.6, 0.6, 0.45, 0.6, },
		visual = "mesh",
		mesh = "rowboat.obj",
		textures = {"default_wood.png"},
	},
	driver_shift = { x = 0, y = 0.4, z = 0, },
	driver_bone_position = { x = 0, y = 1, z = -4, },
	control_modifier = { up = 1.0, down = 1.0, left_right = 0.5, },
	vertical_acceleration = {
		fast_condition = 3,
		fast_up = 3,
		up = 3,
		down = 10,
	},
	description = S("Row Boat"),
	inventory_image = "rowboat_inventory.png",
	wield_image = "rowboat_wield.png",
	recipe = {
		{ "",           "",           "",          },
		{ "group:wood", "",           "group:wood", },
		{ "group:wood", "group:wood", "group:wood", },
	},
	fuel_burntime = 20,
})

lord_boats.register_boat("lord_boats:sail_boat", {
	initial_properties = {
		physical = true,
		-- Warning: Do not change the position of the collisionbox top surface,
		-- lowering it causes the boat to fall through the world if underwater
		collisionbox = { -1, -0.25, -1, 1, 0.65, 1, },
		visual = "mesh",
		mesh = "sailboat.obj",
		textures = {"sailboat.png"},
	},
	driver_shift = { x = 0, y = 0.6, z = 0, },
	driver_bone_position = { x = 0, y = 1, z = -1, },
	control_modifier = { up = 2.0, down = 0.5, left_right = 0.9, },
	vertical_acceleration = {
		fast_condition = 1,
		fast_up = 5,
		up = 5,
		down = 20,
	},
	description = S("Sail Boat"),
	inventory_image = "sailboat_inventory.png",
	wield_image = "sailboat_wield.png",
	recipe = {
		{ "",           "wool:white",     "",           },
		{ "group:wood", "wool:white",     "group:wood", },
		{ "group:tree", "boats:row_boat", "group:tree", },
	},
	fuel_burntime = 30,
})


--Aliases for lord_boats
minetest.register_alias("boats:row_boat", "lord_boats:row_boat")
minetest.register_alias("boats:sail_boat", "lord_boats:sail_boat")


-- Migration `MTG/boats` to `lord_boats`
local migrate_entities = {
	{ "boats:row_boat", "lord_boats:row_boat", },
	{ "boats:sail_boat", "lord_boats:sail_boat", },
}

for i, entity_name in ipairs(migrate_entities) do
	local old_entity = entity_name[1]
	local new_entity = entity_name[2]

	minetest.register_entity(":" .. old_entity, {
		on_activate = function(self, staticdata)
			local pos = self.object:get_pos()
			local pos_log = minetest.pos_to_string(pos)
			self.object:remove()
			minetest.add_entity(pos, new_entity)
			minetest.log("none", pos_log .. " " .. old_entity .. " was replaced with " .. new_entity)
		end,
	})
end
