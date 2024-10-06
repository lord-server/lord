local e = minetest.formspec_escape


--- @class minetest.FormSpec
local FormSpec = {}

minetest.formspec = FormSpec


--- @param bool boolean|string
--- @return string
local function bool_str(bool)
	return (bool==true and 'true' or (bool==false and 'false' or bool))
end
--- @param param     any
--- @param separator string default: `;`
--- @return string
local function optional(param, separator)
	separator = separator or ';'
	return param and (separator.. param) or ''
end
--- @param list      table
--- @param separator string default: `;`
--- @return string
local function key_value_list(list, separator)
	separator = separator or ';'

	local list_strings = {}
	for key, value in pairs(list) do
		table.insert(list_strings, key..'='..value)
	end

	return table.concat(list_strings, separator)
end


FormSpec.escape = e
--- You can use this as `name` of some fields to make them read-only
FormSpec.read_only = ''


---
--- * Set the formspec version to a certain number. If not specified,
--- version 1 is assumed.
--- * Must be specified before `size` element.
--- * Clients older than this version can neither show newer elements nor display
--- elements with new arguments correctly.
--- * Available since feature `formspec_version_element`.
--- * See also: [Version History]
--- @param version number
function FormSpec.formspec_version(version)
	return 'formspec_version['..version..']'
end

---
--- * Define the size of the menu in inventory slots
--- * `fixed_size`: `true`/`false` (optional)
--- * deprecated: `invsize[<W>,<H>;]`
---
--- @return string
function FormSpec.size(W,H,fixed_size)
	return 'size['..W..','..H..optional(fixed_size,',')..']'
end

---
--- * Must be used after `size` element.
--- * Defines the position on the game window of the formspec's `anchor` point.
--- * For X and Y, 0.0 and 1.0 represent opposite edges of the game window,
---   for example:
---     * [0.0, 0.0] sets the position to the top left corner of the game window.
---     * [1.0, 1.0] sets the position to the bottom right of the game window.
--- * Defaults to the center of the game window [0.5, 0.5].
---
--- @return string
function FormSpec.position(X,Y)
	return 'position['..X..','..Y..']'
end

---
--- * Must be used after both `size` and `position` (if present) elements.
--- * Defines the location of the anchor point within the formspec.
--- * For X and Y, 0.0 and 1.0 represent opposite edges of the formspec,
---   for example:
---     * [0.0, 1.0] sets the anchor to the bottom left corner of the formspec.
---     * [1.0, 0.0] sets the anchor to the top right of the formspec.
--- * Defaults to the center of the formspec [0.5, 0.5].
---
--- * `position` and `anchor` elements need suitable values to avoid a formspec
---   extending off the game window due to particular game window sizes.
---
--- @return string
function FormSpec.anchor(X,Y)
	return 'anchor['..X..','..Y..']'
end

---
--- * Must be used after the `size`, `position`, and `anchor` elements (if present).
--- * Defines how much space is padded around the formspec if the formspec tries to
---   increase past the size of the screen and coordinates have to be shrunk.
--- * For X and Y, 0.0 represents no padding (the formspec can touch the edge of the
---   screen), and 0.5 represents half the screen (which forces the coordinate size
---   to 0). If negative, the formspec can extend off the edge of the screen.
--- * Defaults to [0.05, 0.05].
---
--- @return string
function FormSpec.padding(X,Y)
	return 'padding['..X..','..Y..']'
end

---
--- * Must be used after the `size`, `position`, `anchor`, and `padding` elements
---   (if present).
--- * Disables player:set_formspec_prepend() from applying to this formspec.
---
--- @return string
function FormSpec.no_prepend()
	return 'no_prepend[]'
end

---
--- * INFORMATION: Enable it automatically using `formspec_version` version 2 or newer.
--- * When set to true, all following formspec elements will use the new coordinate system.
--- * If used immediately after `size`, `position`, `anchor`, and `no_prepend` elements
---   (if present), the form size will use the new coordinate system.
--- * **Note**: Formspec prepends are not affected by the coordinates in the main form.
---   They must enable it explicitly.
--- * For information on converting forms to the new coordinate system, see `Migrating
---   to Real Coordinates`.
---
--- @return string
function FormSpec.real_coordinates(bool)
	return 'real_coordinates['..bool_str(bool)..']'
end

---
--- * Start of a container block, moves all physical elements in the container by
---   (X, Y).
--- * Must have matching `container_end`
--- * Containers can be nested, in which case the offsets are added
---   (child containers are relative to parent containers)
---
--- ### `container_end[]`
---
--- * End of a container, following elements are no longer relative to this
---   container.
---
--- @return string
function FormSpec.container(X,Y)
	return 'container['..X..','..Y..']'
end

