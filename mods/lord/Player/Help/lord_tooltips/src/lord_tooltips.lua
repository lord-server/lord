local properties_snippet = require('snippet.properties')
local digging_snippet    = require('snippet.digging')
local damage_snippet     = require('snippet.damage')
local armor_snippet      = require('snippet.armor')
local food_snippet       = require('snippet.food')
local buffs_snippet      = require('snippet.buffs')
local potions_snippet    = require('snippet.potions')


return {
	init = function()
		tt.register_snippet(properties_snippet)
		tt.register_snippet(digging_snippet)
		tt.register_snippet(damage_snippet)
		tt.register_snippet(armor_snippet)
		tt.register_snippet(food_snippet)
		tt.register_snippet(buffs_snippet)
		tt.register_snippet(potions_snippet)
		-- Прочность: armor_use/wear
	end,
}
