local properties_snippet = require('snippet.properties')
local digging_snippet    = require('snippet.digging')
local damage_snippet     = require('snippet.damage')
local armor_snippet      = require('snippet.armor')
local buffs_snippet      = require('snippet.buffs')


return {
	init = function()
		tt.register_snippet(properties_snippet)
		tt.register_snippet(damage_snippet)
		tt.register_snippet(armor_snippet)
		tt.register_snippet(buffs_snippet)
		tt.register_snippet(digging_snippet)
		-- Прочность: armor_use/wear
	end,
}
