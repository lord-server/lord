local string_format, tostring, tonumber, pairs
    = string.format, tostring, tonumber, pairs

local DS = os.DIRECTORY_SEPARATOR


--- Minimal client version required by the server.
--- All values are resolved once in `init()`:
---  - the game minimum from `min_minetest_version` of `game.conf`;
---  - the server minimum from settings `lord_client.*`, which can only raise the game minimum.
--- @static
--- @class client.version.Requirement
local Requirement = {
	--- @static
	--- @type string
	DEFAULT_DOWNLOAD_URL = 'https://www.luanti.org/downloads/',
	--- @static
	--- @private
	--- @type helpers.Logger
	logger               = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- Minimal client version required by the game itself (client-side features we use).
	--- @static
	--- @type string
	game_min             = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @static
	--- @type integer
	game_min_protocol    = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @static
	--- @type string
	min                  = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @static
	--- @type integer
	min_protocol         = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @static
	--- @type string
	download_url         = nil, --- @diagnostic disable-line: assign-type-mismatch
}

--- @static
--- @param settings Voxrame.mod.Settings settings of the mod (`lord_client.*`)
--- @param logger   helpers.Logger
function Requirement.init(settings, logger)
	Requirement.logger = logger
	Requirement.game_min, Requirement.game_min_protocol = Requirement.read_game_min()
	Requirement.min, Requirement.min_protocol = Requirement.resolve_min(settings:get('min_version'))

	local download_url = settings:get('download_url')
	Requirement.download_url = (download_url and download_url ~= '') and download_url or Requirement.DEFAULT_DOWNLOAD_URL
end

--- `core.protocol_versions` lists only releases, which changed the protocol (e.g. `5.9.1` but not `5.15.2`),
--- so the protocol of the latest listed `X.Y.p` with `p <= Z` is used for `X.Y.Z`.
--- @static
--- @private
--- @param version string version like `"5.10"` or `"5.10.1"`
--- @return integer|nil protocol version of this client version or `nil` if version is unknown for the server
function Requirement.protocol_of(version)
	local major, minor, patch_string = version:match('^(%d+)%.(%d+)%.?(%d*)$')
	if not major then
		return nil
	end
	local patch = tonumber(patch_string) or 0

	local protocol, protocol_patch
	for listed_version, listed_protocol in pairs(core.protocol_versions) do
		local listed_major, listed_minor, listed_patch_string = listed_version:match('^(%d+)%.(%d+)%.(%d+)$')
		local listed_patch = tonumber(listed_patch_string)
		if
			listed_major == major and listed_minor == minor and listed_patch <= patch and
			(not protocol_patch or listed_patch > protocol_patch)
		then
			protocol, protocol_patch = listed_protocol, listed_patch
		end
	end

	return protocol
end

--- Reads `min_minetest_version` from `game.conf`.
--- @static
--- @private
--- @return string, integer minimal version required by the game and its protocol
function Requirement.read_game_min()
	local game_conf = Settings(core.get_game_info().path .. DS .. 'game.conf')
	local version   = game_conf:get('min_minetest_version')
	local protocol  = version and Requirement.protocol_of(version)
	if not protocol then
		error(string_format(
			'`min_minetest_version` in `game.conf` is not set or unknown for the server: %s', tostring(version)
		))
	end

	-- `version` is set, since `protocol` is resolved from it
	return version --[[@as string]], protocol
end

--- @static
--- @private
--- @param setting string|nil value of `lord_client.min_version`
--- @return string, integer minimal version and its protocol
function Requirement.resolve_min(setting)
	if not setting or setting == '' then
		return Requirement.game_min, Requirement.game_min_protocol
	end

	local setting_protocol = Requirement.protocol_of(setting)
	if not setting_protocol then
		Requirement.logger.warning(
			'Unknown version in `lord_client.min_version = %s`, using the game minimum %s.',
			setting, Requirement.game_min
		)

		return Requirement.game_min, Requirement.game_min_protocol
	end
	if setting_protocol < Requirement.game_min_protocol then
		Requirement.logger.warning(
			'`lord_client.min_version = %s` is lower than required by the game, using the game minimum %s.',
			setting, Requirement.game_min
		)

		return Requirement.game_min, Requirement.game_min_protocol
	end

	return setting, setting_protocol
end


return Requirement
