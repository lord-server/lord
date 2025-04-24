local S = minetest.get_mod_translator()

--- @type traders.config[]
local config = require("traders.config")
--- @type traders.trader.Form
local Form = require("traders.trader.Form")
--- @type traders.trader.Inventory
local Inventory = require("traders.trader.Inventory")


--- @param self LuaEntity
--- @param pos  Position
local function face_pos(self, pos)
	local s   = self.object:get_pos()
	local vec = { x = pos.x - s.x, y = pos.y - s.y, z = pos.z - s.z }
	local yaw = math.atan2(vec.z, vec.x) - math.pi / 2
	if self.drawtype == "side" then
		yaw = yaw + (math.pi / 2)
	end
	self.object:set_yaw(yaw)
	return yaw
end

local common_trader_definition = {
	type                 = "npc",
	visual               = "mesh",
	mesh                 = "lottarmor_character_old.b3d",
	animation            = {
		speed_normal = 15,
		speed_run    = 15,
		stand_start  = 0,
		stand_end    = 79,
		walk_start   = 168,
		walk_end     = 187,
		run_start    = 168,
		run_end      = 187,
		punch_start  = 189,
		punch_end    = 198,
	},
	makes_footstep_sound = true,
	walk_velocity        = 1, -- except elves (1.5)
	light_resistant      = true,
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 10, -- except hobbits (5)
	light_damage         = 0,
	attack_type          = "dogfight",
	follow               = "lottother:narya", -- except hobbits
	jump                 = true,
	drops                = {
		{ name = "lord_money:copper_coin",  chance = 2,  min = 1, max = 30, },
		{ name = "lord_money:silver_coin",  chance = 6,  min = 1, max = 9, },
		{ name = "lord_money:gold_coin",    chance = 9,  min = 1, max = 3, },
		{ name = "lord_money:diamond_coin", chance = 50, min = 1, max = 1, },
	},
	attacks_monsters     = true, -- except hobbits
	group_attack         = true, -- except hobbits
	sounds       = { -- except hobbits (nil)
		war_cry = "mobs_die_yell",
		death   = "default_death",
		attack  = "default_punch2", -- except elves (mobs_slash_attack)
	}
}
--- @param entity  LuaEntity
--- @param clicker Player
--- @param race    string
local function on_rightclick(entity, clicker, race)
	face_pos(entity, clicker:get_pos())
	local player_name = clicker:get_player_name()

	local trader_config = config[race]

	if entity.id == 0 then
		entity.id = (math.random(1, 1000) * math.random(1, 10000)) .. entity.name .. (math.random(1, 1000) ^ 2)
	end
	if entity.game_name == "mob" then
		entity.game_name = tostring(trader_config.names[math.random(1,#trader_config.names)])
		--self.nametag = self.game_name
	end

	minetest.chat_send_player(
		player_name,
		"[NPC] <" .. S("Trader") .. " " .. S(entity.game_name) .. "> " ..
			S("Hello") .. ", " .. player_name .. ", \n" ..
			tostring(trader_config.messages[math.random(1, #trader_config.messages)]) -- messages already translated
	)

	local same_race = character.of(clicker):get_race() == race
	local inventory_id = Inventory:new(clicker, entity, trader_config.goods, same_race):get_id()
	Form:new(clicker, inventory_id, entity.game_name):open()

end

------------------------------------------------------------------------------------------------------------------------

Form.on_close(function(form)
	Inventory.get_by_id(form.inventory_id):return_forgotten()
end)

------------------------------------------------------------------------------------------------------------------------

--- @param name string
--- @param definition table
local function register_trader(name, definition)
	local def         = table.merge(common_trader_definition, definition)

	-- HACK: we can't move this into `common_trader_definition`, because we need `def.race`,
	--       but `mobs:register_mob()` does not pass all `def` into `minetest.register_entity()`
	def.on_rightclick = function(self, clicker)
		on_rightclick(self, clicker, def.race)
	end

	mobs:register_mob(name, def)
end

return {
	register = register_trader
}
