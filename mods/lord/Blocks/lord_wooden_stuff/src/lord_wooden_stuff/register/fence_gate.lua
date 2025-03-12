local S = require("lord_wooden_stuff.config").translator

--- @param wood string
--- @param def LordWoodenStuffDefinition
--- @param groups table<string,number>
local function register_fence(wood, def, groups, _)
	doors.register_fencegate("lord_wooden_stuff:fence_gate_" .. wood, {
			description = S(def.desc .. " Fence Gate"),
			texture = def.texture,
			material = def.wood_name,
			groups = groups,
			sounds = default.node_sound_wood_defaults(),
	})
end

return register_fence
