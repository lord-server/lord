

--- @class effects.Processor
local Processor = {}

function Processor.init()
	minetest.register_on_joinplayer(function(player, last_login)
		-- Get State (from ObjectState)
	end)
	minetest.register_on_leaveplayer(function(player, last_login)
		-- Clean up in-memory State (also we can additionally save it into ObjectState)
	end)
end


return Processor
