local MainTab  = require('inventory.Form.MainTab')
local BagsTab  = require('inventory.Form.BagsTab')
local AboutTab = require('inventory.Form.AboutTab')


--- @class inventory.Form: base_classes.Form.Mixin.WithTabs
local Form = base_classes.Form:personal():with_tabs():extended({
	--- @const
	--- @type string
	NAME = "",
	--- @type string
	player_name = '',
	--- @type table<string,number>
	tab = {
		MAIN  = 1,
		BAGS  = 2,
		ABOUT = 3,
	},
	--- @type number
	current_tab = 1,
	--- Replaces by player forms collection in Form.on_register callback
	--- @see inventory.Form:on_register() @ below.
	---
	--- @static late
	--- @protected
	--- @type inventory.Form[]|table<string,inventory.Form>
	opened_for = {},
	--- We need to not clear `self.opened_for[player_name]`
	--- @see inventory.Form:on_register() @ below.
	---
	--- @type boolean
	no_cleanup_on_close = true,
	--- @type string
	player_lang = 'en',
})

function Form:get_spec_head()
	return 'size[8,8.5]'
end

--- @param player Player
function Form:instantiate(player)
	self.player_lang = minetest.get_player_information(self.player_name).lang_code or 'en'

	self
		:add_tab(MainTab:new(self))
		:add_tab(BagsTab:new(self))
		:add_tab(AboutTab:new(self))
		:refresh()
end

--- @param preview string
--- @return inventory.Form
function Form:set_main_preview(preview)
	--- @type inventory.Form.MainTab
	local main_tab = self.tabs[self.tab.MAIN]
	main_tab:set_preview(preview)

	return self
end

--- @return inventory.Form
function Form:refresh()
	minetest.get_player_by_name(self.player_name)
		:set_inventory_formspec(self:get_spec())

	return self
end


--- @param self                    inventory.Form
--- @param player_forms_collection inventory.Form[]|table<string,inventory.Form>
Form.on_register(function(self, player_forms_collection)
	-- To open some-kind our custom inventory for player, MT provides `player:set_inventory_formspec(spec)` function.
	-- And then MT by itself catch pressed `i` button & opens form with that spec.
	-- So, we doesn't calls `Form:open()` by own code to open inventory initially.
	-- But! Mixin `WithTabs` creates an instance exactly in `Form:open()` and put it into `Form.opened_for[player_name]`
	-- Then this var used to get the instance of the player to handle.
	-- But the `Form:open()` is not calls.
	-- So we need to creates this instances manually and somehow put into `Form.opened_for[player_name]`.
	-- We already do it in `_G.inventory.for_player()`. (see `inventory.lua`)
	-- And here we just replace this `Form.opened_for` array with that `player_forms_collection`.
	-- So `WithTabs` mixin works with the same collection as `_G.inventory.for_player`
	Form.opened_for = player_forms_collection
end)

--- @param self inventory.Form
Form.on_open(function(self)
	self:refresh()
end)


return Form
