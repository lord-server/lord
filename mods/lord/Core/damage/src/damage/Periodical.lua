local pairs, os_time, setmetatable
    = pairs, os.time, setmetatable

--- @class damage.Periodical.Active
--- @field value  string               delta value, that will be applied every second.
--- @field till   number               time when periodical damage will be stopped.
--- @field reason PlayerHPChangeReason reason, which will be passed into `player:set_hp()`

--- Local storage of now active damages for players.
--- @type damage.Periodical.Active[][]
local active_for = {
	-- [player_name] = { fleshy = { value = -7, till = <time> } }
}


--- @class damage.Periodical
local Periodical = {
	--- @type string
	player_name = nil,
}

--- @param player Player
--- @return damage.Periodical
function Periodical:for_player(player)
	local class = self

	self = {}
	self.player_name = player:get_player_name()

	return setmetatable(self, { __index = class })
end

--- @param type    string                   name of damage type (one of registered by `damage.Type.register()`).
--- @param value   number                   negative is damage; positive is healing.
--- @param seconds number                   how much `seconds` the specified damage will be last.
--- @param reason  PlayerHPChangeReason|nil on your choice. See `player:set_hp(.., reason)` param documentation.
function Periodical:start(type, value, seconds, reason)
	if not active_for[self.player_name] then
		active_for[self.player_name] = {}
	end

	active_for[self.player_name][type] = {
		value  = value,
		till   = os_time() + seconds,
		reason = reason
	}
end

--- @return damage.Periodical.Active[]
function Periodical:active()
	return active_for[self.player_name] or {}
end

--- @param type string
function Periodical:stop(type)
	active_for[self.player_name][type] = nil
end

--- @param player Player
minetest.foreach_player_every(1, function(player, delta_time)
	local now = os_time()
	local active_damages = Periodical:for_player(player):active()

	for type, active in pairs(active_damages) do
		if now < active.till then
			-- its something like damage.Type:of(type):apply_to(object)
			player:set_hp(player:get_hp() + active.value, active.reason)
		else
			active_damages[type] = nil
		end
	end
end)


return Periodical
