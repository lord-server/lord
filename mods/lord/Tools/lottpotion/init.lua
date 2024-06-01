local SL = minetest.get_translator("lottpotion")

local limit = {	speed = 4,
				jump =2,
				gravity = 3,
				air = 3,
}

lottpotion = {}

dofile(minetest.get_modpath("lottpotion").."/cauldron.lua")

lottpotion = {
	players = {},
	deaths  = {},
	effects = {
		phys_override = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					lottpotion.grant(time, user, fname.."_"..flags.type..sdata.type, name, flags, itemstack)
					return itemstack
				end,
				lottpotion = {
					speed = 0,
					jump = 0,
					gravity = 0,
					air = 0,
					hp = 0,
					alive = 1,
				},
			}
			return def
		end,
		fixhp = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					local hp_change = sdata.hp or 3
					if flags.inv == true then
						hp_change = -hp_change
					end
					local h = lottpotion.players[user:get_player_name()].hp
					lottpotion.players[user:get_player_name()].hp = h + hp_change
					minetest.after(sdata.time, function()
						local act_player = lottpotion.players[user:get_player_name()]
						if user ~= nil and act_player ~= nil then
							h = act_player.hp
							act_player.hp = h - hp_change
						end
					end)
					itemstack:take_item()
					minetest.give_or_drop(user, ItemStack("vessels:glass_bottle"))
					return itemstack
				end,
			}
			def.mobs = {
				on_near = def.on_use,
			}
			return def
		end,
		air = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					local br_change = sdata.br or 3
					if flags.inv == true then
						br_change = -br_change
					end
					local b = lottpotion.players[user:get_player_name()].air
					lottpotion.players[user:get_player_name()].air = br_change

					minetest.after(sdata.time, function()
						local act_player = lottpotion.players[user:get_player_name()]
						if user ~= nil and act_player ~= nil then
							b = act_player.air
							act_player.air = b - br_change
						end
					end)
					itemstack:take_item()
					minetest.give_or_drop(user, ItemStack("vessels:glass_bottle"))
					return itemstack
				end,
			}
			return def
		end,
	},
	grant = function(time, user, potion_name, type, flags, itemstack)
		local rootdef = minetest.registered_items[potion_name]
		local playername = user:get_player_name()
		if rootdef == nil then
			return
		end
		if rootdef.lottpotion == nil then
			return
		end
		local def = {}
		for name, val in pairs(rootdef.lottpotion) do
			def[name] = val
		end

		itemstack:take_item()
		minetest.give_or_drop(user, ItemStack("vessels:glass_bottle"))

		-- for corruption
		if flags.inv==true then
			def.gravity = 0 - def.gravity
			def.speed = 0 - def.speed
			def.jump = 0 - def.jump
		end

		lottpotion.player_add_effect(playername, def, time)
		minetest.chat_send_player(playername, SL("You are under the effects of the "..type.." potion."))
	end,
	player_load_effects = function(playername)
		local player = minetest.get_player_by_name(playername)
		local pmeta = player:get_meta()
    	local effects_serialized = pmeta:get_string("lottpotion:effects")
    	local effects
		if effects_serialized ~= nil then
        	effects = minetest.deserialize(effects_serialized)
		end

		if effects == nil then
        	effects = {}
    	end
		return effects
	end,
	player_store_effects = function(playername, effects)
		local effects_serialized = minetest.serialize(effects)
		local player = minetest.get_player_by_name(playername)
		local pmeta = player:get_meta()
    	pmeta:set_string("lottpotion:effects", effects_serialized)
	end,
	player_apply_effects = function(playername, effects)
    	-- basic values
		local basic_speed = 1
		local basic_jump = 1
		local basic_gravity = 1

		local speed = 0
		local jump = 0
		local gravity = 0

		-- effects are time ordered
    	for _, effect in ipairs(effects) do
			if effect.jump ~= nil then
				jump = effect.jump
			end
			if effect.speed ~= nil then
				speed = effect.speed
			end
			if effect.gravity ~= nil then
				gravity = effect.gravity
			end
		end

		-- evaluate parameters from basic value and effects
		speed = basic_speed + speed
		jump = basic_jump + jump
		gravity = basic_gravity + gravity

		-- clip parameters
		speed = math.max(math.min(speed, limit.speed), 0)
		jump = math.max(math.min(jump, limit.jump), 0)
		gravity = math.max(math.min(gravity, limit.gravity), 0)

		-- apply effects
		minetest.log("speed = "..speed.." , jump = "..jump.." , gravity = "..gravity)
		minetest.get_player_by_name(playername):set_physics_override({
			speed   = speed,
			jump    = jump,
			gravity = gravity
		})
	end,
	player_add_effect = function(playername, effect, duration)
		local effects = lottpotion.player_load_effects(playername)
    	effects = lord_potion_effects.add_effect(effects, effect, duration)
    	lottpotion.player_store_effects(playername, effects)
		local current_effects = lord_potion_effects.list_effects(effects)
    	lottpotion.player_apply_effects(playername, current_effects)
	end,
	player_update_effects = function(playername, now)
    	local effects = lottpotion.player_load_effects(playername)
    	effects = lord_potion_effects.check_expiration(effects, now)
    	if effects ~= nil then
			lottpotion.player_store_effects(playername, effects)
        	local current_effects = lord_potion_effects.list_effects(effects)
        	lottpotion.player_apply_effects(playername, current_effects)
    	end
	end,
	player_init_effects = function(playername)
		local now = lord_potion_effects.now()
		local effects = lottpotion.player_load_effects(playername)
		local updated_effects = lord_potion_effects.check_expiration(effects, now)
    	if updated_effects ~= nil then
        	lottpotion.player_store_effects(playername, updated_effects)
			effects = updated_effects
		end
		local current_effects = lord_potion_effects.list_effects(effects)
        lottpotion.player_apply_effects(playername, current_effects)
	end,
	register_potion = function(sname, name, fname, time, def)
		local tps = {"power", "corruption"}
		for t=1, #tps do
			for i=1, #def.types do
				local sdata = def.types[i]
				local item_def = {
					description = SL(name.." (Strength: "..tps[t]..sdata.type..")"),
					inventory_image = "lottpotion_bottle.png^" ..
						"lottpotion_"..(def.texture or sname)..".png^" ..
						"lottpotion_"..tps[t]..sdata.type..".png",
					drawtype = "plantlike",
					paramtype = "light",
					walkable = false,
					groups = {dig_immediate=3,attached_node=1,vessel=1},
                         sounds = default.node_sound_glass_defaults(),
				}
				item_def.tiles = {item_def.inventory_image}
				local flags = {
					inv = false,
					type = tps[t],
				}
				if t == 2 then
					flags.inv = true
				end
				for effect_name, val in pairs(lottpotion.effects[def.effect](sname, name, fname, time, sdata, flags)) do
					item_def[effect_name] = val
				end
				for set_name, val in pairs(sdata.set) do
					item_def[set_name] = val
				end
				for effect_name, val in pairs(sdata.effects) do
					item_def.lottpotion[effect_name] = val
				end
                    minetest.register_node(fname.."_"..tps[t]..sdata.type, item_def)
				--potions.register_liquid(i..tps[t]..sname, name.." ("..tps[t].." "..i..")", item_def.on_use)
				if minetest.get_modpath("lottthrowing")~=nil then
					lottpotion.register_arrow(
						fname.."_"..tps[t]..sdata.type,
						i..tps[t]..sname,
						name.." ("..tps[t].." "..i..")",
						item_def.on_use,
						item_def.description,
						item_def.inventory_image
					)
				end
			end
		end
	end,
}
dofile(minetest.get_modpath("lottpotion").."/arrows.lua")

