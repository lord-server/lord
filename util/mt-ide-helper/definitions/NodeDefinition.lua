--- @class NodeDefinition: ItemDefinition
local NodeDefinition = {

	--- For last version see ["Node drawtypes"](https://api.luanti.org/nodes/#node-drawtypes)
	---
	--- There are a bunch of different looking node types.
	---	* `normal`
	---   * * A node-sized cube.
	--- * `airlike`
	---   * * Invisible, uses no texture.
	--- * `liquid`
	---   * * The cubic source node for a liquid.
	---   * * Faces bordering to the same node are never rendered.
	---   * * Connects to node specified in `liquid_alternative_flowing` if specified.
	---   * * Use `backface_culling = false` for the tiles you want to make
	---       visible when inside the node.
	--- * `flowingliquid`
	---   * * The flowing version of a liquid, appears with various heights and slopes.
	---   * * Faces bordering to the same node are never rendered.
	---   * * Connects to node specified in `liquid_alternative_source`.
	---   * * You *must* set `liquid_alternative_flowing` to the node's own name.
	---   * * Node textures are defined with `special_tiles` where the first tile
	---       is for the top and bottom faces and the second tile is for the side
	---       faces.
	---   * * `tiles` is used for the item/inventory/wield image rendering.
	---   * * Use `backface_culling = false` for the special tiles you want to make
	---       visible when inside the node
	--- * `glasslike`
	---   * * Often used for partially-transparent nodes.
	---   * * Only external sides of textures are visible.
	--- * `glasslike_framed`
	---   * * All face-connected nodes are drawn as one volume within a surrounding
	---       frame.
	---   * * The frame appearance is generated from the edges of the first texture
	---       specified in `tiles`. The width of the edges used are 1/16th of texture
	---       size: 1 pixel for 16x16, 2 pixels for 32x32 etc.
	---   * * The glass 'shine' (or other desired detail) on each node face is supplied
	---       by the second texture specified in `tiles`.
	--- * `glasslike_framed_optional`
	---   * * This switches between the above 2 drawtypes according to the menu setting
	---       'Connected Glass'.
	--- * `allfaces`
	---   * * Often used for partially-transparent nodes.
	---   * * External sides of textures, and unlike other drawtypes, the external sides
	---       of other nodes, are visible from the inside.
	--- * `allfaces_optional`
	---   * * Often used for leaves nodes.
	---   * * This switches between `normal`, `glasslike` and `allfaces` according to
	---       the menu setting: Opaque Leaves / Simple Leaves / Fancy Leaves.
	---   * * With 'Simple Leaves' selected, the texture specified in `special_tiles`
	---       is used instead, if present. This allows a visually thicker texture to be
	---       used to compensate for how `glasslike` reduces visual thickness.
	--- * `torchlike`
	---   * * A single vertical texture.
	---   * * If `paramtype2="[color]wallmounted"`:
	---     * * * If placed on top of a node, uses the first texture specified in `tiles`.
	---     * * * If placed against the underside of a node, uses the second texture
	---           specified in `tiles`.
	---     * * * If placed on the side of a node, uses the third texture specified in
	---           `tiles` and is perpendicular to that node.
	---   * * If `paramtype2="none"`:
	---     * * * Will be rendered as if placed on top of a node (see
	---           above) and only the first texture is used.
	--- * `signlike`
	---   * * A single texture parallel to, and mounted against, the top, underside or
	---       side of a node.
	---   * * If `paramtype2="[color]wallmounted"`, it rotates according to `param2`
	---   * * If `paramtype2="none"`, it will always be on the floor.
	--- * `plantlike`
	---   * * Two vertical and diagonal textures at right-angles to each other.
	---   * * See `paramtype2 = "meshoptions"` above for other options.
	--- * `firelike`
	---   * * When above a flat surface, appears as 6 textures, the central 2 as
	---       `plantlike` plus 4 more surrounding those.
	---   * * If not above a surface the central 2 do not appear, but the texture
	---       appears against the faces of surrounding nodes if they are present.
	--- * `fencelike`
	---   * * A 3D model suitable for a wooden fence.
	---   * * One placed node appears as a single vertical post.
	---   * * Adjacently-placed nodes cause horizontal bars to appear between them.
	--- * `raillike`
	---   * * Often used for tracks for mining carts.
	---   * * Requires 4 textures to be specified in `tiles`, in order: Straight,
	---       curved, t-junction, crossing.
	---   * * Each placed node automatically switches to a suitable rotated texture
	---       determined by the adjacent `raillike` nodes, in order to create a
	---       continuous track network.
	---   * * Becomes a sloping node if placed against stepped nodes.
	--- * `nodebox`
	---   * * Often used for stairs and slabs.
	---   * * Allows defining nodes consisting of an arbitrary number of boxes.
	---   * * See [Node boxes] below for more information.
	--- * `mesh`
	---   * * Uses models for nodes.
	---   * * Tiles should hold model materials textures.
	---   * * Only static meshes are implemented.
	---   * * For supported model formats see Irrlicht engine documentation.
	--- * `plantlike_rooted`
	---   * * Enables underwater `plantlike` without air bubbles around the nodes.
	---   * * Consists of a base cube at the coordinates of the node plus a
	---       `plantlike` extension above
	---   * * If `paramtype2="leveled", the `plantlike` extension has a height
	---       of `param2 / 16` nodes, otherwise it's the height of 1 node
	---   * * If `paramtype2="wallmounted"`, the `plantlike` extension
	---       will be at one of the corresponding 6 sides of the base cube.
	---       Also, the base cube rotates like a `normal` cube would
	---   * * The `plantlike` extension visually passes through any nodes above the
	---       base cube without affecting them.
	---   * * The base cube texture tiles are defined as normal, the `plantlike`
	---       extension uses the defined special tile, for example:
	---       `special_tiles = {{name = "default_papyrus.png"}},`
	---
	--- `*_optional` drawtypes need less rendering time if deactivated(always client-side).
	---
	--- @type string?
	drawtype                      = "normal",

	--- Supported for drawtypes "plantlike", "signlike", "torchlike",
	--- "firelike", "mesh", "nodebox", "allfaces".
	--- For plantlike and firelike, the image will start at the bottom of the
	--- node. For torchlike, the image will start at the surface to which the
	--- node "attaches". For the other drawtypes the image will be centered
	--- on the node.
	--- @type number?
	visual_scale                  = 1.0,

	--- {tile definition 1, def2, def3, def4, def5, def6}
	---
	--- Textures of node; +Y, -Y, +X, -X, +Z, -Z
	--- List can be shortened to needed length.
	--- @type table<number,string|TileDefinition>?
	tiles                         = nil,

	--- {tile definition 1, def2, def3, def4, def5, def6}
	---
	--- Same as `tiles`, but these textures are drawn on top of the base
	--- tiles. You can use this to colorize only specific parts of your
	--- texture. If the texture name is an empty string, that overlay is not
	--- drawn. Since such tiles are drawn twice, it is not recommended to use
	--- overlays on very common nodes.
	--- @type table<number,string|TileDefinition>?
	overlay_tiles                 = nil,

	--- {tile definition 1, Tile definition 2},
	--- Special textures of node; used rarely.
	--- List can be shortened to needed length.
	--- @type table<number,string|TileDefinition>?
	special_tiles                 = nil,

	--- The node's original color will be multiplied with this color.
	--- If the node has a palette, then this setting only has an effect in
	--- the inventory and on the wield item.
	--- @see ColorSpec
	--- @type string|ColorSpec|nil
	color                         = '',

	--- Specifies how the texture's alpha channel will be used for rendering.
	--- possible values:
	--- * "opaque": Node is rendered opaque regardless of alpha channel
	--- * "clip": A given pixel is either fully see-through or opaque
	---           depending on the alpha channel being below/above 50% in value
	--- * "blend": The alpha channel specifies how transparent a given pixel
	---            of the rendered node is
	--- The default is "opaque" for drawtypes normal, liquid and flowingliquid;
	--- "clip" otherwise.
	--- If set to a boolean value (deprecated): true either sets it to blend
	--- or clip, false sets it to clip or opaque mode depending on the drawtype.
	--- @type string?
	use_texture_alpha             = "opaque",

	--- The node's `param2` is used to select a pixel from the image.
	--- Pixels are arranged from left to right and from top to bottom.
	--- The node's color will be multiplied with the selected pixel's color.
	--- Tiles can override this behavior.
	--- Only when `paramtype2` supports palettes.
	--- @type string?
	palette                       = "",

	--- Screen tint if player is inside node, see "ColorSpec"
	--- @type string?
	post_effect_color             = "#00000000",

	--- See "Nodes"
	--- @type string?
	paramtype                     = "none",

	--- See "Nodes"
	--- @type string?
	paramtype2                    = "none",

	--- Value for param2 that is set when player places node
	--- @type number?
	place_param2                  = 0,

	--- If false, the cave generator and dungeon generator will not carve
	--- through this node.
	--- Specifically, this stops mod-added nodes being removed by caves and
	--- dungeons when those generate in a neighbor mapchunk and extend out
	--- beyond the edge of that mapchunk.
	--- @type boolean?
	is_ground_content             = true,

	--- If true, sunlight will go infinitely through this node
	--- @type boolean?
	sunlight_propagates           = false,

	--- If true, objects collide with node
	--- @type boolean?
	walkable                      = true,

	--- If true, can be pointed at
	--- @type boolean?
	pointable                     = true,

	--- If false, can never be dug
	--- @type boolean?
	diggable                      = true,

	--- If true, can be climbed on like a ladder
	--- @type boolean?
	climbable                     = false,

	--- Slows down movement of players through this node (max. 7).
	--- If this is nil, it will be equal to liquid_viscosity.
	--- Note: If liquid movement physics apply to the node
	--- (see `liquid_move_physics`), the movement speed will also be
	--- affected by the `movement_liquid_*` settings.
	--- @type number?
	move_resistance               = 0,

	--- If true, placed nodes can replace this node
	--- @type boolean?
	buildable_to                  = false,

	--- If true, liquids flow into and replace this node.
	--- Warning: making a liquid node 'floodable' will cause problems.
	--- @type boolean?
	floodable                     = false,

	--- specifies liquid flowing physics
	--- * "none":    no liquid flowing physics
	--- * "source":  spawns flowing liquid nodes at all 4 sides and below;
	---              recommended drawtype: "liquid".
	--- * "flowing": spawned from source, spawns more flowing liquid nodes
	---              around it until `liquid_range` is reached;
	---              will drain out without a source;
	---              recommended drawtype: "flowingliquid".
	--- If it's "source" or "flowing", then the
	--- `liquid_alternative_*` fields _must_ be specified
	--- @type string?
	liquidtype                    = "none",

	--- These fields may contain node names that represent the
	--- flowing version (`liquid_alternative_flowing`) and
	--- source version (`liquid_alternative_source`) of a liquid.
	---
	--- Specifically, these fields are required if any of these is true:
	--- * `liquidtype ~= "none" or
	--- * `drawtype == "liquid" or
	--- * `drawtype == "flowingliquid"
	---
	--- Liquids consist of up to two nodes: source and flowing.
	---
	--- There are two ways to define a liquid:
	--- 1) Source node and flowing node. This requires both fields to be
	---    specified for both nodes.
	--- 2) Standalone source node (cannot flow). `liquid_alternative_source`
	---    must be specified and `liquid_range` must be set to 0.
	---
	--- Example:
	---     liquid_alternative_flowing = "example:water_flowing",
	---     liquid_alternative_source = "example:water_source",
	--- @type string?
	liquid_alternative_flowing    = "",

	--- These fields may contain node names that represent the
	--- flowing version (`liquid_alternative_flowing`) and
	--- source version (`liquid_alternative_source`) of a liquid.
	---
	--- Specifically, these fields are required if any of these is true:
	--- * `liquidtype ~= "none" or
	--- * `drawtype == "liquid" or
	--- * `drawtype == "flowingliquid"
	---
	--- Liquids consist of up to two nodes: source and flowing.
	---
	--- There are two ways to define a liquid:
	--- 1) Source node and flowing node. This requires both fields to be
	---    specified for both nodes.
	--- 2) Standalone source node (cannot flow). `liquid_alternative_source`
	---    must be specified and `liquid_range` must be set to 0.
	---
	--- Example:
	---     liquid_alternative_flowing = "example:water_flowing",
	---     liquid_alternative_source = "example:water_source",
	--- @type string?
	liquid_alternative_source     = "",

	--- Controls speed at which the liquid spreads/flows (max. 7).
	--- 0 is fastest, 7 is slowest.
	--- By default, this also slows down movement of players inside the node
	--- (can be overridden using `move_resistance`)
	--- @type number?
	liquid_viscosity              = 0,

	--- If true, a new liquid source can be created by placing two or more
	--- sources nearby
	--- @type boolean?
	liquid_renewable              = true,

	--- specifies movement physics if inside node
	--- * false: No liquid movement physics apply.
	--- * true: Enables liquid movement physics. Enables things like
	---   ability to "swim" up/down, sinking slowly if not moving,
	---   smoother speed change when falling into, etc. The `movement_liquid_*`
	---   settings apply.
	--- * nil: Will be treated as true if `liquidtype ~= "none"`
	---   and as false otherwise.
	--- @type boolean|nil
	liquid_move_physics           = nil,

	--- Only valid for "nodebox" drawtype with 'type = "leveled"'.
	--- Allows defining the nodebox height without using param2.
	--- The nodebox height is 'leveled' / 64 nodes.
	--- The maximum value of 'leveled' is `leveled_max`.
	--- @type number?
	leveled                       = 0,

	--- Maximum value for `leveled` (0-127), enforced in
	--- `minetest.set_node_level` and `minetest.add_node_level`.
	--- Values above 124 might causes collision detection issues.
	--- @type number?
	leveled_max                   = 127,

	--- Maximum distance that flowing liquid nodes can spread around
	--- source on flat land;
	--- maximum = 8; set to 0 to disable liquid flow
	--- @type number?
	liquid_range                  = 8,

	--- Player will take this amount of damage if no bubbles are left
	--- @type number?
	drowning                      = 0,

	--- If player is inside node, this damage is caused
	--- @type number?
	damage_per_second             = 0,

	--- See "Node boxes"
	--- @type table?
	node_box                      = {type = "regular"},

	--- Used for nodebox nodes with the type == "connected".
	--- Specifies to what neighboring nodes connections will be drawn.
	--- e.g. `{"group:fence", "default:wood"}` or `"default:stone"`
	--- @type string[]?
	connects_to                   = {},

	--- Tells connected nodebox nodes to connect only to these sides of this
	--- node. possible: "top", "bottom", "front", "left", "back", "right"
	--- @type string[]?
	connect_sides                 = {},

	--- File name of mesh when using "mesh" drawtype
	--- @type string?
	mesh                          = "",

	--- Custom selection box definition. Multiple boxes can be defined.
	--- If "nodebox" drawtype is used and selection_box is nil, then node_box
	--- definition is used for the selection box.
	--- see [Node boxes] for possibilities
	--- @type table?
	selection_box                 = {},

	--- see [Node boxes] for possibilities
	--- Custom collision box definition. Multiple boxes can be defined.
	--- If "nodebox" drawtype is used and collision_box is nil, then node_box
	--- definition is used for the collision box.
	--- @type table?
	collision_box                 = {},

	--- Support maps made in and before January 2012
	--- @type boolean?
	legacy_facedir_simple         = false,
	--- Support maps made in and before January 2012
	--- @type boolean?
	legacy_wallmounted            = false,

	--- Valid for drawtypes:
	--- mesh, nodebox, plantlike, allfaces_optional, liquid, flowingliquid.
	--- 1 - wave node like plants (node top moves side-to-side, bottom is fixed)
	--- 2 - wave node like leaves (whole node moves side-to-side)
	--- 3 - wave node like liquids (whole node moves up and down)
	--- Not all models will properly wave.
	--- plantlike drawtype can only wave like plants.
	--- allfaces_optional drawtype can only wave like leaves.
	--- liquid, flowingliquid drawtypes can only wave like liquids.
	--- @type number?
	waving                        = 0,

	--- Definition of node sounds to be played at various events.
	--- All fields in this table are optional.
	--- @type nil|table<string,SimpleSoundSpec|string?>
	sounds                        = {

		--- If walkable, played when object walks on it. If node is
		--- climbable or a liquid, played when object moves through it
		--- @type SimpleSoundSpec?
		footstep     = nil,

		--- While digging node.
		--- If `"__group"`, then the sound will be
		--- `{name = "default_dig_<groupname>", gain = 0.5}` , where `<groupname>` is the
		--- name of the item's digging group with the fastest digging time.
		--- In case of a tie, one of the sounds will be played (but we
		--- cannot predict which one)
		--- Default value: `"__group"`
		--- @type nil|SimpleSoundSpec|string
		dig          = {} or "__group",

		--- Node was dug
		--- @type SimpleSoundSpec?
		dug          = nil,

		--- Node was placed. Also played after falling
		--- @type SimpleSoundSpec?
		place        = nil,

		--- When node placement failed.
		--- Note: This happens if the _built-in_ node placement failed.
		--- This sound will still be played if the node is placed in the
		--- `on_place` callback manually.
		--- @type SimpleSoundSpec?
		place_failed = nil,

		--- When node starts to fall or is detached
		--- @type SimpleSoundSpec?
		fall         = nil,
	},

	--- Name of dropped item when dug.
	--- Default dropped item is the node itself.
	--- Using a table allows multiple items, drop chances and item filtering:
	--- @type table?
	drop                          = {
		--- Maximum number of item lists to drop.
		--- The entries in 'items' are processed in order. For each:
		--- Item filtering is applied, chance of drop is applied, if both are
		--- successful the entire item list is dropped.
		--- Entry processing continues until the number of dropped item lists
		--- equals 'max_items'.
		--- Therefore, entries should progress from low to high drop chance.
		--- @type number
		max_items = 1,
		--- Examples:
		--- ```lua
		--- {
		--- 	-- 1 in 1000 chance of dropping a diamond.
		--- 	-- Default rarity is '1'.
		--- 	rarity = 1000,
		--- 	items  = {"default:diamond"},
		--- },
		--- {
		--- 	-- Only drop if using an item whose name is identical to one
		--- 	-- of these.
		--- 	tools         = {"default:shovel_mese", "default:shovel_diamond"},
		--- 	rarity        = 5,
		--- 	items         = {"default:dirt"},
		--- 	-- Whether all items in the dropped item list inherit the
		--- 	-- hardware coloring palette color from the dug node.
		--- 	-- Default is 'false'.
		--- 	inherit_color = true,
		--- },
		--- {
		--- 	-- Only drop if using an item whose name contains
		--- 	-- "default:shovel_" (this item filtering by string matching
		--- 	-- is deprecated, use tool_groups instead).
		--- 	tools  = {"~default:shovel_"},
		--- 	rarity = 2,
		--- 	-- The item list dropped.
		--- 	items  = {"default:sand", "default:desert_sand"},
		--- },
		--- {
		--- 	-- Only drop if using an item in the "magicwand" group, or
		--- 	-- an item that is in both the "pickaxe" and the "lucky"
		--- 	-- groups.
		--- 	tool_groups = {
		--- 		"magicwand",
		--- 		{"pickaxe", "lucky"}
		--- 	},
		--- 	items       = {"default:coal_lump"},
		--- },
		--- ```
		items     = {},
	},

	--- Node constructor; called after adding node.
	--- Can set up metadata and stuff like that.
	--- Not called for bulk node placement (i.e. schematics and `VoxelManip`).
	--- Note: Within an on_construct callback, minetest.set_node can cause an
	--- infinite loop if it invokes the same callback.
	---  Consider using `minetest.swap_node()` instead.
	--- default: nil
	--- @type fun(pos:Position)?
	on_construct                  = nil,

	--- Node destructor; called before removing node.
	--- Not called for bulk node placement.
	--- default: nil
	--- @type fun(pos:Position)?
	on_destruct                   = nil,

	--- Node destructor; called after removing node.
	--- Not called for bulk node placement.
	--- default: nil
	--- @type fun(pos:Position, old_node)?
	after_destruct                = nil,

	--- Called when a liquid (new_node) is about to flood old_node, if it has
	--- `floodable = true` in the nodedef. Not called for bulk node placement
	--- (i.e. schematics and `VoxelManip`) or air nodes. If return true the
	--- node is not flooded, but on_flood callback will most likely be called
	--- over and over again every liquid update interval.
	--- Default: nil
	--- Warning: making a liquid node 'floodable' will cause problems.
	--- @type fun(pos:Position, old_node, new_node)?
	on_flood                      = nil,


	--- Called when `old_node` is about be converted to an item, but before the
	--- node is deleted from the world or the drops are added. This is
	--- generally the result of either the node being dug or an attached node
	--- becoming detached.
	--- `old_meta` are the metadata fields (table) of the node before deletion.
	--- drops is a table of `ItemStacks`, so any metadata to be preserved can
	--- be added directly to one or more of the dropped items.
	--- @see ItemStackMetaRef
	--- default: nil
	--- @type fun(pos:Position, old_node, new_node, old_meta, drops:ItemStack[])?
	preserve_metadata             = nil,

	--- Called after constructing node when node was placed using
	--- minetest.item_place_node / minetest.place_node.
	--- If return true no item is taken from itemstack.
	--- `placer` may be any valid ObjectRef or nil.
	--- default: nil
	--- @type fun(pos:Position, placer:Player|ObjectRef|nil, itemstack:ItemStack, pointed_thing:pointed_thing)?
	after_place_node              = nil,

	--- oldmetadata is in table format.
	--- Called after destructing node when node was dug using
	--- minetest.node_dig / minetest.dig_node.
	--- default: nil
	--- @type fun(pos:Player, oldnode, oldmetadata, digger:Player|ObjectRef|nil)?
	after_dig_node                = nil,

	--- Returns true if node can be dug, or false if not.
	--- default: nil
	--- @type fun(pos:Position, player:Player|ObjectRef|nil)?
	can_dig                       = nil,

	--- default: minetest.node_punch
	--- Called when puncher (an ObjectRef) punches the node at pos.
	--- By default calls minetest.register_on_punchnode callbacks.
	--- @type fun(pos:Position, node:NodeTable, puncher:Player|ObjectRef|nil, pointed_thing:pointed_thing)?
	on_punch                      = nil,

	--- default: nil
	--- Called when clicker (an ObjectRef) used the 'place/build' key
	--- (not necessarily an actual rightclick)
	--- while pointing at the node at pos with 'node' being the node table.
	--- itemstack will hold clicker's wielded item.
	--- Shall return the leftover itemstack.
	--- Note: pointed_thing can be nil, if a mod calls this function.
	--- This function does not get triggered by clients <=0.4.16 if the
	--- "formspec" node metadata field is set.
	--- @type fun(pos:Position, node:NodeTable, clicker:Player|ObjectRef|nil, itemstack:ItemStack, pointed_thing:pointed_thing|nil)?
	on_rightclick                 = nil,

	--- default: minetest.node_dig
	--- By default checks privileges, wears out item (if tool) and removes node.
	--- return true if the node was dug successfully, false otherwise.
	--- Deprecated: returning nil is the same as returning true.
	--- @type (fun(pos:Position, node:NodeTable, digger:Player): boolean)?
	on_dig                        = nil,

	--- default: nil
	--- called by NodeTimers, see minetest.get_node_timer and NodeTimerRef.
	--- elapsed is the total time passed since the timer was started.
	--- return true to run the timer for another cycle with the same timeout
	--- value.
	--- @type (fun(pos:Position, elapsed:number): boolean)?
	on_timer                      = nil,

	--- fields = {name1 = value1, name2 = value2, ...}
	--- Called when an UI form (e.g. sign text input) returns data.
	--- See minetest.register_on_player_receive_fields for more info.
	--- default: nil
	--- @type fun(pos:Position, formname:string, fields:table, sender:Player)?
	on_receive_fields             = nil,

	--- Called when a player wants to move items inside the inventory.
	--- Return value: number of items allowed to move.
	--- @type (fun(pos:Position, from_list:string, from_index:number, to_list:string, to_index:number, count:number, player:Player): number)?
	allow_metadata_inventory_move = nil,

	--- Called when a player wants to put something into the inventory.
	--- Return value: number of items allowed to put.
	--- Return value -1: Allow and don't modify item count in inventory.
	--- @type (fun(pos:Position, listname:string, index:number, stack:ItemStack, player:Player): number)?
	allow_metadata_inventory_put  = nil,

	--- Called when a player wants to take something out of the inventory.
	--- Return value: number of items allowed to take.
	--- Return value -1: Allow and don't modify item count in inventory.
	--- @type (fun(pos:Position, listname:string, index:number, stack:ItemStack, player:Player): number)?
	allow_metadata_inventory_take = nil,

	--- Called after the actual action has happened, according to what was
	--- allowed.
	--- No return value.
	--- @type (fun(pos:Position, from_list:string, from_index:number, to_list:string, to_index:number, count:number, player:Player): void)?
	on_metadata_inventory_move    = nil,
	--- Called after the actual action has happened, according to what was
	--- allowed.
	--- No return value.
	--- @type (fun(pos:Position, listname:string, index:number, stack:ItemStack, player:Player): void)?
	on_metadata_inventory_put     = nil,
	--- Called after the actual action has happened, according to what was
	--- allowed.
	--- No return value.
	--- @type (fun(pos:Position, listname:string, index:number, stack:ItemStack, player:Player): void)?
	on_metadata_inventory_take    = nil,

	--- intensity: 1.0 = mid range of regular TNT.
	--- If defined, called when an explosion touches the node, instead of
	--- removing the node.
	--- @type (fun(pos:Position, intensity:number): void)?
	on_blast                      = nil,

	--- stores which mod actually registered a node
	--- If the source could not be determined it contains "??"
	--- Useful for getting which mod truly registered something
	--- example: if a node is registered as ":othermodname:nodename",
	--- nodename will show "othermodname", but mod_origin will say "modname"
	--- @type string?
	mod_origin                    = "modname",
}
