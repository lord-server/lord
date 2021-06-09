local S = minetest.get_translator("dice")

minetest.register_chatcommand("dice", {
    params = S("<MAX_NUM>"),
    description = S("print out random number"),
    func = function(name, param)
		local t = 6
        if (param ~= "") then
            local t1 = tonumber(param)
            if (t1 ~= nil) then
                t = t1
            end
        end
        local num = math.random(1,t)
        return true, name .. " ".. S("dice") .. ": " .. num
    end,
})

lord.mod_loaded()