---
--- * End of a container, following elements are no longer relative to this
---   container.
---
--- @return string
function FormSpec.container_end()
	return 'container_end[]'
end

---
--- * Start of a scroll_container block. All contained elements will ...
---   * take the scroll_container coordinate as position origin,
---   * be additionally moved by the current value of the scrollbar with the name
---     `scrollbar name` times `scroll factor` along the orientation `orientation` and
---   * be clipped to the rectangle defined by `X`, `Y`, `W` and `H`.
--- * `orientation`: possible values are `vertical` and `horizontal`.
--- * `scroll factor`: optional, defaults to `0.1`.
--- * Nesting is possible.
--- * Some elements might work a little different if they are in a scroll_container.
--- * Note: If you want the scroll_container to actually work, you also need to add a
---   scrollbar element with the specified name. Furthermore, it is highly recommended
---   to use a scrollbaroptions element on this scrollbar.
---
--- @return string
function FormSpec.scroll_container(X,Y,W,H,scrollbar_name,orientation,scroll_factor)
	return string.format(
		'scroll_container[%s,%s;%s,%s;%s;%s;%s]',
		X,Y,W,H,scrollbar_name,orientation,scroll_factor
	)
end

---
--- * End of a scroll_container, following elements are no longer bound to this container.
---
--- @return string
function FormSpec.scroll_container_end()
	return 'scroll_container_end[]'
end


---
--- * Show an inventory list if it has been sent to the client.
--- * If the inventory list changes (eg. it didn't exist before, it's resized, or its items
---   are moved) while the formspec is open, the formspec element may (but is not guaranteed
---   to) adapt to the new inventory list.
--- * Item slots are drawn in a grid from left to right, then up to down, ordered
---   according to the slot index.
--- * `W` and `H` are in inventory slots, not in coordinates.
--- * `starting item index` (Optional): The index of the first (upper-left) item to draw.
---   Indices start at `0`. Default is `0`.
--- * The number of shown slots is the minimum of `W*H` and the inventory list's size minus
--- `starting item index`.
--- * **Note**: With the new coordinate system, the spacing between inventory
--- slots is one-fourth the size of an inventory slot by default. Also see
--- [Styling Formspecs] for changing the size of slots and spacing.
---
--- @return string
function FormSpec.list(inventory_location,list_name,X,Y,W,H,starting_item_index)
	return string.format(
		'list[%s;%s;%s,%s;%s;%s;%s]',
		inventory_location,list_name,X,Y,W,H,starting_item_index
	)
end

---
--- * Appends to an internal ring of inventory lists.
--- * Shift-clicking on items in one element of the ring
--- will send them to the next inventory list inside the ring
--- * The first occurrence of an element inside the ring will
--- determine the inventory where items will be sent to
---
--- @return string
function FormSpec.listring(inventory_location,list_name)
	return 'listring['..inventory_location..';'..list_name..']'
end

---
--- * Shorthand for doing `listring[<inventory location>;<list name>]`
--- for the last two inventory lists added by list[...]
---
--- @return string
function FormSpec.listring()
	return 'listring[]'
end

---
--- * Sets background color of slots as `ColorString`
--- * Sets background color of slots on mouse hovering
--- * (optional) Sets color of slots border
--- * (optional) Sets default background color of tooltips
--- * (optional) Sets default font color of tooltips
---
--- @overload fun(slot_bg_normal,slot_bg_hover)
--- @overload fun(slot_bg_normal,slot_bg_hover,slot_border)
--- @overload fun(slot_bg_normal,slot_bg_hover,slot_border,tooltip_bgcolor)
--- @return string
function FormSpec.listcolors(slot_bg_normal,slot_bg_hover,slot_border,tooltip_bgcolor,tooltip_fontcolor)
	return 'listcolors['..
		slot_bg_normal..';'..slot_bg_hover..
		optional(slot_border)..optional(tooltip_bgcolor)..optional(tooltip_fontcolor)..
	']'
end

---
--- * Adds tooltip for an element
--- * `bgcolor` tooltip background color as `ColorString` (optional)
--- * `fontcolor` tooltip font color as `ColorString` (optional)
---
--- @return string
function FormSpec.tooltip(gui_element_name,tooltip_text,bgcolor,fontcolor)
	return 'tooltip['..gui_element_name..';'..e(tooltip_text)..';'..bgcolor..';'..fontcolor..']'
end

---
--- * Adds tooltip for an area. Other tooltips will take priority when present.
--- * `bgcolor` tooltip background color as `ColorString` (optional)
--- * `fontcolor` tooltip font color as `ColorString` (optional)
---
--- @return string
function FormSpec.tooltip2(X,Y,W,H,tooltip_text,bgcolor,fontcolor)
	return string.format(
		'tooltip[%s,%s;%s,%s;%s;%s;%s]',
		X,Y,W,H,e(tooltip_text),bgcolor,fontcolor
	)
