local Type       = require('item_rank.Type')
local Collection = require('item_rank.Collection')
local config     = require('item_rank.config')


--- @class item_rank
--- @field Type     item_rank.Type
--- @field get      fun(code: string): item_rank.Rank
--- @field get_all  fun(): table<string, item_rank.Rank>
item_rank = {} -- luacheck: ignore unused global variable item_rank

local function register_api()
	item_rank = {
		--- @type item_rank.Type
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

--- Colorizes item title with rank color.
--- Runs after `tt` (see `optional_depends` in `mod.conf`), so title is taken from `_tt_original_description`
--- and snippets, appended by `tt`, are kept as is.
--- @param item_name string
--- @param item_def  ItemDefinition
--- @param rank      item_rank.Rank
local function colorize_title(item_name, item_def, rank)
	local description = item_def.description
	if not description or description == '' then return end

	local original = item_def._tt_original_description or description
	local snippets = description:sub(#original + 1)
	local title    = core.colorize(rank.color, original)

	core.override_item(item_name, {
		description              = title .. snippets,
		_tt_original_description = title,
	})
end

local function register_rank_handler()
	core.register_on_mods_loaded(function()
		for item_name, item_def in pairs(core.registered_items) do
			local rank = item_def._rank and Collection.get(item_def._rank)

			if rank and item_def._rank_autocolorize ~= false then
				colorize_title(item_name, item_def, rank)
			end
		end
	end)
end


return {
	--- @param mod core.Mod
	init = function(mod)
		register_api()
        register_item_rank()
        register_rank_handler()
	end,
}