minetest.register_globalstep(function(player)
	local now = lord_potion_effects.now()
	local name = player:get_player_name()
	local hp_change = lottpotion.players[name].hp or 0
	if hp_change ~= 0 then
		local hp = player:get_hp()
		hp = hp + hp_change
		hp = math.min(20, hp)
		hp = math.max(0, hp)
		player:set_hp(hp)
	end
	local br_change = lottpotion.players[name].air or 0
	if br_change ~= 0 then
		local br = player:get_breath()
		br = br + br_change
		br = math.min(20, br)
		br = math.max(0, br)
		player:set_breath(br)
	end
	if lottpotion.players[name].alive ~= 1 then
		lottpotion.players[name].alive = 1
	end

	lottpotion.player_update_effects(name, now)
end)

minetest.register_on_dieplayer(function(player)
	local name = player:get_player_name()
	lottpotion.players[name] = {
		air = 0,
		hp = 0,
		alive = 0,
	}
	if lottpotion.deaths[name] == nil then
		lottpotion.deaths[name] = 1
	end
	lottpotion.deaths[name] = lottpotion.deaths[name] + 1
	lottpotion.player_store_effects(name, {})
	lottpotion.player_apply_effects(name, {})
end)

lottpotion.register_potion("athelasbrew", "Athelas Brew", "lottpotion:athelasbrew", 100, {
	effect = "fixhp",
	types = {
		{
			type = 1,
               hp = 1,
               time = 20,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
               hp = 2,
               time = 50,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
               hp = 4,
               time = 100,
			set = {},
			effects = {
			},
		},
	}
})

