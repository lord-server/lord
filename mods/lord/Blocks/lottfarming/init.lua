function place_seed(itemstack, placer, pointed_thing, plantname, param2)
	param2 = param2 or 0
	local pt = pointed_thing
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	local under = core.get_node(pt.under)
	local above = core.get_node(pt.above)
	if not core.registered_nodes[under.name] then
		return
	end
	if not core.registered_nodes[above.name] then
		return
	end
	if pt.above.y ~= pt.under.y + 1 then
		return
	end
	if not core.registered_nodes[above.name].buildable_to then
		return
	end
	if core.get_item_group(under.name, "soil") <= 1 then
		return
	end
	core.add_node(pt.above, { name = plantname, param2 = param2 })
	if not core.is_creative_enabled(placer) then
		itemstack:take_item()
	end
	return itemstack
end

function place_spore(itemstack, placer, pointed_thing, plantname, param2)
	param2 = param2 or 0
	local pt = pointed_thing
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	local under = core.get_node(pt.under)
	local above = core.get_node(pt.above)
	if not core.registered_nodes[under.name] then
		return
	end
	if not core.registered_nodes[above.name] then
		return
	end
	if pt.above.y ~= pt.under.y + 1 then
		return
	end
	if not core.registered_nodes[above.name].buildable_to then
		return
	end
	if core.get_item_group(under.name, "fungi") <= 1 then
		return
	end
	core.add_node(pt.above, { name = plantname, param2 = param2 })
	if not core.is_creative_enabled(placer) then
		itemstack:take_item()
	end
	return itemstack
end

function farming:add_plant(full_grown, names, interval, chance, param2)
	param2 = param2 or 0;
	core.register_abm({
		nodenames = names,
		interval = interval,
		chance = chance,
		catch_up = true,
		action = function(pos, node)
			pos.y = pos.y-1
			if core.get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			if not core.get_node_light(pos) then
				return
			end
			if core.get_node_light(pos) < 8 then
				return
			end
			local step = nil
			for i,name in ipairs(names) do
				if name == node.name then
					step = i
					break
				end
			end
			if step == nil then
				return
			end
			local new_node = {name=names[step+1], param2=param2}
			if new_node.name == nil then
				new_node.name = full_grown
			end
			core.set_node(pos, new_node)
		end
}	)
end

-- ========= CORN =========
dofile(core.get_modpath("lottfarming") .. "/corn.lua")

-- ========= CARROT =========
dofile(core.get_modpath("lottfarming") .. "/carrots.lua")

-- ========= BERRIES =========
dofile(core.get_modpath("lottfarming") .. "/berries.lua")

-- ========= CABBAGE =========
dofile(core.get_modpath("lottfarming") .. "/cabbage.lua")

-- ========= ATHELAS =========
dofile(core.get_modpath("lottfarming") .. "/athelas.lua")

-- ========= POTATO =========
dofile(core.get_modpath("lottfarming") .. "/potato.lua")

-- ========= TOMATO =========
dofile(core.get_modpath("lottfarming") .. "/tomatoes.lua")

-- ========= TURNIP =========
dofile(core.get_modpath("lottfarming") .. "/turnips.lua")

-- ========= PIPEWEED =========
dofile(core.get_modpath("lottfarming") .. "/pipeweed.lua")

-- ========= MELON =========
dofile(core.get_modpath("lottfarming") .. "/melon.lua")

-- ========= BARLEY =========
dofile(core.get_modpath("lottfarming") .. "/barley.lua")

-- ========= PUMPKIN =========
dofile(core.get_modpath("lottfarming") .. "/pumpkin.lua")

-- ========= CRAFTS =========
dofile(core.get_modpath("lottfarming") .. "/crafting.lua")

-- ========= BROWN MUSHROOM =========
dofile(core.get_modpath("lottfarming") .. "/brown.lua")

-- ========= RED MUSHROOM =========
dofile(core.get_modpath("lottfarming") .. "/red.lua")

-- ========= BLUE MUSHROOM =========
dofile(core.get_modpath("lottfarming") .. "/blue.lua")

-- ========= GREEN MUSHROOM =========
dofile(core.get_modpath("lottfarming") .. "/green.lua")

-- ========= WHITE MUSHROOM =========
dofile(core.get_modpath("lottfarming") .. "/white.lua")

-- ========= ORC FOOD =========
dofile(core.get_modpath("lottfarming") .. "/orc_food.lua")

-- ========= OTHER =========
dofile(core.get_modpath("lottfarming") .. "/other.lua")

-- ========= OIL =========
dofile(core.get_modpath("lottfarming") .. "/oil.lua")
