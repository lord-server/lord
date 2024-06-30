local RESOURCE = '/transactions'

--- @class web_api.api.Clans.Transactions: http.Resource
local Transactions = {}
setmetatable(Transactions, { __index = http.Resource })

--- @param client              http.Client
--- @param parent_resource_url string
function Transactions:new(client, parent_resource_url)
	return http.Resource.new(self, client, parent_resource_url .. RESOURCE)
end


return Transactions