end

---
--- * Show an image.
--- * `middle` (optional): Makes the image render in 9-sliced mode and defines the middle rect.
--- * Requires formspec version >= 6.
--- * See `background9[]` documentation for more information.
---
--- @return string
function FormSpec.image(X,Y,W,H,texture_name,middle)
	return string.format(
		'image[%s,%s;%s,%s;%s;%s]',
		X,Y,W,H,texture_name,middle
	)
end

---
--- * Show an animated image. The image is drawn like a "vertical_frames" tile
--- animation (See [Tile animation definition]), but uses a frame count/duration for simplicity
--- * `name`: Element name to send when an event occurs. The event value is the index of the current frame.
--- * `texture name`: The image to use.
--- * `frame count`: The number of frames animating the image.
--- * `frame duration`: Milliseconds between each frame. `0` means the frames don't advance.
--- * `frame start` (optional): The index of the frame to start on. Default `1`.
--- * `middle` (optional): Makes the image render in 9-sliced mode and defines the middle rect.
---     * Requires formspec version >= 6.
---     * See `background9[]` documentation for more information.
---
--- @return string
function FormSpec.animated_image(X,Y,W,H,name,texture_name,frame_count,frame_duration,frame_start,middle)
	return string.format(
		'animated_image[%s,%s;%s,%s;%s;%s;%s;%s;%s;%s]',
		X,Y,W,H,name,texture_name,frame_count,frame_duration,frame_start,middle
	)
end

---
--- * Show a mesh model.
--- * `name`: Element name that can be used for styling
--- * `mesh`: The mesh model to use.
--- * `textures`: The mesh textures to use according to the mesh materials.
---    Texture names must be separated by commas.
--- * `rotation` (Optional): Initial rotation of the camera, format `x,y`.
---   The axes are euler angles in degrees.
--- * `continuous` (Optional): Whether the rotation is continuous. Default `false`.
--- * `mouse control` (Optional): Whether the model can be controlled with the mouse. Default `true`.
--- * `frame loop range` (Optional): Range of the animation frames.
---     * Defaults to the full range of all available frames.
---     * Syntax: `<begin>,<end>`
--- * `animation speed` (Optional): Sets the animation speed. Default 0 FPS.
---
--- @overload fun(X,Y,W,H,name,mesh,textures):string
--- @return string
function FormSpec.model(X,Y,W,H,name,mesh,textures,rotation,continuous,mouse_control,frame_loop_range,animation_speed)
	return 'model['..
		X..','..Y..';' ..W..','..H..';'..
		name..';'..mesh..';'..textures..
		optional(rotation)..
		optional(continuous)..
		optional(mouse_control)..
		optional(frame_loop_range)..
		optional(animation_speed)..
	']'
end

---
--- * Show an inventory image of registered item/node
---
--- @return string
function FormSpec.item_image(X,Y,W,H,item_name)
	return 'item_image['..X..','..Y..';' ..W..','..H..';'..item_name..']'
end

---
--- * Sets background color of formspec.
--- * `bgcolor` and `fbgcolor` (optional) are `ColorString`s, they define the color
---   of the non-fullscreen and the fullscreen background.
--- * `fullscreen` (optional) can be one of the following:
---    * `false`: Only the non-fullscreen background color is drawn. (default)
---    * `true`: Only the fullscreen background color is drawn.
---    * `both`: The non-fullscreen and the fullscreen background color are drawn.
---    * `neither`: No background color is drawn.
--- * Note: Leave a parameter empty to not modify the value.
--- * Note: `fbgcolor`, leaving parameters empty and values for `fullscreen` that
---   are not bools are only available since formspec version 3.
---
--- @overload fun(bgcolor:string):string
--- @overload fun(bgcolor:string,fullscreen:string):string
--- @param bgcolor    string  is `ColorString`
--- @param fullscreen string  one of `"true"`|`"false"`|`"both"`|`"neither"`
--- @param fbgcolor   string  is `ColorString`
--- @return string
function FormSpec.bgcolor(bgcolor,fullscreen,fbgcolor)
	return 'bgcolor['..bgcolor..optional(fullscreen)..optional(fbgcolor)..']'
end

---
--- * Example for formspec 8x4 in 16x resolution:
---   image shall be sized 8 times 16px  times  4 times 16px
--- * `auto_clip`: (optional). If is `true`, the background is clipped to the formspec size
---   (`x` and `y` are used as offset values, `w` and `h` are ignored)
--- @overload fun(X,Y,W,H,texture_name):string
--- @return string
function FormSpec.background(X,Y,W,H,texture_name,auto_clip)
	return 'background['..
		X..','..Y..';' ..W..','..H..';'..
		texture_name..
		optional(auto_clip)..
	']'
