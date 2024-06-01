
function lord_potion_effects.add_effect(effects, name, duration)
    local now = lord_potion_effects.now()
    table.insert(effects, {name=name, start_time=now, duration=duration})
    return effects
end

function lord_potion_effects.list_effects(effects)
    local names = {}
    for _, effect in ipairs(effects) do
        table.insert(names, effect.name)
    end
    return names
end

function lord_potion_effects.check_expiration(effects, now)
    if now == nil then
        now = os.time(os.date("!*t"))
    end
    local not_expired = {}
    local has_expired = false
    for _, effect in ipairs(effects) do
        if effect.start_time + effect.duration >= now then
            table.insert(not_expired, effect)
        else
            has_expired = true
        end
    end
    if has_expired then
        return not_expired
    end
    return nil
end

function lord_potion_effects.now()
    return os.time(os.date("!*t"))
end
