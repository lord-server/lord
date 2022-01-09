local SL = minetest.get_translator("jailbars")

local function register_jail_door(material, groups)
	groups.door = 1

	doors.register_door("jailbars:jail_door_"..material, {
	        description = SL(material.." jail door"),
	        inventory_image = "castle_jail_door_"..material.."_inv.png",
	        groups = groups,
	        tiles_bottom = {"castle_jail_door_"..material.."_bottom.png", "door_jail.png"},
	        tiles_top = {"castle_jail_door_"..material.."_top.png", "door_jail.png"},
	        sunlight = true,
	})

	doors.register_door("jailbars:jail_door_lock_"..material, {
	        description = SL(material.." jail door with lock"),
	        inventory_image = "castle_jail_door_"..material.."_inv.png^doors_lock.png",
	        groups = groups,
	        tiles_bottom = {"castle_jail_door_"..material.."_bottom.png", "door_jail.png"},
	        tiles_top = {"castle_jail_door_"..material.."_top.png", "door_jail.png"},
	        only_placer_can_open = true,
	        sunlight = true,
	})

	minetest.register_craft({
	        output = "jailbars:jail_door_"..material,
	        recipe = {
	                {"jailbars:jailbars_"..material, "jailbars:jailbars_"..material},
	                {"jailbars:jailbars_"..material, "jailbars:jailbars_"..material},
	                {"jailbars:jailbars_"..material, "jailbars:jailbars_"..material}
        	}
	})

	minetest.register_craft({
        	type = "shapeless",
        	output = "jailbars:jail_door_lock_"..material,
	        recipe = {"jailbars:jail_door_"..material, "default:steel_ingot"}
	})
end

register_jail_door("steel", {cracky=2})
register_jail_door("tilkal", {forbidden=1})
register_jail_door("galvorn", {forbidden=1, cracky=1, level=2})

