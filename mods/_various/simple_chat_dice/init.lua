local S = minetest.get_translator("dice")

minetest.register_chatcommand("dice", {
    params = S("<MAX_NUM>"),
    description = S("print out random number"),
    func = function(name, param)
        if (param ~= "") then
            t = tonumber(param)
            if (t == nil) then
                t = 6
            end
        else
            t = 6
        end
        local num = math.random(1,t)
        return true, name .. " ".. S("dice") .. ": " .. num
    end,
})

lord.mod_loaded()
