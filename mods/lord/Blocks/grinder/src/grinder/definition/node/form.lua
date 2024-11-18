

return {
	--- Returns form specification for Grinder.
	---
	--- @param type         string one of 'active'|'inactive' strings
	--- @param percent      number|nil pass only for active grinder
	--- @param item_percent number|nil pass only for active grinder
	---
	--- @return string form specification
	get_spec = function(type, percent, item_percent)
		assert(type:is_one_of({ 'active', 'inactive' }))

		local imageSpec =
			type == 'active'
				and
					'image[' ..
						'5.25,1.1;' ..
						'1,1;' ..
						'default_furnace_inv.png^' ..
						'default_furnace_fire_bg.png^' ..
						'[lowpart:' .. (100 - percent) .. ':default_furnace_fire_fg.png]' ..
					'image[' ..
						'1.5,1.6;' ..
						'1,1;' ..
						'gui_furnace_arrow_bg.png^' ..
						'[lowpart:' .. (item_percent) .. ':gui_furnace_arrow_fg.png^[transformR180]'
				or
					'image[5.25,1.1;1,1;default_furnace_inv.png^default_furnace_fire_bg.png]'
		;

		return 'size[8,9]' ..
				imageSpec ..
				'list[current_name;fuel;5.25,2.1;1,1;]' ..
				'list[current_name;src;1.5,0.5;1,1;]' ..
				'list[current_name;dst;1,3.5;2,1;]' ..
				'list[current_name;dst;1,2.5;2,1;2]' ..
				'list[current_player;main;0,5;8,4;]' ..
				'listring[current_name;fuel]' ..
				'listring[current_player;main]' ..
				'listring[current_name;src]' ..
				'listring[current_player;main]' ..
				'listring[current_name;dst]' ..
				'listring[current_player;main]' ..
				'background[-0.5,-0.65;9,10.35;gui_grinderbg.png]' ..
				'listcolors[#606060AA;#888;#141318;#30434C;#FFF]'
	end
}
