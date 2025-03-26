local S = require("lord_wooden_stuff.config").translator

--- @param wood       string
--- @param definition LordWoodenStuffDefinition
--- @param groups     table<string,number>
local function register_fence(wood, definition, groups, _)
	doors.register_fencegate("lord_wooden_stuff:fence_gate_" .. wood, {
		description = S(definition.desc .. " Fence Gate"),
		texture = definition.texture,
		material = definition.wood_name,
		groups = groups,
		sounds = default.node_sound_wood_defaults(),
	})
end

return register_fence
