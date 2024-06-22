minetest.register_chatcommand("set_armor", {
    params = "<type> [value]",
    description = "",
    privs = {},
    func = function(name, param)
		if not param or param == "" then
			return
		end
		local player = minetest.get_player_by_name(name)
		local protection_type = param:split(" ")[1]
		local value = tonumber(param:split(" ")[2])
		local armor = player:get_armor_groups()
		armor[protection_type] = value
		player:set_armor_groups(armor)
	end,
})

minetest.register_craftitem("lord_damage:direct_dealer",{
	description = "Direct dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "direct")
	end
})

minetest.register_craftitem("lord_damage:direct_periodic_dealer",{
	description = "Direct Periodic dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 13, "direct_periodic", nil, nil, 3)
	end
})

minetest.register_craftitem("lord_damage:simple_physical_dealer",{
	description = "Simple Physical dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "simple_physical")
	end
})

minetest.register_craftitem("lord_damage:simple_physical_periodic_dealer",{
	description = "Simple Physical Periodic dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "simple_physical_periodic")
	end
})

minetest.register_craftitem("lord_damage:slashing_physical_dealer",{
	description = "Slashing Physical dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "slashing_physical")
	end
})

minetest.register_craftitem("lord_damage:slashing_physical_periodic_dealer",{
	description = "Slashing Physical Periodic dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "slashing_physical_periodic")
	end
})

minetest.register_craftitem("lord_damage:piercing_physical_dealer",{
	description = "Piercing Physical dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "piercing_physical")
	end
})

minetest.register_craftitem("lord_damage:piercing_physical_periodic_dealer",{
	description = "Piercing Physical Periodic dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "piercing_physical_periodic")
	end
})

minetest.register_craftitem("lord_damage:toxical_dealer",{
	description = "Toxical dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "toxical")
	end
})

minetest.register_craftitem("lord_damage:toxical_periodic_dealer",{
	description = "Toxical Periodic dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "toxical_periodic")
	end
})

minetest.register_craftitem("lord_damage:fiery_dealer",{
	description = "Fiery dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "fiery")
	end
})

minetest.register_craftitem("lord_damage:fiery_periodic_dealer",{
	description = "Fiery Periodic dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 13, "fiery_periodic", nil, nil, 3)
	end
})
