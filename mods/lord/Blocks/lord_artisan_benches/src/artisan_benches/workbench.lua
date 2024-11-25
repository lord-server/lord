-- luacheck:ignore 561
-- Отключена проверка на цикломатическую сложность, поскольку
-- mods/lord/Blocks/castle/town_item.lua:152:20: cyclomatic complexity of function get_recipe is too high (14 > 10)
local S = minetest.get_mod_translator()


minetest.register_alias('castle:workbench', 'lord_artisan_benches:workbench')


local get_recipe = function(inv)
	local result, needed, input
	needed          = inv:get_list('rec')

	result, input   = minetest.get_craft_result({
		method = 'normal',
		width  = 3,
		items  = needed
	})

	if result.item:is_empty() then
		return needed, input, nil
	end

	local totalneed = {}
	result = result.item
	for _, item in ipairs(needed) do
		if item ~= nil and not item:is_empty() and not inv:contains_item('src', item) then
			result = nil
			break
		end
		if item ~= nil and not item:is_empty() then
			if totalneed[item:get_name()] == nil then
				totalneed[item:get_name()] = 1
			else
				totalneed[item:get_name()] = totalneed[item:get_name()] + 1
			end
		end
	end
	for name, number in pairs(totalneed) do
		local totallist = inv:get_list('src')
		for i, srcitem in pairs(totallist) do
			if srcitem:get_name() == name then
				local taken  = srcitem:take_item(number)
				number       = number - taken:get_count()
				totallist[i] = srcitem
			end
			if number <= 0 then
				break
			end
		end
		if number > 0 then
			result = nil
			break
		end
	end


	return needed, input, result
end

local workbench_formspec = 'size[8,9;]' ..
	'label[0,0;' .. S('Source Material') .. ']' ..
	'list[context;src;0,0.5;2,4;]' ..
	'label[3.5,0.5;' .. S('Recipe to Use') .. ']' ..
	'list[context;rec;2.5,1;3,3;]' ..
	'label[6,0;' .. S('Craft Output') .. ']' ..
	'list[context;dst;6,0.5;2,4;]' ..
	'list[current_player;main;0,5;8,4;]'..
	'listring[current_player;main]'..
	'listring[context;src]'..
	'listring[current_player;main]'..
	'listring[context;dst]'


minetest.register_lbm({
	label = "workbench formspec replacement",
	name = ":castle:workbench_formspec_replacement",
	nodenames = {"lord_artisan_benches:workbench"},
	run_at_every_load = true,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		meta:set_string('formspec', workbench_formspec)
	end
})

minetest.register_node("lord_artisan_benches:workbench", {
	description                   = S("Workbench"),
	drawtype                      = "mesh",
	mesh = "workbench.obj",
	tiles = { "benches_workbench.png" },
	--tiles                         = {
	--	"benches_workbench_top.png",
	--	"default_wood.png",
	--	"benches_workbench_1.png",
	--	"benches_workbench_1.png",
	--	"benches_workbench_2.png",
	--	"benches_workbench_2.png"
	--},
	paramtype2                    = "facedir",
	paramtype                     = "light",
	groups                        = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wooden = 1 },
	sounds                        = default.node_sound_wood_defaults(),
	on_construct                  = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('formspec', workbench_formspec)
		meta:set_string('infotext', S('Workbench'))
		local inv = meta:get_inventory()
		inv:set_size('src', 2 * 4)
		inv:set_size('rec', 3 * 3)
		inv:set_size('dst', 2 * 4)
	end,
	can_dig                       = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory()
		return inv:is_empty("src") and inv:is_empty("dst") and inv:is_empty("rec")
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			minetest.log("action", player:get_player_name() ..
				" attempt moves stuff in workbench at " .. minetest.pos_to_string(pos))
			return 0
		end
		minetest.log("action", player:get_player_name() ..
			" moves stuff in workbench at " .. minetest.pos_to_string(pos))
		return count
	end,
	allow_metadata_inventory_put  = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			minetest.log("action", player:get_player_name() ..
				" attempt moves stuff to workbench at " .. minetest.pos_to_string(pos))
			return 0
		end
		minetest.log("action", player:get_player_name() ..
			" moves stuff to workbench at " .. minetest.pos_to_string(pos))
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			minetest.log("action", player:get_player_name() ..
				" attempt takes stuff from workbench at " .. minetest.pos_to_string(pos))
			return 0
		end
		minetest.log("action", player:get_player_name() ..
			" takes stuff from workbench at " .. minetest.pos_to_string(pos))
		return stack:get_count()
	end,
	-- allow_metadata_inventory_put = function(pos, listname, index, stack, player)
	-- end,
	-- allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	-- end,
	-- allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	-- end,
})

minetest.register_abm({
	nodenames = { 'lord_artisan_benches:workbench' },
	interval  = 5,
	chance    = 1,
	action    = function(pos, node)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		local result, newinput, needed
		if not inv:is_empty('src') then
			-- Check for a valid recipe and sufficient resources to craft it
			needed, newinput, result = get_recipe(inv)
			if result ~= nil and inv:room_for_item('dst', result) then
				inv:add_item('dst', result)
				for i, item in pairs(needed) do
					if item ~= nil and item ~= '' then
						inv:remove_item('src', ItemStack(item))
					end
					if newinput[i] ~= nil and not newinput[i]:is_empty() then
						inv:add_item('src', newinput[i])
					end
				end
			end
		end
	end
})

minetest.register_craft({
	output = "lord_artisan_benches:workbench",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "default:wood", "default:wood", "default:steel_ingot" },
		{ "default:tree", "default:tree", "default:steel_ingot" },
	}
})
