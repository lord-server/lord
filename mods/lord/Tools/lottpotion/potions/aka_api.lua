local SL    = minetest.get_mod_translator()

-- moved AS IS from lottpotion/init.lua
-- TODO: REMOVE; and migrate to our `lord_potions`

local limit = {
	speed   = 4,
	jump    = 2,
	gravity = 3,
	air     = 3,
}

lottpotion  = {
	players         = {},
	deaths          = {},
	effects         = {
		phys_override = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use     = function(itemstack, user, pointed_thing)
					lottpotion.grant(time, user, fname .. "_" .. flags.type .. sdata.type, name, flags, itemstack)
					return itemstack
				end,
				lottpotion = {
					speed   = 0,
					jump    = 0,
					gravity = 0,
					air     = 0,
					hp      = 0,
					alive   = 1,
				},
			}
			return def
		end,
		fixhp         = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					local hp_change = sdata.hp or 3
					if flags.inv == true then
						hp_change = -hp_change
					end
					local h                                       = lottpotion.players[user:get_player_name()].hp
					lottpotion.players[user:get_player_name()].hp = h + hp_change
					minetest.after(sdata.time, function()
						local act_player = lottpotion.players[user:get_player_name()]
						if user ~= nil and act_player ~= nil then
							h             = act_player.hp
							act_player.hp = h - hp_change
						end
					end)
					itemstack:take_item()
					minetest.give_or_drop(user, ItemStack("vessels:glass_bottle"))
					return itemstack
				end,
			}
			def.mobs  = {
				on_near = def.on_use,
			}
			return def
		end,
		air           = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					local br_change = sdata.br or 3
					if flags.inv == true then
						br_change = -br_change
					end
					local b                                        = lottpotion.players[user:get_player_name()].air
					lottpotion.players[user:get_player_name()].air = br_change

					minetest.after(sdata.time, function()
						local act_player = lottpotion.players[user:get_player_name()]
						if user ~= nil and act_player ~= nil then
							b              = act_player.air
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
	grant           = function(time, user, potion_name, type, flags, itemstack)
		local rootdef    = minetest.registered_items[potion_name]
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
		minetest.give_or_drop(user, ItemStack("vessels:glass_bottle"))
		local image_potion = nil
		--if itemstack:get_definition then
		--  image_potion = itemstack:get_definition().inventory_image
		--end
		if image_potion == nil then
			image_potion = "lottpotion_bottle.png"
		end

		-- for corruption
		if flags.inv == true then
			def.gravity = 0 - def.gravity
			def.speed   = 0 - def.speed
			def.jump    = 0 - def.jump
		end

		lottpotion.addPrefs(playername, def.speed, def.jump, def.gravity)
		lottpotion.refresh(playername)
		local deaths = lottpotion.deaths or 0
		minetest.chat_send_player(playername, SL("You are under the effects of the " .. type .. " potion."))

		local first_screen = user:hud_add({
			hud_elem_type = "image",
			position      = { x = 0.95, y = 0.95 },
			scale         = { x = -5, y = -8 },
			text          = image_potion,
			offset        = { x = 0, y = 1 },
		})

		minetest.after(time, function()
			local new_deaths = lottpotion.deaths or 0
			if new_deaths == deaths then
				local rest_speed   = 0 - def.speed
				local rest_jump    = 0 - def.jump
				local rest_gravity = 0 - def.gravity
				rest_speed         = math.min(rest_speed, limit.speed)
				rest_jump          = math.min(rest_jump, limit.jump)
				rest_gravity       = math.min(rest_gravity, limit.gravity)

				lottpotion.addPrefs(playername, rest_speed, rest_jump, rest_gravity)
				lottpotion.refresh(playername)
				minetest.chat_send_player(playername, SL("The effects of the " .. type .. " potion have worn off."))
				user:hud_remove(first_screen)
			end
		end)
	end,
	addPrefs        = function(playername, speed, jump, gravity)
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
	refresh         = function(playername)
		if minetest.get_player_by_name(playername) ~= nil then
			local prefs = lottpotion.players[playername]
			if prefs == nil then
				return
			end
			minetest.get_player_by_name(playername):set_physics_override({
				speed   = prefs.speed,
				jump    = prefs.jump,
				gravity = prefs.gravity
			})
		end
	end,
	register_potion = function(sname, name, fname, time, def)
		local tps = { "power", "corruption" }
		for t = 1, #tps do
			for i = 1, #def.types do
				local sdata    = def.types[i]
				local item_def = {
					description     = SL(name .. " (Strength: " .. tps[t] .. sdata.type .. ")"),
					inventory_image = "lottpotion_bottle.png^" ..
						"lottpotion_" .. (def.texture or sname) .. ".png^" ..
						"lottpotion_" .. tps[t] .. sdata.type .. ".png",
					drawtype        = "plantlike",
					paramtype       = "light",
					walkable        = false,
					groups          = { dig_immediate = 3, attached_node = 1, vessel = 1 },
					sounds          = default.node_sound_glass_defaults(),
				}
				item_def.tiles = { item_def.inventory_image }
				local flags    = {
					inv  = false,
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
				minetest.register_node(fname .. "_" .. tps[t] .. sdata.type, item_def)
				--potions.register_liquid(i..tps[t]..sname, name.." ("..tps[t].." "..i..")", item_def.on_use)
				if minetest.get_modpath("lottthrowing") ~= nil then
					lottpotion.register_arrow(
						fname .. "_" .. tps[t] .. sdata.type,
						i .. tps[t] .. sname,
						name .. " (" .. tps[t] .. " " .. i .. ")",
						item_def.on_use,
						item_def.description,
						item_def.inventory_image
					)
				end
			end
		end
	end,
}
