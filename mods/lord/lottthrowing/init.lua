local SL = lord.require_intllib()


local lottthrowing_player_shoot = function(player, arrow_name)
	local dir = player:get_look_dir()
	local p = player:get_pos()
	local offset = {x = 0, y = 1.5, z = 0}
	p.x = p.x + offset.x
	p.y = p.y + offset.y
	p.z = p.z + offset.z
	return throwing.shoot(player, "player", arrow_name, p, dir, -0.1)
end

local lottthrowing_shoot = function(player, arrow_name)
	local stack_index = player:get_wield_index() + 1
	local creative = minetest.is_creative_enabled(player)
	local stack = player:get_inventory():get_stack("main", stack_index)

	if (not creative) then
		stack:take_item(1);
		player:get_inventory():set_stack("main", stack_index, stack)
	end

	return lottthrowing_player_shoot(player, arrow_name)
end

local lottthrowing_shoot_arrow = function(itemstack, player)
	local itemname = player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name()
	if throwing.arrow_type(itemname) ~= "arrow" then
		return false
	end
	return lottthrowing_shoot(player, itemname)
end

local lottthrowing_shoot_bolt = function(itemstack, player)
	local itemname = player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name()
	if throwing.arrow_type(itemname) ~= "bolt" then
		return false
	end
	return lottthrowing_shoot(player, itemname)
end

minetest.register_tool("lottthrowing:bow_wood", {
	description = SL("Normal Wood Bow"),
	groups = {wooden = 1},
	inventory_image = "lottthrowing_bow_wood.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/50)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:bow_wood_alder", {
	description = SL("Alder Wood Bow"),
	groups = {wooden = 1},
	inventory_image = "lottthrowing_bow_wood_alder.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/70)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:bow_wood_birch", {
	description = SL("Birch Wood Bow"),
	groups = {wooden = 1},
	inventory_image = "lottthrowing_bow_wood_birch.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/100)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:bow_wood_lebethron", {
	description = SL("Lebethron Wood Bow"),
	groups = {wooden = 1},
	inventory_image = "lottthrowing_bow_wood_lebethron.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/150)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:bow_wood_mallorn", {
	description = SL("Mallorn Bow"),
	groups = {wooden = 1},
	inventory_image = "lottthrowing_bow_wood_mallorn.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/300)
			end
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood',
	recipe = {
		{'farming:string', 'default:wood', ''},
		{'farming:string', '', 'default:wood'},
		{'farming:string', 'default:wood', ''},
	}
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood_alder',
	recipe = {
		{'farming:string', 'lottplants:alderwood', ''},
		{'farming:string', '', 'lottplants:alderwood'},
		{'farming:string', 'lottplants:alderwood', ''},
	}
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood_birch',
	recipe = {
		{'farming:string', 'lottplants:birchwood', ''},
		{'farming:string', '', 'lottplants:birchwood'},
		{'farming:string', 'lottplants:birchwood', ''},
	}
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood_lebethron',
	recipe = {
		{'farming:string', 'lottplants:lebethronwood', ''},
		{'farming:string', '', 'lottplants:lebethronwood'},
		{'farming:string', 'lottplants:lebethronwood', ''},
	}
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood_mallorn',
	recipe = {
		{'farming:string', 'lottplants:mallornwood', ''},
		{'farming:string', '', 'lottplants:mallornwood'},
		{'farming:string', 'lottplants:mallornwood', ''},
	}
})

minetest.register_tool("lottthrowing:crossbow_magical", {
	description = SL("Magical Crossbow"),
	groups = {wooden = 1},
	inventory_image = "lottthrowing_crossbow_magical.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_player_shoot(user, "arrows:darkball") then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/150)
			end
		end
		return itemstack
	end,
})


minetest.register_tool("lottthrowing:crossbow_wood", {
	description = SL("Wooden Crossbow"),
	groups = {wooden = 1},
	inventory_image = "lottthrowing_crossbow_wood.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/50)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_steel", {
	description = SL("Steel Crossbow"),
	groups = {steel_item = 1},
	inventory_image = "lottthrowing_crossbow_steel.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/70)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_tin", {
	description = SL("Tin Crossbow"),
	groups = {tin_item = 1},
	inventory_image = "lottthrowing_crossbow_tin.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/100)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_silver", {
	description = SL("Silver Crossbow"),
	groups = {silver_item = 1},
	inventory_image = "lottthrowing_crossbow_silver.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/150)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_gold", {
	description = SL("Gold Crossbow"),
	groups = {gold_item = 1},
	inventory_image = "lottthrowing_crossbow_gold.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/200)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_galvorn", {
	description = SL("Galvorn Crossbow"),
	inventory_image = "lottthrowing_crossbow_galvorn.png",
	groups = {forbidden=1, galvorn_item = 1},
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/300)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_mithril", {
	description = SL("Mithril Crossbow"),
	groups = {mithril_item = 1},
	inventory_image = "lottthrowing_crossbow_mithril.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(itemstack, user, pointed_thing) then
			if not minetest.is_creative_enabled(user) then
				itemstack:add_wear(65535/500)
			end
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_wood',
	recipe = {
		{'', 'farming:string', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
		{'', 'farming:string', 'default:wood'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_steel',
	recipe = {
		{'', 'farming:string', 'default:steel_ingot'},
		{'default:wood', 'default:wood', 'default:steel_ingot'},
		{'', 'farming:string', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_tin',
	recipe = {
		{'', 'farming:string', 'lottores:tin_ingot'},
		{'default:wood', 'default:wood', 'lottores:tin_ingot'},
		{'', 'farming:string', 'lottores:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_silver',
	recipe = {
		{'', 'farming:string', 'lottores:silver_ingot'},
		{'default:wood', 'default:wood', 'lottores:silver_ingot'},
		{'', 'farming:string', 'lottores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_gold',
	recipe = {
		{'', 'farming:string', 'default:gold_ingot'},
		{'default:wood', 'default:wood', 'default:gold_ingot'},
		{'', 'farming:string', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_galvorn',
	recipe = {
		{'', 'farming:string', 'lottores:galvorn_ingot'},
		{'default:wood', 'default:wood', 'lottores:galvorn_ingot'},
		{'', 'farming:string', 'lottores:galvorn_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_mithril',
	recipe = {
		{'', 'farming:string', 'lottores:mithril_ingot'},
		{'default:wood', 'default:wood', 'lottores:mithril_ingot'},
		{'', 'farming:string', 'lottores:mithril_ingot'},
	}
})

if minetest.settings:get("log_mods") then
	minetest.log("action", "lottthrowing loaded")
end
