
local dummy_entity_base_definition = {
	hp_max               = 1,
	visual               = 'mesh',
	collisionbox         = { 0, 0, 0, 0, 0, 0 },
	physical             = false,
	makes_footstep_sound = false,
	automatic_rotate     = math.pi * -3,
	static_save          = false,
	timer                = 0,
	on_activate          = function(self, staticdata, dtime_s)
		self.object:set_velocity({ x = 0, y = 0, z = 0 })
		self.object:set_acceleration({ x = 0, y = 0, z = 0 })
		self.object:set_armor_groups({ immortal = 1 })
	end
}

local DummyEntity = {

}


return {
	--- @param name       string
	--- @param definition EntityDefinition
	register = function(name, definition)
		DummyEntity[name] = {
			offset = definition.offset
		}
		definition.offset = nil
		minetest.register_entity(name, table.merge(dummy_entity_base_definition, definition))
	end,

	--- @param position Position
	--- @param name     string
	add = function(position, name)
		minetest.add_entity(
			{ x = position.x, y = position.y + DummyEntity[name].offset, z = position.z },
			name
		)

	end,

	--- @param position Position
	remove = function(position)
		--- @type Entity[]
		local objs = minetest.get_objects_inside_radius(position, 0.5)
		if objs then
			for _, obj in ipairs(objs) do
				if obj and obj:get_luaentity() and obj:get_luaentity().name:starts_with('lord_spawners:dummy_') then
					obj:remove()
				end
			end
		end
	end,
}
