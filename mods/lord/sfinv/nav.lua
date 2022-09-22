
function sfinv.get_nav_fs(player, context, nav, current_idx)
    if current_idx then
	    return "tabheader[0,0;sfinv_nav_tabs;" .. table.concat(nav, ",") ..
				";" .. current_idx .. ";true;false]"
    else
        return "tabheader[0,0;sfinv_nav_tabs;" .. table.concat(nav, ",") ..
				";;true;false]"
    end
end

function sfinv.get_inventory_nav(player, context)
    context.page = sfinv.select_consistent_page(player, context)

	-- Generate navigation tabs
	local page_titles = {}
	local page_names = {}
    local current_page_idx = nil

    for name, pdef in pairs(sfinv.pages) do
		if not pdef.is_in_nav or pdef:is_in_nav(player, context) then
			page_titles[#page_titles + 1] = pdef.title
			page_names[#page_names + 1] = pdef.name
			if pdef.name == context.page then
				current_page_idx = #page_names
			end
		end
	end
	context.page_names = page_names
    return sfinv.get_nav_fs(player, context, page_titles, current_page_idx)
end

