local SL      = lord.require_intllib()

local form    = {}
--- @type string
form.NAME     = "brewing_book_form"
--- @param page string
--- @return string
form.get_spec = function(page)
	if page == "brews" then
		return "size[8,5.5]"
			.. "listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
			.. "background[5,5;1,1;craft_formbg.png;true]"
			.. "label[0,0;" .. SL("Book of Brewing") .. "]"
			.. "button_exit[6,0;2,0.5;quit;" .. SL("Exit") .. "]"
			.. "image_button[7,1;1,1;zcg_next.png;brews2;;false;false;zcg_next_press.png]"
			.. "image[6,1;1,1;zcg_previous_inactive.png]"
			--First
			.. "label[1,2.2; " .. SL("Wine") .. "]"
			.. "item_image_button[4,2;1,1;lottpotion:drinking_glass_water;zcg:vessels:glass_water;]"
			.. "item_image_button[5,2;1,1;lottfarming:berries;zcg:berries;5]"
			.. "image[6,2;1,1;zcg_craft_arrow.png]"
			.. "item_image_button[7,2;1,1;lottpotion:wine;zcg:wine;]"
			--Second
			.. "label[1,3.2; " .. SL("Beer") .. "]"
			.. "item_image_button[4,3;1,1;lottpotion:drinking_glass_water;zcg:drinking_glass_water;]"
			.. "item_image_button[5,3;1,1;farming:wheat0;zcg:wheat;3]"
			.. "image[6,3;1,1;zcg_craft_arrow.png]"
			.. "item_image_button[7,3;1,1;lottpotion:beer;zcg:beer;]"
			--Third
			.. "label[1,4.2; " .. SL("Mead") .. "]"
			.. "item_image_button[4,4;1,1;lottpotion:drinking_glass_water;zcg:drinking_glass_water;]"
			.. "item_image_button[5,4;1,1;bees:bottle_honey;zcg:honey;6]"
			.. "image[6,4;1,1;zcg_craft_arrow.png]"
			.. "item_image_button[7,4;1,1;lottpotion:mead;zcg:mead;]"
	end
	if page == "brews2" then
		return "size[8,5.5]"
			.. "listcolors[#606060AA;#888;#14F318;#30434C;#FFF]"
			.. "background[5,5;1,1;craft_formbg.png;true]"
			.. "label[0,0;" .. SL("Book of Brewing") .. "]"
			.. "button_exit[6,0;2,0.5;quit;" .. SL("Exit") .. "]"
			.. "image[7,1;1,1;zcg_next_inactive.png]"
			.. "image_button[6,1;1,1;zcg_previous.png;brews;;false;false;zcg_previous_press.png]"
			--First
			.. "label[1,2.2; " .. SL("Cider") .. "]"
			.. "item_image_button[4,2;1,1;lottpotion:drinking_glass_water;zcg:drinking_glass_water;]"
			.. "item_image_button[5,2;1,1;default:apple;zcg:apple; 5]"
			.. "image[6,2;1,1;zcg_craft_arrow.png]"
			.. "item_image_button[7,2;1,1;lottpotion:cider;zcg:cider;]"
			--Second
			.. "label[1,3.2; " .. SL("Ale") .. "]"
			.. "item_image_button[4,3;1,1;lottpotion:drinking_glass_water;zcg:drinking_glass_water;]"
			.. "item_image_button[5,3;1,1;lottfarming:barley_seed;zcg:barley;6]"
			.. "image[6,3;1,1;zcg_craft_arrow.png]"
			.. "item_image_button[7,3;1,1;lottpotion:ale;zcg:ale;]"
	end
end

--- @param player Player
--- @param page string
form.show     = function(player, page)
	minetest.show_formspec(player:get_player_name(), form.NAME, form.get_spec(page))
end


---@param player    Player
---@param form_name string
---@param fields    table
minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= form.NAME then
		-- HACK: До рефакторинга все формы книг обрабатывали все прилетающие поля со всех форм, не учитывая `form_name`,
		--       с кучей запутанных вызовов.
		--       Теперь нет, однако на форме `lottinventory:master_book` есть кнопка `brews`,
		--       которая открывает эту форму, но обрабатывается она здесь
		if form_name == zmc.form.NAME and fields.brews then
			form.show(player, "brews")
		end
		return
	end

	if fields.brews then
		form.show(player, "brews")
	end
	if fields.brews2 then
		form.show(player, "brews2")
	end
end)

minetest.register_tool("lottinventory:brewing_book", {
	description     = SL("Book of Brewing"),
	inventory_image = "lottinventory_brewing_book.png",
	wield_image     = "",
	wield_scale     = { x = 1, y = 1, z = 1 },
	stack_max       = 1,
	groups          = { cook_crafts = 1, book = 1, paper = 1 },
	on_use          = function(itemstack, player, pointed_thing)
		form.show(player, "brews")
		return itemstack; -- nothing consumed, nothing changed
	end,
})
