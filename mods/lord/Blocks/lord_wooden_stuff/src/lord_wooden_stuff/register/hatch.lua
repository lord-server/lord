local S = require("lord_wooden_stuff.config").translator

--- @type string
local DS = os.DIRECTORY_SEPARATOR

---@param texture string
---@return boolean
local function is_texture_exists(texture)
	local mod_path = minetest.get_modpath(minetest.get_current_modname())
	local mod_textures_path = mod_path .. DS .. "textures" .. DS
	return io.file_exists(mod_textures_path .. texture)
end

--- @param name               string node name postfix (`"lord_wooden_stuff:hatch_"..name`). Also used for textures names.
--- @param description_prefix string used: `S(description_prefix .. " Trapdoor")`
--- @param wood_name          string technical name of planks node (ex.: `"default:wood"`) for craft.
--- @param node_groups        table  groups to apply to. Group `{ hatch = 1 }` will be added.
--- @param texture            string which texture to use, if `"lord_wooden_stuff_"..name.."_planks.png"` doesn't exists.
local function register_hatch(name, description_prefix, wood_name, node_groups, texture)
	local hatch_reg_name = "lord_wooden_stuff:hatch_" .. name
	local front_texture  = "lord_wooden_stuff_hatch_" .. name .. ".png"
	local side_texture   = "lord_wooden_stuff_hatch_" .. name .. "_side.png"
	if not is_texture_exists(front_texture) then
		front_texture = texture .. "^[transformR90^lord_wooden_stuff_hatch__overlay.png"
	end
	if not is_texture_exists(side_texture) then
		side_texture = texture
	end
	doors.register_trapdoor(hatch_reg_name, {
		description     = S(description_prefix .. " Trapdoor"),
		inventory_image = front_texture,
		wield_image     = front_texture,
		tile_front      = front_texture,
		tile_side       = side_texture,
		groups          = table.merge(node_groups, { hatch = 1 }),
	})
	minetest.register_craft({
		output = hatch_reg_name,
		recipe = {
			{ wood_name, wood_name },
			{ wood_name, wood_name },
		}
	})
end

return register_hatch
