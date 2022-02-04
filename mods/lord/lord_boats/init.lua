-- lord_boats/init.lua

-- Load files
local default_path = minetest.get_modpath("lord_boats")
dofile(default_path.."/rowboat.lua")
dofile(default_path.."/sailboat.lua")


--Aliases for lord_boats
minetest.register_alias("boats:row_boat", "lord_boats:row_boat")
minetest.register_alias("boats:sail_boat", "lord_boats:sail_boat")


-- Migration `MTG/boats` to `lord_boats`
local migrate_entities = {
  {"boats:row_boat", "lord_boats:row_boat"},
  {"boats:sail_boat", "lord_boats:sail_boat"},
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