end

---
--- * 9-sliced background. See https://en.wikipedia.org/wiki/9-slice_scaling
--- * Middle is a rect which defines the middle of the 9-slice.
---     * `x` - The middle will be x pixels from all sides.
---     * `x,y` - The middle will be x pixels from the horizontal and y from the vertical.
---     * `x,y,x2,y2` - The middle will start at x,y, and end at x2, y2. Negative x2 and y2 values
---         will be added to the width and height of the texture, allowing it to be used as the
---         distance from the far end.
---     * All numbers in middle are integers.
--- * If `auto_clip` is `true`, the background is clipped to the formspec size
---   (`x` and `y` are used as offset values, `w` and `h` are ignored)
--- * Available since formspec version 2
---
--- @return string
function FormSpec.background9(X,Y,W,H,texture_name,auto_clip,middle)
	return 'background9['..X..','..Y..';' ..W..','..H..';'..texture_name..';'..auto_clip..';'..middle..']'
end

---
--- * Textual password style field; will be sent to server when a button is clicked
--- * When enter is pressed in field, `fields.key_enter_field` will be sent with the
---   name of this field.
--- * With the old coordinate system, fields are a set height, but will be vertically
---   centered on `H`. With the new coordinate system, `H` will modify the height.
--- * `name` is the name of the field as returned in fields to `on_receive_fields`
--- * `label`, if not blank, will be text printed on the top left above the field
--- * See `field_close_on_enter` to stop enter closing the formspec
---
--- @return string
function FormSpec.pwdfield(X,Y,W,H,name,label)
	return 'pwdfield['..X..','..Y..';' ..W..','..H..';'..name..optional(label)..']'
end

---
--- * Textual field; will be sent to server when a button is clicked
--- * When enter is pressed in field, `fields.key_enter_field` will be sent with
---   the name of this field.
--- * With the old coordinate system, fields are a set height, but will be vertically
---   centered on `H`. With the new coordinate system, `H` will modify the height.
--- * `name` is the name of the field as returned in fields to `on_receive_fields`
--- * `label`, if not blank, will be text printed on the top left above the field
--- * `default` is the default value of the field
---     * `default` may contain variable references such as `${text}` which
---       will fill the value from the metadata value `text`
---     * **Note**: no extra text or more than a single variable is supported ATM.
--- * See `field_close_on_enter` to stop enter closing the formspec
---
--- @return string
function FormSpec.field(X,Y,W,H,name,label,default)
	return 'field['..X..','..Y..';' ..W..','..H..';'..name..optional(e(label))..optional(default)..']'
end

---
--- * As above (`.field()`), but without position/size units
--- * When enter is pressed in field, `fields.key_enter_field` will be sent with
---   the name of this field.
--- * Special field for creating simple forms, such as sign text input
--- * Must be used without a `size[]` element
--- * A "Proceed" button will be added automatically
--- * See `field_close_on_enter` to stop enter closing the formspec
---
--- @return string
function FormSpec.field2(name,label,default)
	return 'field['..name..optional(e(label))..optional(default)..']'
end

---
--- * Experimental, may be subject to change or removal at any time.
--- * Only affects Android clients.
--- * `<name>` is the name of the field.
--- * If `<enter_after_edit>` is true, pressing the "Done" button in the Android
---   text input dialog will simulate an <kbd>Enter</kbd> keypress.
--- * Defaults to false when not specified (i.e. no tag for a field).
---
--- @return string
function FormSpec.field_enter_after_edit(name,enter_after_edit)
	return 'field_enter_after_edit['..name..optional(enter_after_edit)..']'
end

---
--- * `<name>` is the name of the field.
--- * If `<close_on_enter>` is false, pressing <kbd>Enter</kbd> in the field will
---   submit the form but not close it.
--- * Defaults to true when not specified (i.e. no tag for a field).
---
--- @return string
function FormSpec.field_close_on_enter(name,close_on_enter)
	return 'field_close_on_enter['..name..optional(close_on_enter)..']'
end

---
--- * Same as fields above, but with multi-line input
--- * If the text overflows, a vertical scrollbar is added.
--- * If the name is empty, the textarea is read-only and
---   the background is not shown, which corresponds to a multi-line label.
---
--- @return string
function FormSpec.textarea(X,Y,W,H,name,label,default)
	return 'textarea['..X..','..Y..';' ..W..','..H..';'..name..optional(e(label))..optional(default)..']'
end

