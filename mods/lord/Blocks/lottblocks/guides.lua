local S        = minetest.get_mod_translator()
local spec     = forms.Spec
local mod_path = minetest.get_modpath(minetest.get_current_modname())


local supported_lang_codes = { 'en', 'ru' }
local DEFAULT_LANG = 'en'

--- @type {about:string,content:string}[]
local book_text_in_lang = {}
--- @param lang_code string
--- @return {about:string,content:string}
local function get_book_in_lang(lang_code)
	if book_text_in_lang[lang_code] then return book_text_in_lang[lang_code] end

	lang_code = table.contains(supported_lang_codes, lang_code) and lang_code or DEFAULT_LANG
	book_text_in_lang[lang_code] = dofile(mod_path .. '/guide_text/palantir_guide.'.. lang_code ..'.lua')

	return book_text_in_lang[lang_code]
end

--- @param itemstack ItemStack
--- @param user      Player|ObjectRef
local function guide_on_use(itemstack, user)
	local player_name = user:get_player_name()

	local lang_code = minetest.get_player_information(player_name).lang_code
	local book = get_book_in_lang(lang_code)

	local formspec = ''
		.. spec.size(9, 9)
		.. spec.image(-.2, -.2, 11.5, 10.95, '(lottblocks_palantir_guide_bg.png^[opacity:70)')
		.. spec.header2(0.9, 0, S('The Eye of the Seer: On Secrets of Palantiri Creation'))
		.. spec.italic(1.2, 0.4, S('The Book of Feanor, greatest of the Eldar artisans.'))
		.. spec.box(0.625, 0.85, 7.45, 1.155, '#000')
		.. spec.italic_area_ro(1, 0.9, 8, 1.3, book.about)
		.. spec.box(0.125, 2.2, 8.5, 6.4, '#000')
		.. spec.textarea(0.5, 2.3, 8.55, 7.3, spec.read_only, '', book.content)
		.. spec.bold(4, 8.7, S('Feanor, son of Finwë, king of the Noldor'))

	minetest.show_formspec(player_name, 'lottother:guide', formspec)
end

minetest.register_craftitem('lottblocks:palantir_guide', {
	description = S('Palantir Guidebook'),
	inventory_image = 'lottblocks_palantir_guide.png',
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		guide_on_use(itemstack, user)
	end
})

minetest.register_craft({
	type = 'shapeless',
	output = 'lottblocks:palantir_guide',
	recipe = {'default:book', 'lottblocks:palantir'},
	replacements = {{'lottblocks:palantir', 'lottblocks:palantir'}}
})
