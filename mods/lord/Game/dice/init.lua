
minetest.mod(function(mod)
	local S = mod.translator

	minetest.register_chatcommand("dice", {
		params      = "[MAX_NUM]",
		description = S("prints out random number"),
		func        = function(name, param)
			local max_limit = 6
			if (param ~= "") then
				local current_limit = tonumber(param)
				if (current_limit ~= nil) then
					max_limit = current_limit
				end
			end
			local num = math.random(1, max_limit)
			minetest.chat_send_all(name .. " - " .. S("dice") .. ": " .. num)
			return true
		end,
	})
end)
