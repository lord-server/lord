--- @class HudDefinition
local HudDefinition = {
	--- Name of the HUD element.
	---
	--- The `name` field is not yet used, but should contain a description of what the HUD element represents.
	---
	--- @type string?
	name = "",

	--- HUD element type, one of:
	---  * `"image"`     - Displays an image on the HUD.
	---  * `"text"`      - Displays text on the HUD.
	---  * `"statbar"`   - Displays a horizontal bar made up of half-images with an optional background.
	---  * `"inventory"` - Displays an inventory list on the HUD.
	---  * `"hotbar"`
	---  * `"waypoint"`  - Displays distance to selected world position.
	---  * `"image_waypoint"` Same as image, but does not accept a position;
	---    the position is instead determined by world_pos, the world position of the waypoint.
	---  * `"compass"`   - Displays an image oriented or translated according to current heading direction.
	---  * `"minimap"`   - Displays a minimap on the HUD.
	---
	--- @type string?
	type = "image",
	--- HUD element type: "image", "text", "statbar", "inventory", "waypoint", "image_waypoint".
	--- In case both are specified (`type` and `hud_elem_type`) `type` will be used.
	--- @deprecated
	--- @type string?
	hud_elem_type = "",

	--- Position on the screen, range: `{x = 0..1, y = 0..1}`.
	--- Top left corner position of element.
	---
	--- To account for differing resolutions, the position coordinates are the percentage of the screen,
	--- ranging in value from `0` to `1`.
	---
	--- @type Position2d?
	position = {x = 0, y = 0},

	--- Offset in pixels from the position.
	--- Contrary to position, the offset is not scaled to screen size.
	--- This allows for some precisely positioned items in the HUD.
	---
	--- **Note:** offset will adapt to screen DPI as well as user defined scaling factor!
	---
	--- @type Position2d?
	offset = {x = 0, y = 0},

	--- Alignment anchor. Values: `{x = -1..1, y = -1..1}`.
	--- It is a table where `x` and `y` range from -1 to 1, with 0 being central.
	--- `-1` is moved to the left/up, and 1 is to the right/down. Fractional values can be used.
	--- @type Position2d?
	alignment = {x = 0, y = 0},

	--- Direction: 0: left-right, 1: right-left, 2: top-bottom, 3: bottom-top.
	---
	--- The direction field is the direction in which something is drawn.
	--- `0` draws from left to right, `1` draws from right to left, `2` draws from top to bottom,
	--- and `3` draws from bottom to top.
	---
	--- @type number?
	direction = 0,

	--- * For `type` == `"image"`:
	--- * * The scale of the image, with {x = 1, y = 1} being the original texture size.
	---     The x and y fields apply to the respective axes. Positive values scale the source image.
	---     Negative values represent percentages relative to screen dimensions.
	---     Example: {x = -20, y = 3} means the image will be drawn 20% of screen width wide,
	---     and 3 times as high as the source image is.
	---
	--- * For `type` == `"text"`:
	--- * * Defines the bounding rectangle of the text. A value such as {x=100, y=100} should work.
	---
	--- * For `type` == `"image_waypoint"`:
	--- * * The scale of the image, with {x = 1, y = 1} being the original texture size.
	---     The x and y fields apply to the respective axes.
	---     Positive values scale the source image.
	---     Negative values represent percentages relative to screen dimensions.
	---     Example: {x = -20, y = 3} means the image will be drawn 20% of screen width wide,
	---     and 3 times as high as the source image is.
	---
	--- * For `type` == `"compass"`:
	--- * * The size of this element.
	---     Negative values represent percentage of the screen; e.g. x=-100 means 100% (width).
	---
	--- @type Position2d?
	scale = {x = 1, y = 1},

	--- Name of the text or image to display.
	--- * For "text": The text to be displayed in the HUD element.
	---   Supports core.translate (always) and core.colorize (since protocol version 44).
	--- * For "image"/"statbar"/"image_waypoint"/"compass": it's the texture name.
	--- * For "inventory": The name of the inventory list to be displayed.
	--- * For "waypoint": Distance suffix. Can be blank.
	---
	--- @type string?
	text = "",

	--- * For "statbar": Optional texture name to enable a background / "off state" texture
	---   (useful to visualize the maximal value).
	---   Both textures must have the same size.
	---
	--- @type string?
	text2 = "",

	--- * For "text": An integer containing the RGB value of the color used to draw the text.
	---   Specify 0xFFFFFF for white text, 0xFF0000 for red, and so on.
	--- * For "statbar": The number of half-textures that are displayed.
	---   If odd, will end with a vertically center-split texture.
	--- * For "inventory": Number of items in the inventory to be displayed.
	--- * For "waypoint": An integer containing the RGB value of the color used to draw the text.
	---
	--- @type number?
	number = 0,

	--- * For "statbar": Same as `number` but for the "off state" texture.
	--- * For "inventory": Position of item that is selected.
	--- @type number?
	item = 0,

	--- * For "text": size of the text. The player-set font size is multiplied by size.x (y value isn't used).
	--- * For "statbar": If used, will force full-image size to this value (override texture pack image size).
	--- * For "compass": The size of this element.
	---   Negative values represent percentage of the screen; e.g. x=-100 means 100% (width).
	--- * For "minimap": Size of the minimap to display. Minimap should be a square to avoid distortion.
	---   * - Negative values represent percentages of the screen.
	---     If either x or y is specified as a percentage, the resulting pixel size will be used for both x and y.
	---     Example: On a 1920x1080 screen, {x = 0, y = -25} will result in a 270x270 minimap.
	---   * - Negative values are supported starting with protocol version 45.
	---
	--- @type Position2d?
	size = {x=0, y=0},

	--- Z index: lower z-index HUDs are displayed behind higher z-index HUDs
	---
	--- Specifies the order of HUD elements from back to front.
	--- Lower z-index elements are displayed behind higher z-index elements.
	--- Elements with same z-index are displayed in an arbitrary order.
	---
	--- Default 0. Supports negative values.
	---
	--- By convention, the following values are recommended:
	---  * -400: Graphical effects, such as vignette
	---  * -300: Name tags, waypoints
	---  * -200: Wieldhand
	---  * -100: Things that block the player's view, e.g. masks
	---  * 0: Default. For standard in-game HUD elements like crosshair, hotbar, minimap, builtin statbars, etc.
	---  * 100: Temporary text messages or notification icons
	---  * 1000: Full-screen effects such as full-black screen or credits. This includes effects that cover the entire screen
	---
	--- If your HUD element doesn't fit into any category, pick a number between the suggested values.
	---
	--- @type number?
	z_index = 0,

	--- * For "text": determines font style Bitfield with 1 = bold, 2 = italic, 4 = monospace.
	---
	--- @type number?
	style = 0,

	--- * For "waypoint": Waypoint precision, integer >= 0. Defaults to 10.
	---   If set to 0, distance is not shown. Shown value is floor(distance*precision)/precision.
	---   When the precision is an integer multiple of 10, there will be log_10(precision) digits after the decimal point.
	---   `precision = 1000`, for example, will show 3 decimal places (eg: `0.999`).
	---   `precision = 2` will show multiples of `0.5`;
	---   `precision = 5` will show multiples of `0.2` and so on: precision = n will show multiples of `1/n`.
	---
	--- @type number?
	precision = 10,

	--- * For "waypoint"/"image_waypoint": World position of the waypoint.
	---
	--- @type Position?
	world_pos = {x=0, y=0, z=0},
}
