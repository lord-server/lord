local SL = lord.require_intllib()

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
					lord.give_or_drop(user, ItemStack("vessels:glass_bottle"))
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
					lord.give_or_drop(user, ItemStack("vessels:glass_bottle"))
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

		-- limit effects
		local test = lottpotion.players[playername]
		if (test ~= nil) and ((test.speed + def.speed > limit.speed) or (test.jump + def.jump > limit.jump)) then
			return
		end

		itemstack:take_item()
		lord.give_or_drop(user, ItemStack("vessels:glass_bottle"))
		local image_potion = nil
		--if itemstack:get_definition then
		--  image_potion = itemstack:get_definition().inventory_image
		--end
		if image_potion == nil then
			image_potion = "lottpotion_bottle.png"
		end

		-- for corruption
		if flags.inv==true then
			def.gravity = 0 - def.gravity
			def.speed = 0 - def.speed
			def.jump = 0 - def.jump
		end

		lottpotion.addPrefs(playername, def.speed, def.jump, def.gravity)
		lottpotion.refresh(playername)
		local deaths = lottpotion.deaths or 0
		minetest.chat_send_player(playername, SL("You are under the effects of the "..type.." potion."))

		local first_screen = user:hud_add({
			hud_elem_type = "image",
			position = {x=0.95, y=0.95},
			scale = {x=-5, y=-8},
			text = image_potion,
			offset = {x=0, y=1},
		})

		minetest.after(time, function()
			local new_deaths = lottpotion.deaths or 0
			if new_deaths == deaths then
				local rest_speed = 0-def.speed
				local rest_jump = 0-def.jump
				local rest_gravity = 0-def.gravity
				rest_speed = math.min(rest_speed,limit.speed)
				rest_jump = math.min(rest_jump,limit.jump)
				rest_gravity = math.min(rest_gravity,limit.gravity)

				lottpotion.addPrefs(playername, rest_speed, rest_jump, rest_gravity)
				lottpotion.refresh(playername)
				minetest.chat_send_player(playername, SL("The effects of the "..type.." potion have worn off."))
				user:hud_remove(first_screen)
			end
		end)
	end,
	addPrefs = function(playername, speed, jump, gravity)
		local prefs = lottpotion.players[playername]
		if prefs == nil then
			return
		end
		prefs.speed = prefs.speed + speed
		if prefs.speed > 5 then
			prefs.speed = 5
		elseif prefs.speed < 0 then
			prefs.speed = 0
		end
		prefs.jump = prefs.jump + jump
		if prefs.jump > 2.5 then
			prefs.jump = 2.5
		elseif prefs.jump < 0 then
			prefs.jump = 0
		end
		prefs.gravity = prefs.gravity + gravity
		if prefs.gravity > 4 then
			prefs.gravity = 4
		elseif prefs.gravity < 0 then
			prefs.gravity = 0
		end
	end,
	refresh = function(playername)
		if minetest.get_player_by_name(playername)~=nil then
			local prefs = lottpotion.players[playername]
			if prefs == nil then
				return
			end
			minetest.get_player_by_name(playername):set_physics_override(prefs.speed, prefs.jump, prefs.gravity)
		end
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

local time = 0
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 1 then
		time = 0
		for _, player in pairs(minetest.get_connected_players()) do
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
		end
	end
end)

minetest.register_on_dieplayer(function(player)
	local name = player:get_player_name()
	lottpotion.players[name] = {
		speed = 1,
		jump = 1,
		gravity = 1,
		air = 0,
		hp = 0,
		alive = 0,
	}
	lottpotion.refresh(name)
	if lottpotion.deaths[name] == nil then
		lottpotion.deaths[name] = 1
	end
	lottpotion.deaths[name] = lottpotion.deaths[name] + 1
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
	lottpotion.players[player:get_player_name()] = {
		speed = 1,
		jump = 1,
		gravity = 1,
		air = 0,
		hp = 0,
		alive = 1,
	}
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
	description = SL("Wine"),
	inventory_image = "lottpotion_wine.png",
	wield_image = "lottpotion_wine.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem( "lottpotion:beer", {
	description = SL("Beer"),
	inventory_image = "lottpotion_beer.png",
	wield_image = "lottpotion_beer.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem( "lottpotion:ale", {
	description = SL("Ale"),
	inventory_image = "lottpotion_ale.png",
	wield_image = "lottpotion_ale.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem( "lottpotion:mead", {
	description = SL("Mead"),
	inventory_image = "lottpotion_mead.png",
	wield_image = "lottpotion_mead.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem( "lottpotion:cider", {
	description = SL("Cider"),
	inventory_image = "lottpotion_cider.png",
	wield_image = "lottpotion_cider.png",
	on_use = minetest.item_eat(1),
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
