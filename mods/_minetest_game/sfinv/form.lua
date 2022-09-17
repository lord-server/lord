minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" or not sfinv.enabled then
		return false
	end

	-- Get Context
	local name = player:get_player_name()
	local context = sfinv.contexts[name]
	if not context then
		minetest.log("error", "Can not find context for player "..name)
		return false
	end

	-- Was a tab selected?
	if fields.sfinv_nav_tabs then
		local tid = tonumber(fields.sfinv_nav_tabs)
		if tid and tid > 0 then
			local name = context.page_names[tid]
            if name then
			    local page = sfinv.pages[name]
			    if page then
				    sfinv.set_page(player, name)
                end
			end
		end
	else
		-- Pass event to page
		local page = sfinv.pages[context.page]
		if page and page.on_player_receive_fields then
			return page:on_player_receive_fields(player, context, fields)
		end
	end
end)

function sfinv.build_sfinv_formspec(player, context, content, size)
	local tmp = {
		size or "size[8,9.1]",
		sfinv.get_inventory_nav(player, context),
		sfinv.get_page_content(player, context),
	}

	local fs = table.concat(tmp, "")
	return fs
end

