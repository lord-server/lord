-- Common parts of the "craft guide" books: `cooking`, `crafts`, `forbidden`, `master`, `protection`.
-- (former copy-pasted code of the `zcc`, `zcg`, `zfc`, `zmc`, `zpc` mods)

local S = core.get_mod_translator()

--- @class lord_books.BookForm
local book_form = {}

--- @type integer
book_form.ITEMS_PER_PAGE = 8 * 3

--- @return table
function book_form.new_user()
	return { current_item = '', alt = 1, page = 0, history = { index = 0, list = {} } }
end

--- @param output string item name
--- @param group  string
--- @return boolean
function book_form.has_group(output, group)
	return core.get_item_group(output, group) > 0
end

--- Resolves `group:` items of the recipe. If a group has several items, adds a separate recipe for each of them.
--- @param book   table  the book (`items_in_group()`, `add_craft()`)
--- @param input  table  recipe (`width`, `type`, `items`)
--- @param output string
--- @param groups table  already chosen items for groups
--- @return table|nil recipe without groups or nil if there is no recipe or it was split to the several recipes
local function resolve_groups(book, input, output, groups)
	local c = { width = input.width, type = input.type, items = input.items }
	if c.items == nil then
		return nil
	end

	for i, item in pairs(c.items) do
		if item:starts_with('group:') then
			local groupname = item:sub(7)
			if groups[groupname] == nil then
				for _, gi in ipairs(book.items_in_group(groupname)) do
					local g2      = groups
					g2[groupname] = gi
					book.add_craft({
						width = c.width,
						type  = c.type,
						items = table.copy(c.items)
					}, output, g2) -- it is needed to copy the table, else groups won't work right
				end

				return nil
			end
			c.items[i] = groups[groupname]
		end
	end

	return c
end

--- Adds the recipe to the book if the book wants it.
--- @param book      table
--- @param input     table
--- @param output    string
--- @param groups    table|nil
--- @param is_wanted fun(input:table, output:string):boolean
function book_form.add_craft(book, input, output, groups, is_wanted)
	if not is_wanted(input, output) then
		return
	end

	local c = resolve_groups(book, input, output, groups or {})
	if not c then
		return
	end
	if c.width == 0 then c.width = 3 end
	table.insert(book.crafts[output], c)
end

--- @param key     string prefix of the form fields
--- @param history table
--- @return string
function book_form.navigation_buttons(key, history)
	local formspec = ''
	if history.index > 1 then
		formspec = formspec ..
			'image_button[0,1;1,1;books_previous.png;' .. key .. '_previous;;false;false;books_previous_press.png]'
	else
		formspec = formspec .. 'image[0,1;1,1;books_previous_inactive.png]'
	end
	if history.index < #history.list then
		formspec = formspec ..
			'image_button[1,1;1,1;books_next.png;' .. key .. '_next;;false;false;books_next_press.png]'
	else
		formspec = formspec .. 'image[1,1;1,1;books_next_inactive.png]'
	end

	return formspec
end

--- @param key string prefix of the form fields
--- @param c   table recipe
--- @return string
local function recipe_view(key, c)
	local formspec = ''
	local x = 3
	local y = 0
	for i, item in pairs(c.items) do
		formspec = formspec ..
			'item_image_button[' ..
				((i - 1) % c.width + x) .. ',' .. (math.floor((i - 1) / c.width + y)) .. ';' ..
				'1,1;' .. item .. ';' ..
				key .. ':' .. item .. ';' ..
			']'
	end
	if c.type == 'normal' or c.type == 'cooking' then
		formspec = formspec .. 'image[6,2;1,1;books_method_' .. c.type .. '.png]'
	else
		-- we don't have an image for other types of crafting
		formspec = formspec .. 'label[0,2;Method: ' .. c.type .. ']'
	end
	formspec = formspec .. 'image[6,1;1,1;books_craft_arrow.png]'

	return formspec
end

