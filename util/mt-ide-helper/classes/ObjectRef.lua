--- @diagnostic disable: missing-return


--- @class ObjectRef
ObjectRef = {}

--- @return Position
function ObjectRef:get_pos() end
--- @param pos Position
function ObjectRef:set_pos(pos) end

--TODO:
--- @return vector|Position returns the velocity, a vector.
function ObjectRef:get_velocity()  end

--- @param vel vector|Position e.g. `{x=0.0, y=2.3, z=1.0}`
---  * In comparison to using get_velocity, adding the velocity and then using
---    set_velocity, add_velocity is supposed to avoid synchronization problems.
---    Additionally, players also do not support set_velocity.
---  * If a player:
---    * Does not apply during free_move.
---    * Note that since the player speed is normalized at each move step,
---      increasing e.g. Y velocity beyond what would usually be achieved
---      (see: physics overrides) will cause existing X/Z velocity to be reduced.
---    * Example: `add_velocity({x=0, y=6.5, z=0})` is equivalent to
---      pressing the jump key (assuming default settings)
function ObjectRef:add_velocity(vel) end
--- @overload fun(pos)
---  * Does an interpolated move for Lua entities for visually smooth transitions.
---  * If `continuous` is true (default: false), the Lua entity will not be moved to the current
---    position before starting the interpolated move.
---  * For players this does the same as `set_pos`,`continuous` is ignored.
--- @param pos Position
--- @param continuous boolean
function ObjectRef:move_to(pos, continuous) end


--- Punches the object, triggering all consequences a normal punch would have.
--- - Arguments `time_from_last_punch`, `tool_capabilities`, and `direction` will be replaced with a default value when the caller sets them to `nil`.
--- - Other arguments: See on_punch for entities
---
--- @param puncher?              ObjectRef|Entity|Player|nil another `ObjectRef` which punched the object or `nil`
--- @param time_from_last_punch? number                      time since last punch action of the puncher
--- @param tool_capabilities?    table                       the tool capabilities of the puncher. See [Tool Capabilities](https://api.luanti.org/tool-capabilities/)
--- @param direction?            Position                    the direction from which the punch came, normalized vector
function ObjectRef:punch(puncher, time_from_last_punch, tool_capabilities, direction) end
--- @param clicker ObjectRef
function ObjectRef:right_click(clicker) end
--- returns number of health points
--- @return number
function ObjectRef:get_hp() end
--- set number of health points
---  * See reason in register_on_player_hpchange
---  * Is limited to the range of 0 ... 65535 (2^16 - 1)
---  * For players: HP are also limited by `hp_max` specified in object properties
--- @param hp number
--- @param reason PlayerHPChangeReason
function ObjectRef:set_hp(hp, reason) end
--- @return InvRef|nil for players, otherwise returns `nil`
function ObjectRef:get_inventory() end
--- @return string the name of the inventory list the wielded item is in.
function ObjectRef:get_wield_list() end
--- @return number the index of the wielded item
function ObjectRef:get_wield_index() end
--- @return ItemStack
function ObjectRef:get_wielded_item() end
--- replaces the wielded item, returns `true` if successful.
--- @param item ItemStack
--- @return boolean
function ObjectRef:set_wielded_item(item) end
--- @param groups table {group1=rating, group2=rating, ...}
function ObjectRef:set_armor_groups(groups) end
--- @return table with the armor group ratings
function ObjectRef:get_armor_groups() end
--- @param frame_range table {x=num, y=num}, default: `{x=1, y=1}`
--- @param frame_speed number default: `15.0`
--- @param frame_blend number default: `0.0`
--- @param frame_loop boolean default: `true`
function ObjectRef:set_animation(frame_range, frame_speed, frame_blend, frame_loop) end
--- @return table,number,number,boolean `range`, `frame_speed`, `frame_blend` and `frame_loop`.
function ObjectRef:get_animation() end
--- @param frame_speed number default: `15.0`
function ObjectRef:set_animation_frame_speed(frame_speed) end

--- Attaches object to `parent`.
--- See 'Attachments' section for details.
--- This command may fail silently (do nothing) when it would result in circular attachments.
--- @overload fun(parent:ObjectRef)
--- @param parent ObjectRef to attach to
--- @param bone string default `""` (the root bone)
--- @param position Position relative position, default `{x=0, y=0, z=0}`
--- @param rotation Position|vector relative rotation in degrees, default `{x=0, y=0, z=0}`
--- @param forced_visible boolean to control whether the attached entity should appear in first person, default `false`.
function ObjectRef:set_attach(parent, bone, position, rotation, forced_visible) end
--- Returns current attachment parameters or nil if it isn't attached.
--- If attached, returns `parent`, `bone`, `position`, `rotation`, `forced_visible`.
--- @return ObjectRef,string,Position,Position,boolean|nil
function ObjectRef:get_attach() end
--- @return ObjectRef[]|table<number,ObjectRef> a list of ObjectRefs that are attached to the object.
function ObjectRef:get_children() end
function ObjectRef:set_detach() end

---
--- @deprecated
--- @param bone?     string   Default is `""`, the root bone
--- @param position? Position `{x=num, y=num, z=num}`, relative, `default {x=0, y=0, z=0}`
--- @param rotation? Position `{x=num, y=num, z=num}`, default `{x=0, y=0, z=0}`
function ObjectRef:set_bone_position(bone, position, rotation) end

--- Returns the previously set position and rotation of the bone.
--- - Shorthand for `get_bone_override(bone).position.vec, get_bone_override(bone).rotation.vec:apply(math.deg)`.
--- - **Note:** Returned rotation is in degrees, not radians.
--- - **Deprecated:** Use `get_bone_override` instead.
---
--- @param bone string
--- @return Position,Position # position and rotation of the bone
function ObjectRef:get_bone_position(bone) end
--- @param object_property_table table<string,any>
function ObjectRef:set_properties(object_property_table) end
--- @return table object property table
function ObjectRef:get_properties() end
--- @return boolean true for players, false otherwise
function ObjectRef:is_player() end
--- Example:
--- ```
---	{
---		text = "",
---		color = {a=0..255, r=0..255, g=0..255, b=0..255},
---		bgcolor = {a=0..255, r=0..255, g=0..255, b=0..255},
---	}
--- ```
--- @return table a table with the attributes of the nametag of an object
function ObjectRef:get_nametag_attributes() end
--- sets the attributes of the nametag of an object.
--- @param attributes table
--- ```
---      {
---        text = "My Nametag",
---        color = ColorSpec,
---        -- ^ Text color
---        bgcolor = ColorSpec or false,
---        -- ^ Sets background color of nametag
---        -- `false` will cause the background to be set automatically based on user settings
---        -- Default: false
---      }
--- ```
function ObjectRef:set_nametag_attributes(attributes) end
