--- @class ObjectProperties
local ObjectProperties = {
	hp_max = 10,
	-- Defines the maximum and default HP of the entity
	-- For Lua entities the maximum is not enforced.
	-- For players this defaults to `minetest.PLAYER_MAX_HP_DEFAULT`.

	breath_max = 0,
	-- For players only. Defaults to `minetest.PLAYER_MAX_BREATH_DEFAULT`.

	zoom_fov = 0.0,
	-- For players only. Zoom FOV in degrees.
	-- Note that zoom loads and/or generates world beyond the server's
	-- maximum send and generate distances, so acts like a telescope.
	-- Smaller zoom_fov values increase the distance loaded/generated.
	-- Defaults to 15 in creative mode, 0 in survival mode.
	-- zoom_fov = 0 disables zooming for the player.

	eye_height = 1.625,
	-- For players only. Camera height above feet position in nodes.

	physical = false,
	-- Collide with `walkable` nodes.

	collide_with_objects = true,
	-- Collide with other objects if physical = true

	collisionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },  -- default
	selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, rotate = false },
	-- { xmin, ymin, zmin, xmax, ymax, zmax } in nodes from object position.
	-- Collision boxes cannot rotate, setting `rotate = true` on it has no effect.
	-- If not set, the selection box copies the collision box, and will also not rotate.
	-- If `rotate = false`, the selection box will not rotate with the object itself, remaining fixed to the axes.
	-- If `rotate = true`, it will match the object's rotation and any attachment rotations.
	-- Raycasts use the selection box and object's rotation, but do *not* obey attachment rotations.
	-- For server-side raycasts to work correctly,
	-- the selection box should extend at most 5 units in each direction.


	pointable = true,
	-- Can be `true` if it is pointable, `false` if it can be pointed through,
	-- or `"blocking"` if it is pointable but not selectable.
	-- Clients older than 5.9.0 interpret `pointable = "blocking"` as `pointable = true`.
	-- Can be overridden by the `pointabilities` of the held item.

	visual = "cube" / "sprite" / "upright_sprite" / "mesh" / "wielditem" / "item",
	-- "cube" is a node-sized cube.
	-- "sprite" is a flat texture always facing the player.
	-- "upright_sprite" is a vertical flat texture.
	-- "mesh" uses the defined mesh model.
	-- "wielditem" is used for dropped items.
	--   (see builtin/game/item_entity.lua).
	--   For this use 'wield_item = itemname'.
	--   Setting 'textures = {itemname}' has the same effect, but is deprecated.
	--   If the item has a 'wield_image' the object will be an extrusion of
	--   that, otherwise:
	--   If 'itemname' is a cubic node or nodebox the object will appear
	--   identical to 'itemname'.
	--   If 'itemname' is a plantlike node the object will be an extrusion
	--   of its texture.
	--   Otherwise for non-node items, the object will be an extrusion of
	--   'inventory_image'.
	--   If 'itemname' contains a ColorString or palette index (e.g. from
	--   `minetest.itemstring_with_palette()`), the entity will inherit the color.
	--   Wielditems are scaled a bit. If you want a wielditem to appear
	--   to be as large as a node, use `0.667` in `visual_size`
	-- "item" is similar to "wielditem" but ignores the 'wield_image' parameter.

	visual_size = {x = 1, y = 1, z = 1},
	-- Multipliers for the visual size. If `z` is not specified, `x` will be used
	-- to scale the entity along both horizontal axes.

	mesh = "model.obj",
	-- File name of mesh when using "mesh" visual

	textures = {},
	-- Number of required textures depends on visual.
	-- "cube" uses 6 textures just like a node, but all 6 must be defined.
	-- "sprite" uses 1 texture.
	-- "upright_sprite" uses 2 textures: {front, back}.
	-- "mesh" requires one texture for each mesh buffer/material (in order)
	-- Deprecated usage of "wielditem" expects 'textures = {itemname}' (see 'visual' above).

	colors = {},
	-- Number of required colors depends on visual

	use_texture_alpha = false,
	-- Use texture's alpha channel.
	-- Excludes "upright_sprite" and "wielditem".
	-- Note: currently causes visual issues when viewed through other
	-- semi-transparent materials such as water.

	spritediv = {x = 1, y = 1},
	-- Used with spritesheet textures for animation and/or frame selection
	-- according to position relative to player.
	-- Defines the number of columns and rows in the spritesheet:
	-- {columns, rows}.

	initial_sprite_basepos = {x = 0, y = 0},
	-- Used with spritesheet textures.
	-- Defines the {column, row} position of the initially used frame in the
	-- spritesheet.

	is_visible = true,
	-- If false, object is invisible and can't be pointed.

	makes_footstep_sound = false,
	-- If true, is able to make footstep sounds of nodes
	-- (see node sound definition for details).

	automatic_rotate = 0,
	-- Set constant rotation in radians per second, positive or negative.
	-- Object rotates along the local Y-axis, and works with set_rotation.
	-- Set to 0 to disable constant rotation.

	stepheight = 0,
	-- If positive number, object will climb upwards when it moves
	-- horizontally against a `walkable` node, if the height difference
	-- is within `stepheight`.

	automatic_face_movement_dir = 0.0,
	-- Automatically set yaw to movement direction, offset in degrees.
	-- 'false' to disable.

	automatic_face_movement_max_rotation_per_sec = -1,
	-- Limit automatic rotation to this value in degrees per second.
	-- No limit if value <= 0.

	backface_culling = true,
	-- Set to false to disable backface_culling for model

	glow = 0,
	-- Add this much extra lighting when calculating texture color.
	-- Value < 0 disables light's effect on texture color.
	-- For faking self-lighting, UI style entities, or programmatic coloring
	-- in mods.

	nametag = "",
	-- The name to display on the head of the object. By default empty.
	-- If the object is a player, a nil or empty nametag is replaced by the player's name.
	-- For all other objects, a nil or empty string removes the nametag.
	-- To hide a nametag, set its color alpha to zero. That will disable it entirely.

	--- @t ColorSpec
	nametag_color = "<ColorSpec>",
	-- Sets text color of nametag

	nametag_bgcolor = "<ColorSpec>",
	-- Sets background color of nametag
	-- `false` will cause the background to be set automatically based on user settings.
	-- Default: false

	infotext = "",
	-- Same as infotext for nodes. Empty by default

	static_save = true,
	-- If false, never save this object statically. It will simply be
	-- deleted when the block gets unloaded.
	-- The get_staticdata() callback is never called then.
	-- Defaults to 'true'.

	damage_texture_modifier = "^[brighten",
	-- Texture modifier to be applied for a short duration when object is hit

	shaded = true,
	-- Setting this to 'false' disables diffuse lighting of entity

	show_on_minimap = false,
	-- Defaults to true for players, false for other entities.
	-- If set to true the entity will show as a marker on the minimap.
}
