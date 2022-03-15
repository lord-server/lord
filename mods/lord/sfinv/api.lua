sfinv = {
	pages = {},
	pages_unordered = {},
	contexts = {},
	enabled = true,
}

function sfinv.register_page(name, def)
	assert(name, "Invalid sfinv page. Requires a name")
	assert(def, "Invalid sfinv page. Requires a def[inition] table")
	assert(def.get, "Invalid sfinv page. Def requires a get function.")
	assert(not sfinv.pages[name], "Attempt to register already registered sfinv page " .. dump(name))

	minetest.log("Registering inventory page \""..name.."\"")

	sfinv.pages[name] = def
	def.name = name
	table.insert(sfinv.pages_unordered, def)

	if def.mainpage then
		sfinv.mainpage = name
	end
end

function sfinv.override_page(name, def)
	assert(name, "Invalid sfinv page override. Requires a name")
	assert(def, "Invalid sfinv page override. Requires a def[inition] table")
	local page = sfinv.pages[name]
	assert(page, "Attempt to override sfinv page " .. dump(name) .. " which does not exist.")
	for key, value in pairs(def) do
		page[key] = value
	end
end

function sfinv.unregister_page(name)
	assert(name, "Invalid sfinv page. Requires a name")
	sfinf.pages[name] = nil
end

function sfinv.get_nav_fs(player, context, nav, current_idx)
	-- Only show tabs if there is more than one page
	print("tabheaders = "..dump(nav))
	--if #nav > 1 then
		return "tabheader[0,0;sfinv_nav_tabs;" .. table.concat(nav, ",") ..
				";" .. current_idx .. ";true;false]"
	--else
	--	return ""
	--end
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

function sfinv.make_formspec(player, context, content, show_inv, size)
	local tmp = {
		size or "size[8,9.1]",
		sfinv.get_nav_fs(player, context, context.nav_titles, context.nav_idx),
		show_inv and theme_inv or "",
		content
	}
	local res = table.concat(tmp, "")
	print(res)
	return res
end

function sfinv.get_formspec(player, context)
	-- Generate navigation tabs
	local nav = {}
	local nav_ids = {}
	local current_idx = ""
	for i, pdef in pairs(sfinv.pages_unordered) do
		if not pdef.is_in_nav or pdef:is_in_nav(player, context) then
			nav[#nav + 1] = pdef.title
			nav_ids[#nav_ids + 1] = pdef.name
			if pdef.name == context.page then
				current_idx = #nav_ids
			end
		end
	end

	context.nav = nav_ids
	context.nav_titles = nav
	context.nav_idx = current_idx

	-- Generate formspec
	local page = sfinv.pages[context.page]
	return page:get(player, context)
end

function sfinv.get_mainpage_name(player)
	if sfinv.mainpage then
		return sfinv.mainpage
	end
	for name, pdef in pairs(sfinv.pages) do
		local context = {}
		if (not pdef.is_in_nav) or pdef:is_in_nav(player, context) then
			return name
		end
	end
	return nil
end

function sfinv.get_or_create_context(player)
	local name = player:get_player_name()
	local context = sfinv.contexts[name]
	if not context then
		context = {
			page = sfinv.get_mainpage_name(player)
		}
		sfinv.contexts[name] = context
	end
	return context
end

function sfinv.set_context(player, context)
	sfinv.contexts[player:get_player_name()] = context
end

function sfinv.set_player_inventory_formspec(player, context)
	local fs = sfinv.get_formspec(player,
			context or sfinv.get_or_create_context(player))
	player:set_inventory_formspec(fs)
end

function sfinv.set_page(player, pagename)
	local page = sfinv.pages[pagename]
	if not page then
		return
	end
	local context = sfinv.get_or_create_context(player)
	local oldpage = sfinv.pages[context.page]
	if oldpage and oldpage.on_leave then
		oldpage:on_leave(player, context)
	end
	context.page = pagename
	if page.on_enter then
		page:on_enter(player, context)
	end

	print("SELECT PAGE "..pagename)
	sfinv.set_player_inventory_formspec(player, context)
end

function sfinv.invalidate_page(player, pagename)
	local context = sfinv.get_or_create_context(player)
	local current_page = context.page

	if pagename == current_page then
		sfinv.set_player_inventory_formspec(player, context)
	end
end

function sfinv.get_page(player)
	local context = sfinv.contexts[player:get_player_name()]
	return context and context.page or sfinv.get_homepage_name(player)
end

minetest.register_on_joinplayer(function(player)
	sfinv.contexts[player:get_player_name()] = nil
	for name, def in pairs(sfinv.pages) do
		sfinv.invalidate_page(player, name)
	end
end)

minetest.register_on_leaveplayer(function(player)
	sfinv.contexts[player:get_player_name()] = nil
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" or not sfinv.enabled then
		return false
	end

	-- Get Context
	local name = player:get_player_name()
	local context = sfinv.contexts[name]
	if not context then
		sfinv.set_player_inventory_formspec(player)
		return false
	end

	local result = nil

	-- Was a tab selected?
	if fields.sfinv_nav_tabs and context.nav then
		local tid = tonumber(fields.sfinv_nav_tabs)
		if tid and tid > 0 then
			local id = context.nav[tid]
			local page = sfinv.pages[id]
			if id and page then
				sfinv.set_page(player, id)
			end
		end
		return
	else
		-- Pass event to page
		local page = sfinv.pages[context.page]
		if page and page.on_player_receive_fields then
			result = page:on_player_receive_fields(player, context, fields)
		end
	end


	if fields["quit"] then
		local pdef = sfinv.pages[context.page]
		if pdef.is_in_nav and not pdef:is_in_nav(player, context) then
			local page = sfinv.get_mainpage_name(player)
			sfinv.set_page(player, page)
		end
	end
	return result
end)
