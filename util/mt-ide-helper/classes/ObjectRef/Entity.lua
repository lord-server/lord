---@class Entity: ObjectRef
Entity = {}

--- Removes object.
--- * The object is removed after returning from Lua. However the `ObjectRef`
--- itself instantly becomes unusable with all further method calls having
--- no effect and returning `nil`.
function Entity:remove() end
--- @param vel vector e.g. `{x=0.0, y=2.3, z=1.0}`
function Entity:set_velocity(vel) end
--- @param acc vector
function Entity:set_acceleration(acc) end
--- Returns the acceleration, a vector.
--- @return vector
function Entity:get_acceleration() end
--- Remove & readd your objects to force a certain rotation.
--- Does not reset rotation incurred through `automatic_rotate`.
--- @param rot vector (radians). X is pitch (elevation), Y is yaw (heading) and Z is roll (bank).
function Entity:set_rotation(rot) end
--- Returns the rotation, a vector (radians).
--- @return vector
function Entity:get_rotation() end
--- Sets the yaw in radians (heading).
--- @param yaw number
function Entity:set_yaw(yaw) end
--- Returns number in radians.
--- @return number
function Entity:get_yaw() end
--- Set a texture modifier to the base texture, for sprites and meshes.
--- When calling `set_texture_mod` again, the previous one is discarded.
--- @param mod string|TextureModifier the texture modifier. See [Texture modifiers].
function Entity:set_texture_mod(mod) end
--- Returns current texture modifier.
--- @return string|TextureModifier
function Entity:get_texture_mod() end
--- Specifies and starts a sprite animation.
--- Only used by `sprite` and `upright_sprite` visuals.
--- Animations iterate along the frame `y` position.
--- @param start_frame {x:number,y:number}  {x=column number, y=row number}, the coordinate of the first frame, default: `{x=0, y=0}`
--- @param num_frames number Total frames in the texture, default: `1`
--- @param framelength number Time per animated frame in seconds, default: `0.2`
--- @param select_x_by_camera boolean Only for visual = `sprite`. Changes the frame `x`position according to the view direction. default: `false`.
--- First column:  subject facing the camera
--- Second column: subject looking to the left
--- Third column:  subject backing the camera
--- Fourth column: subject looking to the right
--- Fifth column:  subject viewed from above
--- Sixth column:  subject viewed from below
function Entity:set_sprite(start_frame, num_frames, framelength, select_x_by_camera) end
--- (**Deprecated**: Will be removed in a future version, use the field `self.name` instead)
--- @deprecated
--- @return string
function Entity:get_entity_name() end
--- @return LuaEntity
function Entity:get_luaentity() end
