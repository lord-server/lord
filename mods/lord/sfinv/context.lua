sfinv.contexts = {}


function sfinv.get_or_create_context(player)
	local name = player:get_player_name()
	local context = sfinv.contexts[name]
	if not context then
		context = {
			page = sfinv.get_homepage_name(player)
		}
		sfinv.contexts[name] = context
	end
	return context
end

function sfinv.set_context(player, context)
	sfinv.contexts[player:get_player_name()] = context
end

function sfinv.check_context_consistency(player, context)
    local pdef = sfinv.pages[context.page]
    if not pdef then
        return false
    end
    if not pdef.is_in_nav or pdef:is_in_nav(player, context) then
        return true
    end
    return false
end

function sfinv.select_consistent_page(player, context)
    if sfinv.check_context_consistency(player, context) then
        return context.page
    end
    -- select first available
    for name, pdef in pairs(sfinv.pages) do
        if not pdef.is_in_nav or pdef:is_in_nav(player, context) then
            return name
        end
    end
    -- if no available page - nil
    return nil
end
