-- Removes non-serializable data
local function sanitize_table(t)
    -- Detect mixed tables
    local seen_non_str_keys = false
    local seen_str_keys = false

    for key, _ in pairs(t) do
        if type(key) == 'string' then
            seen_str_keys = true
        else
            seen_non_str_keys = true
        end
    end

    if seen_non_str_keys and seen_str_keys then
        for k in pairs(t) do
            t[k] = nil
        end
        t['malformed'] = true
        return
    end

    -- Detect non-serializable values
    for key, value in pairs(t) do
        local value_type = type(value)
        if value_type == 'function' or value_type == 'userdata' then
            t[key] = nil
        elseif value_type == 'table' then
            sanitize_table(value)
        end
    end
end

-- after(0, ...) executes on first globalstep to make sure everything is registered
core.after(0, function()
    local game = {}
    game.aliases = table.copy(core.registered_aliases)
    game.items = table.copy(core.registered_items)
    sanitize_table(game)
    for name, item in pairs(game.items) do
        print(name)
        local recipes = core.get_all_craft_recipes(name)
        if recipes then
            print(name, ' has recipes')
        end
        item.recipes = core.get_all_craft_recipes(name)
    end

    local file = io.open(core.get_worldpath() .. '/game-snapshot.json', 'wb')
    local json, err = core.write_json(game, true)
    print(err)
    file:write(json)
    file:close()
end)
