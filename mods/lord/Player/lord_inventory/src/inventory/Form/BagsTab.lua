local S = minetest.get_translator('lord_inventory')


--- @class inventory.Form.BagsTab: base_classes.Form.Element.Tab
local BagsTab = {
	--- @type string
	title = S('Bags'),
	--- @type inventory.Form parent form
	form  = nil,
	--- @type number currently opened bag or 0 if bags selection is opened
	current_bag = 0,
}
BagsTab = base_classes.Form.Element.Tab:extended(BagsTab)


function BagsTab:get_spec()
	local player_name = self.form.player_name
	local bag         = self.current_bag

	-- Form with bags selection
	if bag == 0 then
		return ''
			.. 'button[0,2;2,0.5;bag1;' .. S('Bag') .. ' 1]'
			.. 'button[2,2;2,0.5;bag2;' .. S('Bag') .. ' 2]'
			.. 'button[4,2;2,0.5;bag3;' .. S('Bag') .. ' 3]'
			.. 'button[6,2;2,0.5;bag4;' .. S('Bag') .. ' 4]'
			.. 'list[detached:' .. player_name .. '_bags;bag1;0.5,1;1,1;]'
			.. 'list[detached:' .. player_name .. '_bags;bag2;2.5,1;1,1;]'
			.. 'list[detached:' .. player_name .. '_bags;bag3;4.5,1;1,1;]'
			.. 'list[detached:' .. player_name .. '_bags;bag4;6.5,1;1,1;]'
			.. 'list[current_player;main;0,4.5 ;8,1; ]'
			.. 'list[current_player;main;0,5.75;8,3;8]'
	end

	-- Form with bag contents
	local player = minetest.get_player_by_name(player_name)
	local image = player:get_inventory():get_stack('bag' .. bag, 1):get_definition().inventory_image
	local bags_buttons = 'style_type[image_button;font=bold;textcolor=#fffb]'
	for i = 1, 4 do
		local button_image = player:get_inventory():get_stack('bag' .. i, 1):get_definition().inventory_image or ''
		bags_buttons = bags_buttons ..
			'image_button['..
				(1 + i) .. ',-0.125;1,0.83;' .. button_image .. ';bag'..i..';' .. i ..
			']'
	end

	return 'button[0,0;2,0.5;bags;' .. S('All Bags') .. ']'	.. bags_buttons	.. 'image[7,-0.15;1,1;' .. image .. ']'
		.. 'list[current_player;bag' .. bag .. 'contents;0,1;8,3;]'
		.. 'list[current_player;main;0,4.5 ;8,1; ]'
		.. 'list[current_player;main;0,5.75;8,3;8]'
		.. 'listring[current_player;bag' .. bag .. 'contents]'
		.. 'listring[current_player;main]'
end

--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function BagsTab:handle(fields)
	if fields.bags then
		self.current_bag = 0
		self.form:open()
		return true
	end

	for i = 1, 4 do
		local page = 'bag' .. i
		if fields[page] then
			self.current_bag = i
			local item_in_slot_definition = minetest.get_player_by_name(self.form.player_name)
				:get_inventory():get_stack(page, 1):get_definition()
			if item_in_slot_definition.groups.bagslots == nil then
				self.current_bag = 0
			end

			self.form:open()

			return true
		end
	end
end

--- @param joined_player Player
minetest.register_on_joinplayer(function(joined_player, last_login)
	local player_name = joined_player:get_player_name()
	local player_inv  = joined_player:get_inventory()

	local bags_inv    = minetest.create_detached_inventory(player_name .. '_bags', {
		on_put     = function(inv, list_name, index, stack, player)
			player:get_inventory():set_stack(list_name, index, stack)
			player:get_inventory():set_size(list_name .. 'contents', stack:get_definition().groups.bagslots)
		end,
		on_take    = function(inv, list_name, index, stack, player)
			player:get_inventory():set_stack(list_name, index, nil)
		end,
		allow_put  = function(inv, list_name, index, stack, player)
			if stack:get_definition().groups.bagslots then
				return 1
			else
				return 0
			end
		end,
		allow_take = function(inv, list_name, index, stack, player)
			if player:get_inventory():is_empty(list_name .. 'contents') == true then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	}, player_name)

	for i = 1, 4 do
		local bag = 'bag' .. i
		player_inv:set_size(bag, 1)
		bags_inv:set_size(bag, 1)
		bags_inv:set_stack(bag, 1, player_inv:get_stack(bag, 1))
	end
end)


return BagsTab
