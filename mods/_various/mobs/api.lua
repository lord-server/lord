
-- Mobs Api (26th March 2017)

mobs = {}
mobs.mod = "redo"

local S = minetest.get_mod_translator()

local function mob_is_dead(self)
	if not self.object:get_pos() then
		return true
	end
	return false
end


-- Invisibility mod check
mobs.invis = {}
if rawget(_G, "invisibility") then
	mobs.invis = invisibility
end


-- localize math functions
local pi = math.pi
local square = math.sqrt
local sin = math.sin
local cos = math.cos
local abs = math.abs
local min = math.min
local max = math.max
local atann = math.atan
local random = math.random
local floor = math.floor
local atan = function(x)
	if x ~= x then
		--error("atan bassed NaN")
		return 0
	else
		return atann(x)
	end
end
local table_copy = table.copy


-- Load settings
local damage_enabled = minetest.settings:get_bool("enable_damage")
local peaceful_only = minetest.settings:get_bool("only_peaceful_mobs")
local disable_blood = minetest.settings:get_bool("mobs_disable_blood")
local spawn_protected = tonumber(minetest.settings:get("mobs_spawn_protected")) or 1
local remove_far = minetest.settings:get_bool("remove_far_mobs")
local difficulty = tonumber(minetest.settings:get("mob_difficulty")) or 1.0
local show_health = minetest.settings:get_bool("mob_show_health") ~= false
local max_per_block = tonumber(minetest.settings:get("max_objects_per_block") or 99)

-- calculate aoc range for mob count
local aosrb = tonumber(minetest.settings:get("active_object_send_range_blocks"))
local abr = tonumber(minetest.settings:get("active_block_range"))
local aoc_range = max(aosrb, abr) * 16

-- pathfinding settings
local enable_pathfinding = true
local stuck_timeout = 3 -- how long before mob gets stuck in place and starts searching
local stuck_path_timeout = 10 -- how long will mob follow path before giving up



-- play sound
local mob_sound = function(self, sound)

	if sound then
		minetest.sound_play(sound, {
			object = self.object,
			gain = 1.0,
			max_hear_distance = self.sounds.distance
		})
	end
end


-- attack player/mob
local do_attack = function(self, player)

	if self.state == "attack" then
		return
	end

	self.attack = player
	self.state = "attack"

	if random(0, 100) < 90 then
		mob_sound(self, self.sounds.war_cry)
	end
end


-- move mob in facing direction
local set_velocity = function(self, v)

	local yaw = self.object:get_yaw() + self.rotate

	self.object:set_velocity({
		x = sin(yaw) * -v,
		y = self.object:get_velocity().y,
		z = cos(yaw) * v
	})
end


-- get overall speed of mob
local get_velocity = function(self)

	local v = self.object:get_velocity()

	return (v.x * v.x + v.z * v.z) ^ 0.5
end


-- set defined animation
local set_animation = function(self, anim)

	if not self.animation then return end

	self.animation.current = self.animation.current or ""

	if anim == self.animation.current
	or not self.animation[anim .. "_start"]
	or not self.animation[anim .. "_end"] then
		return
	end

	self.animation.current = anim

	self.object:set_animation({
		x = self.animation[anim .. "_start"],
		y = self.animation[anim .. "_end"]
	}, self.animation[anim .. "_speed"] or self.animation.speed_normal or 15)

end


-- get distance
local get_distance = function(a, b)
	if not a or not b then return 50 end -- nil check and default distance

	local x, y, z = a.x - b.x, a.y - b.y, a.z - b.z

	return square(x * x + y * y + z * z)
end


-- check line of sight using raycasting (thanks Astrobe)
local function line_of_sight(self, pos1, pos2)

	local ray = minetest.raycast(pos1, pos2, true, false) -- ignore entities
	local thing = ray:next()
	local name, nodedef

	while thing do

		if thing.type == "node" then

			name = minetest.get_node(thing.under).name
			nodedef = minetest.registered_items[name]

			if nodedef and nodedef.walkable then return false end
		end

		thing = ray:next()
	end

	return true
end


-- are we flying in what we are suppose to? (taikedz)
local function flight_check(self, pos_w)

	local nod = self.standing_in

	if type(self.fly_in) == "string"
	and ( nod == self.fly_in or nod == self.fly_in:gsub("_source", "_flowing") ) then

		return true

	elseif type(self.fly_in) == "table" then

		for _,fly_in in pairs(self.fly_in) do

			if nod == fly_in or nod == fly_in:gsub("_source", "_flowing") then

				return true
			end
		end
	end
end


-- particle effects
local function effect(pos, amount, texture, min_size, max_size, radius, gravity)

	radius = radius or 2
	min_size = min_size or 0.5
	max_size = max_size or 1
	gravity = gravity or -10

	minetest.add_particlespawner({
		amount = amount,
		time = 0.25,
		minpos = pos,
		maxpos = pos,
		minvel = {x = -radius, y = -radius, z = -radius},
		maxvel = {x = radius, y = radius, z = radius},
		minacc = {x = 0, y = gravity, z = 0},
		maxacc = {x = 0, y = gravity, z = 0},
		minexptime = 0.1,
		maxexptime = 1,
		minsize = min_size,
		maxsize = max_size,
		texture = texture,
	})
end


-- update nametag colour
local function update_tag(self)

	local col = "#00FF00"
	local qua = self.hp_max / 4

	if self.health <= floor(qua * 3) then
		col = "#FFFF00"
	end

	if self.health <= floor(qua * 2) then
		col = "#FF6600"
	end

	if self.health <= floor(qua) then
		col = "#FF0000"
	end

	self.object:set_properties({
		nametag = self.nametag,
		nametag_color = col
	})

end

local function mob_die(self)
	-- drop items when dead
	local obj
	local pos = self.object:get_pos()
	self.drops = self.drops or {} -- error check

	for n = 1, #self.drops do

		if random(1, self.drops[n].chance) == 1 then

			obj = minetest.add_item(pos,
				ItemStack(self.drops[n].name .. " "
					.. random(self.drops[n].min, self.drops[n].max)))

			if obj then

				obj:set_velocity({
					x = random(-10, 10) / 9,
					y = 6,
					z = random(-10, 10) / 9,
				})
			end
		end
	end

	mob_sound(self, self.sounds.death)

	-- execute custom death function
	if self.on_die then

		self.on_die(self, pos)
		self.object:remove()

		return true
	end

	-- default death function and die animation (if defined)
	if self.animation
	and self.animation.die_start
	and self.animation.die_end then

		self.attack = nil
		self.v_start = false
		self.timer = 0
		self.blinktimer = 0
		self.passive = true
		self.state = "die"
		set_velocity(self, 0)
		set_animation(self, "die")

		minetest.after(2, function(entity)
			entity.object:remove()
		end, self)
	else
		self.object:remove()
	end

	effect(pos, 20, "tnt_smoke.png")

	return true
end

local function mob_damaged(self)
	mob_sound(self, self.sounds.damage)

	-- make sure health isn't higher than max
	if self.health > self.hp_max then
		self.health = self.hp_max
	end

	-- backup nametag so we can show health stats
	if not self.nametag2 then
		self.nametag2 = self.nametag or ""
	end

	if show_health then
		self.htimer = 2
		if self.health_orig ~= nil then
			self.nametag = "♥ " .. self.health .. " / " .. self.health_orig
		else
			self.nametag = "♥ " .. self.health .. " / " .. self.hp_max
		end
		update_tag(self)
	end

	return false
end

-- check if mob is dead or only hurt
local function check_for_death(self)
	-- has health actually changed?
	if self.health == self.old_health then
		return
	end

	self.old_health = self.health

	-- still got some health? play hurt sound
	if self.health > 0 then
		return mob_damaged(self)
	else
		return mob_die(self)
	end
end


-- check if within physical map limits (-30911 to 30927)
local function within_limits(pos, radius)

	if  (pos.x - radius) > -30913
	and (pos.x + radius) <  30928
	and (pos.y - radius) > -30913
	and (pos.y + radius) <  30928
	and (pos.z - radius) > -30913
	and (pos.z + radius) <  30928 then
		return true -- within limits
	end

	return false -- beyond limits
end


-- is mob facing a cliff
local function is_at_cliff(self)

	if self.fear_height == 0 then -- 0 for no falling protection!
		return false
	end

	local yaw = self.object:get_yaw()
	local dir_x = -sin(yaw) * (self.collisionbox[4] + 0.5)
	local dir_z = cos(yaw) * (self.collisionbox[4] + 0.5)
	local pos = self.object:get_pos()
	local ypos = pos.y + self.collisionbox[2] -- just above floor

	if minetest.line_of_sight(
		{x = pos.x + dir_x, y = ypos, z = pos.z + dir_z},
		{x = pos.x + dir_x, y = ypos - self.fear_height, z = pos.z + dir_z}
	, 1) then

		return true
	end

	return false
end


-- get node but use fallback for nil or unknown
local function node_ok(pos, fallback)
	fallback = fallback or "default:dirt"
	local node = minetest.get_node_or_nil(pos)
	if not node then
		return minetest.registered_nodes[fallback]
	end
	if minetest.registered_nodes[node.name] then
		return node
	end
	return minetest.registered_nodes[fallback]
