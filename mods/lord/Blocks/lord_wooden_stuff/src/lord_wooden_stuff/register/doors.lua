local S = require("lord_wooden_stuff.config").translator

--- @param name string
--- @param description_prefix string
--- @param wood_name string
--- @param node_groups table
local function register_doors(name, description_prefix, wood_name, node_groups)
	local door_groups = table.merge(node_groups, { door = 1 })

	local door_reg_name    = "lord_wooden_stuff:door_" .. name
	local door_inv_texture = "lord_wooden_stuff_door_" .. name .. ".png"
	local door_uv_texture  = "lord_wooden_stuff_door_" .. name .. "_uv.png"

	local common_definition = {
		tiles           = {{ name = door_uv_texture, backface_culling = true }},
		sound_open      = "doors_door_open",
		sound_close     = "doors_door_close",
		groups          = door_groups,
	}
	doors.register(door_reg_name, table.merge(common_definition, {
		description     = S(description_prefix .. " Door"),
		inventory_image = door_inv_texture,
		recipe = {
			{ wood_name, wood_name },
			{ wood_name, wood_name },
			{ wood_name, wood_name },
		},
	}))
	doors.register(door_reg_name .. "_lock", table.merge(common_definition, {
		description     = S(description_prefix .. " Door With Lock"),
		inventory_image = door_inv_texture .. "^lord_doors_lock.png",
		recipe          = {
			{ door_reg_name, "default:steel_ingot", }
		},
		protected       = true,
	}))
end


return register_doors
