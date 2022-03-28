local function aggression(ai_context, target, self)
    print("AGGRESSION!")
end

right_mobs_ai:register_mob("simple_ai", {
    attack = nil,
    walk = nil,
    stay = nil,
    aggression = aggression,
    aggression_period = 2,
    aggression_time = 10,
})

local function simplemob_die(health_context, self)
    right_mobs_api.mob_death(health_context, self)
end

right_mobs_health:register_mob("simple_health", {
    on_die = simplemob_die,
})

right_mobs_api.register_mob("simplemob:simplemob", {
    description = "Simple mob",
    mesh = "lottarmor_character_old.b3d",
    textures = {"simplemob.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    ai = "simple_ai",
    health = "simple_health",
    max_health = 20,
})
