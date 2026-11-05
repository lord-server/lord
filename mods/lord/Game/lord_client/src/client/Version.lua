local setmetatable, tostring
    = setmetatable, tostring

local Requirement = require('client.version.Requirement')


--- Version of a client.
--- @class client.Version
local Version = {
	--- @type PlayerInformation
	info = nil, --- @diagnostic disable-line: assign-type-mismatch
}

--- @param info PlayerInformation
--- @return client.Version
function Version:new(info)
	local class = self

	self = {
		info = info,
	}

	return setmetatable(self, { __index = class })
end

--- @return integer
function Version:protocol()
	return self.info.protocol_version
end

--- Full version string reported by the client (e.g. `"5.17.0-dev-a1b2c3d4e"`).
--- @return string
function Version:string()
	return tostring(self.info.version_string)
end

--- Only numeric part of the version (e.g. `"5.17.0"`) or the full string, if it has no numeric part.
--- @return string
function Version:number()
	local version = self:string()

	return version:match('^%d+%.%d+%.%d+') or version
end

--- Whether the client is older than the minimal version required by the server.
--- @return boolean
function Version:is_outdated()
	return self:protocol() < Requirement.min_protocol
end


return Version
