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

right_mobs_ai:register_mob("simple_ai", {
    attack = simplemob_attack,
    walk = nil,
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
                switch_time = 20,
                attack_period = 1,
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
