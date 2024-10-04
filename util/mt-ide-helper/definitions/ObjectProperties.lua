--- @class ObjectProperties
local ObjectProperties = {
	--- Defines the maximum and default HP of the entity
	--- For Lua entities the maximum is not enforced.
	--- For players this defaults to `minetest.PLAYER_MAX_HP_DEFAULT`.
	--- @type number
	hp_max = 10,

	--- For players only. Defaults to `minetest.PLAYER_MAX_BREATH_DEFAULT`.
	--- @type number
	breath_max = 0,

	--- For players only. Zoom FOV in degrees.
	--- Note that zoom loads and/or generates world beyond the server's
	--- maximum send and generate distances, so acts like a telescope.
	--- Smaller zoom_fov values increase the distance loaded/generated.
	--- Defaults to 15 in creative mode, 0 in survival mode.
	--- zoom_fov = 0 disables zooming for the player.
	--- @type number
	zoom_fov = 0.0,

	--- For players only. Camera height above feet position in nodes.
	--- @type number
	eye_height = 1.625,

	--- Collide with `walkable` nodes.
	--- @type boolean
	physical = false,

	--- Collide with other objects if physical = true
	--- @type boolean
	collide_with_objects = true,

	--- { xmin, ymin, zmin, xmax, ymax, zmax } in nodes from object position.
	--- Collision boxes cannot rotate, setting `rotate = true` on it has no effect.
	--- If not set, the selection box copies the collision box, and will also not rotate.
	--- default: `{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }`
	--- @type number[]
	collisionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
	--- { xmin, ymin, zmin, xmax, ymax, zmax } in nodes from object position.
	--- Collision boxes cannot rotate, setting `rotate = true` on it has no effect.
	--- If not set, the selection box copies the collision box, and will also not rotate.
	--- If `rotate = false`, the selection box will not rotate with the object itself, remaining fixed to the axes.
	--- If `rotate = true`, it will match the object's rotation and any attachment rotations.
	--- Raycasts use the selection box and object's rotation, but do *not* obey attachment rotations.
	--- For server-side raycasts to work correctly,
	--- the selection box should extend at most 5 units in each direction.
	--- @type number[]|{rotate:boolean}
	selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, rotate = false },

	--- Can be `true` if it is pointable, `false` if it can be pointed through,
	--- or `"blocking"` if it is pointable but not selectable.
	--- Clients older than 5.9.0 interpret `pointable = "blocking"` as `pointable = true`.
	--- Can be overridden by the `pointabilities` of the held item.
	--- @type boolean
	pointable = true,

	--- `"cube"` / `"sprite"` / `"upright_sprite" / `"mesh" / `"wielditem"` / `"item"`
	--- "cube" is a node-sized cube.
	--- "sprite" is a flat texture always facing the player.
	--- "upright_sprite" is a vertical flat texture.
	--- "mesh" uses the defined mesh model.
	--- "wielditem" is used for dropped items.
	---   (see builtin/game/item_entity.lua).
	---   For this use 'wield_item = itemname'.
	---   Setting 'textures = {itemname}' has the same effect, but is deprecated.
	---   If the item has a 'wield_image' the object will be an extrusion of
	---   that, otherwise:
	---   If 'itemname' is a cubic node or nodebox the object will appear
	---   identical to 'itemname'.
	---   If 'itemname' is a plantlike node the object will be an extrusion
	---   of its texture.
	---   Otherwise for non-node items, the object will be an extrusion of
	---   'inventory_image'.
	---   If 'itemname' contains a ColorString or palette index (e.g. from
	---   `minetest.itemstring_with_palette()`), the entity will inherit the color.
	---   Wielditems are scaled a bit. If you want a wielditem to appear
	---   to be as large as a node, use `0.667` in `visual_size`
	--- "item" is similar to "wielditem" but ignores the 'wield_image' parameter.
	--- @type string
	visual = '',

	--- Multipliers for the visual size. If `z` is not specified, `x` will be used
	--- to scale the entity along both horizontal axes.
	--- @type Position
	visual_size = {x = 1, y = 1, z = 1},

	--- File name of mesh when using "mesh" visual
	--- @type string
	mesh = "model.obj",

	--- Number of required textures depends on visual.
	--- "cube" uses 6 textures just like a node, but all 6 must be defined.
	--- "sprite" uses 1 texture.
	--- "upright_sprite" uses 2 textures: {front, back}.
	--- "mesh" requires one texture for each mesh buffer/material (in order)
	--- Deprecated usage of "wielditem" expects 'textures = {itemname}' (see 'visual' above).
	--- @type string[]
	textures = {},

	--- Number of required colors depends on visual
	--- @type string[]
	colors = {},

	--- Use texture's alpha channel.
	--- Excludes "upright_sprite" and "wielditem".
	--- Note: currently causes visual issues when viewed through other
	--- semi-transparent materials such as water.
	--- @type boolean
	use_texture_alpha = false,

	--- Used with spritesheet textures for animation and/or frame selection
	--- according to position relative to player.
	--- Defines the number of columns and rows in the spritesheet:
	--- {columns, rows}.
	--- @type {x:number, y:number}
	spritediv = {x = 1, y = 1},

	--- Used with spritesheet textures.
	--- Defines the {column, row} position of the initially used frame in the
	--- spritesheet.
	--- @type {x:number, y:number}
	initial_sprite_basepos = {x = 0, y = 0},

	--- If false, object is invisible and can't be pointed.
	--- @type boolean
	is_visible = true,

	--- If true, is able to make footstep sounds of nodes
	--- (see node sound definition for details).
	--- @type boolean
	makes_footstep_sound = false,

	--- Set constant rotation in radians per second, positive or negative.
	--- Object rotates along the local Y-axis, and works with set_rotation.
	--- Set to 0 to disable constant rotation.
	--- @type number
	automatic_rotate = 0,

	--- If positive number, object will climb upwards when it moves
	--- horizontally against a `walkable` node, if the height difference
	--- is within `stepheight`.
	--- @type number
	stepheight = 0,

	--- Automatically set yaw to movement direction, offset in degrees.
	--- 'false' to disable.
	--- @type number
	automatic_face_movement_dir = 0.0,

	--- Limit automatic rotation to this value in degrees per second.
	--- No limit if value <= 0.
	--- @type number
	automatic_face_movement_max_rotation_per_sec = -1,

	--- Set to false to disable backface_culling for model
	--- @type boolean
	backface_culling = true,

	--- Add this much extra lighting when calculating texture color.
	--- Value < 0 disables light's effect on texture color.
	--- For faking self-lighting, UI style entities, or programmatic coloring
	--- in mods.
	--- @type number
	glow = 0,

	--- The name to display on the head of the object. By default empty.
	--- If the object is a player, a nil or empty nametag is replaced by the player's name.
	--- For all other objects, a nil or empty string removes the nametag.
	--- To hide a nametag, set its color alpha to zero. That will disable it entirely.
	--- @type string
	nametag = "",

	--- Sets text color of nametag. See ColorSpec
	--- @type string
	nametag_color = "<ColorSpec>",

	--- Sets background color of nametag. See ColorSpec
	--- `false` will cause the background to be set automatically based on user settings.
	--- Default: false
	--- @type string|boolean
	nametag_bgcolor = "<ColorSpec>",

	--- Same as infotext for nodes. Empty by default
	--- @type string
	infotext = "",

	--- If false, never save this object statically. It will simply be
	--- deleted when the block gets unloaded.
	--- The get_staticdata() callback is never called then.
	--- Defaults to 'true'.
	--- @type boolean
	--- @type string
	static_save = true,

	--- Texture modifier to be applied for a short duration when object is hit
	--- @type string
	damage_texture_modifier = "^[brighten",

	--- Setting this to 'false' disables diffuse lighting of entity
	--- @type boolean
	shaded = true,

	--- Defaults to true for players, false for other entities.
	--- If set to true the entity will show as a marker on the minimap.
	--- @type boolean
	show_on_minimap = false,
}
