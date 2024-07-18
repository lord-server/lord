local S = minetest.get_translator("lord_books")
local esc = minetest.formspec_escape

local formspec_size = "size[8,8]"

---Formspec for editing scroll
---@param  title  string   title of the scroll
---@param  text   string   content of the book
---@return        string formspec
local function formspec_write(title, text)
	return "field[0.5,1;7.5,0;title;" .. esc(S("Title:")) .. ";" ..
			esc(title) .. "]" ..
		"textarea[0.5,1.5;7.5,7;text;" .. esc(S("Contents:")) .. ";" ..
			esc(text) .. "]" ..
		"button_exit[2.5,7.5;3,1;save;" .. esc(S("Save")) .. "]"
end

local book_writers = {}

minetest.register_on_leaveplayer(function(player)
	book_writers[player:get_player_name()] = nil
end)

---Show scroll window when player uses it
---@param  itemstack ObjectRef player's itemstack
---@param  user      Player    player
---@return           ObjectRef player's itemstack nothing consumed
local function scroll_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local meta = itemstack:get_meta()

	local data = meta:to_table().fields

	local title = data.title or ""
	local text = data.text or ""

	local formspec
	formspec = formspec_write(title, text)

	minetest.show_formspec(player_name, "lord_books:scroll", formspec_size .. formspec)
	-- Store the wield index in case the user accidentally switches the wield item before the formspec is shown
	book_writers[player_name] = { wield_index = user:get_wield_index() }
	return itemstack
end

local max_title_size = 80
local short_title_size = 35
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "lord_books:scroll" then
		return
	end

	local player_name = player:get_player_name()
	local inv = player:get_inventory()
	if not book_writers[player_name] then
		return
	end

	local wield_index = book_writers[player_name].wield_index
	local wield_list = player:get_wield_list()
	local stack = inv:get_stack(wield_list, wield_index)
	if stack:get_name() ~= "lord_books:scroll" then
		-- No book in the wield slot, abort & inform the player
		minetest.chat_send_player(player_name,
			S("The scroll you were writing to mysteriously disappeared."))
		return
	end
	local data = stack:get_meta():to_table().fields

	if fields.quit then
		book_writers[player_name] = nil
	end

	if fields.save and fields.title and fields.text then
		if not data then data = {} end
		data.title = fields.title:sub(1, max_title_size)
		local short_title = data.title
		-- Don't bother triming the title if the trailing dots would make it longer
		if #short_title > short_title_size + 3 then
			short_title = short_title:sub(1, short_title_size) .. "..."
		end
		data.description = S("Scroll")..": "..short_title
		data.text = fields.text
		data.text = data.text:replace("\r\n", "\n"):replace("\r", "\n")
		data.text = data.text:gsub("[%z\1-\8\11-\31\127]", "") -- strip naughty control characters (keeps \t and \n)

		stack:get_meta():from_table({ fields = data })
	end

	-- Update stack
	inv:set_stack(wield_list, wield_index, stack)
end)

minetest.register_craftitem("lord_books:scroll", {
	description = S("Scroll"),
	inventory_image = "scroll.png",
	groups = { book = 1, flammable = 3 },
	on_use = scroll_on_use,
	stack_max = 1,
})
