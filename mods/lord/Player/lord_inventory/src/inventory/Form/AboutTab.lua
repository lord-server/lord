local S         = minetest.get_translator('lord_inventory')
local spec      = minetest.formspec
local lord_spec = forms.spec


-- TODO #1709

--- @alias lord_inventory.Form.AboutTab.resource { name:string, title:string, url:string }

--- @type lord_inventory.Form.AboutTab.resource[]
local resources = {
	{ name = 'site'   , title = 'Website', url = 'https://lord-server.ru/' },
	{ name = 'discord', title = 'Discord', url = 'https://www.discord.gg/YcT5FuQwUT' },
	{ name = 'youtube', title = 'YouTube', url = 'https://www.youtube.com/@lord-server' },
	{ name = 'vk'     , title = 'group  ', url = 'https://vk.com/minetest_lord' },
	{ name = 'github' , title = 'GitHub ', url = 'https://github.com/lord-server/lord' },
}
--- @type { title:string, sub_title:string, sub_title_dx:number, desc:string }[]
local descriptions = {
	site    = {
		title     = 'Наш сайт',
		sub_title = 'Карта мира', sub_title_dx = 1.06,
		desc      = 'Информация об Игроках, Спаунах и Кланах',
	},
	discord = {
		title     = 'Наш Discord',
		sub_title = 'Болтаем и дружим', sub_title_dx = 1.38,
		desc      = 'Выкладываем новости, договариваемся об Ивентах',
	},
	youtube = {
		title     = 'Наш YouTube',
		sub_title = 'Видео и стримы', sub_title_dx = 1.51,
		desc      = 'Записи Ивентов, Let\'s play-ев, Строительства',
	},
	vk      = {
		title     = 'Страница ВКонтакте',
		desc      = 'Новости и заметки о жизни сервера',
	},
	github  = {
		title     = 'Репозиторий',
		sub_title = 'Open source', sub_title_dx = 1.48,
		desc      = 'Сообщи об ошибке. Присоединяйся к команде',
	},
}


--- @class inventory.Form.AboutTab: base_classes.Form.Element.Tab
local AboutTab = base_classes.Form.Element.Tab:extended({
	title = S('About'),
})


--- @param x    number
--- @param y    number
--- @param res  lord_inventory.Form.AboutTab.resource
local function resource(x, y, res)
	local description = descriptions[res.name]
	local sdx = description.sub_title_dx
	local icon = 'lord_inventory_icon_'..res.name..'.png'

	return ''
		.. lord_spec.bold(x, y + .08, description.title, { textcolor = '#fffe' })
		.. (description.sub_title and (
			lord_spec.small_bold(x + sdx, y + .07, '(' .. description.sub_title .. ')', '#d4d4d4')
		) or '')
		.. lord_spec.small(x, y + .34, description.desc, { textcolor = '#ddd' })
		.. lord_spec.icon_button(x + 5.2, y, res.name, icon, res.title, res.url)
end

--- @param x              number
--- @param y              number
--- @param resources_list lord_inventory.Form.AboutTab.resource[]
local function all_resources(x, y, resources_list)
	local res_strings = {}
	local dx = 0
	local dy = 0
	for _, res in pairs(resources_list) do
		table.insert(res_strings, resource(dx, dy, res))
		dy = dy + 0.9
	end

	return ''
		.. spec.container(x, y)
		..		table.concat(res_strings)
		.. spec.container_end()
end

--- @return string
local function donate_button()
	return ''
		.. spec.style('donate', { bgimg = 'lord_inventory_boosty.png', border = 'false' })
		.. spec.style('donate:hovered', { bgimg = 'lord_inventory_boosty_hovered.png', border = 'false' })
		.. spec.button_url(2.5, 7.75, 3, 1, 'donate', '', 'https://boosty.to/lord-server')
end


--- @return string
function AboutTab:get_spec()
	return ''
		.. lord_spec.title(2.75, 0, 'L.O.R.D. Server')
		.. lord_spec.label(0.3, 0.5, 'по мотивам легендариума Дж. Толкина ("Властелин Колец", "Хоббит", ...)')
		.. lord_spec.muted_italic(2.15, 0.9, 'можно копать... можно не копать...')

		.. lord_spec.button(2, 1.4, 2, 1, 'about', S('About.btn'), 'https://lord-server.ru/about')
		.. lord_spec.button(4, 1.4, 2, 1, 'rules', S('Rules.btn'), 'https://lord-server.ru/rules')

		.. all_resources(.4, 2.6, resources)

		.. lord_spec.bold(2.25, 7.3, 'Поддержать развитие проекта', { textcolor = '#fffd' })
		.. donate_button()
end


return AboutTab
