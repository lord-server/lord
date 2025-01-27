local S        = minetest.get_mod_translator()
local spec     = forms.Spec
local colorize = minetest.colorize


--- @class lord_books.potions.Form: base_classes.Form.Base
local Form = {
	--- @type string
	NAME             = 'potions_book_form',
	RECIPES_PER_PAGE = 3,
	count_of         = {
		ingredients = 0,
		potions     = 0,
	},
	pages_of         = {
		ingredients = 0,
		potions     = 0,
	},
	total_pages      = 0,
}
Form = base_classes.Form:extended(Form)

function Form.init()
	local ingredients_cnt = table.count(potions.ingredient.get_all())
	local potions_cnt     = table.count(potions.potion.get_all())

	Form.count_of         = {
		ingredients = ingredients_cnt,
		potions     = potions_cnt,
	}
	Form.pages_of         = {
		ingredients = math.ceil(ingredients_cnt / Form.RECIPES_PER_PAGE),
		potions     = math.ceil(potions_cnt / Form.RECIPES_PER_PAGE),
	}
	Form.total_pages      = math.ceil((ingredients_cnt + potions_cnt) / Form.RECIPES_PER_PAGE)
end


--- @private
--- @param X    number
--- @param Y    number
--- @param W    number
--- @param H    number
--- @param type string @`"next"` or `"previous"`
--- @param page number
function Form.navigate(X, Y, W, H, type, page)
	return type == 'next'
		and (
			page ~= Form.total_pages
				and spec.image_button(
					X, Y, W, H, 'books_next.png', 'page' .. (page + 1), nil, false, false, 'books_next_press.png'
				)
				or  spec.image(X, Y, W, H, 'books_next_inactive.png')
		)
		or  (
			page ~= 1
				and spec.image_button(
					X, Y, W, H, 'books_previous.png', 'page' .. (page - 1), nil, false, false, 'books_previous_press.png'
				)
				or  spec.image(X, Y, W, H, 'books_previous_inactive.png')
		)
end

--- @private
--- @param page number
--- @return boolean
function Form.is_ingredients_page(page)
	return page * Form.RECIPES_PER_PAGE <= Form.count_of.ingredients
end

--- @private
--- @param X    number
--- @param Y    number
--- @param page number
--- @return string
function Form.page_title(X, Y, page)
	local page_title = Form.is_ingredients_page(page)
		and S('Ingredients for potions')
		or  ''

	return spec.label(X, Y, page_title)
end


--- @private
--- @param item_name       string
--- @param item_definition ItemDefinition
--- @param i               number
function Form.recipe(item_name, item_definition, i, is_ingredients_page)
	local dy = is_ingredients_page
		and i % Form.RECIPES_PER_PAGE
		or  tonumber(item_name:sub(-1)) - 1  -- name of potion has `_1`, `_2`, `_3` postfix at the end

	local recipe = minetest.get_craft_recipe(item_name, minetest.CraftMethod.POTION, minetest.CraftType.COOKING)

	return ''
		.. spec.label(0, 2.75 + dy, item_definition._tt_original_description or item_definition.description)
		.. spec.item_image_button(5, 2.5 + dy, 1, 1, recipe.input[1][1], recipe.input[1][1], '')
		.. spec.item_image_button(6, 2.5 + dy, 1, 1, recipe.input[1][2], recipe.input[1][2], '')
		.. spec.image            (7, 2.5 + dy, 1, 1, 'benches_laboratory.png')
		.. spec.item_image_button(8, 2.5 + dy, 1, 1, item_name, item_name, '')
end

--- @param list     table<string,NodeDefinition>
--- @param callback fun(item_name:string,item_definition:ItemDefinition):boolean return `true` for stop iteration
local function foreach_ingredient_in(list, callback)
	for item_name, item_definition in pairs(list) do
		if callback(item_name, item_definition) then  break  end
	end
end

--- @param list     table<string,table<string,NodeDefinition>>
--- @param callback fun(item_name:string,item_definition:ItemDefinition):boolean return `true` for stop iteration
local function foreach_potion_in(list, callback)
	for group_name, group_list in pairs(list) do
		for item_name, item_definition in pairs(group_list) do
			if callback(item_name, item_definition) then  break  end
		end
	end
end

--- @private
--- @param page number
--- @return string
function Form.list_page(page)
	local is_ingredients_page = Form.is_ingredients_page(page)
	local list = is_ingredients_page
		and potions.ingredient.get_all()
		or  potions.potion.get_all_grouped()

	local list_page     = is_ingredients_page and page or page - Form.pages_of.ingredients
	local items_to_skip = (list_page - 1) * Form.RECIPES_PER_PAGE
	local i             = 1
	local form_spec     = ''

	local foreach_in = is_ingredients_page and foreach_ingredient_in or foreach_potion_in
	foreach_in(list, function(item_name, item_definition)
		if i > items_to_skip + Form.RECIPES_PER_PAGE then
			return true
		end
		if i > items_to_skip then
			form_spec = form_spec .. Form.recipe(item_name, item_definition, i, is_ingredients_page)
		end
		i = i + 1
	end)

	return form_spec
end

--- @param page string
--- @return string
function Form:get_spec(page)
	page = tonumber(page) or 1

	return spec.size(9, 5.5)
		.. spec.bold(0, 0, S('Book "@1"', colorize('#ff8', S('Crafting of Potions'))))
		.. Form.page_title(0, 1, page)
		.. Form.list_page(page)
		.. spec.button_exit(7, 0, 2, 0.5, 'quit', S('Exit'))
		.. Form.navigate(7, 1, 1, 1, 'previous', page)
		.. Form.navigate(8, 1, 1, 1, 'next', page)
end

---@param player    Player
---@param form_name string
---@param fields    table
function Form:handler(player, form_name, fields)
	if form_name ~= Form.NAME then
		-- HACK: До рефакторинга все формы книг обрабатывали все прилетающие поля со всех форм, не учитывая `form_name`,
		--       с кучей запутанных вызовов.
		--       Теперь нет, однако на форме `lord_books:master_book` есть кнопка `potions`,
		--       которая открывает эту форму, но обрабатывается она здесь
		if form_name == zmc.form.NAME and fields.potions then
			Form:new(player):open()
		end
		return
	end

	self.event:trigger(self.event.Type.on_handle, self, player, fields)
	for i = 1, Form.total_pages do
		if fields['page'..i] then
			Form:new(player):open(i)
			break
		end
	end


	if fields.quit then
		self:close()
	end
end


Form.init()
Form:register()

minetest.register_tool('lord_books:potions_book',{
	description     = S('Book "@1"', colorize('#ff0', S('Crafting of Potions'))),
	inventory_image = 'potion_book.png',
	stack_max       = 1,
	groups          = { cook_crafts = 1, book = 1, paper = 1 },
	on_use          = function(itemstack, player, pointed_thing)
		Form:new(player):open()
		return itemstack; -- nothing consumed, nothing changed
	end,
})
