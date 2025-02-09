local S            = minetest.get_mod_translator()
local spec         = forms.Spec
local DefaultStyle = forms.DefaultStyle


--- @type string
local DS = os.DIRECTORY_SEPARATOR
--- @type string
local locale_path  = minetest.get_modpath(minetest.get_current_modname()) .. DS .. 'locale' .. DS
--- @type string
local DEFAULT_LANG = 'en'


--- @alias Form.offset { top:number, right:number, bottom:number, left:number }
--- @alias Form.deltas { dx:number, dy:number, dw:number, dh:number }

--- @class clans_tools.base_certificate.Form: base_classes.Form.Base
local Form = {
	NAME = 'clans_tools:base_certificate',
	--- @static
	--- @type number
	width   = 7,
	--- @static
	--- @type number
	height  = 9,
	--- @static
	--- @type Form.offset this
	margin  = { top = 1, right = 1, bottom = 2, left = 1 },
	--- @static
	--- @type Form.offset
	padding = { top = 0.5, right = 0.8, bottom = 0.5, left = 0.8 },
	--- @static
	--- @type { background:Form.deltas, content:Form.deltas }
	deltas  = {},
	--- @static
	--- @type
	clans_list = table.keys(clans.list()),
	--- @static
	--- @type table<string,string>
	certificate_text = {},
}
Form = base_classes.Form:personal():extended(Form)


Form.event.Type.on_sign     = 'on_sign'
Form.event.subscribers[Form.event.Type.on_sign] = {}
--- @type fun(callback:fun(form:clans_tools.base_certificate.Form)
Form.on_sign = Form.event:on(Form.event.Type.on_sign, Form.event)

--- @param lang_code string
--- @return string
function Form:get_lang_text(lang_code)
	if self.certificate_text[lang_code] then
		return self.certificate_text[lang_code]
	end
	local file_path = locale_path .. 'cert-text.' .. lang_code .. '.lua'
	if io.file_exists(file_path) then
		self.certificate_text[lang_code] = dofile(file_path)
	else
		self.certificate_text[DEFAULT_LANG] = self:get_lang_text(DEFAULT_LANG)
		self.certificate_text[lang_code] = self.certificate_text[DEFAULT_LANG]
	end

	return self.certificate_text[lang_code]
end

--- @param clan string
--- @return string
function Form:get_text(clan)
	local lang_code = minetest.get_player_information(self.player_name).lang_code

	return self:get_lang_text(lang_code):format(clan)
end

--- @param mode      string pass `"for_edit"` to display edit variant of form, or `"for_show"`
--- @param clan      string clan title (used only if `mode` is `"show"`)
--- @param certifier string certifier player name (used only if `mode` is `"show"`)
function Form:get_spec(mode, clan, certifier)
	local w, h = self.width, self.height
	local bg   = self.deltas.background
	local cnt  = self.deltas.content
	local bg_image = 'clans_tools_base_certificate_form_bg.png^[opacity:220'

	return ''
		.. spec.size(w, h)
		.. spec.no_prepend()
		.. spec.real_coordinates(true)
		.. spec.bgcolor('#0000')
		.. spec.style_type('button', DefaultStyle.get('button'))
		.. spec.background9(bg.dx, bg.dy, w + bg.dw, h + bg.dh, bg_image, 'false', 0)
		.. spec.box(cnt.dx, cnt.dy - .3, w + cnt.dw, .7, '#0000003b') -- for `header2`
		.. spec.header2(cnt.dx + .5, cnt.dy, S('Clan Base Certificate'))
		.. spec.box(cnt.dx, cnt.dy + 1, w + cnt.dw, h + cnt.dh - 2, '#000') -- for `italic_area_ro` or edit fields
		.. (mode == 'for_edit'
			and ''
				.. spec.dropdown_WH(cnt.dx + .5, cnt.dy + 3, w + cnt.dw - 2*.5, .7, 'clan_key', self.clans_list, '')
				.. spec.button(w - self.padding.right - 2.2 - .5, cnt.dy + 4, 2.2, .7, 'sign', S('Sign'))
			or ''
				.. spec.italic_area_ro(cnt.dx + .1, cnt.dy + 1 + 0.1, w + cnt.dw - .1, h + cnt.dh - 2 - .1, self:get_text(clan))
				.. spec.box(cnt.dx, h - self.padding.bottom - .2 - .4, w + cnt.dw, .6, '#0004') -- for "Signed by"
				.. spec.bold(w - self.padding.right - 2.5, h - self.padding.bottom - .3, S('Signed by') .. ': ' .. certifier)
		)
end

function Form:handle(fields)
	if fields.sign then
		local clan_key = fields.clan_key
		self.event:trigger(self.event.Type.on_sign, self, clan_key)
		self:close()
	end
end

--- @param self clans_tools.base_certificate.Form
Form.on_register(function(self)
	self.deltas = {
		background = {
			dx = -self.margin.left,
			dy = -self.margin.top,
			dw = self.margin.left + self.margin.right,
			dh = self.margin.top + self.margin.bottom,
		},
		content    = {
			dx = self.padding.left,
			dy = self.padding.top,
			dw = -self.padding.left + -self.padding.right,
			dh = -self.padding.top + -self.padding.bottom,
		}
	}
end)

Form:register()


return Form