lottpotion.register_potion("limpe", "Limpe", "lottpotion:limpe", 240, {
	effect = "air",
	types = {
		{
			type = 1,
			br = 2,
               hp = 10,
               time = 60,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
			br = 5,
               time = 120,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
			br = 10,
               time = 240,
			set = {},
			effects = {
			},
		},
	}
})

lottpotion.register_potion("miruvor", "Miruvor", "lottpotion:miruvor", 240, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			time = 60,
			effects = {
				jump = 0.3,
			},
		},
		{
			type = 2,
			set = {},
			time = 120,
			effects = {
				jump = 0.6,
			},
		},
		{
			type = 3,
			set = {},
			time = 240,
			effects = {
				jump = 1.0,
			},
		},
	}
})

lottpotion.register_potion("spiderpoison", "Spider Poison", "lottpotion:spiderpoison", 20, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
                    speed = -0.2,
                    jump = -0.2,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
                    speed = -0.5,
                    jump = -0.5,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
                    speed = -1,
                    jump = -1,
			},
		},
	}
})

lottpotion.register_potion("orcdraught", "Orc Draught", "lottpotion:orcdraught", 100, {
	effect = "fixhp",
	types = {
		{
			type = 1,
               hp = -1,
               time = 20,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
               hp = -1,
               time = 50,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
               hp = -1,
               time = 100,
			set = {},
			effects = {
			},
		},
	}
})

lottpotion.register_potion("entdraught", "Ent Draught", "lottpotion:entdraught", 240, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
                    speed = 1,
                    jump = -0.2,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
                    speed = 2,
                    jump = -0.5,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
                    speed = 3,
                    jump = -1,
			},
		},
	}
})

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	lottpotion.players[name] = {
		air = 0,
		hp = 0,
		alive = 1,
	}
	lottpotion.player_init_effects(name)
end)

minetest.register_on_leaveplayer(function(player)
	lottpotion.players[player:get_player_name()] = nil
	lottpotion.deaths[player:get_player_name()] = nil
end)

minetest.register_chatcommand("effect", {
	params = "none",
	description = SL("get effect info"),
	func = function(name, param)
		minetest.chat_send_player(name, SL("effects:"))
		local lottpotion_e = lottpotion.players[name]
		if lottpotion_e~=nil then
			for potion_name, val in pairs(lottpotion_e) do
				if potion_name ~= "alive" then
					minetest.chat_send_player(name, potion_name .. "=" .. val)
				end
			end
		end
	end,
})

minetest.register_craftitem( "lottpotion:wine", {
	description     = SL("Wine"),
	inventory_image = "lottpotion_wine.png",
	wield_image     = "lottpotion_wine.png",
	on_use          = minetest.item_eat(1),
	_tt_food        = true,
	_tt_food_hp     = 1,
})

minetest.register_craftitem( "lottpotion:beer", {
	description     = SL("Beer"),
	inventory_image = "lottpotion_beer.png",
	wield_image     = "lottpotion_beer.png",
	on_use          = minetest.item_eat(1),
	_tt_food        = true,
	_tt_food_hp     = 1,
})

minetest.register_craftitem("lottpotion:ale", {
	description     = SL("Ale"),
	inventory_image = "lottpotion_ale.png",
	wield_image     = "lottpotion_ale.png",
	on_use          = minetest.item_eat(1),
	_tt_food        = true,
	_tt_food_hp     = 1,
})

minetest.register_craftitem("lottpotion:mead", {
	description     = SL("Mead"),
	inventory_image = "lottpotion_mead.png",
	wield_image     = "lottpotion_mead.png",
	on_use          = minetest.item_eat(1),
	_tt_food        = true,
	_tt_food_hp     = 1,
})

minetest.register_craftitem("lottpotion:cider", {
	description     = SL("Cider"),
	inventory_image = "lottpotion_cider.png",
	wield_image     = "lottpotion_cider.png",
	on_use          = minetest.item_eat(1),
	_tt_food        = true,
	_tt_food_hp     = 1,
})

function lottpotion.can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if not inv:is_empty("src") or not inv:is_empty("dst") or not inv:is_empty("fuel") or
	   not inv:is_empty("upgrade1") or not inv:is_empty("upgrade2") then
		minetest.chat_send_player(player:get_player_name(),
			SL("Brewer cannot be removed because it is not empty"))
		return false
	else
		return true
	end
end

function lottpotion.swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name ~= name then
		node.name = name
		minetest.swap_node(pos, node)
	end
	return node.name
end

dofile(minetest.get_modpath("lottpotion").."/potionbrewing.lua")
dofile(minetest.get_modpath("lottpotion").."/brewing.lua")
