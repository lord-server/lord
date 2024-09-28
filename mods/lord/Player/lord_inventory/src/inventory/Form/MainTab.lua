local S = minetest.get_translator('lord_inventory')


--- Trash / Recycle Bin
local detached_inv_trash = minetest.create_detached_inventory('trash', {
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put    = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, '')
	end,
})
detached_inv_trash:set_size('main', 1)
--- /

--- Form Spec Template
local formspec_template = ''
    -- Armor slots
	.. 'image[0,0;1,1;lottarmor_helmet.png]'
	.. 'image[0,1;1,1;lottarmor_chestplate.png]'
	.. 'image[0,2;1,1;lottarmor_leggings.png]'
	.. 'image[0,3;1,1;lottarmor_boots.png]'
	.. 'list[detached:{{armor_slots}};armor;0,0;1,4;]'
	-- Clothes slots
	.. 'image[3,0;1,1;lottarmor_helmet.png]'
	.. 'image[3,1;1,1;lottarmor_shirt.png]'
	.. 'image[3,2;1,1;lottarmor_trousers.png]'
	.. 'image[3,3;1,1;lottarmor_shoes.png]'
	.. 'list[detached:{{clothing_slots}};clothing;3,0;1,4;]'
	.. 'image[4,0;1,1;lottarmor_cloak.png]'
	.. 'list[detached:{{clothing_slots}};clothing;4,0;1,1;4]'
	-- Preview & Shield
	.. 'image[1.16,0.25;2,4;{{armor_preview}}]'
	.. 'image[2,2;1,1;lottarmor_shield.png]'
	.. 'list[detached:{{armor_slots}};armor;2,2;1,1;4]'
	-- Crafting
	.. 'image[5.05,0;3.5,1;lottarmor_crafting.png]'
	.. 'list[current_player;craft;4,1;3,3;]'
	.. 'list[current_player;craftpreview;7,2;1,1;]'
	-- Bags & Trash
	.. 'image_button[7,1;1,1;bags.png;bags;]'
	.. 'image[7,3;1,1;lottarmor_trash.png]'
	.. 'list[detached:trash;main;7,3;1,1;]'
	-- Player inventory content
	.. 'list[current_player;main;0,4.25;8,1;]'
	.. 'list[current_player;main;0,5.5;8,3;8]'
	-- options
	.. 'listring[current_player;main]'
	.. 'listring[current_player;craft]'
--- /


--- @class inventory.Form.MainTab: base_classes.Form.Element.Tab
local MainTab = base_classes.Form.Element.Tab:extended({
	title = S('Main'),
	--- @type inventory.Form parent form
	form  = nil,
	--- @type string
	template = formspec_template,
	--- @type string
	preview = ''
})

--- @param preview
--- @return self|inventory.Form.MainTab
function MainTab:set_preview(preview)
	self.preview = preview

	return self
end

function MainTab:get_spec()
	local armor_inv_name = equipment.get_inventory_name(self.form.player_name, equipment.Kind.ARMOR)
	local clothing_inv_name = equipment.get_inventory_name(self.form.player_name, equipment.Kind.CLOTHING)
	local formspec = self.template
	formspec = formspec:replace('{{armor_slots}}', armor_inv_name)
	formspec = formspec:replace('{{clothing_slots}}', clothing_inv_name)
	formspec = formspec:replace('{{armor_preview}}', self.preview)

	return formspec
end

--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function MainTab:handle(fields)
	if fields.bags then
		self.form:switch_tab(self.form.tab.BAGS)
		return true
	end
end


return MainTab
