--- @class ItemDefinition
local ItemDefinition = {
    --- Can contain new lines. "\n" has to be used as new line character.
    --- See also: `get_description` in [`ItemStack`]
    --- @type string
    description = "",

    --- Must not contain new lines.
    --- Defaults to nil.
    --- Use an [`ItemStack`] to get the short description, e.g.:
    ---   ItemStack(itemname):get_short_description()
    --- @type string
    short_description = "",

    --- key = name, value = rating; rating = <number>.
    --- If rating not applicable, use 1.
    --- e.g. {wool = 1, fluffy = 3}
    ---      {soil = 2, outerspace = 1, crumbly = 1}
    ---      {bendy = 2, snappy = 1},
    ---      {hard = 1, metal = 1, spikes = 1}
    --- @type table<string,number>
    groups = {},

    --- Texture shown in the inventory GUI
    --- Defaults to a 3D rendering of the node if left empty.
    --- @type string
    inventory_image = "",

    --- An overlay texture which is not affected by colorization
    --- @type string
    inventory_overlay = "",

    --- Texture shown when item is held in hand
    --- Defaults to a 3D rendering of the node if left empty.
    --- @type string
    wield_image = "",

    --- Like inventory_overlay but only used in the same situation as wield_image
    --- @type string
    wield_overlay = "",

    --- Scale for the item when held in hand
    --- @type Position scale vector
    wield_scale = {x = 1, y = 1, z = 1},

    --- An image file containing the palette of a node.
    --- You can set the currently used color as the "palette_index" field of
    --- the item stack metadata.
    --- The palette is always stretched to fit indices between 0 and 255, to
    --- ensure compatibility with "colorfacedir" (and similar) nodes.
    --- @type string
    palette = "",

    --- Color the item is colorized with. The palette overrides this.
    --- @type string|ColorSpec
    color = "#ffffffff",

    --- Maximum amount of items that can be in a single stack.
    --- The default can be changed by the setting `default_stack_max`
    --- @type number
    stack_max = 99,

    --- Range of node and object pointing that is possible with this item held
    --- @type number
    range = 4.0,

    --- If true, item can point to all liquid nodes (`liquidtype ~= "none"`),
    --- even those for which `pointable = false`
    --- @type boolean
    liquids_pointable = false,

    --- When used for nodes: Defines amount of light emitted by node.
    --- Otherwise: Defines texture glow when viewed as a dropped item
    --- To set the maximum (14), use the value 'minetest.LIGHT_MAX'.
    --- A value outside the range 0 to minetest.LIGHT_MAX causes undefined
    --- behavior.
    --- @type number
    light_source = 0,

    --- See "Tool Capabilities" section for an example including explanation
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 0,
        --- For example:
        --- `choppy = {times = {2.50, 1.40, 1.00}, uses = 20, maxlevel = 2}`,
        groupcaps = {
            --- For example:
            choppy = {times = {2.50, 1.40, 1.00}, uses = 20, maxlevel = 2},
        },
        --- Damage values must be between -32768 and 32767 (2^15)
        --- @type table<string,number>
        damage_groups = {groupname = 7},

        --- Amount of uses this tool has for attacking players and entities
        --- by punching them (0 = infinite uses).
        --- For compatibility, this is automatically set from the first
        --- suitable groupcap using the formula "uses * 3^(maxlevel - 1)".
        --- It is recommend to set this explicitly instead of relying on the
        --- fallback behavior.
        --- @type number
        punch_attack_uses = nil,
    },

    --- If nil and item is node, prediction is made automatically.
    --- If nil and item is not a node, no prediction is made.
    --- If "" and item is anything, no prediction is made.
    --- Otherwise should be name of node which the client immediately places
    --- on ground when the player places the item. Server will always update
    --- with actual result shortly.
    --- @type string
    node_placement_prediction = nil,

    --- if "", no prediction is made.
    --- if "air", node is removed.
    --- Otherwise should be name of node which the client immediately places
    --- upon digging. Server will always update with actual result shortly.
    --- @type string
    node_dig_prediction = "air",

    --- Definition of item sounds to be played at various events.
    --- All fields in this table are optional.
    sound = {

        --- When tool breaks due to wear. Ignored for non-tools
        --- @type SimpleSoundSpec
        breaks = nil,

        --- When item is eaten with `minetest.do_item_eat`
        --- @type SimpleSoundSpec
        eat = nil,

        --- When item is used with the 'punch/mine' key pointing at a node or entity
        --- @type SimpleSoundSpec
        punch_use = nil,

        --- When item is used with the 'punch/mine' key pointing at nothing (air)
        --- @type SimpleSoundSpec
        punch_use_air = nil,
    },

    --- When the 'place' key was pressed with the item in hand
    --- and a node was pointed at.
    --- Shall place item and return the leftover itemstack
    --- or nil to not modify the inventory.
    --- The placer may be any ObjectRef or nil.
    --- default: minetest.item_place
    --- @type fun(itemstack:ItemStack, placer:Player|ObjectRef|nil, pointed_thing:pointed_thing)
    on_place = minetest.item_place,

    --- Same as on_place but called when not pointing at a node.
    --- Function must return either nil if inventory shall not be modified,
    --- or an itemstack to replace the original itemstack.
    --- The user may be any ObjectRef or nil.
    --- default: nil
    --- @type fun(itemstack:ItemStack, user:Player|ObjectRef|nil, pointed_thing:pointed_thing)
    on_secondary_use = nil,

    --- Shall drop item and return the leftover itemstack.
    --- The dropper may be any ObjectRef or nil.
    --- default: minetest.item_drop
    --- @type fun(itemstack:ItemStack, dropper:Player|ObjectRef|nil, pos:Position)
    on_drop = minetest.item_drop,

    --- Called when a dropped item is punched by a player.
    --- Shall pick-up the item and return the leftover itemstack or nil to not
    --- modify the dropped item.
    --- Parameters:
    --- * `itemstack`: The `ItemStack` to be picked up.
    --- * `picker`: Any `ObjectRef` or `nil`.
    --- * `pointed_thing` (optional): The dropped item (a `"__builtin:item"`
    ---   luaentity) as `type="object"` `pointed_thing`.
    --- * `time_from_last_punch, ...` (optional): Other parameters from
    ---   `luaentity:on_punch`.
    --- default: `minetest.item_pickup`
    --- @type fun(itemstack:ItemStack, picker:Player|ObjectRef|nil, pointed_thing:pointed_thing, time_from_last_punch, ...)
    on_pickup = minetest.item_pickup,

    --- default: nil
    --- When user pressed the 'punch/mine' key with the item in hand.
    --- Function must return either nil if inventory shall not be modified,
    --- or an itemstack to replace the original itemstack.
    --- e.g. itemstack:take_item(); return itemstack
    --- Otherwise, the function is free to do what it wants.
    --- The user may be any ObjectRef or nil.
    --- The default functions handle regular use cases.
    --- @type fun(itemstack:ItemStack, user:Player|ObjectRef|nil, pointed_thing:pointed_thing)
    on_use = nil,

    --- default: nil
    --- If defined, should return an itemstack and will be called instead of
    --- wearing out the item (if tool). If returns nil, does nothing.
    --- If after_use doesn't exist, it is the same as:
    ---   function(itemstack, user, node, digparams)
    ---     itemstack:add_wear(digparams.wear)
    ---     return itemstack
    ---   end
    --- The user may be any ObjectRef or nil.
    --- @type fun(itemstack:ItemStack, user:Player|ObjectRef|nil, node, digparams)
    after_use = nil,

    --- Add your own custom fields. By convention, all custom field names
    --- should start with `_` to avoid naming collisions with future engine
    --- usage.
    _custom_field = "< whatever >",
}
