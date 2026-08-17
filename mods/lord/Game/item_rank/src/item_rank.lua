local Type = require('item_rank.Type')
local Collection = require('item_rank.Collection')
local config = require('item_rank.config')


item_rank = {} -- luacheck: ignore unused global variable item_rank

local function register_api()
	_G.item_rank = {
        Type = Type,
        --- @param code string
        --- @return item_rank.Rank
        get = function(code)
            return Collection.get(code)
        end,
        --- @return table <string, item_rank.Rank>
        get_all = function()
            return Collection.all
        end
    }
end

local function register_item_rank()
	for code, rank in pairs(config) do
        Collection.add(rank)
	end
end

local function register_rank_handler()
    core.register_on_mods_loaded(function()
        for item_name, item_def in pairs(core.registered_items) do
            local _rank = item_def._rank

            if _rank then
                local rank = Collection.get(_rank)
                if rank and item_def.description then
                    local title, description = item_def.description:match('^([^\n]*)(.*)$')
                    if title then
                        core.override_item(item_name,{
                            description = core.colorize(rank.color, title) .. description
                        })
                    end
                end
            end
        end
    end)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
        register_item_rank()
        register_rank_handler()
	end,
}
