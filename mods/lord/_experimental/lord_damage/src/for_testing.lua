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

minetest.register_craftitem("lord_damage:physical_dealer",{
	description = "Physical dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "physical")
	end
})

minetest.register_craftitem("lord_damage:toxic_dealer",{
	description = "Toxic dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "toxic")
	end
})

minetest.register_craftitem("lord_damage:fiery_dealer",{
	description = "Fiery dealer",
	on_use = function(itemstack, player, pointed_thing)
		lord_damage.deal_damage(player, 5, "fiery")
	end
})
