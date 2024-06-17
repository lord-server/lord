local S = require("lord_wooden_stuff.config").translator

--- @param wood string
--- @param def LordWoodenStuffDefinition
--- @param groups table<string,number>
local function register_doors(wood, def, groups, _)
	local groups = table.merge(groups, { door = 1 })

	local name    = "lord_wooden_stuff:door_" .. wood
	local inv_texture = "lord_wooden_stuff_door_" .. wood .. ".png"
	local uv_texture  = "lord_wooden_stuff_door_" .. wood .. "_uv.png"

	local common_definition = {
		tiles           = {{ name = uv_texture, backface_culling = true }},
		sound_open      = "doors_door_open",
		sound_close     = "doors_door_close",
		groups          = groups,
	}
	doors.register(name, table.merge(common_definition, {
		description     = S(def.desc .. " Door"),
		inventory_image = inv_texture,
		recipe = {
			{ def.wood_name, def.wood_name },
			{ def.wood_name, def.wood_name },
			{ def.wood_name, def.wood_name },
		},
	}))
	doors.register(name .. "_lock", table.merge(common_definition, {
		description     = S(def.desc .. " Door With Lock"),
		inventory_image = inv_texture .. "^lord_doors_lock.png",
		recipe          = {
			{ name, "default:steel_ingot", }
		},
		protected       = true,
	}))
end


return register_doors
