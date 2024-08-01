-- ------------------------------------------------------------------ --
-- Just fully copied from `tt_base` mod. Needs some refactor & remake --
-- ------------------------------------------------------------------ --
local S = minetest.get_translator(minetest.get_current_modname())


local function newline(str)
	if str ~= "" then
		str = str .. "\n"
	end
	return str
end


return function(itemstring)
	local def = minetest.registered_items[itemstring]
	local desc = ""

	-- Health-related node facts
	if def.damage_per_second then
		if def.damage_per_second > 0 then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DANGER, S("Contact damage: @1 per second", def.damage_per_second))
		elseif def.damage_per_second < 0 then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_GOOD, S("Contact healing: @1 per second", math.abs(def.damage_per_second)))
		end
	end
	if def.drowning and def.drowning ~= 0 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DANGER, S("Drowning damage: @1", def.drowning))
	end
	local tmp = minetest.get_item_group(itemstring, "fall_damage_add_percent")
	if tmp > 0 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DANGER, S("Fall damage: +@1%", tmp))
	elseif tmp == -100 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_GOOD, S("No fall damage"))
	elseif tmp < 0 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Fall damage: @1%", tmp))
	end

	-- Movement-related node facts
	if minetest.get_item_group(itemstring, "disable_jump") == 1 and not def.climbable then
		if def.liquidtype == "none" then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No jumping"))
		elseif minetest.get_item_group(itemstring, "fake_liquid") == 0 then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No swimming upwards"))
		else
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No rising"))
		end
	end
	if def.climbable then
		if minetest.get_item_group(itemstring, "disable_jump") == 1 then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Climbable (only downwards)"))
		else
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Climbable"))
		end
	end
	if minetest.get_item_group(itemstring, "slippery") >= 1 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Slippery"))
	end
	tmp = minetest.get_item_group(itemstring, "bouncy")
	if tmp >= 1 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Bouncy (@1%)", tmp))
	end
	if desc == "" then
		desc = nil
	end
	return desc, false
end
