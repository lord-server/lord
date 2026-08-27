local S    = minetest.get_mod_translator()
local spec = forms.Spec --[[@as forms.Spec]]


-- TODO #1709

--- @class lord_inventory.Form.AboutTab.resource
--- @field title          string
--- @field sub_title?     string
--- @field sub_title_dx?  number
--- @field desc           string
--- @field at_single_mode boolean
--- @field at_server_mode boolean
--- @field btn_text       string
--- @field url            string

--- @type lord_inventory.Form.AboutTab.resource[string]
local resources = {
	site    = {
		title          = S('Website'),
		sub_title      = not core.is_singleplayer() and S('World Map') or nil, sub_title_dx = 1.06,
		desc           = S('Information about Players, Spawns and Clans'),
		at_single_mode = true,
		at_server_mode = true,
		btn_text       = 'Website',
		url            = 'https://lord-server.ru/',
	},
	telegram = {
		title          = S('Our Telegram'),
		sub_title      = S('Stay in touch'), sub_title_dx = 1.48,
		desc           = S('Post news, inform about events and streams'),
		at_single_mode = true,
		at_server_mode = true,
		btn_text       = 'Telegram',
		url            = 'https://t.me/lord_server_ru',
	},
	discord = {
		title          = S('Our Discord'),
		sub_title      = S('Chat and friendship'), sub_title_dx = 1.38,
		desc           = S('Post news, discuss events'),
		at_single_mode = true,
		at_server_mode = true,
		btn_text       = 'Discord',
		url            = 'https://www.discord.gg/YcT5FuQwUT',
	},
	youtube = {
		title          = S('Our YouTube'),
		sub_title      = S('Video and streams'), sub_title_dx = 1.51,
		desc           = S('Records of events, Let\'s play, Building'),
		at_single_mode = true,
		at_server_mode = true,
		btn_text       = 'YouTube',
		url            = 'https://www.youtube.com/@lord-server',
	},
	vk      = {
		title          = S('VKontakte page'),
		desc           = S('News and notes about server life'),
		at_single_mode = false,
		at_server_mode = true,
		btn_text       = 'group',
		url            = 'https://vk.com/minetest_lord',
	},
	github  = {
		title          = 'Репозиторий',
		sub_title      = 'Open source', sub_title_dx = 1.48,
		desc           = 'Сообщи об ошибке. Присоединяйся к команде',
		at_single_mode = true,
		at_server_mode = false,
		btn_text       = 'GitHub',
		url            = 'https://github.com/lord-server/lord',
	},
}


--- @class inventory.Form.AboutTab: base_classes.Form.Element.Tab
local AboutTab = base_classes.Form.Element.Tab:extended({
	title = S('About'),
})


--- @param x    number
--- @param y    number
--- @param name string
--- @param res  lord_inventory.Form.AboutTab.resource
local function resource(x, y, name, res)
	local sdx = res.sub_title_dx or 0
	local icon = 'lord_inventory_icon_'..name..'.png'

	return ''
		.. spec.bold(x, y + .08, res.title, { textcolor = '#fffe' })
		.. (res.sub_title and (
			spec.small_bold(x + sdx, y + .07, '(' .. res.sub_title .. ')', '#d4d4d4')
		) or '')
		.. spec.small(x, y + .34, res.desc, { textcolor = '#ddd' })
		.. spec.icon_button(x + 5.2, y, name, icon, res.btn_text, res.url)
end

--- @param x              number
--- @param y              number
--- @param resources_list table<string, lord_inventory.Form.AboutTab.resource>
local function all_resources(x, y, resources_list)
	local res_strings = {}
	local dx = 0.0
	local dy = 0.0
	local is_single_mode = core.is_singleplayer()
	local is_server_mode = not is_single_mode
	for name, res in pairs(resources_list) do
		if (is_single_mode and res.at_single_mode) or (is_server_mode and res.at_server_mode) then
			table.insert(res_strings, resource(dx, dy, name, res))
			dy = dy + 0.9
		end
	end

	return ''
		.. spec.container(x, y)
		..		table.concat(res_strings)
		.. spec.container_end()
end

--- @return string
local function donate_button()
	return ''
		.. spec.style('donate', { bgimg = 'lord_inventory_boosty.png', border = true })
		.. spec.style('donate:hovered', { bgimg = 'lord_inventory_boosty_hovered.png', border = false })
		.. spec.button_url(2.5, 7.75, 3, 1, 'donate', '', 'https://boosty.to/lord-server')
end


--- @return string
function AboutTab:get_spec()
	return ''
		.. spec.title(2.75, 0, 'L.O.R.D. Server')
		.. spec.label(0.3, 0.5, 'по мотивам легендариума Дж. Толкина ("Властелин Колец", "Хоббит", ...)')
		.. spec.muted_italic(2.15, 0.9, 'можно копать... можно не копать...')

		.. spec.button(2, 1.4, 2, 1, 'about', S('About'), 'https://lord-server.ru/about')
		.. spec.button(4, 1.4, 2, 1, 'rules', S('Rules'), 'https://lord-server.ru/rules')

		.. all_resources(.4, 2.6, resources)

		.. spec.bold(2.25, 7.3, 'Поддержать развитие проекта', { textcolor = '#fffd' })
		.. donate_button()
end


return AboutTab
