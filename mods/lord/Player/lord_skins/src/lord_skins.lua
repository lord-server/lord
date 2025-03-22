local config = require('lord_skins.config')


--- @class lord_skins the namespace to refers to in @see notations.
lord_skins   = {} -- luacheck: ignore unused global variable lord_skins

local function register_api()
	_G.lord_skins = {
		--- @param race    string one of lord_races.Name.<CONST>, from `lord_races.get_player_races()` scope.
		--- @param gender  string one of `"male"` | `"female"`.
		--- @param skin_no number skin number.
		get_texture_name      = function(race, gender, skin_no)
			assert(lord_races.get_player_races()[race] ~= nil, 'Unknown race for players: ' .. race)

			skin_no = skin_no or 1

			return string.format("%s_%s%d.png", race, gender, skin_no)
		end,

		--- @param preview_type string one of `"both"` | `"front"`.
		--- @param race         string one of lord_races.Name.<CONST>, from `lord_races.get_player_races()` scope.
		--- @param gender       string one of `"male"` | `"female"`.
		--- @param skin_no      number skin number.
		get_preview_name = function(preview_type, race, gender, skin_no)
			if race ~= lord_races.Name.SHADOW then
				return string.format("preview_%s_%s%d_%s.png", race, gender, skin_no, preview_type)
			else
				return nil
			end
		end,

		--- @param race         string one of lord_races.Name.<CONST>, from `lord_races.get_player_races()` scope.
		--- @param gender       string one of `"male"` | `"female"`.
		get_skins_count = function(race, gender)
			return config[race].skins_count[gender]
		end
	}
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
	end,
}
