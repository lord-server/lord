local table_merge
    = table.merge

local DefaultStyle = require('forms.DefaultStyle')
local spec         = minetest.formspec


local BOLD   = { font = 'bold' }
local ITALIC = { font = 'italic' }
local MUTED  = { textcolor = '#ccc' }
local SMALL  = { font_size = '-1' }

local HEADER1_SIZE = '+7'
local HEADER2_SIZE = '+5'
local HEADER3_SIZE = '+3'


--- @class forms.Spec: minetest.FormSpec
local Spec = setmetatable({}, { __index = spec })

--- @see forms.DefaultStyle
--- @param element_name string name of element type (`label`, ...). Valid: one of `forms.DefaultStyle.<name>`
--- @return string
function Spec.reset_style(element_name)
	return spec.style_type(element_name, DefaultStyle.get(element_name))
end

--- @param x     number
--- @param y     number
--- @param text  string
--- @param style minetest.FormSpec.Style  additional style to merge with `{ font = 'bold' }`
--- @return string
function Spec.text(x, y, text, style)
	return ''
		.. spec.style_type('label', style)
		.. spec.label(x, y, text)
		.. Spec.reset_style('label')
end

--- Styled Read-Only textarea
--- @param x      number
--- @param y      number
--- @param width  number
--- @param height number
--- @param text   string
--- @param style  minetest.FormSpec.Style  additional style to merge with `{ font = 'bold' }`
--- @return string
function Spec.area_ro(x, y, width, height, text, style)
	return ''
		.. spec.style_type('textarea', style)
		.. spec.textarea(x, y, width, height, spec.read_only, '', text)
		.. Spec.reset_style('textarea')
end

--- @param x     number
--- @param y     number
--- @param text  string
--- @param style minetest.FormSpec.Style  additional style to merge with `{ font = 'bold' }`
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.bold(x, y, text, style)
	style = table_merge(BOLD, style or {})

	return Spec.text(x, y, text, style)
end

--- @param x     number
--- @param y     number
--- @param text  string
--- @param style minetest.FormSpec.Style  additional style to merge with `{ font = 'italic' }`
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.italic(x, y, text, style)
	style = table_merge(ITALIC, style or {})

	return Spec.text(x, y, text, style)
end

--- Styled Read-Only textarea
--- @param x      number
--- @param y      number
--- @param width  number
--- @param height number
--- @param text   string
--- @param style  minetest.FormSpec.Style  additional style to merge with `{ font = 'italic' }`
--- @overload fun(x:number,y:number,width:number,height:number,text:string):string
--- @return string
function Spec.italic_area_ro(x, y, width, height, text, style)
	style = table_merge(ITALIC, style or {})

	return Spec.area_ro(x, y, width, height, text, style)
end

--- Styled Read-Only textarea
--- @param x      number
--- @param y      number
--- @param width  number
--- @param height number
--- @param text   string
--- @param style  minetest.FormSpec.Style  additional style to merge with `{ font = 'italic' }`
--- @overload fun(x:number,y:number,width:number,height:number,text:string):string
--- @return string
function Spec.bold_area_ro(x, y, width, height, text, style)
	style = table_merge(BOLD, style or {})

	return Spec.area_ro(x, y, width, height, text, style)
end

--- Styled Read-Only textarea
--- @param x      number
--- @param y      number
--- @param width  number
--- @param height number
--- @param text   string
--- @param style  minetest.FormSpec.Style  additional style to merge with `{ font = 'italic' }`
--- @overload fun(x:number,y:number,width:number,height:number,text:string):string
--- @return string
function Spec.bold_area_ro(x, y, width, height, text, style)
	style = table_merge(BOLD, style or {})

	return Spec.area_ro(x, y, width, height, text, style)
end

--- @param x     number
--- @param y     number
--- @param text  string
--- @param style minetest.FormSpec.Style  additional style to merge with `{ textcolor = '#ccc' }`
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.muted(x, y, text, style)
	style = table_merge(MUTED, style or {})

	return Spec.text(x, y, text, style)
