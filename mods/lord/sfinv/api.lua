
function sfinv.set_player_inventory_formspec(player, context)
	context = context or sfinv.get_or_create_context(player)
	local fs = sfinv.build_sfinv_formspec(player, context)
	player:set_inventory_formspec(fs)
end

function sfinv.set_page(player, pagename)
	local context = sfinv.get_or_create_context(player)
	local oldpage = sfinv.pages[context.page]
	if oldpage and oldpage.on_leave then
		oldpage:on_leave(player, context)
	end
	context.page = pagename
	context.page = sfinv.select_consistent_page(player, context)
	local page = sfinv.pages[pagename]
	if page.on_enter then
		page:on_enter(player, context)
	end
	sfinv.set_player_inventory_formspec(player, context)
end

function sfinv.get_page(player)
	local context = sfinv.contexts[player:get_player_name()]
	context.page = sfinv.select_consistent_page(player, context)
	return context.page
end

minetest.register_on_joinplayer(function(player)
	if sfinv.enabled then
		sfinv.set_player_inventory_formspec(player)
	end
end)

minetest.register_on_leaveplayer(function(player)
	sfinv.contexts[player:get_player_name()] = nil
end)

function sfinv.update_player(player)
    local context = sfinv.get_or_create_context(player)
	local fs = sfinv.build_sfinv_formspec(player, context)
	player:set_inventory_formspec(fs)
end

local theme_inv = [[
	image[0,5.2;1,1;gui_hb_bg.png]
	image[1,5.2;1,1;gui_hb_bg.png]
	image[2,5.2;1,1;gui_hb_bg.png]
	image[3,5.2;1,1;gui_hb_bg.png]
	image[4,5.2;1,1;gui_hb_bg.png]
	image[5,5.2;1,1;gui_hb_bg.png]
	image[6,5.2;1,1;gui_hb_bg.png]
	image[7,5.2;1,1;gui_hb_bg.png]
	list[current_player;main;0,5.2;8,1;]
	list[current_player;main;0,6.35;8,3;8]
]]


-- for compatibility purposes
function sfinv.make_formspec(_player, _context, content, show_inv)
	local inv = ""
	if show_inv then
		inv = theme_inv
	end
	return content .. inv
end

function sfinv.get_homepage_name(player)
	return nil
end
