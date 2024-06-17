local S = minetest.get_translator("lord_wooden_stuff")


local register_doors = require("lord_wooden_stuff.register.doors")
local register_hatch = require("lord_wooden_stuff.register.hatch")
local register_reinforced_hatch = require("lord_wooden_stuff.register.reinforced_hatch")
local register_fence = require("lord_wooden_stuff.register.fence")
local register_stick = require("lord_wooden_stuff.register.stick")
local register_ladder = require("lord_wooden_stuff.register.ladder")
local register_stanchion = require("lord_wooden_stuff.register.stanchion")
local register_table = require("lord_wooden_stuff.register.table")
local register_chair = require("lord_wooden_stuff.register.chair")


--- Registers doors, hatches, fences (with reinforced ones), sticks, ladders, stanchions, tables, chairs of given wood
--- with some exceptions.
---@param wood string
---@param def LordWoodenStuffDefinition
local function register_wooden_stuff(wood, def)
	local desc_prefix = def.desc
	local planks_name = def.wood_name
	local planks_texture = def.texture

	local node_groups     = table.copy(minetest.registered_nodes[planks_name].groups)
	node_groups["wood"]   = nil
	node_groups["wooden"] = 1

	local stick_reg_name

	if wood ~= "wood" then -- in order to not overwrite registrations from minetest_game
		if not table.contains({ "beech", "cherry", "culumalda", "elm", "fir", "plum", }, wood) then
			register_doors(wood, desc_prefix, planks_name, node_groups)
		end
		register_hatch(wood, desc_prefix, planks_name, node_groups, planks_texture)
		if wood ~= "junglewood" then
			register_fence(wood, desc_prefix, planks_name, node_groups)
		end
		stick_reg_name = register_stick(wood, desc_prefix, planks_name)
		register_ladder(wood, desc_prefix, stick_reg_name, planks_texture)
	end

	if table.contains({ "wood", "junglewood", "beech", "elm"}, wood) then
		register_reinforced_hatch(wood, desc_prefix, planks_name, node_groups)
	end

	register_stanchion(wood, desc_prefix, planks_texture, node_groups, stick_reg_name or "default:stick")
	register_table(wood, desc_prefix, planks_texture, planks_name, node_groups)
	register_chair(wood, desc_prefix, planks_texture, planks_name, node_groups)
end


return { register_wooden_stuff = register_wooden_stuff }
