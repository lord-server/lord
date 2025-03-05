local texture = minetest.texture

--- @class minetest.Tile
local Tile = {}

minetest.tile = Tile

--- @static
--- @overload fun(anim_texture:string, period:number)
--- @overload fun(anim_texture:string, period:number, bg_texture:string, frames_count:number)
---
--- @param anim_texture string animated texture.
--- @param period       number period in seconds of full animation loop.
--- @param bg_texture   string @(optional) background texture, that will be vertically repeated.
--- @param frames_count number @(optional) count to repeat `bg_texture` (count of frames in `anim_texture`).
--- @param frame_width  number @(optional). Default: `16`
--- @param frame_height number @(optional). Default: `16`
---
--- @return TileDefinition|table
function Tile.anim_vertical_frames(anim_texture, period, bg_texture, frames_count, frame_width, frame_height)
	frame_width  = frame_width or 16
	frame_height = frame_height or 16

	if bg_texture then
		assert(frames_count and frames_count > 1, 'You should specify `frames_count`, if you need background')
		anim_texture = texture.repeat_vertically(bg_texture, frames_count, frame_height) .. "^" .. anim_texture
	end

	return {
		name      = anim_texture,
		animation = {
			type     = 'vertical_frames',
			aspect_w = frame_width,
			aspect_h = frame_height,
			length   = period,
		}
	}
end
