--- @class TileDefinition
local TileDefinition = {
	--- @type string
	name = "image.png",

	--- @type TileAnimationDefinition?
	animation = nil,

	--- Backface culling enabled by default for most nodes.
	--- @type boolean?
	backface_culling = true,

	--- One of `{"node"|"world"|"user"}`.
	---
	--- `align_style` determines whether the texture will be rotated with the node or kept aligned with its surroundings.
	---
	--- `"user"` means that client setting will be used, similar to `glasslike_framed_optional`.
	---
	--- **Note:** supported by solid nodes and nodeboxes only.
	--- @type string?
	align_style = "none",

	--- `scale` is used to make texture span several (exactly scale) nodes, instead of just one, in each direction.
	---
	--- Works for world-aligned textures only.
	---
	--- **Note** that as the effect is applied on per-mapblock basis,
	---   16 should be equally divisible by scale or you may get wrong results.
	--- @type number?
	scale = 1,

	--- - the texture's color will be multiplied with this color.
    --- - the tile's color overrides the owning node's color in all cases.
	--- @type string|ColorSpec|nil
	color = ""
}
