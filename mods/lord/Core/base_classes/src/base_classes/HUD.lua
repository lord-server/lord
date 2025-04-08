local setmetatable, ipairs, table_insert
    = setmetatable, ipairs, table.insert


--- @class base_classes.HUD
local HUD = {
	--- @private
	--- @type number[]
	IDs    = {},
	--- @protected
	--- @type Player
	player = nil,
	--- @private
	--- @generic GenericHUD: base_classes.HUD
	--- @type table<string,GenericHUD>
	hud    = nil,
}

--- @public
--- @generic GenericHUD: base_classes.HUD
--- @param child_class GenericHUD
--- @return GenericHUD
function HUD:extended(child_class)
	child_class = child_class or {}
	child_class.hud = {}

	return setmetatable(child_class, { __index = self })
end

--- @private
--- @generic GenericHUD: base_classes.HUD
--- @return GenericHUD
function HUD:new(player)
	local class = self

	self = {}
	self.player = player

	return setmetatable(self, { __index = class })
end

--- @param player Player
--- @generic GenericHUD: base_classes.HUD
--- @return GenericHUD
function HUD:for_player(player)
	local player_name = player:get_player_name()
	if not self.hud[player_name] then
		self.hud[player_name] = self:new(player)
	end

	return self.hud[player_name]
end

--- @return HudDefinition[]
function HUD:get_definitions()
	error('You should to override method `:get_definitions()`')
end

--- @generic GenericHUD: base_classes.HUD
--- @return GenericHUD
function HUD:show()
	for _, definition in ipairs(self:get_definitions()) do
		table_insert(self.IDs, self.player:hud_add(definition))
	end

	return self
end

--- @generic GenericHUD: base_classes.HUD
--- @return GenericHUD
function HUD:hide()
	for _, id in ipairs(self.IDs) do
		self.player:hud_remove(id)
	end

	self.hud[self.player:get_player_name()] = nil

	return self
end

--- You should to call this method after you declare your HUD class.
--- @generic GenericHUD: base_classes.HUD
--- @return GenericHUD
function HUD:register()
	minetest.register_on_leaveplayer(function(player, timed_out)
		self.hud[player:get_player_name()] = nil
	end)

	return self
end


return HUD
