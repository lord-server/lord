minetest.register_chatcommand("dice", {
    params = "",
    description = "print out random number",
    func = function(name, param)
        local num = math.random(1,6)
        return true, name .." dice: " .. num
    end,
})

lord.mod_loaded()