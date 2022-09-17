sfinv.pages = {}

function sfinv.register_page(name, def)
	assert(name, "Invalid sfinv page. Requires a name")
	assert(def, "Invalid sfinv page. Requires a def[inition] table")
	assert(def.get, "Invalid sfinv page. Def requires a get function.")
	assert(not sfinv.pages[name], "Attempt to register already registered sfinv page " .. dump(name))

	sfinv.pages[name] = def
	def.name = name
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
    sfinv.pages[name] = nil
end

function sfinv.get_page_content(player, context)
    context.page = sfinv.select_consistent_page(player, context)
	if context.page == nil then
		minetest.log("error", "Can not select inventory page for player "..player:get_player_name())
        return ""
    end

	-- Generate formspec
	local page = sfinv.pages[context.page]
    local content = page:get(player, context)
    return content
end

function sfinv.get_homepage_name(player)
	return nil
end
