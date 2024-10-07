local DefaultStyle = require('forms.DefaultStyle')
local FormsPrepend = require('forms.prepend')
local FormsSpec    = require('forms.Spec')


forms = {}

local function register_api()
	_G.forms = {
		DefaultStyle = DefaultStyle,
		Spec         = FormsSpec,
	}
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
		FormsPrepend.register()
	end
}
