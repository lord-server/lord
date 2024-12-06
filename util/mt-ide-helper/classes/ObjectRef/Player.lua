--- @class Player: ObjectRef
Player = {}

--- @return string
function Player:get_player_name() end
--- @return InvRef
function Player:get_inventory() end

--TODO:
--- returns `""` if is not a player
--- @return string
function Player:get_player_name() end
--- **DEPRECATED**, use get_velocity() instead.
---  table {x, y, z} representing the player's instantaneous velocity in nodes/s
--- @deprecated
function Player:get_player_velocity() end
--- **DEPRECATED**, use add_velocity(vel) instead.
--- @deprecated
function Player:add_player_velocity(vel) end
--- get camera direction as a unit vector
function Player:get_look_dir() end
--- pitch in radians
---    * Angle ranges between -pi/2 and pi/2, which are straight up and down
---      respectively.
function Player:get_look_vertical() end
--- yaw in radians
---    * Angle is counter-clockwise from the +z direction.
--- @return number
function Player:get_look_horizontal() end
--- sets look pitch
---    * radians: Angle from looking forward, where positive is downwards.
function Player:set_look_vertical(radians) end
--- sets look yaw
---    * radians: Angle from the +z direction, where positive is counter-clockwise.
function Player:set_look_horizontal(radians) end
--- pitch in radians - Deprecated as broken. Use
---  `get_look_vertical`.
---    * Angle ranges between -pi/2 and pi/2, which are straight down and up
---      respectively.
function Player:get_look_pitch() end
--- yaw in radians - Deprecated as broken. Use
---  `get_look_horizontal`.
---    * Angle is counter-clockwise from the +x direction.
--- @deprecated
function Player:get_look_yaw() end
--- sets look pitch - Deprecated. Use `set_look_vertical`.
function Player:set_look_pitch(radians) end
---  sets look yaw - Deprecated. Use
---  `set_look_horizontal`.
function Player:set_look_yaw(radians) end
--- returns player's breath
function Player:get_breath() end
--- sets player's breath
---    * values:
---        * `0`: player is drowning
---        * max: bubbles bar is not shown
---        * See [Object properties] for more information
---    * Is limited to range 0 ... 65535 (2^16 - 1)
function Player:set_breath(value) end
--- Sets player's FOV
---    * `fov`: FOV value.
---    * `is_multiplier`: Set to `true` if the FOV value is a multiplier.
---      Defaults to `false`.
---    * `transition_time`: If defined, enables smooth FOV transition.
---      Interpreted as the time (in seconds) to reach target FOV.
---      If set to 0, FOV change is instantaneous. Defaults to 0.
---    * Set `fov` to 0 to clear FOV override.
function Player:set_fov(fov, is_multiplier, transition_time) end
--- Returns the following:
---    * Server-sent FOV value. Returns 0 if an FOV override doesn't exist.
---    * Boolean indicating whether the FOV value is a multiplier.
---    * Time (in seconds) taken for the FOV transition. Set by `set_fov`.
function Player:get_fov() end
---  DEPRECATED, use get_meta() instead
---    * Sets an extra attribute with value on player.
---    * `value` must be a string, or a number which will be converted to a
---      string.
---    * If `value` is `nil`, remove attribute from player.
function Player:set_attribute(attribute, value) end
---  DEPRECATED, use get_meta() instead
---    * Returns value (a string) for extra attribute.
---    * Returns `nil` if no attribute found.
function Player:get_attribute(attribute) end
--- Returns a PlayerMetaRef.
function Player:get_meta() end
---    * Redefine player's inventory form
---    * Should usually be called in `on_joinplayer`
---    * If `formspec` is `""`, the player's inventory is disabled.
function Player:set_inventory_formspec(formspec) end
--- returns a formspec string
function Player:get_inventory_formspec() end
---    * the formspec string will be added to every formspec shown to the user,
---      except for those with a no_prepend[] tag.
---    * This should be used to set style elements such as background[] and
---      bgcolor[], any non-style elements (eg: label) may result in weird behavior.
---    * Only affects formspecs shown after this is called.
function Player:set_formspec_prepend(formspec) end
---  returns a formspec string.
function Player:get_formspec_prepend(formspec) end
--- returns table with player pressed keys
---    * The table consists of fields with the following boolean values
---      representing the pressed keys: `up`, `down`, `left`, `right`, `jump`,
---      `aux1`, `sneak`, `dig`, `place`, `LMB`, `RMB`, and `zoom`.
---    * The fields `LMB` and `RMB` are equal to `dig` and `place` respectively,
---      and exist only to preserve backwards compatibility.
---    * Returns an empty table `{}` if the object is not a player.
function Player:get_player_control() end
--- returns integer with bit packed player pressed
---  keys.
---    * Bits:
---        * 0 - up
---        * 1 - down
---        * 2 - left
---        * 3 - right
---        * 4 - jump
---        * 5 - aux1
---        * 6 - sneak
---        * 7 - dig
---        * 8 - place
---        * 9 - zoom
---    * Returns `0` (no bits set) if the object is not a player.