---
--- * The label formspec element displays the text set in `label`
---   at the specified position.
--- * **Note**: If the new coordinate system is enabled, labels are
---   positioned from the center of the text, not the top.
--- * The text is displayed directly without automatic line breaking,
---   so label should not be used for big text chunks.  Newlines can be
---   used to make labels multiline.
--- * **Note**: With the new coordinate system, newlines are spaced with
---   half a coordinate.  With the old system, newlines are spaced 2/5 of
---   an inventory slot.
---
--- @return string
function FormSpec.label(X,Y,label)
	return 'label['..X..','..Y..';'..e(label)..']'
end

--- * Displays a static formatted text with hyperlinks.
--- * **Note**: This element is currently unstable and subject to change.
--- * `x`, `y`, `w` and `h` work as per field
--- * `name` is the name of the field as returned in fields to `on_receive_fields` in case of action in text.
--- * `text` is the formatted text using `Markup Language` described below.
---
--- @return string
function FormSpec.hypertext(X,Y,W,H,name,text)
	return 'hypertext['..X..','..Y..';' ..W..','..H..';'..name..';'..text..']'
end

--- * Textual label drawn vertically
--- * `label` is the text on the label
--- * **Note**: If the new coordinate system is enabled, vertlabels are
---   positioned from the center of the text, not the left.
---
--- @return string
function FormSpec.vertlabel(X,Y,label)
	return 'vertlabel['..X..','..Y..';'..e(label)..']'
end

---
--- * Clickable button. When clicked, fields will be sent.
--- * With the old coordinate system, buttons are a set height, but will be vertically
---   centered on `H`. With the new coordinate system, `H` will modify the height.
--- * `label` is the text on the button
---
--- @return string
function FormSpec.button(X,Y,W,H,name,label)
	return 'button['..X..','..Y..';' ..W..','..H..';'..name..optional(e(label))..']'
end

---
--- * Clickable button. When clicked, fields will be sent and the user will be given the
---   option to open the URL in a browser.
--- * With the old coordinate system, buttons are a set height, but will be vertically
---   centered on `H`. With the new coordinate system, `H` will modify the height.
--- * To make this into an `image_button`, you can use formspec styling.
--- * `label` is the text on the button.
--- * `url` must be a valid web URL, starting with `http://` or `https://`.
---
--- @return string
function FormSpec.button_url(X,Y,W,H,name,label,url)
	return 'button_url['..X..','..Y..';' ..W..','..H..';'..name..';'..e(label)..';'..e(url)..']'
end

---
--- * `texture name` is the filename of an image
--- * **Note**: Height is supported on both the old and new coordinate systems
---   for image_buttons.
--- * `noclip=true` means the image button doesn't need to be within specified formsize.
--- * `drawborder`: draw button border or not
--- * `pressed texture name` is the filename of an image on pressed state
---
--- @overload fun(X,Y,W,H,texture_name,name,label):string
--- @return string
function FormSpec.image_button(X,Y,W,H,texture_name,name,label,noclip,drawborder,pressed_texture_name)
	return 'image_button['..
		X..','..Y..';' ..W..','..H..';'..
		texture_name..';'..name..';'..optional(e(label))..
		optional(noclip)..optional(drawborder)..optional(pressed_texture_name)..
	']'
end

---
--- * `item name` is the registered name of an item/node
--- * `name` is non-optional and must be unique, or else tooltips are broken.
--- * The item description will be used as the tooltip. This can be overridden with
--- a tooltip element.
---
--- @return string
function FormSpec.item_image_button(X,Y,W,H,item_name,name,label)
	return 'item_image_button['..X..','..Y..';' ..W..','..H..';'..item_name..';'..name..optional(e(label))..']'
end

---
--- * When clicked, fields will be sent and the form will quit.
--- * Same as `button` in all other respects.
---
--- @return string
function FormSpec.button_exit(X,Y,W,H,name,label)
	return 'button_exit['..X..','..Y..';' ..W..','..H..';'..name..';'..label..']'
end

---
--- * When clicked, fields will be sent and the form will quit.
--- * Same as `button_url` in all other respects.
---
--- @return string
function FormSpec.button_url_exit(X,Y,W,H,name,label,url)
	return 'button_url_exit['..X..','..Y..';' ..W..','..H..';'..name..';'..label..';'..url..']'
end

---
--- * When clicked, fields will be sent and the form will quit.
--- * Same as `image_button` in all other respects.
---
--- @return string
function FormSpec.image_button_exit(X,Y,W,H,texture_name,name,label)
	return 'image_button_exit['..X..','..Y..';' ..W..','..H..';'..texture_name..';'..name..optional(label)..']'
end

