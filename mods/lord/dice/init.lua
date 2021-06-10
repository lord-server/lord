local S = minetest.get_translator("dice")

minetest.register_chatcommand("dice", {
    max_num = S("<MAX_NUM>"),
    description = S("prints out random number"),
    func = function(name, param_num)
        local t = 6
        if (param_num ~= "") then
            local t1 = tonumber(param_num)
            if (t1 ~= nil) then
                t = t1
            end
        end
        local num = math.random(1, t)
        return true, name .. " ".. S("dice") .. ": " .. num
    end,
})

lord.mod_loaded()
