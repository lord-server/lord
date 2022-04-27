

local function simplemob_aggression(ai_context, target, self)
    print("Agression")
end

local function simplemob_attack(ai_context, target, attack_type, self)
    local pos = self.object:get_pos()
    local tpos = target:get_pos()

    local vec = {x = tpos.x - pos.x, y = tpos.y - pos.y, z = tpos.z - pos.z}
    local yaw = -math.atan2(vec.x, vec.z)
    self.object:set_yaw(yaw)

    if attack_type == right_mobs_ai.attacks.dogfight then
        print("Attack, dogfight")
        local damage = {
            full_punch_interval = 1.0,
            damage_groups = self.weapon.dogfight.damage,
        }
        target:punch(self.object, 1.0, damage, nil)
    elseif attack_type == right_mobs_ai.attacks.remote_attack then
        print("Attack, remote")
        local p = {x=pos.x, y=pos.y, z=pos.z}
		p.y = p.y + (self.collisionbox[2]*0.2 + self.collisionbox[5]*0.8)
		local dir = {
			x = vec.x,
			y = vec.y,
			z = vec.z,
		}
		throwing:shoot(self.object, "entity", self.weapon.remote_attack.arrow, p, dir, 0.5)
    end
end

local function near(p1, p2, delta)
    local d = {x=p1.x-p2.x, y=p1.y-p2.y, z=p1.z-p2.z}
    if vector.length(d) > delta then
        return false
    end
    return true
end

local function line_completed(p1, p2, p)
    local d1 = {x=p2.x-p1.x, y=p2.y-p1.y, z=p2.z-p1.z}
    local d2 = {x=p.x-p1.x, y=p.y-p1.y, z=p.z-p1.z}
    return vector.length(d2) >= vector.length(d1)
end

local function simplemob_walk(ai_context, target_position, movement, self)
    local pos = self.object:get_pos()
    pos.y = pos.y - 0.5
    if near(pos, target_position, 2) then
        self.path.way = nil
        self.object:set_velocity({x=0,y=0,z=0})
        return
    end

    if self.path == nil then
        self.path = {}
    end

    local build_path = (self.path.way == nil)
    if self.path.way then
        local l = #self.path.way

        if l == 0 then
            build_path = true
        else
            if not near(target_position, self.path.way[l], 2) then
                build_path = true
            end
            if not near(pos, self.path.way[1], 2) then
                build_path = true
            end
        end
    end

    if build_path then
        local p1 = {x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5), z=math.floor(pos.z+0.5)}
        local p2 = {x=math.floor(target_position.x+0.5), y=math.floor(target_position.y+0.5), z=math.floor(target_position.z+0.5)}
        self.path.way = minetest.find_path(p1, p2, 20, 1, 1, "Dijkstra")
        if self.path.way and #self.path.way >= 2 then
            self.path.last_point = table.remove(self.path.way, 1)
            self.path.next_point = table.remove(self.path.way, 1)
        end
        print("pos = "..dump(pos))
        print(dump(self.path))
    end

    if not self.path.way then
        self.object:set_velocity({x=0,y=0,z=0})
        return
    end

    if line_completed(self.path.last_point, self.path.next_point, pos) then
        self.path.last_point = self.path.next_point
        self.path.next_point = table.remove(self.path.way, 1)

        if self.path.next_point == nil then
            self.path.way = nil
            self.path.last_point = nil
            self.object:set_velocity({x=0,y=0,z=0})
            return
        end

        local yaw = -math.atan2(self.path.next_point.x-self.path.last_point.x, self.path.next_point.z-self.path.last_point.z)
        self.object:set_yaw(yaw)

        local dir = {
            x = self.path.next_point.x-self.path.last_point.x,
            y = self.path.next_point.y-self.path.last_point.y,
            z = self.path.next_point.z-self.path.last_point.z
        }

        local v = vector.length(dir)
        local speed = 1
        if movement == right_mobs_ai.movements.stroll then
            speed = 2
        elseif movement == right_mobs_ai.movements.goto_target then
            speed = 4
        end
        local vel = {x=dir.x/v*speed, y=dir.y/v*speed, z=dir.z/v*speed}
        self.object:set_velocity(vel)
    end
end

right_mobs_ai:register_mob("simple_ai", {
    attack = simplemob_attack,
    walk = simplemob_walk,
    stay = nil,
    aggression = simplemob_aggression,
})

local function simplemob_die(health_context, self)
    right_mobs_api.mob_death(health_context, self)
end

right_mobs_health:register_mob("simple_health", {
    on_die = simplemob_die,
    factors = {fleshy = 10},
})

right_mobs_api.register_mob("simplemob:simplemob", {
    description = "Simple mob",
    mesh = "lottarmor_character_old.b3d",
    textures = {"simplemob.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    ai = "simple_ai",
    health = "simple_health",
    parameters = {
        ai = {
            aggression = {
                switch_time = 0.3,
            },
            attack = {
                switch_time = 3,
                attack_period = 1,
            },
            goto_target = {
                switch_time = 3,
            },
            dogfight_distance = 3,
            available_attacks = {right_mobs_ai.attacks.dogfight, right_mobs_ai.attacks.remote_attack},
        },
        health = {
            factors = {
                fleshy = 20,
            },
        },
    },
    weapon = {
        dogfight = {
            damage = {
                fleshy = 2,
            },
        },
        remote_attack = {
            arrow = "arrows:arrow_steel",
        }
    },
})