end


-- environmental damage (water, lava, fire, light)
local do_env_damage = function(self)
	if mob_is_dead(self) then
		return
	end

	-- feed/tame text timer (so mob 'full' messages dont spam chat)
	if self.htimer > 0 then
		self.htimer = self.htimer - 1
	end

	-- reset nametag after showing health stats
	if self.htimer < 1 and self.nametag2 then

		self.nametag = self.nametag2
		self.nametag2 = nil

		update_tag(self)
	end

	local pos = self.object:get_pos()

	self.time_of_day = minetest.get_timeofday()

	-- remove mob if beyond map limits
	if not within_limits(pos, 0) then
		self.object:remove()
		return
	end

	-- daylight above ground
	if self.light_damage ~= 0
	and pos.y > 0
	and self.time_of_day > 0.2
	and self.time_of_day < 0.8
	and (minetest.get_node_light(pos) or 0) > 12 then

		self.health = self.health - self.light_damage

		effect(pos, 5, "tnt_smoke.png")
	end

	-- what is mob standing in?
	pos.y = pos.y + self.collisionbox[2] + 0.1 -- foot level
	self.standing_in = node_ok(pos, "air").name
	--print ("standing in " .. self.standing_in)

	-- don't fall when on ignore, just stand still
	if self.standing_in == "ignore" then
		self.object:set_velocity({x = 0, y = 0, z = 0})
		--print ("--- stopping on ignore")
	end

	if self.water_damage ~= 0
	or self.lava_damage ~= 0 then

		local nodef = minetest.registered_nodes[self.standing_in]

		pos.y = pos.y + 1

		-- water
		if self.water_damage ~= 0
		and nodef.groups.water then

			self.health = self.health - self.water_damage

			effect(pos, 5, "bubble.png", nil, nil, 1, nil)

		-- lava or fire
		elseif self.lava_damage ~= 0
		and (nodef.groups.lava
		or self.standing_in == "fire:basic_flame"
		or self.standing_in == "fire:permanent_flame") then

			self.health = self.health - self.lava_damage

			effect(pos, 5, "fire_basic_flame.png", nil, nil, 1, nil)

		-- damage_per_second node check
--		elseif minetest.registered_nodes[self.standing_in].damage_per_second ~= 0 then

--			local dps = minetest.registered_nodes[self.standing_in].damage_per_second

--			self.health = self.health - dps

--			effect(pos, 5, "tnt_smoke.png")
		end
	end

	check_for_death(self)
end


-- jump if facing a solid node (not fences or gates)
local do_jump = function(self)
	if mob_is_dead(self) then
		return
	end

	if not self.jump
	or self.jump_height == 0
	or self.fly
	or self.child then
		return false
	end

	-- something stopping us while moving?
	if self.state ~= "stand"
	and get_velocity(self) > 0.5
	and self.object:get_velocity().y ~= 0 then
		return false
	end

	local pos = self.object:get_pos()
	local yaw = self.object:get_yaw()

	local nod
	-- what is mob standing on?
	pos.y = pos.y + self.collisionbox[2] - 0.2

	nod = node_ok(pos)

--print ("standing on:", nod.name, pos.y)

	if minetest.registered_nodes[nod.name].walkable == false then
		return false
	end

	-- where is front
	local dir_x = -sin(yaw) * (self.collisionbox[4] + 0.5)
	local dir_z = cos(yaw) * (self.collisionbox[4] + 0.5)

	-- what is in front of mob?
	nod = node_ok({
		x = pos.x + dir_x,
		y = pos.y + 0.5,
		z = pos.z + dir_z
	})

	-- thin blocks that do not need to be jumped
	if nod.name == "default:snow" then
		return false
	end

--print ("in front:", nod.name, pos.y + 0.5)

	if (minetest.registered_items[nod.name].walkable
	and not nod.name:find("fence")
	and not nod.name:find("gate"))
	or self.walk_chance == 0 then

		local v = self.object:get_velocity()

		v.y = self.jump_height -- + 1

		set_animation(self, "jump") -- only when defined

		self.object:set_velocity(v)

		mob_sound(self, self.sounds.jump)

		return true
	end

	return false
end


-- blast damage to entities nearby (modified from TNT mod)
local function entity_physics(pos, radius)

	radius = radius * 2

	local objs = minetest.get_objects_inside_radius(pos, radius)
	local obj_pos, dist

	for n = 1, #objs do

		obj_pos = objs[n]:get_pos()

		dist = max(1, get_distance(pos, obj_pos))

		local damage = floor((4 / dist) * radius)

		-- punches work on entities AND players
		objs[n]:punch(objs[n], 1.0,
			{full_punch_interval = 1.0, damage_groups = {fleshy = damage}}, pos)
	end
end


-- should mob follow what I'm holding ?
local function follow_holding(self, clicker)

	if mobs.invis[clicker:get_player_name()] then
		return false
	end

	local item = clicker:get_wielded_item()
	local t = type(self.follow)

	-- single item
	if t == "string"
	and item:get_name() == self.follow then
		return true

	-- multiple items
	elseif t == "table" then

		for no = 1, #self.follow do

			if self.follow[no] == item:get_name() then
				return true
			end
		end
	end

	return false
end


-- find two animals of same type and breed if nearby and horny
local function breed(self)

	-- child takes 240 seconds before growing into adult
	if self.child == true then

		self.hornytimer = self.hornytimer + 1

		if self.hornytimer > 240 then

			self.child = false
			self.hornytimer = 0

			self.object:set_properties({
				textures = self.base_texture,
				mesh = self.base_mesh,
				visual_size = self.base_size,
				collisionbox = self.base_colbox,
			})

			-- jump when fully grown so not to fall into ground
			self.object:set_velocity({
				x = 0,
				y = self.jump_height,
				z = 0
			})
		end

		return
	end

	-- horny animal can mate for 40 seconds,
	-- afterwards horny animal cannot mate again for 200 seconds
	if self.horny == true
	and self.hornytimer < 240 then

		self.hornytimer = self.hornytimer + 1

		if self.hornytimer >= 240 then
			self.hornytimer = 0
			self.horny = false
		end
	end

	-- find another same animal who is also horny and mate if close enough
	if self.horny == true
	and self.hornytimer <= 40 then

		local pos = self.object:get_pos()

		effect({x = pos.x, y = pos.y + 1, z = pos.z}, 8, "heart.png", 3, 4, 1, 0.1)

		local objs = minetest.get_objects_inside_radius(pos, 3)
		local num = 0
		local ent

		for n = 1, #objs do

			ent = objs[n]:get_luaentity()

			-- check for same animal with different colour
			local canmate = false

			if ent then

				if ent.name == self.name then
					canmate = true
				else
					local entname = string.split(ent.name,":")
					local selfname = string.split(self.name,":")

					if entname[1] == selfname[1] then
						entname = string.split(entname[2],"_")
						selfname = string.split(selfname[2],"_")

						if entname[1] == selfname[1] then
							canmate = true
						end
					end
				end
			end

			if ent
			and canmate == true
			and ent.horny == true
			and ent.hornytimer <= 40 then
				num = num + 1
			end

			-- found your mate? then have a baby
			if num > 1 then

				self.hornytimer = 41
				ent.hornytimer = 41

				-- spawn baby
				minetest.after(5, function()

					local mob = minetest.add_entity(pos, self.name)
					local ent2 = mob:get_luaentity()
					local textures = self.base_texture

					if self.child_texture then
						textures = self.child_texture[1]
					end

					mob:set_properties({
						textures = textures,
						visual_size = {
							x = self.base_size.x * .5,
							y = self.base_size.y * .5,
						},
						collisionbox = {
							self.base_colbox[1] * .5,
							self.base_colbox[2] * .5,
							self.base_colbox[3] * .5,
							self.base_colbox[4] * .5,
							self.base_colbox[5] * .5,
							self.base_colbox[6] * .5,
						},
					})
					ent2.child = true
					ent2.tamed = true
					ent2.owner = self.owner
				end)

				break
			end
		end
	end
end


