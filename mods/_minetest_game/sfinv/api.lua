
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
    context = context or sfinv.get_or_create_context(player)
	local fs = sfinv.build_sfinv_formspec(player, context)
	player:set_inventory_formspec(fs)
end

-- for compatibility purposes
function sfinv.make_formspec(_player, _context, content, _show_inv)
	return content
end
