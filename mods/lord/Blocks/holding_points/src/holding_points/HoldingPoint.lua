local Meta      = require('holding_points.HoldingPoint.Meta')
local Processor = require('holding_points.HoldingPoint.Processor')

local S = minetest.get_mod_translator()


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
}

--- @private
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
	self.meta.captured_at = 0
	self.processor:stop()

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
	self:add_score(10, clan.name)

	self.processor:start()
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

	minetest.chat_send_all('Score: ' .. battle_stat[clan_name])

	return self
end

--- @return number
function HoldingPoint:get_holding_time()
	return os.time() - self.meta.captured_at
end


return HoldingPoint
