local Event = require('holding_points.Event')

local Logger  = minetest.get_mod_logger()
local S       = minetest.get_mod_translator()


--- Management of periodic events (battles) on the server.
--- No, not the events triggered by code, but events for players.
--- @static Singleton
--- @class holding_points.Manager
local Manager = {
	--- @private
	--- @type holding_points.Storage
	storage = nil,
	--- @private
	--- @type holding_points.Battle[]
	battles = {},
}
local self = Manager

--- @param storage holding_points.Storage
--- @return holding_points.Manager
function Manager.init(storage)
	self.storage = storage
	self.load_battles()

	return Manager
end

--- @return holding_points.Battle[]
function Manager.get_battles()
	return self.battles
end

--- @param name string
--- @return holding_points.Battle
function Manager.get_battle(name)
	return self.battles[name]
end

function Manager.add_battle(battle)
	self.battles[battle.name] = battle

	return self
end

--- @public
function Manager.load_battles()
	for _, battle in pairs(self.storage:load_battles()) do
		self.add_battle(battle)
	end
end

--- @public
function Manager.save_battles()
	self.storage:save_battles(self.battles)
end

--- @public
--- @param scheduler holding_points.Scheduler
function Manager.run(scheduler)
	scheduler
		:set_battles(self.battles)
		:on_upcoming(self.on_upcoming_reached)
		:on_start(self.on_start_reached)
		:on_finish(self.on_finish_reached)
		:run()
end

--- @private
--- @param battle  holding_points.Battle
--- @param minutes number
function Manager.on_upcoming_reached(battle, minutes)
	minetest.chat_send_all(S('Time left until the battle `@1` starts: @2 minutes', battle.title, minutes))

	Event:trigger(Event.Type.on_battle_upcoming, battle, minutes)
end

--- @private
--- @param battle holding_points.Battle
function Manager.on_start_reached(battle)
	Manager.start_battle(battle)
	Logger.action('Battle `%s` started', battle.name)
	minetest.chat_send_all(S('Battle `@1` started', battle.title))
end

--- @private
--- @param battle holding_points.Battle
function Manager.on_finish_reached(battle)
	Manager.stop_battle(battle)
	Logger.action('Battle `%s` stopped', battle.name)
	minetest.chat_send_all(S('Battle `@1` finished', battle.title))
end

--- @param battle holding_points.Battle|string
--- @return boolean|holding_points.Battle, string|nil returns `false, error` or `battle` instance
function Manager.start_battle(battle)
	if type(battle) == 'string' then
		local battle_name = battle
		battle = self.battles[battle]
		if not battle then
			Logger.error('Battle `%s` not found', battle_name)

			return false, S('Battle `@1` not found', battle_name)
		end
	end

	battle:activate()

	Event:trigger(Event.Type.on_battle_started, battle)

	return battle, nil
end

--- @param battle holding_points.Battle
function Manager.stop_battle(battle)
	if type(battle) == 'string' then
		battle = self.battles[battle]
		if not battle then
			local battle_name = battle
			Logger.error('Battle `%s` not found', battle_name)

			return false, S('Battle `@1` not found', battle_name)
		end
	end

	battle:deactivate()

	Event:trigger(Event.Type.on_battle_stopped, battle)

	return battle, nil
end


return Manager
