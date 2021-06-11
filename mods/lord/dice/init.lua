local S = minetest.get_translator("dice")

minetest.register_chatcommand("dice", {
	params = "[MAX_NUM]",
	description = S("prints out random number"),
	func = function(name, param)
		local max_limit = 6
		if (param ~= "") then
			local current_limit = tonumber(param)
			if (current_limit ~= nil) then
				max_limit = current_limit
			end
		end
		local num = math.random(1, max_limit)
		return true, name .. " ".. S("dice") .. ": " .. num
	end,
})

--lord.mod_loaded()
