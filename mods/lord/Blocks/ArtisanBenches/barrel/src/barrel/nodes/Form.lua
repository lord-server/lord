local S = minetest.get_mod_translator()

--- @class barrel.node.Form: fuel_device.node.Form
local Form = {
	get_spec = function(type, percent, item_percent)
		assert(type:is_one_of({ 'active', 'inactive' }))
		percent = percent or 0
		--item_percent = item_percent or 0

		local bubbles_image = type == 'inactive'
			and 'image[4,2;1,1;benches_barrel_form_bubble.png]'
			or  'image[4,2;1,1;benches_barrel_form_bubble.png^[lowpart:' .. (percent) .. ':benches_form_bubble.png]'


		return 'size[8,9]' ..
			'label[0,0;' .. S('Barrel') .. ']' ..
			bubbles_image ..
			'image[3,2;1,1;benches_form_arrow.png]' ..
			'image[5,2;1,1;benches_form_arrow.png]' ..
			'label[2.9,3.2;' .. S('Fuel:') .. ']' ..
			'list[current_name;fuel;4,3;1,1;]' ..
			'label[1,1.5;' .. S('Ingredients:') .. ']' ..
			'list[current_name;src;1,2;2,1;]' ..
			'label[6,1.5;' .. S('Result:') .. ']' ..
			'list[current_name;dst;6,2;1,2;]' ..
			'list[current_player;main;0,5;8,4;]' ..
			'listring[current_name;fuel]' ..
			'listring[current_player;main]' ..
			'listring[current_name;src]' ..
			'listring[current_player;main]' ..
			'listring[current_name;dst]' ..
			'listring[current_player;main]'
	end
}


return Form
