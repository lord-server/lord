local unpack
    = unpack

--- @class effects.Processor
local Processor = {}

function Processor.init()
	minetest.register_on_joinplayer(function(player, last_login)
		-- Get State (from ObjectState) ??? (or in Character, TODO #1673)
	end)
	minetest.register_on_leaveplayer(function(player, timed_out)
		--if timed_out then
			-- Save State (into ObjectState) ??? (or in Character, TODO #1673)
		--end

		effects.for_player(player):reset()
	end)
	minetest.register_on_dieplayer(function(player, reason)
		effects.for_player(player):reset()
	end)
end

--- @param player   Player
--- @param effect   effects.Effect
--- @param amount   number
--- @param duration number
--- @param after_stop fun(player:Player,effect:effects.Effect) @ /!\ warn: the `player` could have already left.
--- @return job
function Processor.run_effect_for(player, effect, amount, duration, params, after_stop)
	effect:start(player, amount, duration, unpack(params))

	return minetest.after(duration, function()
		effect:stop(player, amount, duration, unpack(params))
		after_stop(player, effect)
	end)
end

--- @param player        Player
--- @param active_effect effects.ForPlayer.Active
function Processor.stop_for(player, active_effect, ...)
	active_effect.effect:stop(
		player, active_effect.amount, active_effect.duration, unpack({ active_effect.reason, ... })
	)
	active_effect.job:cancel()
end


return Processor
