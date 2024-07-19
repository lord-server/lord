
--- @return string returns the currently loading mod's name, when loading a mod.
function minetest.get_current_modname() end

--- Returns the directory path for a mod, e.g. "/home/user/.minetest/usermods/modname".
---  - Returns nil if the mod is not enabled or does not exist (not installed).
---  - Works regardless of whether the mod has been loaded yet.
---  - Useful for loading additional `.lua` modules or static data from a mod, or checking if a mod is enabled.
--- @param mod_name string
--- @return string
function minetest.get_modpath(mod_name) end

--- Returns a list of enabled mods, sorted alphabetically.
---  - Does not include disabled mods, even if they are installed.
--- @return table
function minetest.get_modnames() end

--- @class GameInfo
--- @field id     string
--- @field title  string
--- @field author string
--- @field path   string The root directory of the game.

--- Returns a table containing information about the current game.
--- Note that other meta information (e.g. version/release number)
---    can be manually read from `game.conf` in the game's root directory.
---
--- @return GameInfo
function minetest.get_game_info() end

--- Returns e.g. "/home/user/.minetest/world"
---  - Useful for storing custom data
--- @return string
function minetest.get_worldpath() end

--- Returns e.g. "/home/user/.minetest/mod_data/mymod"
---  - Useful for storing custom data independently of worlds.
---  - Must be called during mod load time.
---  - Can read or write to this directory at any time.
---  - It's possible that multiple Minetest instances are running at the same time, which may lead to corruption if you are not careful.
--- @return string
function minetest.get_mod_data_path() end

--- @return boolean
function minetest.is_singleplayer() end


--- Table containing API feature flags
--- @type table
minetest.features = {
	--- @since 0.4.7
	glasslike_framed = true,
	--- @since 0.4.7
	nodebox_as_selectionbox = true,
	--- @since 0.4.7
	get_all_craft_recipes_works = true,
	--- The transparency channel of textures can optionally be used on nodes
	--- @since 0.4.7
	use_texture_alpha = true,
	--- Tree and grass ABMs are no longer done from C++
	--- @since 0.4.8
	no_legacy_abms = true,
	--- Texture grouping is possible using parentheses
	--- @since 0.4.11
	texture_names_parens = true,
	--- Unique Area ID for AreaStore:insert_area
	--- @since 0.4.14
	area_store_custom_ids = true,
	--- add_entity supports passing initial staticdata to on_activate
	--- @since 0.4.16
	add_entity_with_staticdata = true,
	--- Chat messages are no longer predicted
	--- @since 0.4.16
	no_chat_message_prediction = true,
	--- The transparency channel of textures can optionally be used on
	--- objects (ie: players and lua entities)
	--- @since 5.0.0
	object_use_texture_alpha = true,
	--- Object selectionbox is settable independently from collisionbox
	--- @since 5.0.0
	object_independent_selectionbox = true,
	--- Specifies whether binary data can be uploaded or downloaded using the HTTP API
	--- @since 5.1.0
	httpfetch_binary_data = true,
	--- Whether formspec_version[<version>] may be used
	--- @since 5.1.0
	formspec_version_element = true,
	--- Whether AreaStore's IDs are kept on save/load
	--- @since 5.1.0
	area_store_persistent_ids = true,
	--- Whether minetest.find_path is functional
	--- @since 5.2.0
	pathfinder_works = true,
	--- Whether Collision info is available to an objects' on_step
	--- @since 5.3.0
	object_step_has_moveresult = true,
	--- Whether get_velocity() and add_velocity() can be used on players
	--- @since 5.4.0
	direct_velocity_on_players = true,
	--- nodedef's use_texture_alpha accepts new string modes
	--- @since 5.4.0
	use_texture_alpha_string_modes = true,
	--- degrotate param2 rotates in units of 1.5° instead of 2°
	--- thus changing the range of values from 0-179 to 0-240
	--- @since 5.5.0
	degrotate_240_steps = true,
	--- ABM supports min_y and max_y fields in definition
	--- @since 5.5.0
	abm_min_max_y = true,
	--- dynamic_add_media supports passing a table with options
	--- @since 5.5.0
	dynamic_add_media_table = true,
	--- particlespawners support texpools and animation of properties,
	--- particle textures support smooth fade and scale animations, and
	--- sprite-sheet particle animations can by synced to the lifetime
	--- of individual particles
	--- @since 5.6.0
	particlespawner_tweenable = true,
	--- allows get_sky to return a table instead of separate values
	--- @since 5.6.0
	get_sky_as_table = true,
	--- VoxelManip:get_light_data accepts an optional buffer argument
	--- @since 5.7.0
	get_light_data_buffer = true,
	--- When using a mod storage backend that is not "files" or "dummy",
	--- the amount of data in mod storage is not constrained by
	--- the amount of RAM available.
	--- @since 5.7.0
	mod_storage_on_disk = true,
	--- "zstd" method for compress/decompress
	--- @since 5.7.0
	compress_zstd = true,
	--- Sound parameter tables support start_time
	--- @since 5.8.0
	sound_params_start_time = true,
	--- New fields for set_physics_override: speed_climb, speed_crouch,
	--- liquid_fluidity, liquid_fluidity_smooth, liquid_sink,
	--- acceleration_default, acceleration_air
	--- @since 5.8.0
	physics_overrides_v2 = true,
	--- In HUD definitions the field `type` is used and `hud_elem_type` is deprecated
	--- @since 5.9.0
	hud_def_type_field = true,
	--- PseudoRandom and PcgRandom state is restorable
	--- PseudoRandom has get_state method
	--- PcgRandom has get_state and set_state methods
	--- @since 5.9.0
	random_state_restore = true,
	--- minetest.after guarantees that coexisting jobs are executed primarily
	--- in order of expiry and secondarily in order of registration
	--- @since 5.9.0
	after_order_expiry_registration = true,
	--- wallmounted nodes mounted at floor or ceiling may additionally
	--- be rotated by 90° with special param2 values
	--- @since 5.9.0
	wallmounted_rotate = true,
	--- Availability of the `pointabilities` property in the item definition
	--- @since 5.9.0
	item_specific_pointabilities = true,
	--- Nodes `pointable` property can be `"blocking"`
	--- @since 5.9.0
	blocking_pointability_type = true,
	--- dynamic_add_media can be called at startup when leaving callback as `nil`
	--- @since 5.9.0
	dynamic_add_media_startup = true,
	--- dynamic_add_media supports `filename` and `filedata` parameters
	--- @since 5.9.0
	dynamic_add_media_filepath = true,
	--- L-system decoration type
	--- @since 5.9.0
	lsystem_decoration_type = true,
	--- Overrideable pointing range using the itemstack meta key `"range"`
	--- @since 5.9.0
	item_meta_range = true,
	--- Allow passing an optional "actor" ObjectRef to the following functions:
	--- minetest.place_node, minetest.dig_node, minetest.punch_node
	--- @since 5.9.0
	node_interaction_actor = true,
	--- "new_pos" field in entity moveresult
	--- @since 5.9.0
	moveresult_new_pos = true,
	--- Allow removing definition fields in `minetest.override_item`
	override_item_remove_fields = true,
}

