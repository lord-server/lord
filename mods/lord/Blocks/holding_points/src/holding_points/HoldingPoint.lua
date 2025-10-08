local Meta      = require('holding_points.HoldingPoint.Meta')
local Processor = require('holding_points.HoldingPoint.Processor')
local Event     = require('holding_points.Event')

local S = minetest.get_mod_translator()

local DAY = 60 * 60 * 24


--- @class holding_points.HoldingPoint
local HoldingPoint = {
	--- @private
	--- @type Position position of node
	position  = nil,
	--- @private
	--- @type string   HoldingPoint identifier
	id        = nil,
	--- @private
	--- @type holding_points.HoldingPoint.Meta
	meta      = nil,
	--- @private
	--- @type NodeMetaRef
	node_meta = nil,
	--- @private
	--- @type holding_points.HoldingPoint.Processor
	processor = nil,
	--- @static
	--- @public
	debug     = false,
}

--- @static
--- @param position Position
--- @return string
function HoldingPoint.create_id(position)
	return minetest.pos_to_string(position)
end

--- @param position Position
--- @return holding_points.HoldingPoint
function HoldingPoint:new(position)
	local class = self

	self = setmetatable({}, { __index = class })
	self.position  = position
	self.id        = class.create_id(position)
	self.node_meta = minetest.get_meta(position)
	self.meta      = Meta:new(self.node_meta)
	self.processor = Processor.get_for(self)

	return self
end

--- @return string
function HoldingPoint:get_id()
	return self.id
end

--- @return Position
function HoldingPoint:get_position()
	return self.position
end

function HoldingPoint:init_node()
	self.meta.name              = ''
	self.meta.in_event_list     = true
	self.meta.active            = false
	self.meta.last_activated_at = 0
	self.meta.captured_by_clan  = ''
	self.meta.captured_at       = 0
	self.meta.reward_given_at   = 0
	self.meta.battle_stat       = {}

	self.node_meta:get_inventory():set_size('reward', 8)
end

--- @return string
function HoldingPoint:get_name()
	return self.meta.name
end

--- @return boolean
function HoldingPoint:is_in_event_list()
	return self.meta.in_event_list
end

--- @return string
function HoldingPoint:get_battle_name()
	return self.meta.battle
end

--- @return string
function HoldingPoint:get_captured_by_clan()
	return self.meta.captured_by_clan
end

--- @return holding_points.HoldingPoint
function HoldingPoint:activate()
	self.meta.active            = true
	self.meta.last_activated_at = os.time()
	self.meta.captured_at       = 0
	self.meta.captured_by_clan  = ''
	self.meta.battle_stat       = {}

	return self
end

--- @return holding_points.HoldingPoint
function HoldingPoint:deactivate()
	self.meta.active      = false
	self.processor:stop()

	local win_clan_id = self:get_win_clan()
	self.meta.captured_by_clan = win_clan_id and win_clan_id.name or ''

	return self
end

--- @param player Player
function HoldingPoint:punch(player)
	local player_name = player:get_player_name()

	local clan = clans.clan_get_by_player_name(player_name)
	if not clan then
		minetest.chat_send_player(player_name, S('For clan players only.'))

		return
	end

	local meta = self.meta

	if not meta.active then
		minetest.chat_send_player(player_name, S('This point is not currently participating in the battle.'))

		return
	end

	if meta.captured_by_clan == clan.name then
		return
	end

	self.processor:stop()

	meta.captured_at = os.time()
	meta.captured_by_clan = clan.name

	self.processor:start()

	Event:trigger(Event.Type.on_point_captured, self, clan)
end

--- @param player Player
function HoldingPoint:reward(player)
	local player_name = player:get_player_name()

	local clan = clans.clan_get_by_player_name(player_name)
	if not clan then
		minetest.chat_send_player(player_name, S('For clan players only.'))

		return
	end

	if not self:can_get_reward(player, clan) then
		minetest.chat_send_player(player_name, S('You can\'t get reward.'))

		return
	end

	local reward = self.node_meta:get_inventory():get_list('reward')
	drop_items_to_world(self.position, player:get_pos(), player:get_look_horizontal(), reward)
	self.meta.reward_given_at = os.time() -- now
end

---@param score     number
---@param clan_name string
---@return holding_points.HoldingPoint
function HoldingPoint:add_score(score, clan_name)
	local meta = self.meta

	clan_name = clan_name or meta.captured_by_clan
	local battle_stat = meta.battle_stat
	battle_stat[clan_name] = (battle_stat[clan_name] or 0) + score
	meta.battle_stat = battle_stat

	if self.debug then
		minetest.chat_send_all('Score: ' .. battle_stat[clan_name])
	end

	return self
end

--- @return number
function HoldingPoint:get_holding_time()
	return os.time() - self.meta.captured_at
end

--- @param player Player
--- @param clan   clans.Clan
function HoldingPoint:can_get_reward(player, clan)
	local now = os.time()

	return
		not self.meta.active and
		self.meta.captured_by_clan == clan.name and
		clan.leader == player:get_player_name() and
		(now - self.meta.captured_at) < 7 * DAY and
		not self.same_day(self.meta.reward_given_at, now)
end

--- @static
--- @param timestamp1 number
--- @param timestamp2 number
--- @return boolean
function HoldingPoint.same_day(timestamp1, timestamp2)
	local d1 = os.date('*t', timestamp1)
	local d2 = os.date('*t', timestamp2)

	return
		d1.year == d2.year and
		d1.month == d2.month and
		d1.day == d2.day
end

--- @return clans.Clan
function HoldingPoint:get_win_clan()
	local max_score   = 0
	local win_clan_id = nil
	for clan_id, score in pairs(self.meta.battle_stat) do
		if score > max_score then
			max_score   = score
			win_clan_id = clan_id
		end
	end

	return clans.clan_get_by_name(win_clan_id)
end


return HoldingPoint
