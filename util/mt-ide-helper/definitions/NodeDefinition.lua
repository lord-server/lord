--- @class NodeDefinition: ItemDefinition
NodeDefinition = {

	drawtype                      = "normal", -- See "Node drawtypes"

	visual_scale                  = 1.0,
	-- Supported for drawtypes "plantlike", "signlike", "torchlike",
	-- "firelike", "mesh", "nodebox", "allfaces".
	-- For plantlike and firelike, the image will start at the bottom of the
	-- node. For torchlike, the image will start at the surface to which the
	-- node "attaches". For the other drawtypes the image will be centered
	-- on the node.

	--- {tile definition 1, def2, def3, def4, def5, def6}
	---
	--- Textures of node; +Y, -Y, +X, -X, +Z, -Z
	--- List can be shortened to needed length.
	tiles                         = nil,

	--- {tile definition 1, def2, def3, def4, def5, def6}
	---
	--- Same as `tiles`, but these textures are drawn on top of the base
	--- tiles. You can use this to colorize only specific parts of your
	--- texture. If the texture name is an empty string, that overlay is not
	--- drawn. Since such tiles are drawn twice, it is not recommended to use
	--- overlays on very common nodes.
	overlay_tiles                 = nil,

	--- {tile definition 1, Tile definition 2},
	--- Special textures of node; used rarely.
	--- List can be shortened to needed length.
	special_tiles                 = nil,

	color                         = ColorSpec,
	-- The node's original color will be multiplied with this color.
	-- If the node has a palette, then this setting only has an effect in
	-- the inventory and on the wield item.

	use_texture_alpha             = ...,
	-- Specifies how the texture's alpha channel will be used for rendering.
	-- possible values:
	-- * "opaque": Node is rendered opaque regardless of alpha channel
	-- * "clip": A given pixel is either fully see-through or opaque
	--           depending on the alpha channel being below/above 50% in value
	-- * "blend": The alpha channel specifies how transparent a given pixel
	--            of the rendered node is
	-- The default is "opaque" for drawtypes normal, liquid and flowingliquid;
	-- "clip" otherwise.
	-- If set to a boolean value (deprecated): true either sets it to blend
	-- or clip, false sets it to clip or opaque mode depending on the drawtype.

	palette                       = "",
	-- The node's `param2` is used to select a pixel from the image.
	-- Pixels are arranged from left to right and from top to bottom.
	-- The node's color will be multiplied with the selected pixel's color.
	-- Tiles can override this behavior.
	-- Only when `paramtype2` supports palettes.

	post_effect_color             = "#00000000",
	-- Screen tint if player is inside node, see "ColorSpec"

	paramtype                     = "none", -- See "Nodes"

	paramtype2                    = "none", -- See "Nodes"

	place_param2                  = 0,
	-- Value for param2 that is set when player places node

	is_ground_content             = true,
	-- If false, the cave generator and dungeon generator will not carve
	-- through this node.
	-- Specifically, this stops mod-added nodes being removed by caves and
	-- dungeons when those generate in a neighbor mapchunk and extend out
	-- beyond the edge of that mapchunk.

	sunlight_propagates           = false,
	-- If true, sunlight will go infinitely through this node

	walkable                      = true, -- If true, objects collide with node

	pointable                     = true, -- If true, can be pointed at

	diggable                      = true, -- If false, can never be dug

	climbable                     = false, -- If true, can be climbed on like a ladder

	move_resistance               = 0,
	-- Slows down movement of players through this node (max. 7).
	-- If this is nil, it will be equal to liquid_viscosity.
	-- Note: If liquid movement physics apply to the node
	-- (see `liquid_move_physics`), the movement speed will also be
	-- affected by the `movement_liquid_*` settings.

	buildable_to                  = false, -- If true, placed nodes can replace this node

	floodable                     = false,
	-- If true, liquids flow into and replace this node.
	-- Warning: making a liquid node 'floodable' will cause problems.

	liquidtype                    = "none", -- specifies liquid flowing physics
	-- * "none":    no liquid flowing physics
	-- * "source":  spawns flowing liquid nodes at all 4 sides and below;
	--              recommended drawtype: "liquid".
	-- * "flowing": spawned from source, spawns more flowing liquid nodes
	--              around it until `liquid_range` is reached;
	--              will drain out without a source;
	--              recommended drawtype: "flowingliquid".
	-- If it's "source" or "flowing", then the
	-- `liquid_alternative_*` fields _must_ be specified

	liquid_alternative_flowing    = "",
	liquid_alternative_source     = "",
	-- These fields may contain node names that represent the
	-- flowing version (`liquid_alternative_flowing`) and
	-- source version (`liquid_alternative_source`) of a liquid.
	--
	-- Specifically, these fields are required if any of these is true:
	-- * `liquidtype ~= "none" or
	-- * `drawtype == "liquid" or
	-- * `drawtype == "flowingliquid"
	--
	-- Liquids consist of up to two nodes: source and flowing.
	--
	-- There are two ways to define a liquid:
	-- 1) Source node and flowing node. This requires both fields to be
	--    specified for both nodes.
	-- 2) Standalone source node (cannot flow). `liquid_alternative_source`
	--    must be specified and `liquid_range` must be set to 0.
	--
	-- Example:
	--     liquid_alternative_flowing = "example:water_flowing",
	--     liquid_alternative_source = "example:water_source",

	liquid_viscosity              = 0,
	-- Controls speed at which the liquid spreads/flows (max. 7).
	-- 0 is fastest, 7 is slowest.
	-- By default, this also slows down movement of players inside the node
	-- (can be overridden using `move_resistance`)

	liquid_renewable              = true,
	-- If true, a new liquid source can be created by placing two or more
	-- sources nearby

	liquid_move_physics           = nil, -- specifies movement physics if inside node
	-- * false: No liquid movement physics apply.
	-- * true: Enables liquid movement physics. Enables things like
	--   ability to "swim" up/down, sinking slowly if not moving,
	--   smoother speed change when falling into, etc. The `movement_liquid_*`
	--   settings apply.
	-- * nil: Will be treated as true if `liquidtype ~= "none"`
	--   and as false otherwise.

	leveled                       = 0,
	-- Only valid for "nodebox" drawtype with 'type = "leveled"'.
	-- Allows defining the nodebox height without using param2.
	-- The nodebox height is 'leveled' / 64 nodes.
	-- The maximum value of 'leveled' is `leveled_max`.

	leveled_max                   = 127,
	-- Maximum value for `leveled` (0-127), enforced in
	-- `minetest.set_node_level` and `minetest.add_node_level`.
	-- Values above 124 might causes collision detection issues.

	liquid_range                  = 8,
	-- Maximum distance that flowing liquid nodes can spread around
	-- source on flat land;
	-- maximum = 8; set to 0 to disable liquid flow

	drowning                      = 0,
	-- Player will take this amount of damage if no bubbles are left

	damage_per_second             = 0,
	-- If player is inside node, this damage is caused

	node_box                      = {type = "regular"}, -- See "Node boxes"

	connects_to                   = {},
	-- Used for nodebox nodes with the type == "connected".
	-- Specifies to what neighboring nodes connections will be drawn.
	-- e.g. `{"group:fence", "default:wood"}` or `"default:stone"`

	connect_sides                 = {},
	-- Tells connected nodebox nodes to connect only to these sides of this
	-- node. possible: "top", "bottom", "front", "left", "back", "right"

	mesh                          = "",
	-- File name of mesh when using "mesh" drawtype

	selection_box                 = {
		-- see [Node boxes] for possibilities
	},
	-- Custom selection box definition. Multiple boxes can be defined.
	-- If "nodebox" drawtype is used and selection_box is nil, then node_box
	-- definition is used for the selection box.

	collision_box                 = {
		-- see [Node boxes] for possibilities
	},
	-- Custom collision box definition. Multiple boxes can be defined.
	-- If "nodebox" drawtype is used and collision_box is nil, then node_box
	-- definition is used for the collision box.

	-- Support maps made in and before January 2012
	legacy_facedir_simple         = false,
	legacy_wallmounted            = false,

	waving                        = 0,
	-- Valid for drawtypes:
	-- mesh, nodebox, plantlike, allfaces_optional, liquid, flowingliquid.
	-- 1 - wave node like plants (node top moves side-to-side, bottom is fixed)
	-- 2 - wave node like leaves (whole node moves side-to-side)
	-- 3 - wave node like liquids (whole node moves up and down)
	-- Not all models will properly wave.
	-- plantlike drawtype can only wave like plants.
	-- allfaces_optional drawtype can only wave like leaves.
	-- liquid, flowingliquid drawtypes can only wave like liquids.

	sounds                        = {
		-- Definition of node sounds to be played at various events.
		-- All fields in this table are optional.

		--- @type SimpleSoundSpec
		footstep     = nil,
		-- If walkable, played when object walks on it. If node is
		-- climbable or a liquid, played when object moves through it

		--- @type SimpleSoundSpec|string
		dig          = {} or "__group",
		-- While digging node.
		-- If `"__group"`, then the sound will be
		-- `{name = "default_dig_<groupname>", gain = 0.5}` , where `<groupname>` is the
		-- name of the item's digging group with the fastest digging time.
		-- In case of a tie, one of the sounds will be played (but we
		-- cannot predict which one)
		-- Default value: `"__group"`

		--- @type SimpleSoundSpec
		dug          = nil,
		-- Node was dug

		--- @type SimpleSoundSpec
		place        = nil,
		-- Node was placed. Also played after falling

		--- @type SimpleSoundSpec
		place_failed = nil,
		-- When node placement failed.
		-- Note: This happens if the _built-in_ node placement failed.
		-- This sound will still be played if the node is placed in the
		-- `on_place` callback manually.

		--- @type SimpleSoundSpec
		fall         = nil,
		-- When node starts to fall or is detached
	},

	drop                          = "",
	-- Name of dropped item when dug.
	-- Default dropped item is the node itself.

	-- Using a table allows multiple items, drop chances and item filtering:
	drop                          = {
		max_items = 1,
		-- Maximum number of item lists to drop.
		-- The entries in 'items' are processed in order. For each:
		-- Item filtering is applied, chance of drop is applied, if both are
		-- successful the entire item list is dropped.
		-- Entry processing continues until the number of dropped item lists
		-- equals 'max_items'.
		-- Therefore, entries should progress from low to high drop chance.
		items     = {
			-- Examples:
			{
				-- 1 in 1000 chance of dropping a diamond.
				-- Default rarity is '1'.
				rarity = 1000,
				items  = {"default:diamond"},
			},
			{
				-- Only drop if using an item whose name is identical to one
				-- of these.
				tools         = {"default:shovel_mese", "default:shovel_diamond"},
				rarity        = 5,
				items         = {"default:dirt"},
				-- Whether all items in the dropped item list inherit the
				-- hardware coloring palette color from the dug node.
				-- Default is 'false'.
				inherit_color = true,
			},
			{
				-- Only drop if using an item whose name contains
				-- "default:shovel_" (this item filtering by string matching
				-- is deprecated, use tool_groups instead).
				tools  = {"~default:shovel_"},
				rarity = 2,
				-- The item list dropped.
				items  = {"default:sand", "default:desert_sand"},
			},
			{
				-- Only drop if using an item in the "magicwand" group, or
				-- an item that is in both the "pickaxe" and the "lucky"
				-- groups.
				tool_groups = {
					"magicwand",
					{"pickaxe", "lucky"}
				},
				items       = {"default:coal_lump"},
			},
		},
	},

	--- @type fun(pos:Position)
	on_construct                  = nil,
	-- Node constructor; called after adding node.
	-- Can set up metadata and stuff like that.
	-- Not called for bulk node placement (i.e. schematics and VoxelManip).
	-- Note: Within an on_construct callback, minetest.set_node can cause an
	-- infinite loop if it invokes the same callback.
	--  Consider using minetest.swap_node instead.
	-- default: nil

	--- @type fun(pos:Position)
	on_destruct                   = nil,
	-- Node destructor; called before removing node.
	-- Not called for bulk node placement.
	-- default: nil

	--- @type fun(pos:Position, oldnode)
	after_destruct                = nil,
	-- Node destructor; called after removing node.
	-- Not called for bulk node placement.
	-- default: nil

	--- @type fun(pos:Position, oldnode, newnode)
	on_flood                      = nil,
	-- Called when a liquid (newnode) is about to flood oldnode, if it has
	-- `floodable = true` in the nodedef. Not called for bulk node placement
	-- (i.e. schematics and VoxelManip) or air nodes. If return true the
	-- node is not flooded, but on_flood callback will most likely be called
	-- over and over again every liquid update interval.
	-- Default: nil
	-- Warning: making a liquid node 'floodable' will cause problems.


	--- @type fun(pos:Position, oldnode, newnode, oldmeta, drops:ItemStack[])
	preserve_metadata             = nil,
	-- Called when oldnode is about be converted to an item, but before the
	-- node is deleted from the world or the drops are added. This is
	-- generally the result of either the node being dug or an attached node
	-- becoming detached.
	-- oldmeta are the metadata fields (table) of the node before deletion.
	-- drops is a table of ItemStacks, so any metadata to be preserved can
	-- be added directly to one or more of the dropped items. See
	-- "ItemStackMetaRef".
	-- default: nil

	--- @type fun(pos:Position, placer:Player|ObjectRef|nil, itemstack:ItemStack, pointed_thing:pointed_thing)
	after_place_node              = nil,
	-- Called after constructing node when node was placed using
	-- minetest.item_place_node / minetest.place_node.
	-- If return true no item is taken from itemstack.
	-- `placer` may be any valid ObjectRef or nil.
	-- default: nil

	--- @type fun(pos:Player, oldnode, oldmetadata, digger:Player|ObjectRef|nil)
	after_dig_node                = nil,
	-- oldmetadata is in table format.
	-- Called after destructing node when node was dug using
	-- minetest.node_dig / minetest.dig_node.
	-- default: nil

	--- @type fun(pos:Position, player:Player|ObjectRef|nil)
	can_dig                       = nil,
	-- Returns true if node can be dug, or false if not.
	-- default: nil

	--- @type fun(pos:Position, node, puncher:Player|ObjectRef|nil, pointed_thing:pointed_thing)
	on_punch                      = nil,
	-- default: minetest.node_punch
	-- Called when puncher (an ObjectRef) punches the node at pos.
	-- By default calls minetest.register_on_punchnode callbacks.

	--- @type fun (pos:Position, node, clicker:Player|ObjectRef|nil, itemstack:ItemStack, pointed_thing:pointed_thing)
	on_rightclick                 = nil,
	-- default: nil
	-- Called when clicker (an ObjectRef) used the 'place/build' key
	-- (not necessarily an actual rightclick)
	-- while pointing at the node at pos with 'node' being the node table.
	-- itemstack will hold clicker's wielded item.
	-- Shall return the leftover itemstack.
	-- Note: pointed_thing can be nil, if a mod calls this function.
	-- This function does not get triggered by clients <=0.4.16 if the
	-- "formspec" node metadata field is set.

	--- @type fun(pos, node, digger)
	on_dig                        = nil,
	-- default: minetest.node_dig
	-- By default checks privileges, wears out item (if tool) and removes node.
	-- return true if the node was dug successfully, false otherwise.
	-- Deprecated: returning nil is the same as returning true.

	--- @type fun(pos, elapsed)
	on_timer                      = nil,
	-- default: nil
	-- called by NodeTimers, see minetest.get_node_timer and NodeTimerRef.
	-- elapsed is the total time passed since the timer was started.
	-- return true to run the timer for another cycle with the same timeout
	-- value.

	--- @type fun(pos, formname, fields, sender)
	on_receive_fields             = nil,
	-- fields = {name1 = value1, name2 = value2, ...}
	-- Called when an UI form (e.g. sign text input) returns data.
	-- See minetest.register_on_player_receive_fields for more info.
	-- default: nil

	--- @type fun(pos, from_list, from_index, to_list, to_index, count, player)
	allow_metadata_inventory_move = nil,
	-- Called when a player wants to move items inside the inventory.
	-- Return value: number of items allowed to move.

	--- @type fun(pos, listname, index, stack, player)
	allow_metadata_inventory_put  = nil,
	-- Called when a player wants to put something into the inventory.
	-- Return value: number of items allowed to put.
	-- Return value -1: Allow and don't modify item count in inventory.

	--- @type fun(pos, listname, index, stack, player)
	allow_metadata_inventory_take = nil,
	-- Called when a player wants to take something out of the inventory.
	-- Return value: number of items allowed to take.
	-- Return value -1: Allow and don't modify item count in inventory.

	--- @type fun(pos, from_list, from_index, to_list, to_index, count, player)
	on_metadata_inventory_move    = nil,
	--- @type fun(pos, listname, index, stack, player)
	on_metadata_inventory_put     = nil,
	--- @type fun(pos, listname, index, stack, player)
	on_metadata_inventory_take    = nil,
	-- Called after the actual action has happened, according to what was
	-- allowed.
	-- No return value.

	--- @type fun (pos, intensity)
	on_blast                      = nil,
	-- intensity: 1.0 = mid range of regular TNT.
	-- If defined, called when an explosion touches the node, instead of
	-- removing the node.

	mod_origin                    = "modname",
	-- stores which mod actually registered a node
	-- If the source could not be determined it contains "??"
	-- Useful for getting which mod truly registered something
	-- example: if a node is registered as ":othermodname:nodename",
	-- nodename will show "othermodname", but mod_origin will say "modname"
}
