local S = require("lord_wooden_stuff.config").translator

--- @type string
local DS = os.DIRECTORY_SEPARATOR

local mod_path = minetest.get_modpath(minetest.get_current_modname())
local mod_textures_path = mod_path .. DS .. "textures" .. DS .. "hatches" .. DS

-- TODO: get rid of this function with #1467 issue
---@param texture string
---@return boolean
local function is_texture_exists(texture)
	return io.file_exists(mod_textures_path .. texture)
end

--- @param wood string
--- @param def LordWoodenStuffDefinition
--- @param groups table<string,number>
local function register_hatch(wood, def, groups, _)
	local name = "lord_wooden_stuff:hatch_" .. wood
	local front_texture = "lord_wooden_stuff_hatch_" .. wood .. ".png"
	local side_texture  = "lord_wooden_stuff_hatch_" .. wood .. "_side.png"
	if not is_texture_exists(front_texture) then
		front_texture = def.texture .. "^[transformR90^lord_wooden_stuff_hatch__overlay.png"
	end
	if not is_texture_exists(side_texture) then
		side_texture = def.texture
	end
	doors.register_trapdoor(name, {
		description     = S(def.desc .. " Trapdoor"),
		inventory_image = front_texture,
		wield_image     = front_texture,
		tile_front      = front_texture,
		tile_side       = side_texture,
		groups          = table.merge(groups, { hatch = 1 }),
	})
	minetest.register_craft({
		output = name,
		recipe = {
			{ def.wood_name, def.wood_name },
			{ def.wood_name, def.wood_name },
		}
	})
end

return register_hatch
