

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

--- @param player   Player
--- @param effect   effects.Effect
--- @param amount   number
--- @param duration number
--- @param after_stop fun()
function Processor.run_effect_for(player, effect, amount, duration, after_stop)
	effect:start(player, amount, duration)
	-- TODO: effect can be reapplied. #1650
	minetest.after(duration, function()
		-- TODO: the `player` could have already left. #1673
		effect:stop(player)
		after_stop(player, effect)
	end)
end


return Processor
