local Segments = require("nametag.Segments")
local NameTag  = require("nametag.NameTag")


nametag = {} -- luacheck: ignore unused global variable nametag

local function register_api()
	_G.nametag = {
		segments = Segments,
		for_player = NameTag.for_player,
	}
end


return {
	init = function()
		NameTag.set_segments(Segments)
		register_api()
	end,
}