-- find and replace what mob is looking for (grass, wheat etc.)
local function replace(self, pos)
	if mob_is_dead(self) then
		return
	end

	if not self.replace_rate
	or not self.replace_what
	or self.child == true
	or self.object:get_velocity().y ~= 0
	or random(1, self.replace_rate) > 1 then
		return
	end

	local what, with, y_offset

	if type(self.replace_what[1]) == "table" then

		local num = random(#self.replace_what)

		what = self.replace_what[num][1] or ""
		with = self.replace_what[num][2] or ""
		y_offset = self.replace_what[num][3] or 0
	else
		what = self.replace_what
		with = self.replace_with or ""
		y_offset = self.replace_offset or 0
	end

	pos.y = pos.y + y_offset

	if #minetest.find_nodes_in_area(pos, pos, what) > 0 then

-- print ("replace node = ".. minetest.get_node(pos).name, pos.y)

		minetest.set_node(pos, {name = with})

		-- when cow/sheep eats grass, replace wool and milk
		if self.gotten == true then
			self.gotten = false
			self.object:set_properties(self)
		end
	end
end


-- check if daytime and also if mob is docile during daylight hours
local function day_docile(self)

	if self.docile_by_day == false then

		return false

	elseif self.docile_by_day == true
	and self.time_of_day > 0.2
	and self.time_of_day < 0.8 then

		return true
	end
end


-- path finding and smart mob routine by rnd
local function smart_mobs(self, s, p, dist, dtime)
	if mob_is_dead(self) then
		return
	end

	local s1 = self.path.lastpos

	-- is it becoming stuck?
	if abs(s1.x - s.x) + abs(s1.z - s.z) < 1.5 then
		self.path.stuck_timer = self.path.stuck_timer + dtime
	else
		self.path.stuck_timer = 0
	end

	self.path.lastpos = {x = s.x, y = s.y, z = s.z}

	-- im stuck, search for path
	if (self.path.stuck_timer > stuck_timeout and not self.path.following)
	or (self.path.stuck_timer > stuck_path_timeout
	and self.path.following) then

		self.path.stuck_timer = 0

		-- lets try find a path, first take care of positions
		-- since pathfinder is very sensitive
		local sheight = self.collisionbox[5] - self.collisionbox[2]

		-- round position to center of node to avoid stuck in walls
		-- also adjust height for player models!
		s.x = floor(s.x + 0.5)
		s.y = floor(s.y + 0.5) - sheight
		s.z = floor(s.z + 0.5)

		local ssight, sground = minetest.line_of_sight(s, {
			x = s.x, y = s.y - 4, z = s.z}, 1)

		-- determine node above ground
		if not ssight then
			s.y = sground.y + 1
		end

		local p1 = self.attack:get_pos()

		p1.x = floor(p1.x + 0.5)
		p1.y = floor(p1.y + 0.5)
		p1.z = floor(p1.z + 0.5)

		self.path.way = minetest.find_path(s, p1, 16, 2, 6, "Dijkstra")

		-- attempt to unstick mob that is "daydreaming"
		self.object:set_pos({
			x = s.x + 0.1 * (random() * 2 - 1),
			y = s.y + 1,
			z = s.z + 0.1 * (random() * 2 - 1)
		})

		self.state = ""
		do_attack(self, self.attack)

		-- no path found, try something else
		if not self.path.way then

			self.path.following = false

			 -- lets make way by digging/building if not accessible
			if self.pathfinding == 2 then

				 -- add block and remove one block above so
				 -- there is room to jump if needed
				if s.y < p1.y then

					if not minetest.is_protected(s, "") then
						minetest.set_node(s, {name = "default:dirt"})
					end

					local sheight = math.ceil(self.collisionbox[5]) + 1

					-- assume mob is 2 blocks high so it digs above its head
					s.y = s.y + sheight

					if not minetest.is_protected(s, "") then

						local node1 = minetest.get_node(s).name

						if node1 ~= "air"
						and node1 ~= "ignore" then
							minetest.set_node(s, {name = "air"})
							minetest.add_item(s, ItemStack(node1))
						end
					end

					s.y = s.y - sheight
					self.object:set_pos({x = s.x, y = s.y + 2, z = s.z})

				else -- dig 2 blocks to make door toward player direction

					local yaw1 = self.object:get_yaw() + pi / 2
					local p1 = {
						x = s.x + cos(yaw1),
						y = s.y,
						z = s.z + sin(yaw1)
					}

					if not minetest.is_protected(p1, "") then

						local node1 = minetest.get_node(p1).name

						if node1 ~= "air"
						and node1 ~= "ignore" then
							minetest.add_item(p1, ItemStack(node1))
							minetest.set_node(p1, {name = "air"})
						end

						p1.y = p1.y + 1
						node1 = minetest.get_node(p1).name

						if node1 ~= "air"
						and node1 ~= "ignore" then
							minetest.add_item(p1, ItemStack(node1))
							minetest.set_node(p1, {name = "air"})
						end

					end
				end
			end

			-- will try again in 2 second
			self.path.stuck_timer = stuck_timeout - 2

			-- frustration! cant find the damn path :(
			mob_sound(self, self.sounds.random)
		else
			-- yay i found path
			mob_sound(self, self.sounds.attack)

			set_velocity(self, self.walk_velocity)

			-- follow path now that it has it
			self.path.following = true
		end
	end
end


-- specific attacks
local specific_attack = function(list, what)

	-- no specific attack
	if list == nil then
		return false
	end

	-- is found entity on list to attack?
	for no = 1, #list do

		if list[no] == what then
			return true
		end
	end

	return false
end

local is_target = function(self, name, type)
	if specific_attack(self.specific_attack, name) then
		return true
	end

	if factions:is_hostile(type, self.type) then
		return true
	end

	return false
end

-- mob find someone to attack
local mob_attack = function(self)
	if mob_is_dead(self) then
		return
	end

	if self.state == "attack" or day_docile(self) then
		return
	end

	local s = self.object:get_pos()
	local p, sp, dist
	local player, obj, min_player
	local type, name = "", ""
	local min_dist = self.view_range + 1
	local objs = minetest.get_objects_inside_radius(s, self.view_range)

	for n = 1, #objs do

		if objs[n]:is_player() then
			player = objs[n]
			local player_name = player:get_player_name()
			if mobs.invis[ player_name ] then
				type = ""
			else
				type = races.get_faction(player_name)
				name = "player"
			end
		else
			obj = objs[n]:get_luaentity()

			if obj then
				player = obj.object
				type = obj.type
				name = obj.name or ""
			end
		end

		if is_target(self, name, type) then
			s = self.object:get_pos()
			p = player:get_pos()
			sp = s

			-- aim higher to make looking up hills more realistic
			p.y = p.y + 1
			sp.y = sp.y + 1

			dist = get_distance(p, s)

			if dist < self.view_range then
			-- field of view check goes here

				-- choose closest player to attack
				if line_of_sight(self, sp, p) == true
				and dist < min_dist then
					min_dist = dist
					min_player = player
				end
			end
		end
	end

	-- attack player
	if min_player then
		do_attack(self, min_player)
	end
end


-- follow player if owner or holding item, if fish outta water then flop
local follow_flop = function(self)
	if mob_is_dead(self) then
		return
	end

	-- find player to follow
	if (self.follow ~= ""
	or self.order == "follow")
	and not self.following
	and self.state ~= "attack"
	and self.state ~= "runaway" then

		local s = self.object:get_pos()
		local players = minetest.get_connected_players()

		for n = 1, #players do

			if get_distance(players[n]:get_pos(), s) < self.view_range
			and not mobs.invis[ players[n]:get_player_name() ] then

				self.following = players[n]

				break
			end
		end
	end

	if self.type == "npc"
	and self.order == "follow"
	and self.state ~= "attack"
	and self.owner ~= "" then

		-- npc stop following player if not owner
		if self.following
		and self.owner
		and self.owner ~= self.following:get_player_name() then
			self.following = nil
		end
	else
		-- stop following player if not holding specific item
		if self.following
		and self.following:is_player()
		and follow_holding(self, self.following) == false then
			self.following = nil
		end

	end

	-- follow that thing
	if self.following then

		local s = self.object:get_pos()
		local p

		if self.following:is_player() then

			p = self.following:get_pos()

		elseif self.following.object then

			p = self.following.object:get_pos()
		end

		if p then

			local dist = get_distance(p, s)

			-- dont follow if out of range
			if dist > self.view_range then
				self.following = nil
			else
				local vec = {
					x = p.x - s.x,
					z = p.z - s.z
				}

				local yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

				if p.x > s.x then yaw = yaw + pi end

				self.object:set_yaw(yaw)

				-- anyone but standing npc's can move along
				if dist > self.reach
				and self.order ~= "stand" then

					set_velocity(self, self.walk_velocity)

					if self.walk_chance ~= 0 then
						set_animation(self, "walk")
					end
				else
					set_velocity(self, 0)
					set_animation(self, "stand")
				end

				return
			end
		end
	end

	-- swimmers flop when out of their element, and swim again when back in
	if self.fly then
		local s = self.object:get_pos()
		if not flight_check(self, s) then

			self.state = "flop"
			self.object:set_velocity({x = 0, y = -5, z = 0})

			set_animation(self, "stand")

			return
		elseif self.state == "flop" then
			self.state = "stand"
		end
	end
end


-- dogshoot attack switch and counter function
local dogswitch = function(self, dtime)

	-- switch mode not activated
	if not self.dogshoot_switch
	or not dtime then
		return 0
	end

	self.dogshoot_count = self.dogshoot_count + dtime

	if (self.dogshoot_switch == 1
	and self.dogshoot_count > self.dogshoot_count_max)
	or (self.dogshoot_switch == 2
	and self.dogshoot_count > self.dogshoot_count2_max) then

		self.dogshoot_count = 0

		if self.dogshoot_switch == 1 then
			self.dogshoot_switch = 2
		else
			self.dogshoot_switch = 1
		end
	end

	return self.dogshoot_switch
end


-- TODO: move this into `Projectile` class or some physics helper.
local math_min, math_max, math_sqrt, math_tan, math_atan, math_quadratic_equation_roots, v
    = math.min, math.max, math.sqrt, math.tan, math.atan, math.quadratic_equation_roots, vector.new

--- @param p1 vector shooting mob position
--- @param p2 vector position of the mob|player being attacked
--- @param v0 number initial velocity/speed of projectile
function calculate_shot_direction(p1, p2, v0)
	local g = 9.8 -- TODO: get from mt-config (use GRAVITY in projectile mod)

	local delta = p2 - p1
	local d     = math_sqrt(delta.x^2 + delta.z^2) -- Horizontal distance
	local dh    = delta.y                          -- Height difference

	-- Coefficients for the quadratic equation tan(theta)
	local a = -g * d^2 / (2 * v0^2)
	local b = d
	local c = a - dh

	-- Find tan(theta) for the shooting angles
	local tan_angle1, tan_angle2 = math_quadratic_equation_roots(a, b, c)
	if not tan_angle1 then
		minetest.log('warning', 'Impossible to shoot: no real roots of quadratic equation.')
		return nil
	end
	-- We choose a "flatter" trajectory
	local tan_angle = math_min(tan_angle1, tan_angle2)

	return v(delta.x / d, tan_angle, delta.z / d):normalize()
end

-- execute current state (stand, walk, run, attacks)
local do_states = function(self, dtime)
	if mob_is_dead(self) then
		return
	end

	local yaw

	if self.state == "stand" then

		if random(1, 4) == 1 then

			local lp = nil
			local s = self.object:get_pos()
			local objs = minetest.get_objects_inside_radius(s, 3)

			for n = 1, #objs do

				if objs[n]:is_player() then
					lp = objs[n]:get_pos()
					break
				end
			end

			-- look at any players nearby, otherwise turn randomly
			if lp then

				local vec = {
					x = lp.x - s.x,
					z = lp.z - s.z
				}

				yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

				if lp.x > s.x then yaw = yaw + pi end
			else
				yaw = (random(0, 360) - 180) / 180 * pi
			end

			self.object:set_yaw(yaw)
		end

		set_velocity(self, 0)
		set_animation(self, "stand")

		-- npc's ordered to stand stay standing
		if self.type ~= "npc"
		or self.order ~= "stand" then

			if self.walk_chance ~= 0
			and random(1, 100) <= self.walk_chance
			and is_at_cliff(self) == false then

				set_velocity(self, self.walk_velocity)
				self.state = "walk"
				set_animation(self, "walk")

				-- fly up/down randombly for flying mobs
				if self.fly and random(1, 100) <= self.walk_chance then

					local v = self.object:get_velocity()
					local ud = random(-1, 2) / 9

					self.object:set_velocity({x = v.x, y = ud, z = v.z})
				end
			end
		end

	elseif self.state == "walk" then

		local s = self.object:get_pos()
		local lp = nil

		-- is there something I need to avoid?
		if self.water_damage > 0
		and self.lava_damage > 0 then

			lp = minetest.find_node_near(s, 1, {"group:water", "group:lava"})

		elseif self.water_damage > 0 then

			lp = minetest.find_node_near(s, 1, {"group:water"})

		elseif self.lava_damage > 0 then

			lp = minetest.find_node_near(s, 1, {"group:lava"})
		end

		if lp then

			-- if mob in water or lava then look for land
			if (self.lava_damage
				and minetest.registered_nodes[self.standing_in].groups.lava)
			or (self.water_damage
				and minetest.registered_nodes[self.standing_in].groups.water) then

				lp = minetest.find_node_near(s, 5, {"group:soil", "group:stone",
					"group:sand", "default:ice", "default:snowblock"})

				-- did we find land?
				if lp then

					local vec = {
						x = lp.x - s.x,
						z = lp.z - s.z
					}

					yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

					if lp.x > s.x then yaw = yaw + pi end

						-- look towards land and jump/move in that direction
						self.object:set_yaw(yaw)
						do_jump(self)
						set_velocity(self, self.walk_velocity)
				else
					yaw = (random(0, 360) - 180) / 180 * pi
				end

			else

				local vec = {
					x = lp.x - s.x,
					z = lp.z - s.z
				}

				yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

				if lp.x > s.x then yaw = yaw + pi end
			end

			self.object:set_yaw(yaw)

		-- otherwise randomly turn
		elseif random(1, 100) <= 30 then

			yaw = random() * 2 * pi

			self.object:set_yaw(yaw)
		end

		-- stand for great fall in front
		local temp_is_cliff = is_at_cliff(self)

		if temp_is_cliff
		or random(1, 100) <= 30 then

			set_velocity(self, 0)
			self.state = "stand"
			set_animation(self, "stand")
		else
			set_velocity(self, self.walk_velocity)

			if flight_check(self)
			and self.animation
			and self.animation.fly_start
			and self.animation.fly_end then
				set_animation(self, "fly")
			else
				set_animation(self, "walk")
			end
		end

	-- runaway when punched
	elseif self.state == "runaway" then

		self.runaway_timer = self.runaway_timer + 1

		-- stop after 5 seconds or when at cliff
		if self.runaway_timer > 5
		or is_at_cliff(self) then
			self.runaway_timer = 0
			set_velocity(self, 0)
			self.state = "stand"
			set_animation(self, "stand")
		else
			set_velocity(self, self.run_velocity)
			set_animation(self, "walk")
		end

	-- attack routines (explode, dogfight, shoot, dogshoot)
	elseif self.state == "attack" then

		-- calculate distance from mob and enemy
		local s = self.object:get_pos()
		local p = self.attack and self.attack:get_pos()
		local dist = get_distance(p, s)

		-- stop attacking if player or out of range
		if dist > self.view_range
		or not self.attack
		or not self.attack:get_pos()
		or self.attack:get_hp() <= 0
		or (self.attack:is_player() and mobs.invis[ self.attack:get_player_name() ]) then

			--print(" ** stop attacking **", dist, self.view_range)
			self.state = "stand"
			set_velocity(self, 0)
			set_animation(self, "stand")
			self.attack = nil
			self.v_start = false
			self.timer = 0
			self.blinktimer = 0

			return
		end

		if self.attack_type == "explode" then

			local vec = {
				x = p.x - s.x,
				z = p.z - s.z
			}

			yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

			if p.x > s.x then yaw = yaw + pi end

			self.object:set_yaw(yaw)

			if dist > self.reach then

				if not self.v_start then

					self.v_start = true
					set_velocity(self, self.run_velocity)
					self.timer = 0
					self.blinktimer = 0
				else
					self.timer = 0
					self.blinktimer = 0

					set_velocity(self, self.run_velocity)
				end

				set_animation(self, "run")
			else
				set_velocity(self, 0)
				set_animation(self, "punch")

				self.timer = self.timer + dtime
				self.blinktimer = (self.blinktimer or 0) + dtime

				if self.blinktimer > 0.2 then

					self.blinktimer = 0

					if self.blinkstatus then
						self.object:settexturemod("")
					else
						self.object:settexturemod("^[brighten")
					end

					self.blinkstatus = not self.blinkstatus
				end

				if self.timer > 3 then

					local pos = self.object:get_pos()
					local radius = self.explosion_radius or 1

					-- dont damage anything if area protected or next to water
					if minetest.find_node_near(pos, 1, {"group:water"})
					or minetest.is_protected(pos, "") then

						mob_sound(self, self.sounds.explode)

						self.object:remove()

						effect(pos, 15, "tnt_smoke.png")

						-- hurt player/mobs caught in blast area
						entity_physics(pos, radius)

						return
					end

					pos.y = pos.y - 1

					mobs:explosion(pos, radius, 1, 1, self.sounds.explode)

					self.object:remove()

					entity_physics(pos, radius)

					return
				end
			end

		elseif self.attack_type == "dogfight"
		or (self.attack_type == "dogshoot" and dogswitch(self, dtime) == 2)
		or (self.attack_type == "dogshoot" and dist <= self.reach and dogswitch(self) == 0) then

			if self.fly
			and dist > self.reach then

				local p1 = s
				local me_y = floor(p1.y)
				local p2 = p
				local p_y = floor(p2.y + 1)
				local v = self.object:get_velocity()

				if flight_check(self, s) then

					if me_y < p_y then

						self.object:set_velocity({
							x = v.x,
							y = 1 * self.walk_velocity,
							z = v.z
						})

					elseif me_y > p_y then

						self.object:set_velocity({
							x = v.x,
							y = -1 * self.walk_velocity,
							z = v.z
						})
					end
				else
					if me_y < p_y then

						self.object:set_velocity({
							x = v.x,
							y = 0.01,
							z = v.z
						})

					elseif me_y > p_y then

						self.object:set_velocity({
							x = v.x,
							y = -0.01,
							z = v.z
						})
					end
				end

			end

			-- rnd: new movement direction
			if self.path.following
			and self.path.way
			and self.attack_type ~= "dogshoot" then

				-- no paths longer than 50
				if #self.path.way > 50
				or dist < self.reach then
					self.path.following = false
					return
				end

				local p1 = self.path.way[1]

				if not p1 then
					self.path.following = false
					return
				end

				if abs(p1.x-s.x) + abs(p1.z - s.z) < 0.6 then
					-- reached waypoint, remove it from queue
					table.remove(self.path.way, 1)
				end

				-- set new temporary target
				p = {x = p1.x, y = p1.y, z = p1.z}
			end

			local vec = {
				x = p.x - s.x,
				z = p.z - s.z
			}

			yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

			if p.x > s.x then yaw = yaw + pi end

			self.object:set_yaw(yaw)

			-- move towards enemy if beyond mob reach
			if dist > self.reach then

				-- path finding by rnd
				if self.pathfinding -- only if mob has pathfinding enabled
				and enable_pathfinding then

					smart_mobs(self, s, p, dist, dtime)
				end

				if is_at_cliff(self) then

					set_velocity(self, 0)
					set_animation(self, "stand")
				else

					if self.path.stuck then
						set_velocity(self, self.walk_velocity)
					else
						set_velocity(self, self.run_velocity)
					end

					set_animation(self, "run")
				end

			else -- rnd: if inside reach range

				self.path.stuck = false
				self.path.stuck_timer = 0
				self.path.following = false -- not stuck anymore

				set_velocity(self, 0)

				if not self.custom_attack then

					if self.timer > 1 then

						self.timer = 0

						if self.double_melee_attack
						and random(1, 2) == 1 then
							set_animation(self, "punch2")
						else
							set_animation(self, "punch")
						end

						local p2 = p
						local s2 = s

						p2.y = p2.y + .5
						s2.y = s2.y + .5

						if line_of_sight(self, p2, s2) == true then

							-- play attack sound
							mob_sound(self, self.sounds.attack)

							-- punch player (or what player is attached to)
							local attached = self.attack:get_attach()
							if attached then
								self.attack = attached
							end
							self.attack:punch(self.object, 1.0, {
								full_punch_interval = 1.0,
								damage_groups = {[self.damage_type] = self.damage}
							}, nil)
						end
					end
				else	-- call custom attack every second
					if self.custom_attack
					and self.timer > 1 then

						self.timer = 0

						self.custom_attack(self, p)
					end
				end
			end

		elseif self.attack_type == "shoot"
		or (self.attack_type == "dogshoot" and dogswitch(self, dtime) == 1)
		or (self.attack_type == "dogshoot" and dist > self.reach and dogswitch(self) == 0) then

			p.y = p.y - .5
			s.y = s.y + .5

			local vec = {
				x = p.x - s.x,
				y = p.y - s.y,
				z = p.z - s.z
			}

			yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

			if p.x > s.x then yaw = yaw + pi end

			self.object:set_yaw(yaw)

			set_velocity(self, 0)

			if self.shoot_interval
			and self.timer > self.shoot_interval
			and random(1, 100) <= 60 then

				self.timer = 0
				set_animation(self, "shoot")

				-- play shoot attack sound
				mob_sound(self, self.sounds.shoot_attack)

				s = v(self.object:get_pos())
				p = v(self.attack:get_pos())
				if self.attack:is_player() then
					p = p + v(0, 1, 0) -- на данный момент игрок находится на блок ниже моба
				end

				-- TODO: move direction calculation into `Projectile` class.
				local projectile = projectiles.get_projectiles()[self.arrow]
				local power      = 0.6 + random(-.1, .1)
				local velocity   = projectile.entity_reg.max_speed * power
				local shoot_dir  = calculate_shot_direction(s, p, velocity)

				local arrow = ItemStack(self.arrow)
				minetest.sound_play(arrow:get_definition()._sound_on_release, { object = self.object })
				archery.projectile_shoot(self.object, arrow, power, shoot_dir)
			end
		end
	end
end


-- falling and fall damage
local falling = function(self, pos)
	if mob_is_dead(self) then
		return
	end

	if self.fly then
		return
	end

	-- floating in water (or falling)
	local v = self.object:get_velocity()

	-- going up then apply gravity
	if v.y > 0.1 then

		self.object:set_acceleration({
			x = 0,
			y = self.fall_speed,
			z = 0
		})
	end

	-- in water then float up
	if minetest.registered_nodes[node_ok(pos).name].groups.liquid then

		if self.floats == 1 then

			self.object:set_acceleration({
				x = 0,
				y = -self.fall_speed / (max(1, v.y) ^ 2),
				z = 0
			})
		end
	else
		-- fall downwards
		self.object:set_acceleration({
			x = 0,
			y = self.fall_speed,
			z = 0
		})

		-- fall damage
		if self.fall_damage == 1
		and self.object:get_velocity().y == 0 then

			local d = (self.old_y or 0) - self.object:get_pos().y

			if d > 5 then

				self.health = self.health - floor(d - 5)

				effect(pos, 5, "tnt_smoke.png", 1, 2, 2, nil)

				if check_for_death(self) then
					return
				end
			end

			self.old_y = self.object:get_pos().y
		end
	end
end


-- deal damage and effects when mob punched
function mobs.mob_punch(self, hitter, tflp, tool_capabilities, dir)
	-- TEMPORARY FIX (remove when refactoring)
	if not hitter then
		return
	end

	-- mob health check
	if self.health <= 0 then
		-- kill mob
		mob_die(self)
		return
	end

	-- error checking when mod profiling is enabled
	if not tool_capabilities then
		print (S("[MOBS] mod profiling enabled, damage not enabled"))
		return
	end

	-- is mob protected?
	if self.protected and hitter:is_player()
	and minetest.is_protected(self.object:get_pos(), hitter:get_player_name()) then
		minetest.chat_send_player(hitter:get_player_name(), "Mob has been protected!")
		return
	end

	-- weapon wear
	local weapon = ItemStack("lord_archery:apple_wood_bow")
	if hitter and hitter:is_player() then
		weapon = hitter:get_wielded_item()
	end
	local punch_interval = 1.4

	-- calculate mob damage
	local damage = 0
	local armor = self.object:get_armor_groups() or {}
	local tmp

	-- quick error check incase it ends up 0 (serialize.h check test)
	if tflp == 0 then
		tflp = 0.2
	end

	for group,_ in pairs( (tool_capabilities.damage_groups or {}) ) do

		tmp = tflp / (tool_capabilities.full_punch_interval or 1.4)

		if tmp < 0 then
			tmp = 0.0
		elseif tmp > 1 then
			tmp = 1.0
		end

		damage = damage + (tool_capabilities.damage_groups[group] or 0)
			* tmp * ((armor[group] or 0) / 100.0)
	end

	-- check for tool immunity or special damage
	for n = 1, #self.immune_to do

		if self.immune_to[n][1] == weapon:get_name() then

			damage = self.immune_to[n][2] or 0
			break
		end
	end

	-- healing
	if damage <= -1 then
		self.health = self.health - floor(damage)
		return
	end

	--	print ("Mob Damage is", damage)

	-- add weapon wear
	if tool_capabilities then
		punch_interval = tool_capabilities.full_punch_interval or 1.4
	end

	if weapon:get_definition()
	and weapon:get_definition().tool_capabilities
	and hitter and hitter:is_player() then
		weapon:add_wear(floor((punch_interval / 75) * 9000))
		hitter:set_wielded_item(weapon)
	end

	-- only play hit sound and show blood effects if damage is 1 or over
	if damage >= 1 then

		-- weapon sounds
		if weapon:get_definition().sounds ~= nil then

			local s = random(0, #weapon:get_definition().sounds)

			minetest.sound_play(weapon:get_definition().sounds[s], {
				object = hitter,
				max_hear_distance = 8
			})
		else
			minetest.sound_play("default_punch", {
				object = hitter,
				max_hear_distance = 5
			})
		end

		-- blood_particles
		if self.blood_amount > 0
		and not disable_blood then

			local pos = self.object:get_pos()

			pos.y = pos.y + (-self.collisionbox[2] + self.collisionbox[5]) * .5

			effect(pos, self.blood_amount, self.blood_texture, nil, nil, 1, nil)
		end

		-- do damage
		self.health = self.health - floor(damage)

		-- exit here if dead
		if check_for_death(self) then
			return
		end

		--[[ add healthy afterglow when hit (can cause hit lag with larger textures)
		core.after(0.1, function()
			self.object:settexturemod("^[colorize:#c9900070")

			core.after(0.3, function()
				self.object:settexturemod("")
			end)
		end) ]]

		-- knock back effect (only on full punch)
		if self.knock_back > 0
		and tflp > punch_interval then

			local v = self.object:get_velocity()
			local r = 1.4 - min(punch_interval, 1.4)
			local kb = r * 5
			local up = 2

			-- if already in air then dont go up anymore when hit
			if v.y > 0
			or self.fly then
				up = 0
			end

			-- direction error check
			dir = dir or {x = 0, y = 0, z = 0}

			self.object:set_velocity({
				x = dir.x * kb,
				y = up,
				z = dir.z * kb
			})

			self.pause_timer = r
		end
	end -- END if damage

	-- if skittish then run away
	if self.runaway == true then

		local lp = hitter:get_pos()
		local s = self.object:get_pos()

		local vec = {
			x = lp.x - s.x,
			y = lp.y - s.y,
			z = lp.z - s.z
		}

		local yaw = atan(vec.z / vec.x) + 3 * pi / 2

		if lp.x > s.x then
			yaw = yaw + pi
		end

		self.object:set_yaw(yaw)
		self.state = "runaway"
		self.runaway_timer = 0
		self.following = nil
	end

	-- attack puncher and call other mobs for help
	if self.passive == false
	and self.state ~= "flop"
	and self.child == false
	and (hitter.is_player == nil or hitter:is_player() == false or (hitter:get_player_name() ~= self.owner
	and not mobs.invis[ hitter:get_player_name() ])) then

		-- attack whoever punched mob / нападать на того, кто ударил моба
		self.state = ""
		do_attack(self, hitter)

		-- alert others to the attack / предупредить других в атаку
		local objs = minetest.get_objects_inside_radius(hitter:get_pos(), self.view_range)
		local obj

		for n = 1, #objs do
			if not objs[n]:is_player() then
				obj = objs[n]:get_luaentity()
				if obj then
					local type = obj.type

					local is_friend = factions:is_friend(type, self.type)

					if is_friend then
						if obj.group_attack == true and obj.state ~= "attack" then
							do_attack(obj, hitter)
						end
					end
				end
			end

		end
	end
end

-- get entity staticdata
local mob_staticdata = function(self)

	-- remove mob when out of range unless tamed
	if remove_far
	and self.remove_ok
	and not self.tamed
	and self.lifetimer < 20000 then

		--print ("REMOVED " .. self.name)

		self.object:remove()

		return ""-- nil
	end

	self.remove_ok = true
	self.attack = nil
	self.following = nil
	self.state = "stand"

	-- used to rotate older mobs
	if self.drawtype
	and self.drawtype == "side" then
		self.rotate = math.rad(90)
	end

	local tmp = {}

	for _,stat in pairs(self) do

		local t = type(stat)

		if  t ~= "function"
		and t ~= "nil"
		and t ~= "userdata" then
			tmp[_] = self[_]
		end
	end

	--print('===== '..self.name..'\n'.. dump(tmp)..'\n=====\n')
	return minetest.serialize(tmp)
end


-- activate mob and reload settings
local mob_activate = function(self, staticdata, def)
	if mob_is_dead(self) then
		return
	end

	-- remove monsters in peaceful mode, or when no data
	if (self.type == "monster" and peaceful_only) then

		self.object:remove()

		return
	end

	-- load entity variables
	local tmp = minetest.deserialize(staticdata)

	if tmp then
		for _,stat in pairs(tmp) do
			self[_] = stat
		end
	end

	-- select random texture, set model and size
	if not self.base_texture then

		-- compatiblity with old simple mobs textures
		if type(def.textures[1]) == "string" then
			def.textures = {def.textures}
		end

		self.base_texture = def.textures[random(1, #def.textures)]
		self.base_mesh = def.mesh
		self.base_size = self.visual_size
		self.base_colbox = self.collisionbox
	end

	-- set texture, model and size
	local textures = self.base_texture
	local mesh = self.base_mesh
	local vis_size = self.base_size
	local colbox = self.base_colbox

	-- specific texture if gotten
	if self.gotten == true
	and def.gotten_texture then
		textures = def.gotten_texture
	end

	-- specific mesh if gotten
	if self.gotten == true
	and def.gotten_mesh then
		mesh = def.gotten_mesh
	end

	-- set child objects to half size
	if self.child == true then

		vis_size = {
			x = self.base_size.x * .5,
			y = self.base_size.y * .5,
		}

		if def.child_texture then
			textures = def.child_texture[1]
		end

		colbox = {
			self.base_colbox[1] * .5,
			self.base_colbox[2] * .5,
			self.base_colbox[3] * .5,
			self.base_colbox[4] * .5,
			self.base_colbox[5] * .5,
			self.base_colbox[6] * .5
		}
	end

	if self.health == 0 then
        self.health = random (self.hp_min, self.hp_max)
        self.health_orig = self.health
	end

	-- rnd: pathfinding init
	self.path = {}
	self.path.way = {} -- path to follow, table of positions
	self.path.lastpos = {x = 0, y = 0, z = 0}
	self.path.stuck = false
	self.path.following = false -- currently following path?
	self.path.stuck_timer = 0 -- if stuck for too long search for path

	-- Armor groups (immortal = 1 for custom damage handling)
	local armor

	if type(self.armor) == "table" then
		armor = table_copy(self.armor)
	else
		armor = {fleshy = self.armor, immortal = 1}
	end

	self.object:set_armor_groups(armor)

	-- mob defaults
	self.old_y = self.object:get_pos().y
	self.old_health = self.health
	self.sounds.distance = self.sounds.distance or 10
	self.textures = textures
	self.mesh = mesh
	self.collisionbox = colbox
	self.visual_size = vis_size
	self.standing_in = ""

	-- set anything changed above
	self.object:set_properties(self)
	self.object:set_yaw((random(0, 360) - 180) / 180 * pi)
	update_tag(self)
end


-- main mob function
local mob_step = function(self, dtime)
	if mob_is_dead(self) then
		return
	end

	local pos = self.object:get_pos()

	-- when lifetimer expires remove mob (except npc and tamed)
	if self.type ~= "npc"
	and not self.tamed
	and self.state ~= "attack"
	and remove_far ~= true
	and self.lifetimer < 20000 then

		self.lifetimer = self.lifetimer - dtime

		if self.lifetimer <= 0 then

			-- only despawn away from player
			local objs = minetest.get_objects_inside_radius(pos, 15)

			for n = 1, #objs do

				if objs[n]:is_player() then

					self.lifetimer = 20

					return
				end
			end

--			minetest.log("action",
--				S("lifetimer expired, removed @1", self.name))

			effect(pos, 15, "tnt_smoke.png", 2, 4, 2, 0)

			self.object:remove()

			return
		end
	end

	falling(self, pos)

	-- knockback timer
	if self.pause_timer > 0 then

		self.pause_timer = self.pause_timer - dtime

		if self.pause_timer < 1 then
			self.pause_timer = 0
		end

		return
	end

	-- run custom function (defined in mob lua file)
	if self.do_custom then

		-- when false skip going any further
		if self.do_custom(self, dtime) == false then
			return
		end
	end

	-- attack timer
	self.timer = self.timer + dtime

	if self.state ~= "attack" then

		if self.timer < 1 then
			return
		end

		self.timer = 0
	end

	-- never go over 100
	if self.timer > 100 then
		self.timer = 1
	end

	-- node replace check (cow eats grass etc.)
	replace(self, pos)

	-- mob plays random sound at times
	if random(1, 100) == 1 then
		mob_sound(self, self.sounds.random)
	end

	-- environmental damage timer (every 1 second)
	self.env_damage_timer = self.env_damage_timer + dtime

	if (self.state == "attack" and self.env_damage_timer > 1)
	or self.state ~= "attack" then

		self.env_damage_timer = 0

		do_env_damage(self)
	end

	mob_attack(self)

	breed(self)

	follow_flop(self)

	do_states(self, dtime)

	do_jump(self)

end


-- default function when mobs are blown up with TNT
local do_tnt = function(obj, damage)

	obj.object:punch(obj.object, 1.0, {
		full_punch_interval = 1.0,
		damage_groups = {fleshy = damage},
	}, nil)

	return false, true, {}
end


mobs.spawning_mobs = {}

local function punch(self, hitter, tflp, tool_capabilities, dir)
	mobs.mob_punch(self, hitter, tflp, tool_capabilities, dir)
end

-- register mob entity
function mobs:register_mob(name, def)

	mobs.spawning_mobs[name] = true

minetest.register_entity(name, {

	stepheight = def.stepheight or 0.6,
	name = name,
	type = def.type,
	attack_type = def.attack_type,
	fly = def.fly,
	fly_in = def.fly_in or "air",
	owner = def.owner or "",
	order = def.order or "",
	on_die = def.on_die,
	do_custom = def.do_custom,
	jump_height = def.jump_height or 6,
	drawtype = def.drawtype, -- DEPRECATED, use rotate instead
	rotate = math.rad(def.rotate or 0), --  0=front, 90=side, 180=back, 270=side2
	lifetimer = def.lifetimer or 180, -- 3 minutes
	hp_min = max(1, (def.hp_min or 5) * difficulty),
	hp_max = max(1, (def.hp_max or 10) * difficulty),
	physical = true,
	collisionbox = def.collisionbox,
	visual = def.visual,
	visual_size = def.visual_size or {x = 1, y = 1},
	mesh = def.mesh,
	makes_footstep_sound = def.makes_footstep_sound or false,
	view_range = def.view_range or 5,
	walk_velocity = def.walk_velocity or 1,
	run_velocity = def.run_velocity or 2,
	damage = max(1, (def.damage or 0) * difficulty),
	damage_type = def.damage_type or 'fleshy',
	light_damage = def.light_damage or 0,
	water_damage = def.water_damage or 0,
	lava_damage = def.lava_damage or 0,
	fall_damage = def.fall_damage or 1,
	fall_speed = def.fall_speed or -10, -- must be lower than -2 (default: -10)
	drops = def.drops or {},
	armor = def.armor or 100,
	on_rightclick = def.on_rightclick,
	arrow = def.arrow,
	shoot_interval = def.shoot_interval,
	sounds = def.sounds or {},
	animation = def.animation,
	follow = def.follow,
	jump = def.jump ~= false,
	walk_chance = def.walk_chance or 50,
	attacks_monsters = def.attacks_monsters or false,
	group_attack = def.group_attack or false,
	passive = def.passive or false,
	recovery_time = def.recovery_time or 0.5,
	knock_back = def.knock_back or 3,
	blood_amount = def.blood_amount or 5,
	blood_texture = def.blood_texture or "mobs_blood.png",
	shoot_offset = def.shoot_offset or 0,
	floats = def.floats or 1, -- floats in water by default
	replace_rate = def.replace_rate,
	replace_what = def.replace_what,
	replace_with = def.replace_with,
	replace_offset = def.replace_offset or 0,
	timer = 0,
	env_damage_timer = 0, -- only used when state = "attack"
	tamed = false,
	pause_timer = 0,
	horny = false,
	hornytimer = 0,
	child = false,
	gotten = false,
	health = 0,
	reach = def.reach or 3,
	htimer = 0,
--	id = (math.random(1, 1000) * math.random(1, 10000)) .. name .. (math.random(1, 1000) ^ 2),
--	id = name .. os.time() .. math.random(10^6),
	id = 0,
	game_name = "mob",
	texture_list = def.textures,
	use_texture_alpha = def.use_texture_alpha or false,
	child_texture = def.child_texture,
	docile_by_day = def.docile_by_day or false,
	time_of_day = 0.5,
	fear_height = def.fear_height or 0,
	runaway = def.runaway,
	runaway_timer = 0,
	pathfinding = def.pathfinding,
	immune_to = def.immune_to or {},
	explosion_radius = def.explosion_radius,
	custom_attack = def.custom_attack,
	double_melee_attack = def.double_melee_attack,
	dogshoot_switch = def.dogshoot_switch,
	dogshoot_count = 0,
	dogshoot_count_max = def.dogshoot_count_max or 5,
	dogshoot_count2_max = def.dogshoot_count2_max or (def.dogshoot_count_max or 5),
	attack_animals = def.attack_animals or false,
	specific_attack = def.specific_attack,

	on_blast = def.on_blast or do_tnt,

	on_step = mob_step,

	on_punch = def.on_punch or punch,

	on_activate = function(self, staticdata)
		return mob_activate(self, staticdata, def)
	end,

	get_staticdata = function(self)
		return mob_staticdata(self)
	end,

})

end -- END mobs:register_mob function


-- count how many mobs of one type are inside an area
local count_mobs = function(pos, type)

	local num_type = 0
	local num_total = 0
	local objs = minetest.get_objects_inside_radius(pos, aoc_range)

	for n = 1, #objs do

		if not objs[n]:is_player() then

			local obj = objs[n]:get_luaentity()

			-- count mob type and add to total also
			if obj and obj.name and obj.name == type then

				num_type = num_type + 1
				num_total = num_total + 1

			-- add to total mobs
			elseif obj and obj.name and obj.health ~= nil then

				num_total = num_total + 1
			end
		end
	end

	return num_type, num_total
end


-- global functions

function mobs:spawn_specific(name, nodes, neighbors, min_light, max_light,
	interval, chance, aoc, min_height, max_height, day_toggle, on_spawn)

	-- chance/spawn number override in minetest.conf for registered mob
	local numbers = minetest.settings:get(name)

	if numbers then
		numbers = numbers:split(",")
		chance = tonumber(numbers[1]) or chance
		aoc = tonumber(numbers[2]) or aoc

		if chance == 0 then
			print(S("[Mobs Redo] @1 has spawning disabled", name))
			return
		end

		print (S("[Mobs Redo] Chance setting for @1 changed to @2", name, chance)
			.. " (total: " .. aoc .. ")")

	end

	minetest.register_abm({

		label = name .. " spawning",
		nodenames = nodes,
		neighbors = neighbors,
		interval = interval,
		chance = chance,
		catch_up = false,

		action = function(pos, node, active_object_count, active_object_count_wider)

			-- is mob actually registered?
			if not mobs.spawning_mobs[name] then
--print ("--- mob doesn't exist", name)
				return
			end

			-- do not spawn if too many of same mob in area
			if active_object_count_wider >= max_per_block
			or count_mobs(pos, name) >= aoc then
--print ("--- too many entities", name, aoc, active_object_count_wider)
				return
			end

			-- if toggle set to nil then ignore day/night check
			if day_toggle ~= nil then

				local tod = (minetest.get_timeofday() or 0) * 24000

				if tod > 4500 and tod < 19500 then
					-- daylight, but mob wants night
					if day_toggle == false then
--print ("--- mob needs night", name)
						return
					end
				else
					-- night time but mob wants day
					if day_toggle == true then
--print ("--- mob needs day", name)
						return
					end
				end
			end

			-- spawn above node
			pos.y = pos.y + 1

			-- only spawn away from player
			local objs = minetest.get_objects_inside_radius(pos, 10)

			for n = 1, #objs do

				if objs[n]:is_player() then
--print ("--- player too close", name)
					return
				end
			end

			-- mobs cannot spawn in protected areas when enabled
			if spawn_protected == 1
			and minetest.is_protected(pos, "") then
--print ("--- inside protected area", name)
				return
			end

			-- are we spawning within height limits?
			if pos.y > max_height
			or pos.y < min_height then
--print ("--- height limits not met", name, pos.y)
				return
			end

			-- are light levels ok?
			local light = minetest.get_node_light(pos)
			if not light
			or light > max_light
			or light < min_light then
--print ("--- light limits not met", name, light)
				return
			end

			-- are we spawning inside solid nodes?
			if minetest.registered_nodes[node_ok(pos).name].walkable == true then
--print ("--- feet in block", name, node_ok(pos).name)
				return
			end

			pos.y = pos.y + 1

			if minetest.registered_nodes[node_ok(pos).name].walkable == true then
--print ("--- head in block", name, node_ok(pos).name)
				return
			end

			-- spawn mob half block higher than ground
			pos.y = pos.y - 0.5

			local mob = minetest.add_entity(pos, name)

			if mob and mob:get_luaentity() then
--				print ("[mobs] Spawned " .. name .. " at "
--				.. minetest.pos_to_string(pos) .. " on "
--				.. node.name .. " near " .. neighbors[1])
				if on_spawn and not on_spawn(mob, pos) then
					return
				end
			else
				print (S("[mobs] @1 failed to spawn at @2",
				name, minetest.pos_to_string(pos)))
			end

		end
	})
end


-- compatibility with older mob registration
function mobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height, day_toggle)

	mobs:spawn_specific(name, nodes, {"air"}, min_light, max_light, 30,
		chance, active_object_count, -31000, max_height, day_toggle)
end


-- MarkBu's spawn function
function mobs:spawn(def)

	local name = def.name
	local nodes = def.nodes or {"group:soil", "group:stone"}
	local neighbors = def.neighbors or {"air"}
	local min_light = def.min_light or 0
	local max_light = def.max_light or 15
	local interval = def.interval or 30
	local chance = def.chance or 5000
	local active_object_count = def.active_object_count or 1
	local min_height = def.min_height or -31000
	local max_height = def.max_height or 31000
	local day_toggle = def.day_toggle
	local on_spawn = def.on_spawn

	mobs:spawn_specific(name, nodes, neighbors, min_light, max_light, interval,
		chance, active_object_count, min_height, max_height, day_toggle, on_spawn)
end


-- set content id's
local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_obsidian = minetest.get_content_id("default:obsidian")
local c_chest = minetest.get_content_id("default:chest_locked")

-- explosion (cannot break protected or unbreakable nodes)
function mobs:explosion(pos, radius, fire, smoke, sound)

	radius = radius or 0
	fire = fire or 0
	smoke = smoke or 0

	-- if area protected or near map limits then no blast damage
	if minetest.is_protected(pos, "")
	or not within_limits(pos, radius) then
		return
	end

	-- explosion sound
	if sound
	and sound ~= "" then

		minetest.sound_play(sound, {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 16
		})
	end

	pos = vector.round(pos) -- voxelmanip doesn't work properly unless pos is rounded ?!?!

	local vm = VoxelManip()
	local minp, maxp = vm:read_from_map(vector.subtract(pos, radius), vector.add(pos, radius))
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()
	local p = {}
	local pr = PseudoRandom(os.time())

	for z = -radius, radius do
	for y = -radius, radius do
	local vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)
	for x = -radius, radius do

		p.x = pos.x + x
		p.y = pos.y + y
		p.z = pos.z + z

		if (x * x) + (y * y) + (z * z) <= (radius * radius) + pr:next(-radius, radius)
		and data[vi] ~= c_air
		and data[vi] ~= c_ignore
		and data[vi] ~= c_obsidian
		and data[vi] ~= c_chest then

			local n = node_ok(p).name
			local on_blast = minetest.registered_nodes[n].on_blast

			if on_blast then

				return on_blast(p)

			else

				-- after effects
				if fire > 0
				and (minetest.registered_nodes[n].groups.flammable
				or random(1, 100) <= 30) then

					minetest.set_node(p, {name = "fire:basic_flame"})
				else
					minetest.set_node(p, {name = "air"})

					if smoke > 0 then
						effect(p, 2, "tnt_smoke.png")
					end
				end
			end
		end

		vi = vi + 1

	end
	end
	end
end




-- register spawn eggs
function mobs:register_egg(mob, desc, background, addegg, no_creative)

	local grp = {}

	-- do NOT add this egg to creative inventory (e.g. dungeon master)
	if minetest.is_creative_enabled() and no_creative == true then
		grp = {not_in_creative_inventory = 1}
	end

	local invimg = background

	if addegg == 1 then
		invimg = "mobs_chicken_egg.png^(" .. invimg ..
			"^[mask:mobs_chicken_egg_overlay.png)"
	end

	-- register new spawn egg containing mob information
	minetest.register_craftitem(mob .. "_set", {

		description = desc .. " (Tamed)",
		inventory_image = invimg,
		groups = {not_in_creative_inventory = 1},
		stack_max = 1,

		on_place = function(itemstack, placer, pointed_thing)

			local pos = pointed_thing.above

			-- am I clicking on something with existing on_rightclick function?
			local under = minetest.get_node(pointed_thing.under)
			local def = minetest.registered_nodes[under.name]
			if def and def.on_rightclick then
				return def.on_rightclick(pointed_thing.under, under, placer, itemstack)
			end

			if pos and within_limits(pos, 0) then

				pos.y            = pos.y + 1

				local data       = itemstack:get_metadata()
				local entity     = minetest.add_entity(pos, mob, data)
				local lua_entity = entity:get_luaentity()

				if not lua_entity then
					entity:remove()
					return
				end

				if lua_entity.type ~= "monster" then
					-- set owner and tame if not monster
					lua_entity.owner = placer:get_player_name()
					lua_entity.tamed = true
				end

				-- since mob is unique we remove egg once spawned
				itemstack:take_item()
			end

			return itemstack
		end,
	})


	-- register old stackable mob egg
	minetest.register_craftitem(mob, {

		description = desc,
		inventory_image = invimg,
		groups = grp,

		on_place = function(itemstack, placer, pointed_thing)

			local pos = pointed_thing.above

			-- am I clicking on something with existing on_rightclick function?
			local under = minetest.get_node(pointed_thing.under)
			local def = minetest.registered_nodes[under.name]
			if def and def.on_rightclick then
				return def.on_rightclick(pointed_thing.under, under, placer, itemstack)
			end

			if pos
			and within_limits(pos, 0)
			and not minetest.is_protected(pos, placer:get_player_name()) then

				pos.y            = pos.y + 1

				local entity     = minetest.add_entity(pos, mob)
				local lua_entity = entity:get_luaentity()

				if not lua_entity then
					entity:remove()
					return
				end

				if lua_entity.type ~= "monster" then
					-- set owner and tame if not monster
					lua_entity.owner = placer:get_player_name()
					lua_entity.tamed = true
				end

				-- if not in creative then take item
				if not minetest.is_creative_enabled(placer) then
					itemstack:take_item()
				end
			end

			return itemstack
		end,
	})

end


-- capture critter (thanks to blert2112 for idea)
function mobs:capture_mob(self, clicker, chance_hand, chance_net, chance_lasso, force_take, replacewith)

	if self.child
	or not clicker:is_player()
	or not clicker:get_inventory() then
		return false
	end

	-- get name of clicked mob
	local mobname = self.name

	-- if not nil change what will be added to inventory
	if replacewith then
		mobname = replacewith
	end

	local name = clicker:get_player_name()

	-- is mob tamed?
	if self.tamed == false
	and force_take == false then
		return false
	end

	-- cannot pick up if not owner
	if self.owner ~= name
	and force_take == false then
		return false
	end

	if clicker:get_inventory():room_for_item("main", mobname) then

		-- was mob clicked with hand, net, or lasso?
		local tool = clicker:get_wielded_item()
		local chance = 0

		if tool:is_empty() then
			chance = chance_hand

		elseif tool:get_name() == "mobs:net" then

			chance = chance_net

			tool:add_wear(4000) -- 17 uses

			clicker:set_wielded_item(tool)

		elseif tool:get_name() == "mobs:magic_lasso" then

			chance = chance_lasso

			tool:add_wear(650) -- 100 uses

			clicker:set_wielded_item(tool)
		end

		-- calculate chance.. add to inventory if successful?
		if chance > 0 and random(1, 100) <= chance then

			-- default mob egg
			local new_stack = ItemStack(mobname)

			-- add special mob egg with all mob information
			-- unless 'replacewith' contains new item to use
			if not replacewith then

				new_stack = ItemStack(mobname .. "_set")

				local tmp = {}

				for _,stat in pairs(self) do
					local t = type(stat)
					if  t ~= "function"
					and t ~= "nil"
					and t ~= "userdata" then
						tmp[_] = self[_]
					end
				end

				local data_str = minetest.serialize(tmp)

				new_stack:set_metadata(data_str)
			end

			local inv = clicker:get_inventory()

			if inv:room_for_item("main", new_stack) then
				inv:add_item("main", new_stack)
			else
				minetest.add_item(clicker:get_pos(), new_stack)
			end

			self.object:remove()

			return true
		else
			minetest.chat_send_player(name, S("Missed!"))
		end
	end

	return false
end


-- protect tamed mob with rune item
function mobs:protect(self, clicker)

	local name = clicker:get_player_name()

	if self.tamed == false then
		minetest.chat_send_player(name, S("Not tamed!"))
		return false
	end

	if self.protected == true then
		minetest.chat_send_player(name, S("Already protected!"))
		return false
	end

	local tool = clicker:get_wielded_item()

	if tool:get_name() == "mobs:protector" then

		tool:take_item() -- take 1 protection rune
		clicker:set_wielded_item(tool)

		self.protected = true
		minetest.chat_send_player(name, S("Protected!"))

		return true
	end

	return false
end


local mob_obj = {}
local mob_sta = {}

-- feeding, taming and breeding (thanks blert2112)
function mobs:feed_tame(self, clicker, feed_count, breed, tame)

	local beast_ring = "lottother:beast_ring"
	local item = clicker:get_wielded_item()
	local itemname = item:get_name() or ""
	local ring_used = itemname == beast_ring

	if not self.follow and not ring_used then
		return false
	end

	-- can eat/tame with item in hand
	if follow_holding(self, clicker) then
		-- if not in creative then take item
		if not minetest.is_creative_enabled(clicker) and not ring_used then

			item:take_item()

			clicker:set_wielded_item(item)
		end

		-- increase health
		if not ring_used then
			self.health = self.health + 4
		end

		if self.health >= self.hp_max then

			self.health = self.hp_max

			if self.htimer < 1 then

				self.htimer = 5
			end
		end

		self.object:set_hp(self.health)

		update_tag(self)

		-- make children grow quicker
		if self.child == true then

			self.hornytimer = self.hornytimer + 20

			return true
		end

		-- feed and tame
		self.food = (self.food or 0) + 1
		if self.food >= feed_count or ring_used then

			self.food = 0

			if breed and self.hornytimer == 0 and not ring_used then
				self.horny = true
			end

			self.gotten = false

			if tame then

				self.tamed = true

				if not self.owner or self.owner == "" then
					self.owner = clicker:get_player_name()
				end
			end

			-- make sound when fed so many times
			mob_sound(self, self.sounds.random)
		end

		return true
	end

	-- if mob has been tamed you can name it with a nametag
	if item:get_name() == "mobs:nametag"
	and clicker:get_player_name() == self.owner then

		local name = clicker:get_player_name()

		-- store mob and nametag stack in external variables
		mob_obj[name] = self
		mob_sta[name] = item

		local tag = self.nametag or ""

		minetest.show_formspec(name, "mobs_nametag", "size[8,4]"
			.. "field[0.5,1;7.5,0;name;" .. S("Enter name:") .. ";" .. tag .. "]"
			.. "button_exit[2.5,3.5;3,1;mob_rename;" .. S("Rename") .. "]")

	end

	return false

end


-- inspired by blockmen's nametag mod
minetest.register_on_player_receive_fields(function(player, formname, fields)

	-- right-clicked with nametag and name entered?
	if formname == "mobs_nametag"
	and fields.name
	and fields.name ~= "" then

		local name = player:get_player_name()

		if not mob_obj[name]
		or not mob_obj[name].object then
			return
		end

		-- limit name entered to 64 characters long
		if string.len(fields.name) > 64 then
			fields.name = string.sub(fields.name, 1, 64)
		end

		-- update nametag
		mob_obj[name].nametag = fields.name

		update_tag(mob_obj[name])

		-- if not in creative then take item
		if not minetest.is_creative_enabled(name) then

			mob_sta[name]:take_item()

			player:set_wielded_item(mob_sta[name])
		end

		-- reset external variables
		mob_obj[name] = nil
		mob_sta[name] = nil

	end
end)


-- compatibility function for old entities to new modpack entities
function mobs:alias_mob(old_name, new_name)

	-- spawn egg
	minetest.register_alias(old_name, new_name)

	-- entity
	minetest.register_entity(":" .. old_name, {

		physical = false,

		on_step = function(self)

			local pos = self.object:get_pos()

			minetest.add_entity(pos, new_name)

			self.object:remove()
		end
	})
end
