local FormsPrepend = require('forms.prepend')
local FormsSpec    = require('forms.spec')


forms = {}

local function register_api()
	_G.forms = {
		spec = FormsSpec
	}
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
		FormsPrepend.register()
	end
}
