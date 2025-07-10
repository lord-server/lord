local Meta      = require('holding_points.HoldingPoint.Meta')
local Processor = require('holding_points.HoldingPoint.Processor')

local S = minetest.get_mod_translator()

local DAY = 60 * 60 * 24


-- TODO: extract this function into `helpers` mod or into `builtin`. Also see remains, reward_chest. Also see #2180
--- @param chest_pos Position
--- @param player_pos Position
--- @param items ItemStack[]
local function drop_items_to_world(chest_pos, player_pos, items)
	local drop_pos       = table.copy(chest_pos)
	drop_pos.y           = chest_pos.y + 1
	local drop_direction = {
		x = (player_pos.x - drop_pos.x),
		y = (player_pos.y - drop_pos.y + 3.5),
		z = (player_pos.z - drop_pos.z),
	}
	for _, reward in ipairs(items) do
		if reward:get_count() > 0 then
			--- @type Entity
			local item = minetest.add_item(drop_pos, reward)
			item:set_velocity(drop_direction)
		end
	end
end


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

--- @return string
function HoldingPoint:get_battle_name()
	return self.meta.battle
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
	drop_items_to_world(self.position, player:get_pos(), reward)
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


return HoldingPoint
