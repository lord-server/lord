--- Used by `HTTPApiTable.fetch` and `HTTPApiTable.fetch_async`.
---@class HTTPRequest: table
local HTTPRequest = {
	---@type string? @The URL to fetch. [required]
    url = "http://example.org",

	---@type number? @Timeout for request to be completed in seconds. Default depends on engine settings.
    timeout = 10,

	---@type string? @`"GET"`, `"POST"`, `"PUT"` or `"DELETE"`. The http method to use. Defaults to "GET".
    method = "GET",

	--- Data for the POST, PUT or DELETE request.
    --- Accepts both a string and a table. If a table is specified, encodes
    --- table as x-www-form-urlencoded key-value pairs.
	---@type (string|table)? @`"Raw request data string"` or `{field1 = "data1", field2 = "data2"}`
    data = "example raw request",

	---@type string? @Optional, if specified replaces the default minetest user agent with given string
    user_agent = "ExampleUserAgent",

	---@type table? @Optional, if specified adds additional headers to the HTTP request. You must make sure that the
	--- header strings follow HTTP specification  (`"Key: Value"`).
    extra_headers = { "Accept-Language: en-us", "Accept-Charset: utf-8" },

	--- Default is false.
    --- Post only, data must be array
	---@type boolean? @Optional, if true performs a multipart HTTP request.
    multipart = false,

	--- Deprecated, use `data` instead. Forces `method = "POST"`.
	---@type (string|table)? @`"Raw POST request data string"` or `{field1 = "data1", field2 = "data2"}`
    post_data = "Raw POST request data string",
}
