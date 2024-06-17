local S = require("lord_wooden_stuff.config").translator

--- @param name string
--- @param description_prefix string
--- @param wood_name string
--- @param node_groups table
local function register_fence(name, description_prefix, wood_name, node_groups)
	local texture   = "lord_planks_"..name..".png"
	default.register_fence("lord_wooden_stuff:fence_" .. name, {
		description = S(description_prefix .. " Fence"),
		texture = texture,
		material = wood_name,
		groups = node_groups,
		sounds = default.node_sound_wood_defaults()
	})
	default.register_fence_rail("lord_wooden_stuff:fence_rail_" .. name, {
		description = S(description_prefix .. " Fence Rail"),
		texture = texture,
		material = wood_name,
		groups = node_groups,
		sounds = default.node_sound_wood_defaults()
	})
end

return register_fence
