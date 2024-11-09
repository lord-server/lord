
--luacheck: globals minetest.registered_chatcommands.tell

minetest.register_on_mods_loaded(function()

	-- Override /tell chat command to execute callbacks.
	-- Command is added by mesecons command block.
	if minetest.registered_chatcommands.tell then
		local tell = minetest.registered_chatcommands.tell.func
		minetest.registered_chatcommands.tell.func = function(name, param)
			local target, message = param:match("^([^%s]+)%s*(.*)$")
			if target == nil then
				return tell(name, param)
			elseif beerchat.execute_callbacks('before_send_pm', name, message, target) then
				return tell(name, param)
			end
		end
	end

end)
