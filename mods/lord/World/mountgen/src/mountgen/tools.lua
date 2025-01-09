local Form = require('mountgen.config.Form')


local S = minetest.get_mod_translator()


local function register_stick()
	minetest.register_tool('mountgen:mount_tool', {
		description = S('Mountain tool'),
		inventory_image = 'mountgen_tool.png',
		on_use = function(itemstack, placer, pointed_thing)
			local user_name = placer:get_player_name()
			local can_access = minetest.get_player_privs(user_name)[mountgen.required_priv]
			if not can_access then
				return
			end

			Form:new(placer):open(mountgen.config)
		end,
		group = {},
		on_drop = function(itemstack, dropper, pos)
			return
		end,
	})
end


return {
	register_stick = register_stick
}
