local S        = minetest.get_translator('lord_inventory')
local spec     = minetest.formspec


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

--- @param x     number
--- @param y     number
--- @param name  string
--- @param title string
local function icon_button(x, y, name, title, url)
	return ''
		.. spec.button_url(x, y, 2, 1, name, title, url)
		.. spec.image(x+.2, y+.24, 0.4, 0.4, 'lord_inventory_icon_'..name..'.png')
end

--- @param x         number
--- @param y         number
--- @param text      string
--- @param font_size string  see minetest.FormSpec.Style.font_size . Default: `"+7"`
local function title(x, y, text, font_size)
	font_size = font_size or '+7'

	return ''
		.. spec.style_type('label', { font = 'bold', font_size = font_size })
		.. spec.label(x, y, text)
		.. spec.style_type('label', { font = 'normal', font_size = '+0' })
end

--- @param x    number
--- @param y    number
--- @param text string
local function slogan(x, y, text)
	return ''
		.. spec.style_type('label', { font = 'italic', textcolor = '#ccc' })
		.. spec.label(x, y, text)
		.. spec.style_type('label', { font = 'normal', textcolor = '#fff' })
end

--- @param x    number
--- @param y    number
--- @param res  lord_inventory.Form.AboutTab.resource
local function resource(x, y, res)
	local description = descriptions[res.name]
	local sdx = description.sub_title_dx

	return ''
		.. spec.style_type('label', { font = 'bold', textcolor = '#fffe' })
		.. spec.label(x, y + .08, description.title)
		.. (description.sub_title and (
			spec.style_type('label', { font = 'bold', textcolor = '#d4d4d4', font_size = '-1' }) ..
			spec.label(x + sdx, y + .07, '(' .. description.sub_title .. ')')
		) or '')
		.. spec.style_type('label', { font = 'normal', textcolor = '#ddd', font_size = '-1' })
		.. spec.label(x, y + .34, description.desc)
		.. spec.style_type('label', { font = 'normal', textcolor = '#fff', font_size = '+0' })
		.. icon_button(x + 5.2, y, res.name, res.title, res.url)
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
		..		spec.style_type('button_url', { padding= '20,0,0,0' })
		..		table.concat(res_strings)
		.. spec.container_end()
end

--- @return string
function AboutTab:get_spec()
	return ''
		.. title(2.75, 0, 'L.O.R.D. Server')
		.. spec.label(0.3, 0.5, 'по мотивам легендариума Дж. Толкина ("Властелин Колец", "Хоббит", ...)')
		.. slogan(2.15, 0.9, 'можно копать... можно не копать...')

		.. spec.button_url(2, 1.4, 2, 1, 'about', S('About.btn'), 'https://lord-server.ru/about')
		.. spec.button_url(4, 1.4, 2, 1, 'rules', S('Rules.btn'), 'https://lord-server.ru/rules')

		.. all_resources(.4, 2.6, resources)

		.. spec.style_type('label', { font = 'bold', textcolor = '#fffd' })
		.. spec.label(2.25, 7.3, 'Поддержать развитие проекта')
		.. spec.style('donate', { bgimg = 'lord_inventory_boosty.png', border = 'false' })
		.. spec.style('donate:hovered', { bgimg = 'lord_inventory_boosty_hovered.png', border = 'false' })
		.. spec.button_url(2.5, 7.75, 3, 1, 'donate', '', 'https://boosty.to/lord-server')
end


return AboutTab