---
--- * Scrollable item list showing arbitrary text elements
--- * `name` fieldname sent to server on double-click value is current selected
--- element.
--- * `listelements` can be prepended by #color in hexadecimal format RRGGBB
--- (only).
---   * if you want a listelement to start with "#" write "##".
--- * Index to be selected within textlist
--- * `true`/`false`: draw transparent background
--- * See also `minetest.explode_textlist_event`
--- (main menu: `core.explode_textlist_event`).
---
--- @param list_elements table
--- @param selected_idx  number
--- @param transparent   boolean
--- @return string
function FormSpec.textlist(X,Y,W,H,name,list_elements,selected_idx,transparent)
	return 'textlist['..
		X..','..Y..';' ..W..','..H..';'..
		name..';'..
		table.concat(list_elements,',')..
		optional(selected_idx)..
		optional(transparent)..
	']'
end

---
--- * Show a tab**header** at specific position (ignores formsize)
--- * `X` and `Y`: position of the tabheader
--- * *Note*: Width and height are automatically chosen with this syntax
--- * `name` fieldname data is transferred to Lua
--- * `caption 1`...: name shown on top of tab
--- * `current_tab`: index of selected tab 1...
--- * `transparent` (optional): if true, tabs are semi-transparent
--- * `draw_border` (optional): if true, draw a thin line at tab base
---
--- @return string
function FormSpec.tabheader(X,Y,name,captions_array,current_tab,transparent,draw_border)
	return 'tabheader['..
		X..','..Y..';'..
		name..';'..
		table.concat(captions_array,',')..';'..current_tab..
		optional(transparent)..
		optional(draw_border)..
	']'
end

---
--- * Show a tab**header** at specific position (ignores formsize)
--- * **Important note**: This syntax for tabheaders can only be used with the
--- new coordinate system.
--- * `X` and `Y`: position of the tabheader
--- * `H`: height of the tabheader. Width is automatically determined with this syntax.
--- * `name` fieldname data is transferred to Lua
--- * `caption 1`...: name shown on top of tab
--- * `current_tab`: index of selected tab 1...
--- * `transparent` (optional): show transparent
--- * `draw_border` (optional): draw border
---
--- @return string
function FormSpec.tabheader_H(X,Y,H,name,captions_array,current_tab,transparent,draw_border)
	return 'tabheader['..
		X..','..Y..';'.. H..';'..
		name..';'..
		table.concat(captions_array,',')..';'..current_tab..
		optional(transparent)..
		optional(draw_border)..
	']'
end

---
--- * Show a tab**header** at specific position (ignores formsize)
--- * **Important note**: This syntax for tabheaders can only be used with the
--- new coordinate system.
--- * `X` and `Y`: position of the tabheader
--- * `W` and `H`: width and height of the tabheader
--- * `name` fieldname data is transferred to Lua
--- * `caption 1`...: name shown on top of tab
--- * `current_tab`: index of selected tab 1...
--- * `transparent` (optional): show transparent
--- * `draw_border` (optional): draw border
---
--- @return string
function FormSpec.tabheader_WH(X,Y,W,H,name,captions_array,current_tab,transparent,draw_border)
	return 'tabheader['..
		X..','..Y..';' ..W..','..H..';'..
		name..';'..
		table.concat(captions_array,',')..';'..current_tab..
		optional(transparent)..
		optional(draw_border)..
	']'
end

---
--- * Simple colored box
--- * `color` is color specified as a `ColorString`.
--- If the alpha component is left blank, the box will be semitransparent.
--- If the color is not specified, the box will use the options specified by
--- its style. If the color is specified, all styling options will be ignored.
---
--- @return string
function FormSpec.box(X,Y,W,H,color)
	return 'box['..X..','..Y..';' ..W..','..H.. optional(color) ..']'
end

---
--- * Show a dropdown field
--- * **Important note**: There are two different operation modes:
--- 1. handle directly on change (only changed dropdown is submitted)
--- 2. read the value on pressing a button (all dropdown values are available)
--- * `X` and `Y`: position of the dropdown
--- * `W`: width of the dropdown. Height is automatically chosen with this syntax.
--- * Fieldname data is transferred to Lua
--- * Items to be shown in dropdown
--- * Index of currently selected dropdown item
--- * `index event` (optional, allowed parameter since formspec version 4): Specifies the
--- event field value for selected items.
--- * `true`: Selected item index
--- * `false` (default): Selected item value
---
--- @return string
function FormSpec.dropdown_W(X,Y,W,name,items_array,selected_idx,index_event)
	return 'dropdown['..
		X..','..Y..';' ..W..';'..
		name..';'..
		table.concat(items_array,',')..
		optional(selected_idx)..
		optional(index_event)..
	']'
end

