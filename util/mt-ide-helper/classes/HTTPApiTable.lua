--- @diagnostic disable: missing-return


--- @class HTTPRequestHandle

--- @class HTTPApiTable
local HTTPApiTable = {}

--- Performs given request asynchronously and calls callback upon completion.
--- Use this HTTP function if you are unsure, the others are for advanced use.
---
--- @param request HTTPRequest
--- @param callback fun(result:HTTPRequestResult)
function HTTPApiTable:fetch(request, callback) end

--- Performs given request asynchronously and returns handle for `HTTPApiTable.fetch_async_get()`.
---
--- @param request HTTPRequest
--- @return HTTPRequestHandle
function HTTPApiTable:fetch_async(request) end
--- Return response data for given asynchronous HTTP request.
---
--- @param handle HTTPRequestHandle
--- @return HTTPRequestResult
function HTTPApiTable:fetch_async_get(handle) end

