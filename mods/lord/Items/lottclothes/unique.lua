local S = minetest.get_mod_translator()    
local event_cloak_message = minetest.colorize('#FFAA00', S('Cloak "Guardian of Minas Tirith"'))
local seasonable_collection_message = S('unique collection')
    
core.register_tool(':lord_clothes:uniq_cloak_guardian_of_minas_tirith', {
		description     = event_cloak_message .. '\n' .. seasonable_collection_message ,
		inventory_image = 'lord_clothes_uniq_cloak_guardian_of_minas_tirith_inv.png',
		groups          = { clothes = 1, no_preview = 1, clothes_cloak = 1 },
		wear            = 0,
})