local S = minetest.get_mod_translator()


--- @class holding_points.HoldingPoint
local HoldingPoint = {
	--- @type NodeMetaRef
	meta = nil
}

--- @param position Position
--- @return holding_points.HoldingPoint
function HoldingPoint:new(position)
	local class = self

	self = {}
	self.meta = minetest.get_meta(position)

	return setmetatable(self, { __index = class })
end

function HoldingPoint:init_node()
	self.meta:set_string('name', '')
	self.meta:set_int('in_event_list', 1)
	self.meta:set_int('active', 0)
	self.meta:set_int('last_activate_at', 0)
	self.meta:set_string('captured_by_clan', '')
	self.meta:set_int('captured_at', 0)
	self.meta:set_int('reward_gived_at', 0)
	self.meta:set_string('battle_stat', minetest.serialize({}))

	self.meta:get_inventory():set_size('reward', 8)
end

--- @param player Player
function HoldingPoint:punch(player)
	local clan = clans.clan_get_by_player(player)
	if not clan then
		minetest.chat_send_player(player:get_player_name(), S('For clan players only'))
		return
	end

	-- нужно проверить наличие клана игрока в таблице статистики, обновить время захвата при наличии
	local meta             = self.meta
	local battle_stat      = minetest.deserialize(meta:get_string('battle_stat')) or {}
	local current_time     = os.time()

	battle_stat[clan.name] = 0

	-- обновить метаданные ноды
	meta:set_string('battle_stat', minetest.serialize(battle_stat))
	meta:set_string('captured_by_clan', clan.name)
	meta:set_int('captured_at', current_time)
end


return HoldingPoint
