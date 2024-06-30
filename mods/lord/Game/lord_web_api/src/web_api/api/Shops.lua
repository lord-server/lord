local ShopTransactions = require("web_api.api.Shops.Transactions")

local RESOURCE = '/shops'

--- @class web_api.api.Shops: http.Resource
local Shops = {
	resource = RESOURCE,
}

setmetatable(Shops, { __index = http.Resource })

function Shops:transactions()
	return ShopTransactions:new(self.client, self.resource)
end


return Shops