--- @class physics_override_table
--- @field speed        number multiplier to default walking speed value (default: `1`)
--- @field jump         number multiplier to default jump value (default: `1`)
--- @field gravity      number multiplier to default gravity value (default: `1`)
--- @field sneak        number whether player can sneak (default: `true`)
--- @field sneak_glitch number whether player can use the new move code replications of the old sneak side-effects: sneak ladders and 2 node sneak jump (default: `false`)
--- @field new_move     number use new move/sneak code. When `false` the exact old code is used for the specific old sneak behavior (default: `true`)

--- @return physics_override_table
function Player:get_player_control_bits() end
---    * `override_table` is a table with the following fields:
---        * `speed`: multiplier to default walking speed value (default: `1`)
---        * `jump`: multiplier to default jump value (default: `1`)
---        * `gravity`: multiplier to default gravity value (default: `1`)
---        * `sneak`: whether player can sneak (default: `true`)
---        * `sneak_glitch`: whether player can use the new move code replications
---          of the old sneak side-effects: sneak ladders and 2 node sneak jump
---          (default: `false`)
---        * `new_move`: use new move/sneak code. When `false` the exact old code
---          is used for the specific old sneak behavior (default: `true`)
--- @param override_table physics_override_table
function Player:set_physics_override(override_table) end
--- returns the table given to `set_physics_override`
function Player:get_physics_override() end
--- add a HUD element described by HUD def, returns ID
---   number on success
function Player:hud_add(hud_definition) end
--- remove the HUD element of the specified id
function Player:hud_remove(id) end
--- change a value of a previously added HUD
---  element.
---    * `stat` supports the same keys as in the hud definition table except for
---      `"hud_elem_type"`.
function Player:hud_change(id, stat, value) end
--- gets the HUD element definition structure of the specified ID
function Player:hud_get(id) end
--- sets specified HUD flags of player.
---    * `flags`: A table with the following fields set to boolean values
---        * `hotbar`
---        * `healthbar`
---        * `crosshair`
---        * `wielditem`
---        * `breathbar`
---        * `minimap`: Modifies the client's permission to view the minimap.
---          The client may locally elect to not view the minimap.
---        * `minimap_radar`: is only usable when `minimap` is true
---        * `basic_debug`: Allow showing basic debug info that might give a gameplay advantage.
---          This includes map seed, player position, look direction, the pointed node and block bounds.
---          Does not affect players with the `debug` privilege.
---    * If a flag equals `nil`, the flag is not modified
function Player:hud_set_flags(flags) end
--- returns a table of player HUD flags with boolean values.
---    * See `hud_set_flags` for a list of flags that can be toggled.
function Player:hud_get_flags() end
--- sets number of items in builtin hotbar
----    * `count`: number of items, must be between `1` and `32`
function Player:hud_set_hotbar_itemcount(count) end
--- returns number of visible items
function Player:hud_get_hotbar_itemcount() end
---    * sets background image for hotbar
function Player:hud_set_hotbar_image(texturename) end
--- returns texturename
function Player:hud_get_hotbar_image() end
---    * sets image for selected item of hotbar
function Player:hud_set_hotbar_selected_image(texturename) end
--- returns texturename
function Player:hud_get_hotbar_selected_image() end
--- modes_list: {mode, mode, ...}
---    * Overrides the available minimap modes (and toggle order), and changes the
---    selected mode.
---    * `mode` is a table consisting of up to four fields:
---        * `type`: Available type:
---            * `off`: Minimap off
---            * `surface`: Minimap in surface mode
---            * `radar`: Minimap in radar mode
---            * `texture`: Texture to be displayed instead of terrain map
---              (texture is centered around 0,0 and can be scaled).
---              Texture size is limited to 512 x 512 pixel.
---        * `label`: Optional label to display on minimap mode toggle
---          The translation must be handled within the mod.
---        * `size`: Sidelength or diameter, in number of nodes, of the terrain
---          displayed in minimap
---        * `texture`: Only for texture type, name of the texture to display
---        * `scale`: Only for texture type, scale of the texture map in nodes per
---          pixel (for example a `scale` of 2 means each pixel represents a 2x2
---          nodes square)
---    * `selected_mode` is the mode index to be selected after modes have been changed
---    (0 is the first mode).
function Player:set_minimap_modes(modes_list, selected_mode) end
---    * The presence of the function `set_sun`, `set_moon` or `set_stars` indicates
---      whether `set_sky` accepts this format. Check the legacy format otherwise.
---    * Passing no arguments resets the sky to its default values.
---    * `sky_parameters` is a table with the following optional fields:
---        * `base_color`: ColorSpec, changes fog in "skybox" and "plain".
---          (default: `#ffffff`)
---        * `type`: Available types:
---            * `"regular"`: Uses 0 textures, `base_color` ignored
---            * `"skybox"`: Uses 6 textures, `base_color` used as fog.
---            * `"plain"`: Uses 0 textures, `base_color` used as both fog and sky.
---            (default: `"regular"`)
---        * `textures`: A table containing up to six textures in the following
---            order: Y+ (top), Y- (bottom), X- (west), X+ (east), Z+ (north), Z- (south).
---        * `clouds`: Boolean for whether clouds appear. (default: `true`)
---        * `sky_color`: A table used in `"regular"` type only, containing the
---          following values (alpha is ignored):
---            * `day_sky`: ColorSpec, for the top half of the sky during the day.
---              (default: `#61b5f5`)
---            * `day_horizon`: ColorSpec, for the bottom half of the sky during the day.
---              (default: `#90d3f6`)
---            * `dawn_sky`: ColorSpec, for the top half of the sky during dawn/sunset.
---              (default: `#b4bafa`)
---              The resulting sky color will be a darkened version of the ColorSpec.
---              Warning: The darkening of the ColorSpec is subject to change.
---            * `dawn_horizon`: ColorSpec, for the bottom half of the sky during dawn/sunset.
---              (default: `#bac1f0`)
---              The resulting sky color will be a darkened version of the ColorSpec.
---              Warning: The darkening of the ColorSpec is subject to change.
---            * `night_sky`: ColorSpec, for the top half of the sky during the night.
---              (default: `#006bff`)
---              The resulting sky color will be a dark version of the ColorSpec.
---              Warning: The darkening of the ColorSpec is subject to change.
---            * `night_horizon`: ColorSpec, for the bottom half of the sky during the night.
---              (default: `#4090ff`)
---              The resulting sky color will be a dark version of the ColorSpec.
---              Warning: The darkening of the ColorSpec is subject to change.
---            * `indoors`: ColorSpec, for when you're either indoors or underground.
---              (default: `#646464`)
---            * `fog_sun_tint`: ColorSpec, changes the fog tinting for the sun
---              at sunrise and sunset. (default: `#f47d1d`)
---            * `fog_moon_tint`: ColorSpec, changes the fog tinting for the moon
---              at sunrise and sunset. (default: `#7f99cc`)
---            * `fog_tint_type`: string, changes which mode the directional fog
---                abides by, `"custom"` uses `sun_tint` and `moon_tint`, while
---                `"default"` uses the classic Minetest sun and moon tinting.
---                Will use tonemaps, if set to `"default"`. (default: `"default"`)
function Player:set_sky(sky_parameters) end
---    * Deprecated. Use `set_sky(sky_parameters)`
---    * `base_color`: ColorSpec, defaults to white
---    * `type`: Available types:
---        * `"regular"`: Uses 0 textures, `bgcolor` ignored
---        * `"skybox"`: Uses 6 textures, `bgcolor` used
---        * `"plain"`: Uses 0 textures, `bgcolor` used
---    * `clouds`: Boolean for whether clouds appear in front of `"skybox"` or
---      `"plain"` custom skyboxes (default: `true`)
function Player:set_sky(base_color, type, texture_names, clouds) end
---    * `as_table`: boolean that determines whether the deprecated version of this
---    function is being used.
---        * `true` returns a table containing sky parameters as defined in `set_sky(sky_parameters)`.
---        * Deprecated: `false` or `nil` returns base_color, type, table of textures,
---        clouds.
function Player:get_sky(as_table) end
---    * Deprecated: Use `get_sky(as_table)` instead.
---    * returns a table with the `sky_color` parameters as in `set_sky`.
function Player:get_sky_color() end
---    * Passing no arguments resets the sun to its default values.
---    * `sun_parameters` is a table with the following optional fields:
---        * `visible`: Boolean for whether the sun is visible.
---            (default: `true`)
---        * `texture`: A regular texture for the sun. Setting to `""`
---            will re-enable the mesh sun. (default: "sun.png", if it exists)
---            The texture appears non-rotated at sunrise and rotated 180 degrees
---            (upside down) at sunset.
---        * `tonemap`: A 512x1 texture containing the tonemap for the sun
---            (default: `"sun_tonemap.png"`)
---        * `sunrise`: A regular texture for the sunrise texture.
---            (default: `"sunrisebg.png"`)
---        * `sunrise_visible`: Boolean for whether the sunrise texture is visible.
---            (default: `true`)
---        * `scale`: Float controlling the overall size of the sun. (default: `1`)
---            Note: For legacy reasons, the sun is bigger than the moon by a factor
---            of about `1.57` for equal `scale` values.
function Player:set_sun(sun_parameters) end
--- returns a table with the current sun parameters as in
---    `set_sun`.
function Player:get_sun() end
---    * Passing no arguments resets the moon to its default values.
---    * `moon_parameters` is a table with the following optional fields:
---        * `visible`: Boolean for whether the moon is visible.
---            (default: `true`)
---        * `texture`: A regular texture for the moon. Setting to `""`
---            will re-enable the mesh moon. (default: `"moon.png"`, if it exists)
---            The texture appears non-rotated at sunrise / moonset and rotated 180
---            degrees (upside down) at sunset / moonrise.
---            Note: Relative to the sun, the moon texture is hence rotated by 180°.
---            You can use the `^[transformR180` texture modifier to achieve the same orientation.
---        * `tonemap`: A 512x1 texture containing the tonemap for the moon
---            (default: `"moon_tonemap.png"`)
---        * `scale`: Float controlling the overall size of the moon (default: `1`)
---            Note: For legacy reasons, the sun is bigger than the moon by a factor
---            of about `1.57` for equal `scale` values.
function Player:set_moon(moon_parameters) end
--- returns a table with the current moon parameters as in
---    `set_moon`.
function Player:get_moon() end
---    * Passing no arguments resets stars to their default values.
---    * `star_parameters` is a table with the following optional fields:
---        * `visible`: Boolean for whether the stars are visible.
---            (default: `true`)
---        * `day_opacity`: Float for maximum opacity of stars at day.
---            No effect if `visible` is false.
---            (default: 0.0; maximum: 1.0; minimum: 0.0)
---        * `count`: Integer number to set the number of stars in
---            the skybox. Only applies to `"skybox"` and `"regular"` sky types.
---            (default: `1000`)
---        * `star_color`: ColorSpec, sets the colors of the stars,
---            alpha channel is used to set overall star brightness.
---            (default: `#ebebff69`)
---        * `scale`: Float controlling the overall size of the stars (default: `1`)
function Player:set_stars(star_parameters) end
--- returns a table with the current stars parameters as in
---    `set_stars`.
function Player:get_stars() end
--- set cloud parameters
---    * Passing no arguments resets clouds to their default values.
---    * `cloud_parameters` is a table with the following optional fields:
---        * `density`: from `0` (no clouds) to `1` (full clouds) (default `0.4`)
---        * `color`: basic cloud color with alpha channel, ColorSpec
---          (default `#fff0f0e5`).
---        * `ambient`: cloud color lower bound, use for a "glow at night" effect.
---          ColorSpec (alpha ignored, default `#000000`)
---        * `height`: cloud height, i.e. y of cloud base (default per conf,
---          usually `120`)
---        * `thickness`: cloud thickness in nodes (default `16`)
---        * `speed`: 2D cloud speed + direction in nodes per second
---          (default `{x=0, z=-2}`).
function Player:set_clouds(cloud_parameters) end
--- returns a table with the current cloud parameters as in
---  `set_clouds`.
function Player:get_clouds() end
---    * `0`...`1`: Overrides day-night ratio, controlling sunlight to a specific
---      amount.
---    * `nil`: Disables override, defaulting to sunlight based on day-night cycle
function Player:override_day_night_ratio(ratio) end
--- returns the ratio or nil if it isn't overridden
function Player:get_day_night_ratio() end
---  set animation for player model in third person view.
---    * Every animation equals to a `{x=starting frame, y=ending frame}` table.
---    * `frame_speed` sets the animations frame speed. Default is 30.
function Player:set_local_animation(idle, walk, dig, walk_while_dig, frame_speed) end
--- returns idle, walk, dig, walk_while_dig tables and
---  `frame_speed`.
function Player:get_local_animation() end
--- defines offset vectors for
---  camera per player. An argument defaults to `{x=0, y=0, z=0}` if unspecified.
---    * in first person view
---    * in third person view (max. values `{x=-10/10,y=-10,15,z=-5/5}`)
--- v -- [firstperson, thirdperson]
function Player:set_eye_offset(v) end
--- returns first and third person offsets.
function Player:get_eye_offset() end
---    * Sends an already loaded mapblock to the player.
---    * Returns `false` if nothing was sent (note that this can also mean that
---      the client already has the block)
---    * Resource intensive - use sparsely
function Player:send_mapblock(blockpos) end
--- sets lighting for the player
---    * `light_definition` is a table with the following optional fields:
---      * `saturation` sets the saturation (vividness).
---          values > 1 increase the saturation
---          values in [0,1) decrease the saturation
---            * This value has no effect on clients who have the "Tone Mapping" shader disabled.
---      * `shadows` is a table that controls ambient shadows
---        * `intensity` sets the intensity of the shadows from 0 (no shadows, default) to 1 (blackness)
---            * This value has no effect on clients who have the "Dynamic Shadows" shader disabled.
function Player:set_lighting(light_definition) end
--- returns the current state of lighting for the player.
---    * Result is a table with the same fields as `light_definition` in `set_lighting`.
function Player:get_lighting() end
--- Respawns the player using the same mechanism as the death screen,
---  including calling on_respawnplayer callbacks.
function Player:respawn() end
