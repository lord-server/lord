

--- @class minetest.Texture
local Texture = {}

minetest.texture = Texture

--- @static
--- @overload fun(texture:string, times:number)
---
--- @param texture string name of texture to repeat.
--- @param times   number count how many times to repeat.
--- @param height  number height of specified `texture`. Default: `16`
---
--- @return string returns `[combine` string
--- [See `[combine` docs](https://api.luanti.org/textures/#combinewxhx1y1file1x2y2file2)
function Texture.repeat_vertically(texture, times, height)
	height = height or 16

	local repeated = '[combine:16x' .. height * times
	for i = 0, times - 1 do
		repeated = repeated .. ":0," .. (i*height) .. "=" .. texture
	end

	return repeated
end
