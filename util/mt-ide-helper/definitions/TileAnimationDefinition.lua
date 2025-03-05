--- @class TileAnimationDefinition: table
local TileAnimationDefinition = {
	--- @type string one of {"vertical_frames"|"sheet_2d"}
	type = "",

	--- Width of a frame in pixels.
	--- Only for `type == "vertical_frames"`
	--- @type number
	aspect_w = 16,

	--- Height of a frame in pixels
	--- Only for `type == "vertical_frames"`
	--- @type number
	aspect_h = 16,

	--- Full loop length
	--- Only for `type == "vertical_frames"`
	--- @type number
	length = 3.0,

	--- Width in number of frames
	--- Only for `type == "sheet_2d"`
	--- @type number
	frames_w = 5,

	--- Height in number of frames
	--- Only for `type == "sheet_2d"`
	--- @type number
	frames_h = 3,

	--- Length of a single frame
	--- Only for `type == "sheet_2d"`
	--- @type number
	frame_length = 0.5,
}
