local Collection = require('item_collection.Collection')
local Registry   = require('item_collection.Registry')


--- @class item_collection.Definition
--- @field title string      translated title, displayed in item tooltip.
--- @field color string|nil  color of the title in item tooltip (default: `item_collection.Collection.DEFAULT_COLOR`).

--- @class item_collection
--- @field register fun(id: string, definition: item_collection.Definition): item_collection.Collection
--- @field get      fun(id: string): item_collection.Collection|nil
--- @field get_all  fun(): table<string, item_collection.Collection>
item_collection = {} -- luacheck: ignore unused global variable item_collection

local function register_api()
	item_collection = {
		--- @param id         string one of `item_collection.Id.<CONST>`
		--- @param definition item_collection.Definition
		--- @return item_collection.Collection
		register = function(id, definition)
			local collection = Collection:new(id, definition.title, definition.color)
			Registry.add(collection)

			return collection
		end,
		--- @param id string
		--- @return item_collection.Collection|nil
		get      = function(id)
			return Registry.get(id)
		end,
		--- @return table<string, item_collection.Collection>
		get_all  = function()
			return Registry.all
		end,
	}

	--- Ids of registered collections. Each mod adds its own constants before registering the collection:
	--- ```lua
	--- item_collection.Id.CHRISTMAS = 'christmas'
	--- item_collection.register(item_collection.Id.CHRISTMAS, { title = S('Christmas collection') })
	--- ```
	--- @class item_collection.Id
	item_collection.Id = {}
end


return {
	init = function()
		register_api()
	end,
}
