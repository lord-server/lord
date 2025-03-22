local Character = require('character.Character')
local Storage   = require('character.Storage')


--- @type character.Character[]|table<string,character.Character>
local player_characters = {}

character = {} -- luacheck: ignore unused global variable character

local function register_api()
	_G.character = {
		--- @param player Player
		--- @return character.Character
		of = function(player)
			local name = player:get_player_name()
			if not player_characters[name] then
				player_characters[name] = Character:new(Storage:new(player))
			end

			return player_characters[name]
		end
	}
	-- Cleanup cached character on leave
	minetest.register_on_leaveplayer(function(player, timed_out)
		player_characters[player:get_player_name()] = nil
	end)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
	end,
}
