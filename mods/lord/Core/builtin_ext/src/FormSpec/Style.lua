
--- @class minetest.FormSpec.Style
local Style = { -- luacheck: ignore unused variable Style
	--- set to true to allow the element to exceed formspec bounds.
	--- Defaults to false in formspec_version version 3 or higher
	--- @type boolean
    noclip = false,

    --- **Note**: accept multiple input types:
    ---    * Single value (e.g. `#FF0`): All corners/borders.
    ---    * Two values (e.g. `red,#FFAAFF`): top-left and bottom-right,top-right and bottom-left/
    ---      top and bottom,left and right.
    ---    * Four values (e.g. `blue,#A0F,green,#FFFA`): top-left/top and rotates clockwise.
    ---    * These work similarly to CSS borders.
	---`ColorString`. Sets the color(s) of the box corners. Default `black`.
	--- @type string
    colors = 'black',
	--- **Note**: accept multiple input types:
	---    * Single value (e.g. `#FF0`): All corners/borders.
	---    * Two values (e.g. `red,#FFAAFF`): top-left and bottom-right,top-right and bottom-left/
	---      top and bottom,left and right.
	---    * Four values (e.g. `blue,#A0F,green,#FFFA`): top-left/top and rotates clockwise.
	---    * These work similarly to CSS borders.
	--- `ColorString`. Sets the color(s) of the borders. Default `black`.
	--- @type
    bordercolors = 'black',
	--- Integer! Sets the width(s) of the borders in pixels. If the width is
	--- negative, the border will extend inside the box, whereas positive extends outside
	--- the box. A width of zero results in no border; this is default.
	--- @type number
    borderwidths = 0,
	--- whether to draw alpha in bgimg. Default true.
	--- @type boolean
	alpha = true,
	--- color, sets button tint.
	--- @type string
    bgcolor = '',
	--- color when hovered. Defaults to a lighter bgcolor when not provided.
	--- This is deprecated, use states instead.
	--- @deprecated
	--- @type string
    bgcolor_hovered = nil,
	--- color when pressed. Defaults to a darker bgcolor when not provided.
	--- This is deprecated, use states instead.
	--- @deprecated
	--- @type string
    bgcolor_pressed = nil,
	--- standard background image. Defaults to none.
	--- @type string
    bgimg = nil,
	--- background image when hovered. Defaults to bgimg when not provided.
	--- This is deprecated, use states instead.
	--- @deprecated
	--- @type string
    bgimg_hovered = nil,
	--- Makes the bgimg textures render in 9-sliced mode and defines the middle rect.
	--- See background9[] documentation for more details. This property also pads the
	--- button's content when set.
	--- @type string
    bgimg_middle = nil,
	--- background image when pressed. Defaults to bgimg when not provided.
	--- This is deprecated, use states instead.
	--- @type
    bgimg_pressed = nil,
	--- Sets font type. This is a comma separated list of options. Valid options:
	---  * Main font type options. These cannot be combined with each other:
	---    * `normal`: Default font
	---    * `mono`: Monospaced font
	---  * Font modification options. If used without a main font type, `normal` is used:
	---    * `bold`: Makes font bold.
	---    * `italic`: Makes font italic.
	---  Default `normal`.
	--- @type string
    font = 'normal',
	--- Sets font size. Default is user-set. Can have multiple values:
	---  * `<number>`: Sets absolute font size to `number`.
	---  * `+<number>`/`-<number>`: Offsets default font size by `number` points.
	---  * `*<number>`: Multiplies default font size by `number`, similar to CSS `em`.
	--- @type number
    font_size = nil,
	--- draw border. Set to false to hide the bevelled button pane. Default true.
	--- @type boolean
    border = true,
	--- 2d vector, shifts the position of the button's content without resizing it.
	--- @type
    content_offset = nil,
	--- rect, adds space between the edges of the button and the content. This value is relative to bgimg_middle.
	--- @type
    padding = nil,
	--- a sound to be played when triggered.
	--- @type
    sound = nil,
	--- color, default white.
	--- @type string
    textcolor = '#fff',

	--- 2d vector, sets the size of inventory slots in coordinates. (for `list`)
	size = nil,
	--- 2d vector, sets the space between inventory slots in coordinates. (for `list`)
	spacing = nil,


	--- (additional properties for `image_button`)
	--- standard image. Defaults to none.
	--- @type string
	fgimg = nil,
	--- (additional properties for `image_button`)
	--- image when hovered. Defaults to fgimg when not provided.
	--- This is deprecated, use states instead.
	--- @deprecated
	--- @type string
	fgimg_hovered = nil,
	--- (additional properties for `image_button`)
	--- image when pressed. Defaults to fgimg when not provided.
	--- This is deprecated, use states instead.
	--- @deprecated
	--- @type string
	fgimg_pressed = nil,
	--- (additional properties for `image_button`)
	--- Makes the fgimg textures render in 9-sliced mode and defines the middle rect.
	--- See background9[] documentation for more details.
	--- @type
	fgimg_middle = nil,
}
