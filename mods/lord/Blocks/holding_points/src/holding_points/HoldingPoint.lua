local Meta = require('holding_points.HoldingPoint.Meta')

local S = minetest.get_mod_translator()


--- @class holding_points.HoldingPoint
local HoldingPoint = {
	--- @type holding_points.HoldingPoint.Meta
	meta = nil
}

--- @param position Position
--- @return holding_points.HoldingPoint
function HoldingPoint:new(position)
	local class = self

	self = {}
	self.meta = Meta:new(position)
	self.node_meta = self.meta.meta

	return setmetatable(self, { __index = class })
end

function HoldingPoint:init_node()
	self.meta.name = ''
	self.meta.in_event_list = true
	self.meta.active = false
	self.meta.last_activated_at = 0
	self.meta.captured_by_clan = ''
	self.meta.captured_at = 0
	self.meta.reward_given_at = 0
	self.meta.battle_stat = {}

	self.node_meta:get_inventory():set_size('reward', 8)
end

--- @param player Player
function HoldingPoint:punch(player)
	local clan = clans.clan_get_by_player(player)
	if not clan then
		minetest.chat_send_player(player:get_player_name(), S('For clan players only'))
		return
	end

	-- нужно проверить наличие клана игрока в таблице статистики, обновить время захвата при наличии
	local meta        = self.meta
	local battle_stat = meta.battle_stat or {}


	battle_stat[clan.name] = 0

	-- обновить метаданные ноды
	meta.battle_stat      = battle_stat
	meta.captured_by_clan = clan.name
	meta.captured_at      = os.time()
end


return HoldingPoint
