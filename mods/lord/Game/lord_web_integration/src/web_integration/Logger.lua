
--- @static
--- @class web_integration.Logger:helpers.Logger
local Logger = {}

function Logger.extend(base_logger)
	Logger = table.overwrite(base_logger, Logger)

	return Logger
end

--- @static
--- @param result HTTPRequestResult
function Logger.log_api_error(result)
	Logger.error("API call error: [%s] %s", result.code, dump(result))
end


return Logger
