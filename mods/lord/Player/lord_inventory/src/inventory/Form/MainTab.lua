local S = minetest.get_translator('lord_inventory')

local EXISTING_CRAFTING_IMAGE_LANG = { 'ru', 'en' }
local DEFAULT_CRAFTING_IMAGE_LANG  = 'en'

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
	.. 'image[0,0;1,1;lord_inventory_slot_helmet.png]'
	.. 'image[0,1;1,1;lord_inventory_slot_chestplate.png]'
	.. 'image[0,2;1,1;lord_inventory_slot_leggings.png]'
	.. 'image[0,3;1,1;lord_inventory_slot_boots.png]'
	.. 'list[detached:{{armor_slots}};armor;0,0;1,4;]'
	-- Clothes slots
	.. 'image[3,0;1,1;lord_inventory_slot_helmet.png]'
	.. 'image[3,1;1,1;lord_inventory_slot_shirt.png]'
	.. 'image[3,2;1,1;lord_inventory_slot_trousers.png]'
	.. 'image[3,3;1,1;lord_inventory_slot_shoes.png]'
	.. 'list[detached:{{clothing_slots}};clothing;3,0;1,4;]'
	.. 'image[4,0;1,1;lord_inventory_slot_cloak.png]'
	.. 'list[detached:{{clothing_slots}};clothing;4,0;1,1;4]'
	-- Preview & Shield
	.. 'image[1.16,0.25;2,4;{{preview}}]'
	.. 'image[2,2;1,1;lord_inventory_slot_shield.png]'
	.. 'list[detached:{{armor_slots}};armor;2,2;1,1;4]'
	-- Crafting
	.. 'image[5.05,0;3.5,1;{{crafting_image}}]'
	.. 'list[current_player;craft;4,1;3,3;]'
	.. 'list[current_player;craftpreview;7,2;1,1;]'
	-- Bags & Trash
	.. 'image_button[7,1;1,1;lord_inventory_bags_button.png;bags;]'
	.. 'image[7,3;1,1;lord_inventory_trash_slot.png]'
	.. 'list[detached:trash;main;7,3;1,1;]'
	-- Player inventory content
	.. 'list[current_player;main;0,4.25;8,1;]'
	.. 'list[current_player;main;0,5.5;8,3;8]'
	-- options
	.. 'listring[current_player;main]'
	.. 'listring[current_player;craft]'
--- /


--- @class inventory.Form.MainTab: base_classes.Form.Element.Tab
local MainTab = {
	title = S('Main'),
	--- @type inventory.Form parent form
	form  = nil,
	--- @type string
	template = formspec_template,
	--- @type string
	preview = ''
}
MainTab = base_classes.Form.Element.Tab:extended(MainTab)

--- @param preview
--- @return self|inventory.Form.MainTab
function MainTab:set_preview(preview)
	self.preview = preview

	return self
end

function MainTab:get_spec()
	local armor_inv_name = equipment.get_inventory_name(self.form.player_name, equipment.Kind.ARMOR)
	local clothing_inv_name = equipment.get_inventory_name(self.form.player_name, equipment.Kind.CLOTHING)
	local crafting_image_lang = table.contains(EXISTING_CRAFTING_IMAGE_LANG, self.form.player_lang)
		and self.form.player_lang
		or  DEFAULT_CRAFTING_IMAGE_LANG

	local formspec = self.template
	formspec = formspec:replace('{{armor_slots}}', armor_inv_name)
	formspec = formspec:replace('{{clothing_slots}}', clothing_inv_name)
	formspec = formspec:replace('{{preview}}', self.preview)
	formspec = formspec:replace('{{crafting_image}}', 'lord_inventory_crafting.' .. crafting_image_lang .. '.png')

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