--- Formspec of the selected item recipe (with the buttons to switch between alternative recipes).
--- @param key   string prefix of the form fields
--- @param book  table
--- @param user  table
--- @return string
function book_form.selected_recipe(key, book, user)
	local current_item = user.current_item
	if current_item == '' then
		return ''
	end
	local recipes = book.crafts[current_item]
	if not recipes then
		return ''
	end

	local formspec = ''
	local alt      = math.min(user.alt, #recipes)
	if alt > 1 then
		formspec = formspec .. 'button[7,0;1,1;' .. key .. '_alt:' .. (alt - 1) .. ';^]'
	end
	if alt < #recipes then
		formspec = formspec .. 'button[7,2;1,1;' .. key .. '_alt:' .. (alt + 1) .. ';v]'
	end
	local c = recipes[alt]
	if c then
		formspec = formspec .. recipe_view(key, c)
		formspec = formspec .. 'item_image_button[7,1;1,1;' .. user.current_item .. ';;]'
	end

	return formspec
end

--- Buttons of the items of the current page.
--- @param key      string   prefix of the form fields
--- @param list     string[] item names
--- @param page     integer  0-based
--- @param y_offset number   Y of the first row of the buttons
--- @return string, integer formspec, amount of the shown buttons
function book_form.item_buttons(key, list, page, y_offset)
	local npp      = book_form.ITEMS_PER_PAGE
	local formspec = ''
	local i        = 0 -- for positionning buttons
	local s        = 0 -- for skipping pages
	for _, name in ipairs(list) do
		if s < page * npp then
			s = s + 1
		else
			if i >= npp then break end
			formspec = formspec ..
				'item_image_button[' ..
					(i % 8) .. ',' .. (math.floor(i / 8) + y_offset) .. ';' ..
					'1,1;' ..
					name .. ';' ..
					key .. ':' .. name .. ';' ..
				']'
			i = i + 1
		end
	end

	return formspec, i
end

--- Buttons to switch the page.
--- @param key   string  prefix of the form fields
--- @param page  integer 0-based
--- @param shown integer amount of the shown items on the page
--- @param y     string  Y of the buttons
--- @return string
function book_form.page_buttons(key, page, shown, y)
	local formspec = ''
	if page > 0 then
		formspec = formspec .. 'button[0,' .. y .. ';1,.5;' .. key .. '_page:' .. (page - 1) .. ';<<]'
	end
	if shown >= book_form.ITEMS_PER_PAGE then
		formspec = formspec .. 'button[1,' .. y .. ';1,.5;' .. key .. '_page:' .. (page + 1) .. ';>>]'
	end

	return formspec
end

--- @param y     string  Y of the label
--- @param page  integer 0-based
--- @param total integer amount of all the items
--- @return string
function book_form.page_label(y, page, total)
	-- The Y is approximatively the good one to have it centered vertically...
	return 'label[2,' .. y .. ';' .. S('Page') .. ' ' .. (page + 1) .. '/' ..
		(math.floor(total / book_form.ITEMS_PER_PAGE + 1)) .. ']'
end

--- Moves through the history of the viewed items.
--- @param book          table
--- @param user          table
--- @param pn            string
--- @param step          integer -1 or 1
--- @param search_phrase string|nil
local function go_through_history(book, user, pn, step, search_phrase)
	local history = user.history
	if step < 0 and history.index <= 1 or step > 0 and history.index >= #history.list then
		return
	end

	history.index     = history.index + step
	user.current_item = history.list[history.index]
	book.form.show(pn, search_phrase)
end

--- Handles the `<key>:<item>`, `<key>_page:<n>` and `<key>_alt:<n>` fields.
--- @param book          table
--- @param key           string
--- @param user          table
--- @param pn            string
--- @param name          string field name
--- @param search_phrase string|nil
local function handle_link_field(book, key, user, pn, name, search_phrase)
	local item_prefix = key .. ':'
	local page_prefix = key .. '_page:'
	local alt_prefix  = key .. '_alt:'
	if name:starts_with(item_prefix) then
		local item = name:sub(#item_prefix + 1)
		if book.crafts[item] then
			user.current_item = item
			table.insert(user.history.list, item)
			user.history.index = #user.history.list
			book.form.show(pn, search_phrase)
		end
	elseif name:starts_with(page_prefix) then
		user.page = tonumber(name:sub(#page_prefix + 1))
		book.form.show(pn, search_phrase)
	elseif name:starts_with(alt_prefix) then
		user.alt = tonumber(name:sub(#alt_prefix + 1))
		book.form.show(pn, search_phrase)
	end
end

--- Reads the search field. If the search was submitted by Enter, resets the current page.
--- @param key    string
--- @param user   table
--- @param fields table
--- @return string, boolean search phrase, whether the search was submitted
local function read_search(key, user, fields)
	local filter_field = key .. '_filter'
	if fields.key_enter and fields.key_enter_field == filter_field and fields[filter_field] then
		user.page = 0

		return fields[filter_field], true
	end

	return fields[filter_field] or '', false
end

--- Handler of the book form fields.
--- @param book        table
--- @param key         string  prefix of the form fields
--- @param player      Player
--- @param fields      table
--- @param with_search boolean the book has the search field (`<key>_filter`)
function book_form.handle_fields(book, key, player, fields, with_search)
	local pn = player:get_player_name()
	if book.users[pn] == nil then
		book.users[pn] = book_form.new_user()
	end
	local user = book.users[pn]

	local search_phrase, new_filter
	if with_search then
		search_phrase, new_filter = read_search(key, user, fields)
	end

	if fields[key] or new_filter then
		book.form.show(pn, search_phrase)
		return
	elseif fields[key .. '_previous'] then
		go_through_history(book, user, pn, -1, search_phrase)
	elseif fields[key .. '_next'] then
		go_through_history(book, user, pn, 1, search_phrase)
	end

	for name, _ in pairs(fields) do
		handle_link_field(book, key, user, pn, name, search_phrase)
	end
end


return book_form
