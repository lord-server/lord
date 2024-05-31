
--- @param player Player
--- @return number
local function get_player_web_id(player)
	-- TODO get from mod_storage
end

--- @param player Player
--- @param web_id number
local function set_player_web_id(player, web_id)
	-- TODO store in mod_storage
end


return {
	register = function()
		minetest.register_on_joinplayer(function(player, last_login)
			if not player:is_player() then return end

			if last_login then -- player not new
				local player_web_id = get_player_web_id(player)
				lord_web_api.players:update(player_web_id, {last_login = last_login})
			else -- player is new
				local player_web_id = lord_web_api.players:create({
					name = "", -- TODO
					race = "", -- TODO
				})
				set_player_web_id(player, player_web_id)
			end
		end)
	end
}