end

--- @param x     number
--- @param y     number
--- @param text  string
--- @param style minetest.FormSpec.Style
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.small(x, y, text, style)
	return Spec.text(x, y, text, table_merge(SMALL, style or {}))
end

--- @param x     number
--- @param y     number
--- @param text  string
--- @param color string
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.muted_bold(x, y, text, color)
	color = color and { textcolor = color } or {}

	return Spec.muted(x, y, text, table_merge(BOLD, color))
end

--- @param x    number
--- @param y    number
--- @param text string
--- @param color string
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.muted_italic(x, y, text, color)
	color = color and { textcolor = color } or {}

	return Spec.muted(x, y, text, table_merge(ITALIC, color))
end

--- @param x     number
--- @param y     number
--- @param text  string
--- @param color string
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.small_bold(x, y, text, color)
	color = color and { textcolor = color } or {}

	return Spec.small(x, y, text, table_merge(BOLD, color))
end

--- @param x    number
--- @param y    number
--- @param text string
--- @param color string
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.small_italic(x, y, text, color)
	color = color and { textcolor = color } or {}

	return Spec.small(x, y, text, table_merge(ITALIC, color))
end

--- @param x         number
--- @param y         number
--- @param text      string
--- @param font_size string  see minetest.FormSpec.Style.font_size . Default: `HEADER1_SIZE` (`"+7"`)
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.title(x, y, text, font_size)
	font_size = font_size or HEADER1_SIZE

	return Spec.bold(x, y, text, { font_size = font_size })
end

--- @param x    number
--- @param y    number
--- @param text string
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.header1(x, y, text)
	return Spec.title(x, y, text, HEADER1_SIZE)
end

--- @param x         number
--- @param y         number
--- @param text      string
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.header2(x, y, text)
	return Spec.title(x, y, text, HEADER2_SIZE)
end

--- @param x         number
--- @param y         number
--- @param text      string
--- @overload fun(x:number,y:number,text:string):string
--- @return string
function Spec.header3(x, y, text)
	return Spec.title(x, y, text, HEADER3_SIZE)
end

--- @param x      number
--- @param y      number
--- @param width  number
--- @param height number
--- @param name   string
--- @param title  string
--- @param url    string
--- @param exit   boolean
--- @return string
function Spec.button(x, y, width, height, name, title, url, exit)
	return '' ..
		(url
			and (exit
				and spec.button_url_exit(x, y, width, height, name, title, url)
				or  spec.button_url     (x, y, width, height, name, title, url)
			)
			or  (exit
				and spec.button_exit(x, y, width, height, name, title)
				or  spec.button     (x, y, width, height, name, title)
			)
		)
end

--- @param x     number
--- @param y     number
--- @param name  string
--- @param title string
--- @param url   string
--- @param exit  boolean
--- @return string
function Spec.icon_button(x, y, name, icon, title, url, exit)
	return ''
		.. spec.style(name, { padding= '20,0,0,0' })
		.. Spec.button(x, y, 2, 1, name, title, url)
		.. spec.image(x+.2, y+.24, 0.4, 0.4, icon)
end

--- @overload fun(x:number, y:number, width:number, height:number, position:Position, list:string)
--- @param x                   number
--- @param y                   number
--- @param width               number
--- @param height              number
--- @param position            Position
--- @param list                string
--- @param starting_item_index number|nil
--- @return string
function Spec.node_inventory(x, y, width, height, position, list, starting_item_index)
	local str_pos = position.x .. ',' .. position.y .. ',' .. position.z

	return spec.list('nodemeta:' .. str_pos, list, x, y, width, height, starting_item_index)
end

--- @param x     number
--- @param y     number
--- @return string
function Spec.player_inventory(x, y)
	return ''
		.. spec.list('current_player', 'main', x, y      , 8, 1   )
		.. spec.list('current_player', 'main', x, y + 1.5, 8, 3, 8)
end


return Spec
