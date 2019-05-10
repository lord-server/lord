local SL = lord.require_intllib()

local lpp = 13
local function guide_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local data = minetest.registered_items[itemstack:get_name()].text
	local page_info = minetest.deserialize(itemstack:get_metadata())
	local page, lines, string = 1, {}, ""

	local title = data.title
	local text = data.text
	local owner = data.owner
	local page_max = data.page_max
	local background = data.background or "gui_elfbg.png"

	for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
		lines[#lines+1] = str
	end

	if page_info then
		if page_info.page then
			page = page_info.page
		end
	end

	for i = ((lpp * page) - lpp) + 1, lpp * page do
		if not lines[i] then break end
		string = string .. lines[i] .. "\n"
	end

	local formspec = "size[8,8]" ..
		"background[8,8;1,1;" .. background .. ";true]"..
		"label[0.5,0.5;" .. minetest.colorize("black"," от автора   ") .. minetest.colorize("purple",owner) .. "]" ..
		"label[0.4,0;" .. minetest.colorize("purple", minetest.formspec_escape(title)) .. "]" ..
		"textarea[0.5,1.5;7.5,7;;" ..
		minetest.colorize("black", minetest.formspec_escape(string ~= "" and string or text)) .. ";]" ..
		"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
		"label[3.1,7.7;" .. minetest.colorize("black","Страница "..page .. " из " .. page_max) .. "]" ..
		"button[5.2,7.6;0.8,0.8;book_next;>]"

	minetest.show_formspec(player_name, "lottother:guide", formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "lottother:guide" then return end
	local stack = player:get_wielded_item()

	if fields.book_next or fields.book_prev then
		local data = minetest.registered_items[stack:get_name()].text
		local page_info = minetest.deserialize(stack:get_metadata())
		if not page_info then
			page_info = {page = 1}
		end

		if fields.book_next then
			page_info.page = page_info.page + 1
			if page_info.page > data.page_max then
				page_info.page = 1
			end
		else
			page_info.page = page_info.page - 1
			if page_info.page == 0 then
				page_info.page = data.page_max
			end
		end

		local data_str = minetest.serialize(page_info)
		stack:set_metadata(data_str)
		guide_on_use(stack, player)
	end

	player:set_wielded_item(stack)
end)

local palantir_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/palantir_guide.lua")

minetest.register_craftitem("lottblocks:palantir_guide", {
	description = SL("Palantir Guidebook"),
	inventory_image = "lottblocks_book_blue.png",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(palantir_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craft({
	type = "shapeless",
	output = "lottblocks:palantir_guide",
	recipe = {"default:book", "lottblocks:palantir"},
	replacements = {{"lottblocks:palantir", "lottblocks:palantir"}}
})
