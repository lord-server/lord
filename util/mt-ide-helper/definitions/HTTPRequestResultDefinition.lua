--- Passed to `HTTPApiTable.fetch` callback. Returned by `HTTPApiTable.fetch_async_get`.
---@class HTTPRequestResult: table
local HTTPRequestResult = {
	---@type boolean @If true, the request has finished (either succeeded, failed or timed out)
    completed = true,

	---@type boolean @If true, the request was successful
    succeeded = true,

	---@type boolean @If true, the request timed out
    timeout = false,

	---@type number @HTTP status code
    code = 200,

	---@type string
    data = "response",
}
