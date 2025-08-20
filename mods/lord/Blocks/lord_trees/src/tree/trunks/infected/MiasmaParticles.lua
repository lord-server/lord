local v = vector.new

--- @class tree.trunks.infected.MiasmaParticles
local MiasmaParticles = {
	--- @private
	--- @static
	--- @type number
	speed = 0.6
}

---@param trunk_position Position
---@param air_position   Position
function MiasmaParticles.spawn(trunk_position, air_position)
	local direction = v(air_position) - v(trunk_position)
	direction.y     = 0
	direction       = direction:normalize()
	if direction:length() == 0 then
		return
	end

	local start_pos = trunk_position + (direction / 2)
	direction = (direction + v(0, 1, 0)):normalize()
	local velocity  = direction * MiasmaParticles.speed

	minetest.add_particlespawner({
		amount  = 1,
		size    = { min = 1.5,       max = 2.5, },
		pos     = {	min = start_pos, max = start_pos, },
		vel     = velocity,
		acc     = -direction * 0.7,
		time    = 3,
		glow    = 3,
		texture = {
			name        = "lord_trees_infected_miasma.png^[opacity:200",
			alpha_tween = { 0.7, 0 },
			scale_tween = { 1, 1.7 },
		},
	})
end


return MiasmaParticles
