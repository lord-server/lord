local S_tt = minetest.get_translator("tt_base")

local registered_projectiles = {}
local entity = require("projectiles.entity")

--- @class projectiles.Registration
--- @field projectile_texture table           table of textures used for projectile entity
--- @field definition         ItemDefinition  definition of projectile craftitem
--- @field entity_name        string          itemstring <mod>:<name>; used to name the projectile entity
--- @field damage             number          damage base value of projectile that used to calculate resulting damage
--- @field speed              number          projectile speed multiplier that used to calculate the flight trajectory
--- @field type               string          a type of projectile

--- @param name               string                    itemstring "<mod>:<projectile_name>"
--- @param reg                projectiles.Registration  projectile registration table
--- @param not_register_item  boolean                   whether to register craftitem or not (false/nil = register)
local function register_projectile(name, reg, not_register_item)
	local def       = reg.definition
	reg.type        = reg.type
	reg.entity_name = reg.entity_name or name

	registered_projectiles[name] = reg

	entity.register_projectile_entity(reg.entity_name, reg.entity_reg)

	if not_register_item then
		return
	end

	minetest.register_craftitem(name, table.overwrite({
		_tt_help = S_tt("Damage: @1", reg.damage_tt)
	}, def))
end

local flame_node = function(pos)
	local n = minetest.get_node(pos).name
	local node_desc = minetest.registered_nodes[n]
	if node_desc == nil then
		minetest.log("error", "Attempt to flame unknown node: "..n..
				" ("..pos.x..","..pos.y..","..pos.z..")")
		return
	end

	if node_desc.groups == nil then
		node_desc.groups = {}
	end

	if node_desc.groups.forbidden == nil then
		local in_nazgul_area = nazgul_area.position_in_nazgul_area(pos)

		if node_desc.groups.flammable or math.random(1, 100) <= 30 then
			if n == "air" or not in_nazgul_area then
				minetest.set_node(pos, { name = "fire:basic_flame" })
			end
		else
			if not in_nazgul_area then
				minetest.remove_node(pos)
			end
		end
	end
end

local flame_area = function(p1, p2)
	for y = p1.y, p2.y do
		for z = p1.z, p2.z do
			minetest.punch_node({ x = p1.x - 1, y = y, z = z })
			minetest.punch_node({ x = p2.x + 1, y = y, z = z })
		end
	end

	for x = p1.x, p2.x do
		for z = p1.z, p2.z do
			minetest.punch_node({ x = x, y = p1.y - 1, z = z })
			minetest.punch_node({ x = x, y = p2.y + 1, z = z })
		end
	end

	for x = p1.x, p2.x do
		for y = p1.y, p2.y do
			minetest.punch_node({ x = x, y = y, z = p1.z - 1 })
			minetest.punch_node({ x = x, y = y, z = p2.z + 1 })
		end
	end

	for x = p1.x, p2.x do
		for y = p1.y, p2.y do
			for z = p1.z, p2.z do
				flame_node(vector.new(x, y, z))
			end
		end
	end
end


return {
	flame_area          = flame_area,
	register_projectile = register_projectile,
	get_projectiles     = function() return registered_projectiles end,
}
