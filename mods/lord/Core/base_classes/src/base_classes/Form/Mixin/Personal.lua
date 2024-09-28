local Logger = minetest.get_mod_logger()


--- @class base_classes.Form.Mixin.Personal: base_classes.Form.Mixin
local Personal = {
	--- @static late
	--- @protected
	--- @type table<string,base_classes.Form.Base>
	opened_for = nil,
	--- Set `true` if you don't need to cleanup `self.opened_for[player_name]` on each close form.
	--- In this case it will be removed only on player leave.
	--- Useful for player inventory specified by `player:set_inventory_formspec()` MT function.
	--- @type string
	no_cleanup_on_close = false,
}

--- @public
--- @static late
--- @param player Player
function Personal:get_opened_for(player)
	return self.opened_for[player:get_player_name()]
end

--- @protected
--- @param player    Player
--- @param form_name string
--- @param fields    table
function Personal:handler(player, form_name, fields)
	if form_name ~= self.NAME then
		return
	end

	local form = self:get_opened_for(player)
	if not form then
		Logger.error('[Form.Mixin.Personal]: opened form for player `%s` not found.', player:get_player_name())
		return
	end

	self.event:trigger(self.event.Type.on_handle, form, player, fields)
	if form:handle(fields) then
		return
	end

	if fields.quit then
		form:close()
	end
end

--- @protected
--- @param player Player
function Personal:player_leave(player, _)
	local form = self:get_opened_for(player);
	if form then
		form:close()
		if self.no_cleanup_on_close then
			self.opened_for[self.player_name] = nil
		end
	end
end


--- @static
--- @param class base_classes.Form.Base|base_classes.Form.Mixin.Personal
function Personal.mix_to(class)
	class.opened_for = {}

	--- @param self base_classes.Form.Mixin.Personal
	class.on_open(function(self)
		self.opened_for[self.player_name] = self;
	end)
	--- @param self base_classes.Form.Mixin.Personal
	class.on_close(function(self)
		if not self.no_cleanup_on_close then
			self.opened_for[self.player_name] = nil
		end
	end)
	--- @param self base_classes.Form.Mixin.Personal
	class.on_register(function(self)
		minetest.register_on_leaveplayer(function(player, _)
			self:player_leave(player)
		end)
	end)
end


return Personal