--- Returns `boolean, missing_features`
--- * `arg`: string or table in format `{foo=true, bar=true}`
--- * `missing_features`: `{foo=true, bar=true}`
--- @param arg string|table
--- @return boolean,table<string,boolean>
function minetest.has_feature(arg) end

--- Table containing information
---   about a player. Example return value:
--- ```lua
---   {
---       address = "127.0.0.1",     -- IP address of client
---       ip_version = 4,            -- IPv4 / IPv6
---       connection_uptime = 200,   -- seconds since client connected
---       protocol_version = 32,     -- protocol version used by client
---       formspec_version = 2,      -- supported formspec version
---       lang_code = "fr"           -- Language code used for translation
---       -- the following keys can be missing if no stats have been collected yet
---       min_rtt = 0.01,            -- minimum round trip time
---       max_rtt = 0.2,             -- maximum round trip time
---       avg_rtt = 0.02,            -- average round trip time
---       min_jitter = 0.01,         -- minimum packet time jitter
---       max_jitter = 0.5,          -- maximum packet time jitter
---       avg_jitter = 0.03,         -- average packet time jitter
---       -- the following information is available in a debug build only!!!
---       -- DO NOT USE IN MODS
---       --ser_vers = 26,             -- serialization version used by client
---       --major = 0,                 -- major version number
---       --minor = 4,                 -- minor version number
---       --patch = 10,                -- patch version number
---       --vers_string = "0.4.9-git", -- full version string
---       --state = "Active"           -- current client state
---   }
--- ```
--- [View in lua_api.txt](https://github.com/minetest/minetest/blob/5.4.1/doc/lua_api.txt#L4400-L4425)
function minetest.get_player_information(player_name) end


--- Will only be present if the client sent this information (requires v5.7+)
---
--- Note that none of these things are constant, they are likely to change during a client
--- connection as the player resizes the window and moves it between monitors
---
--- real_gui_scaling and real_hud_scaling can be used instead of DPI.
--- OSes don't necessarily give the physical DPI, as they may allow user configuration.
--- real_*_scaling is just OS DPI / 96 but with another level of user configuration.
--- ```lua
--- {
--- 	-- Current size of the in-game render target (pixels).
--- 	--
--- 	-- This is usually the window size, but may be smaller in certain situations,
--- 	-- such as side-by-side mode.
--- 	size = {
--- 		x = 1308,
--- 		y = 577,
--- 	},
---
--- 	-- Estimated maximum formspec size before Minetest will start shrinking the
--- 	-- formspec to fit. For a fullscreen formspec, use a size 10-20% larger than
--- 	-- this and `padding[-0.01,-0.01]`.
--- 	max_formspec_size = {
--- 		x = 20,
--- 		y = 11.25
--- 	},
---
--- 	-- GUI Scaling multiplier
--- 	-- Equal to the setting `gui_scaling` multiplied by `dpi / 96`
--- 	real_gui_scaling = 1,
---
--- 	-- HUD Scaling multiplier
--- 	-- Equal to the setting `hud_scaling` multiplied by `dpi / 96`
--- 	real_hud_scaling = 1,
---
--- 	-- Whether the touchscreen controls are enabled.
--- 	-- Usually (but not always) `true` on Android.
--- 	-- Requires at least Minetest 5.9.0 on the client. For older clients, it
--- 	-- is always set to `false`.
--- 	touch_controls = false,
--- }
--- ```
function minetest.get_player_window_information(player_name) end

--- Returns success.
--- * Creates a directory specified by `path`, creating parent directories
---   if they don't exist.
---
--- [View in lua_api.txt](https://github.com/minetest/minetest/blob/5.4.1/doc/lua_api.txt#L4427-L4429)
function minetest.mkdir(path) end

--- Removes a directory specified by path.
--- If recursive is set to true, the directory is recursively removed. Otherwise, the directory will only be removed if it is empty.
--- Returns true on success, false on failure.
--- @param path string
--- @param recursive boolean
--- @return boolean
function minetest.rmdir(path, recursive) end


--- Copies a directory specified by path to destination
--- Any files in destination will be overwritten if they already exist.
--- Returns true on success, false on failure.
--- @param source string
--- @param destination string
--- @return boolean
function minetest.cpdir(source, destination) end


--- Moves a directory specified by path to destination.
--- If the destination is a non-empty directory, then the move will fail.
--- Returns true on success, false on failure.
--- @param source string
--- @param destination string
--- @return boolean
function minetest.mvdir(source, destination) end

--- Returns list of entry names
--- * `is_dir` [Optional] is one of:
---     * nil: return all entries,
---     * true: return only subdirectory names, or
---     * false: return only file names.
---
--- [View in lua_api.txt](https://github.com/minetest/minetest/blob/5.4.1/doc/lua_api.txt#L4430-L4434)
function minetest.get_dir_list(path, is_dir) end

--- Returns boolean indicating success
--- * Replaces contents of file at path with new contents in a safe (atomic)
---   way. Use this instead of below code when writing e.g. database files:
---   `local f = io.open(path, "wb"); f:write(content); f:close()`
---
--- [View in lua_api.txt](https://github.com/minetest/minetest/blob/5.4.1/doc/lua_api.txt#L4435-L4438)
function minetest.safe_file_write(path, content) end

--- Returns a table containing components of the
---    engine version.  Components:
--- * `project`: Name of the project, eg, "Minetest"
--- * `string`: Simple version, eg, "1.2.3-dev"
--- * `hash`: Full git version (only set if available),
---   eg, "1.2.3-dev-01234567-dirty".
---   Use this for informational purposes only. The information in the returned
---   table does not represent the capabilities of the engine, nor is it
---   reliable or verifiable. Compatible forks will have a different name and
---   version entirely. To check for the presence of engine features, test
---   whether the functions exported by the wanted features exist. For example:
---   `if minetest.check_for_falling then ... end`.
---
--- [View in lua_api.txt](https://github.com/minetest/minetest/blob/5.4.1/doc/lua_api.txt#L4439-L4450)
function minetest.get_version() end

--- Returns the sha1 hash of data
--- * `data`: string of data to hash
--- * `raw`: [Optional] return raw bytes instead of hex digits, default: false
---
--- [View in lua_api.txt](https://github.com/minetest/minetest/blob/5.4.1/doc/lua_api.txt#L4451-L4453)
function minetest.sha1(data, raw) end

--- Returns the sha256 hash of `data`
--- @param data string string of data to hash
--- @param raw boolean optional. return raw bytes instead of hex digits, default: false
function minetest.sha256(data, raw) end