---
--- * Show a dropdown field
--- * **Important note**: This syntax for dropdowns can only be used with the
--- new coordinate system.
--- * **Important note**: There are two different operation modes:
--- 1. handle directly on change (only changed dropdown is submitted)
--- 2. read the value on pressing a button (all dropdown values are available)
--- * `X` and `Y`: position of the dropdown
--- * `W` and `H`: width and height of the dropdown
--- * Fieldname data is transferred to Lua
--- * Items to be shown in dropdown
--- * Index of currently selected dropdown item
--- * `index event` (optional, allowed parameter since formspec version 4): Specifies the
--- event field value for selected items.
--- * `true`: Selected item index
--- * `false` (default): Selected item value
---
--- @return string
function FormSpec.dropdown_WH(X,Y,W,H,name,items_array,selected_idx,index_event)
	return 'dropdown['..
		X..','..Y..';' ..W..','..H..';'..
		name..';'..
		table.concat(items_array,',')..
		optional(selected_idx)..
		optional(index_event)..
	']'
end

---
--- * Show a checkbox
--- * `name` fieldname data is transferred to Lua
--- * `label` to be shown left of checkbox
--- * `selected` (optional): `true`/`false`
--- * **Note**: If the new coordinate system is enabled, checkboxes are
--- positioned from the center of the checkbox, not the top.
---
--- @return string
function FormSpec.checkbox(X,Y,name,label,selected)
	return 'checkbox['..X..','..Y..';' .. name..optional(e(label))..optional(selected)..']'
end

---
--- * Show a scrollbar using options defined by the previous `scrollbaroptions[]`
--- * There are two ways to use it:
--- 1. handle the changed event (only changed scrollbar is available)
--- 2. read the value on pressing a button (all scrollbars are available)
--- * `orientation`: `vertical`/`horizontal`. Default horizontal.
--- * Fieldname data is transferred to Lua
--- * Value of this trackbar is set to (`0`-`1000`) by default
--- * See also `minetest.explode_scrollbar_event`
--- (main menu: `core.explode_scrollbar_event`).
---
--- @return string
function FormSpec.scrollbar(X,Y,W,H,orientation,name,value)
	return 'scrollbar['..X..','..Y..';' ..W..','..H..';'..orientation..';'..name..optional(value)..']'
end

--- * Sets options for all following `scrollbar[]` elements
--- * `min=<int>`
--- * Sets scrollbar minimum value, defaults to `0`.
--- * `max=<int>`
--- * Sets scrollbar maximum value, defaults to `1000`.
--- If the max is equal to the min, the scrollbar will be disabled.
--- * `smallstep=<int>`
--- * Sets scrollbar step value when the arrows are clicked or the mouse wheel is
--- scrolled.
--- * If this is set to a negative number, the value will be reset to `10`.
--- * `largestep=<int>`
--- * Sets scrollbar step value used by page up and page down.
--- * If this is set to a negative number, the value will be reset to `100`.
--- * `thumbsize=<int>`
--- * Sets size of the thumb on the scrollbar. Size is calculated in the number of
--- units the thumb spans out of the range of the scrollbar values.
--- * Example: If a scrollbar has a `min` of 1 and a `max` of 100, a thumbsize of 10
--- would span a tenth of the scrollbar space.
--- * If this is set to zero or less, the value will be reset to `1`.
--- * `arrows=<show/hide/default>`
--- * Whether to show the arrow buttons on the scrollbar. `default` hides the arrows
--- when the scrollbar gets too small, but shows them otherwise.
---
--- @return string
function FormSpec.scrollbaroptions(options)
	return 'scrollbaroptions['..key_value_list(options)..']'
end

---
--- * Show scrollable table using options defined by the previous `tableoptions[]`
--- * Displays cells as defined by the previous `tablecolumns[]`
--- * `name`: fieldname sent to server on row select or double-click
--- * `cell 1`...`cell n`: cell contents given in row-major order
--- * `selected idx`: index of row to be selected within table (first row = `1`)
--- * See also `minetest.explode_table_event`
--- (main menu: `core.explode_table_event`).
---
--- @return string
function FormSpec.table(X,Y,W,H,name,cells_array,selected_idx)
	return 'table['..X..','..Y..';' ..W..','..H..';'..name..';'..table.concat(cells_array)..optional(selected_idx)..']'
end

---
--- * Sets options for `table[]`
--- * `color=#RRGGBB`
--- * default text color (`ColorString`), defaults to `#FFFFFF`
--- * `background=#RRGGBB`
--- * table background color (`ColorString`), defaults to `#000000`
--- * `border=<true/false>`
--- * should the table be drawn with a border? (default: `true`)
--- * `highlight=#RRGGBB`
--- * highlight background color (`ColorString`), defaults to `#466432`
--- * `highlight_text=#RRGGBB`
--- * highlight text color (`ColorString`), defaults to `#FFFFFF`
--- * `opendepth=<value>`
--- * all subtrees up to `depth < value` are open (default value = `0`)
--- * only useful when there is a column of type "tree"
---
--- @return string
function FormSpec.tableoptions(options)
	return 'tableoptions['..key_value_list(options)..']'
