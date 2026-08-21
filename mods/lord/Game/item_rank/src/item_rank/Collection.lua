
--- @class item_rank.Collection
local Collection = {
	--- @type table <string, item_rank.Rank>
	all = {},
}

--- @static
--- @param rank item_rank.Rank
function Collection.add(rank)
	Collection.all[rank.code] = rank
end

--- @static
--- @param code string
--- @return item_rank.Rank
function Collection.get(code)
	return Collection.all[code]
end


return Collection