end

---
--- * Sets columns for `table[]`
--- * Types: `text`, `image`, `color`, `indent`, `tree`
--- * `text`:   show cell contents as text
--- * `image`:  cell contents are an image index, use column options to define
--- images. images are scaled down to fit the row height if necessary.
--- * `color`:  cell contents are a ColorString and define color of following
--- cell.
--- * `indent`: cell contents are a number and define indentation of following
--- cell.
--- * `tree`:   same as indent, but user can open and close subtrees
--- (treeview-like).
--- * Column options:
--- * `align=<value>`
--- * for `text` and `image`: content alignment within cells.
--- Available values: `left` (default), `center`, `right`, `inline`
--- * `width=<value>`
--- * for `text` and `image`: minimum width in em (default: `0`)
--- * for `indent` and `tree`: indent width in em (default: `1.5`)
--- * `padding=<value>`: padding left of the column, in em (default `0.5`).
--- Exception: defaults to 0 for indent columns
--- * `tooltip=<value>`: tooltip text (default: empty)
--- * `image` column options:
--- * `0=<value>` sets image for image index 0
--- * `1=<value>` sets image for image index 1
--- * `2=<value>` sets image for image index 2
--- * and so on; defined indices need not be contiguous. empty or
--- non-numeric cells are treated as `0`.
--- * `color` column options:
--- * `span=<value>`: number of following columns to affect
--- (default: infinite).
---
--- @param columns {type:string,options:table<string,string>}[]
--- @return string
function FormSpec.tablecolumns(columns)
	local columns_strings = {}
	for _, column in pairs(columns) do
		table.insert(
			columns_strings,
			column.type..','..key_value_list(column.options,',')
		)
	end
	return 'tablecolumns['.. table.concat(columns_strings,';') ..']'
end

---
--- * Set the style for the element(s) matching `selector` by name.
--- * `selector` can be one of:
--- * `<name>` - An element name. Includes `*`, which represents every element.
--- * `<name>:<state>` - An element name, a colon, and one or more states.
--- * `state` is a list of states separated by the `+` character.
--- * If a state is provided, the style will only take effect when the element is in that state.
--- * All provided states must be active for the style to apply.
--- * Note: this **must** be before the element is defined.
--- * See [Styling Formspecs].
---
--- ### Valid States
--- * *all elements*
---     * default - Equivalent to providing no states
--- * button, button_exit, image_button, item_image_button
---     * focused - Active when button has focus
---     * hovered - Active when the mouse is hovering over the element
---     * pressed - Active when the button is pressed
---
--- @param selectors  string|string[]
--- @param properties minetest.FormSpec.Style
--- @return string
function FormSpec.style(selectors, properties)
	selectors = type(selectors) == 'table' and selectors or { selectors }

	return 'style['.. table.concat(selectors,',') ..';'.. key_value_list(properties) ..']'
end

---
--- * Set the style for the element(s) matching `selector` by type.
--- * `selector` can be one of:
--- * `<type>` - An element type. Includes `*`, which represents every element.
--- * `<type>:<state>` - An element type, a colon, and one or more states.
--- * `state` is a list of states separated by the `+` character.
--- * If a state is provided, the style will only take effect when the element is in that state.
--- * All provided states must be active for the style to apply.
--- * See [Styling Formspecs].
---
--- ### Valid States
--- * *all elements*
---     * default - Equivalent to providing no states
--- * button, button_exit, image_button, item_image_button
---     * focused - Active when button has focus
---     * hovered - Active when the mouse is hovering over the element
---     * pressed - Active when the button is pressed
---
--- @param selectors  string|string[]
--- @param properties minetest.FormSpec.Style
--- @return string
function FormSpec.style_type(selectors, properties)
	selectors = type(selectors) == 'table' and selectors or { selectors }

	return 'style_type['.. table.concat(selectors,',') ..';'.. key_value_list(properties) ..']'
end

---
--- * Sets the focus to the element with the same `name` parameter.
--- * **Note**: This element must be placed before the element it focuses.
--- * `force` (optional, default `false`): By default, focus is not applied for
--- re-sent formspecs with the same name so that player-set focus is kept.
--- `true` sets the focus to the specified element for every sent formspec.
--- * The following elements have the ability to be focused:
--- * checkbox
--- * button
--- * button_exit
--- * image_button
--- * image_button_exit
--- * item_image_button
--- * table
--- * textlist
--- * dropdown
--- * field
--- * pwdfield
--- * textarea
--- * scrollbar
--- @return string
function FormSpec.set_focus(name,force)
	return 'set_focus['..name..optional(force)..']'
end


return FormSpec
