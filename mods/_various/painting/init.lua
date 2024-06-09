-- painting - in-game painting for minetest

-- THIS MOD CODE AND TEXTURES ARE LICENSED
--						<3 TO YOU <3
--		UNDER TERMS OF WTFPL LICENSE

-- 2012, 2013, 2014 obneq aka jin xi

-- picture is drawn using a nodebox to draw the canvas
-- and an entity which has the painting as its texture.
-- this texture is created by minetests internal image
-- compositing engine (see tile.cpp).
local SL = lord.require_intllib()

local revcolors = {
    [1] = "white",
    [2] = "darkgreen",
    [3] = "grey",
    [4] = "red",
    [5] = "brown",
    [6] = "cyan",
    [7] = "orange",
    [8] = "violet",
    [9] = "darkgrey",
    [10] = "pink",
    [11] = "green",
    [12] = "magenta",
    [13] = "yellow",
    [14] = "black",
    [15] = "blue",
}

local textures = {}
for _, col in ipairs(revcolors) do
	textures[col] = col..".png"
end

local colors = {}
local thickness = 0.1

-- picture node
local picbox = {
	type = "fixed",
	fixed = { -0.499, -0.499, 0.499, 0.499, 0.499, 0.499 - thickness }
}

minetest.register_node("painting:pic", {
	description = SL("Picture"),
	tiles = { "white.png" },
	inventory_image = "painted.png",
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = picbox,
	selection_box = picbox,
	groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},

	--handle that right below, don't drop anything
	drop = "",

	after_dig_node = function(pos, oldnode, oldmetadata, digger)

		--find and remove the entity
		for _,e in pairs(minetest.get_objects_inside_radius(pos, 0.5)) do

			if e:get_luaentity()
			and e:get_luaentity().name == "painting:picent" then
				e:remove()
			end
		end

		local inv = digger:get_inventory()

		if inv
		and inv:room_for_item("main", "painting:paintedcanvas") then

			-- put picture data back into inventory as item
			inv:add_item("main", {
				name = "painting:paintedcanvas",
				count = 1,
				metadata = oldmetadata.fields["painting:picturedata"]
			})

		else
			-- drop picture as item
			minetest.add_item(pos, ItemStack({
				name = "painting:paintedcanvas",
				count = 1,
				metadata = oldmetadata.fields["painting:picturedata"]
			}))
		end
	end
})

local to_imagestring

-- picture texture entity
minetest.register_entity("painting:picent", {
	collisionbox = { 0, 0, 0, 0, 0, 0 },
	visual = "upright_sprite",
	textures = { "white.png" },

	on_activate = function(self, staticdata)

		local pos = self.object:get_pos()
		local meta = minetest.get_meta(pos)
		local data = meta:get_string("painting:picturedata")

		data = minetest.deserialize(data)

		if not data or not data.grid then
			return
		end

		self.object:set_properties({textures = { to_imagestring(data.grid, data.res) }})
	end
})

-- taken from vector_extras to save dependency
local twolines = {}

local twoline = function(x, y)

	local pstr = x.." "..y
	local line = twolines[pstr]

	if line then
		return line
	end

	line = {}

	local n = 1
	local dirx = 1

	if x < 0 then
		dirx = -dirx
	end

	local ymin, ymax = 0, y

	if y < 0 then
		ymin, ymax = ymax, ymin
	end

	local m = y / x --y/0 works too
	local dir = 1

	if m < 0 then
		dir = -dir
	end

	for i = 0, x, dirx do

		local p1 = math.max(math.min(math.floor((i - 0.5) * m + 0.5), ymax), ymin)
		local p2 = math.max(math.min(math.floor((i + 0.5) * m + 0.5), ymax), ymin)

		for j = p1, p2, dir do

			line[n] = {i, j}

			n = n + 1
		end
	end

	twolines[pstr] = line

	return line
end

local paintbox = {
	[0] = { -0.5,-0.5,0,0.5,0.5,0 },
	[1] = { 0,-0.5,-0.5,0,0.5,0.5 }
}

local dirs, intersect, clamp

minetest.register_entity("painting:paintent", {
	collisionbox = { 0, 0, 0, 0, 0, 0 },
	visual = "upright_sprite",
	textures = { "white.png" },

	on_punch = function(self, puncher)

		--check for brush
		local name = puncher:get_wielded_item():get_name()

		name = string.split(name, "_")[2]

		if not textures[name] then
			return
		end

		--get player eye level
		--see player.h line 129
		local ppos = puncher:get_pos()

		ppos.y = ppos.y + 1.47

		local pos = self.object:get_pos()
		local l = puncher:get_look_dir()

		local d = dirs[self.fd]
		local od = dirs[(self.fd + 1) % 4]
		local normal = { x = d.x, y = 0, z = d.z }
		local p = intersect(ppos, l, pos, normal)

		local off = -0.5

		pos = vector.add(pos, {x = off  *od.x, y = off, z = off * od.z})

		p = vector.subtract(p, pos)

		local x = math.abs(p.x + p.z)
		local y = 1 - p.y

		--print("x: "..x.." y: "..y)

		x = math.floor(x * self.res)
		y = math.floor(y * self.res)

		--print("grid x: "..x.." grid y: "..y)

		x = clamp(x, self.res)
		y = clamp(y, self.res)

		local x0 = self.x0

		if puncher:get_player_control().sneak
		and x0 then

			local y0 = self.y0
			local line = twoline(x0 - x, y0 - y)

			for _,coord in pairs(line) do
				self.grid[x + coord[1]][y + coord[2]] = colors[name]
			end
		else
			self.grid[x][y] = colors[name]
		end

		self.object:set_properties({textures = { to_imagestring(self.grid, self.res) }})

		self.x0 = x
		self.y0 = y

		local wielded = puncher:get_wielded_item()

		wielded:add_wear(65536 / 256)

		puncher:set_wielded_item(wielded)
	end,

	on_activate = function(self, staticdata)

		local data = minetest.deserialize(staticdata)

		if not data then
			return
		end

		self.fd = data.fd
		self.x0 = data.x0
		self.y0 = data.y0
		self.res = data.res
		self.grid = data.grid
		self.object:set_properties({ textures = { to_imagestring(self.grid, self.res) }})

		if not self.fd then
			return
		end

		self.object:set_properties({ collisionbox = paintbox[self.fd % 2] })
		self.object:set_armor_groups({immortal = 1})
	end,

	get_staticdata = function(self)

		local data = { fd = self.fd, res = self.res, grid = self.grid, x0 = self.x0, y0 = self.y0 }

		return minetest.serialize(data)
	end
})

-- just pure magic
local walltoface = {-1, -1, 1, 3, 0, 2}

--paintedcanvas picture inventory item
minetest.register_craftitem("painting:paintedcanvas", {
	description = SL("Painted Canvas"),
	inventory_image = "painted.png",
	stack_max = 1,
	groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1 },

	on_place = function(itemstack, placer, pointed_thing)

		--place node
		local pos = pointed_thing.above

		if minetest.is_protected(pos, placer:get_player_name()) then
			return
		end

		local under = pointed_thing.under

		local wm = minetest.dir_to_wallmounted(vector.subtract(under, pos))

		local fd = walltoface[wm + 1]

		if fd == -1 then
			return itemstack
		end

		minetest.add_node(pos, {name = "painting:pic", param2 = fd})

		--save metadata
		local data = itemstack:get_metadata()

		minetest.get_meta(pos):set_string("painting:picturedata", data)

		--add entity
		dir = dirs[fd]

		local off = 0.5 - thickness - 0.01

		pos.x = pos.x + dir.x * off
		pos.z = pos.z + dir.z * off

		data = minetest.deserialize(data)

		local p = minetest.add_entity(pos, "painting:picent"):get_luaentity()

		p.object:set_properties({ textures = { to_imagestring(data.grid, data.res) }})
		p.object:set_yaw(math.pi * fd / -2)

		return ItemStack("")
	end
})

--canvas inventory items
minetest.register_craftitem("painting:canvas_16", {
	description = SL("Canvas") .. " 16",
	inventory_image = "canvas_16.png",
	stack_max = 99,
})

minetest.register_craftitem("painting:canvas_32", {
	description = SL("Canvas") .. " 32",
	inventory_image = "canvas_32.png",
	stack_max = 99,
})

--canvas for drawing
local canvasbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, 0, 0.5, 0.5, thickness }
}

minetest.register_node("painting:canvasnode", {
	description = SL("Canvas"),
	tiles = { "white.png" },
	inventory_image = "painted.png",
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = canvasbox,
	selection_box = canvasbox,
	groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1 },

	drop = "",

	after_dig_node = function(pos, oldnode, oldmetadata, digger)

		--get data and remove pixels
		local data = {}

		for _,e in pairs(minetest.get_objects_inside_radius(pos, 0.1)) do

			e = e:get_luaentity()

			if e
			and e.grid then

				data.grid = e.grid
				data.res = e.res
			end

			e.object:remove()
		end

		pos.y = pos.y - 1

		minetest.get_meta(pos):set_int("has_canvas", 0)

		if data.grid then

			local item = {
				name = "painting:paintedcanvas",
				count = 1,
				metadata = minetest.serialize(data)
			}

			local inv = digger:get_inventory()

			if inv
			and inv:room_for_item("main", "painting:paintedcanvas") then

				digger:get_inventory():add_item("main", item)
			else
				minetest.add_item(pos, ItemStack(item))
			end
		end
	end
})

-- easel
local easelbox = {
	type = "fixed",
	fixed = {
		--feet
		{-0.4, -0.5, -0.5, -0.3, -0.4, 0.5 },
		{ 0.3, -0.5, -0.5, 0.4, -0.4, 0.5 },
		--legs
		{-0.4, -0.4, 0.1, -0.3, 1.5, 0.2 },
		{ 0.3, -0.4, 0.1, 0.4, 1.5, 0.2 },
		--shelf
		{-0.5, 0.35, -0.3, 0.5, 0.45, 0.1 }
	}
}

local initgrid

minetest.register_node("painting:easel", {
	description = SL("Easel"),
	tiles = { "default_wood.png" },
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = easelbox,
	selection_box = easelbox,

	groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2 },

	on_punch = function(pos, node, player)

		local wielded_raw = player:get_wielded_item():get_name()

		wielded = string.split(wielded_raw, "_")

		local name = wielded[1]

		if name ~= "painting:canvas" then
			return
		end

		local res = tonumber(wielded[2])

		local meta = minetest.get_meta(pos)
		local fd = node.param2

		pos.y = pos.y + 1

		if minetest.get_node(pos).name ~= "air" then
			return
		end

		minetest.add_node(pos, { name = "painting:canvasnode", param2 = fd})

		local dir = dirs[fd]

		pos.x = pos.x - 0.01 * dir.x
		pos.z = pos.z - 0.01 * dir.z

		local p = minetest.add_entity(pos, "painting:paintent"):get_luaentity()

		p.object:set_properties({ collisionbox = paintbox[fd % 2] })
		p.object:set_armor_groups({immortal = 1})
		p.object:set_yaw(math.pi * fd / -2)
		p.grid = initgrid(res)
		p.res = res
		p.fd = fd

		meta:set_int("has_canvas", 1)

		local itemstack = ItemStack(wielded_raw)

		player:get_inventory():remove_item("main", itemstack)
	end,

	can_dig = function(pos)
		return minetest.get_meta(pos):get_int("has_canvas") == 0
	end
})

--brushes
local function table_copy(t)

	local t2 = {}

	for k,v in pairs(t) do
		t2[k] = v
	end

	return t2
end

local brush = {
	wield_image = "",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps = {}
	}
}

for color, _ in pairs(textures) do

	local brush_new = table_copy(brush)

	brush_new.description = SL(color:gsub("^%l", string.upper)) .. " " .. SL("brush")
	brush_new.inventory_image = "painting_brush_" .. color .. ".png"

	minetest.register_tool("painting:brush_" .. color, brush_new)

	-- compatibility
	local col = color
	if col == "darkgreen" then
		col = "dark_green"
	elseif col == "darkgrey" then
		col = "dark_grey"
	end

	minetest.register_craft({
		output = "painting:brush_" .. color,
		recipe = {
			{"dye:" .. col},
			{"default:stick"},
			{"default:stick"}
		}
	})
end

for i, color in ipairs(revcolors) do
	colors[color] = i
end

minetest.register_alias("easel", "painting:easel")
minetest.register_alias("canvas", "painting:canvas_16")

function initgrid(res)

	local grid, a, x, y = {}, res-1

	for x = 0, a do

		grid[x] = {}

		for y = 0, a do
			grid[x][y] = colors["white"]
		end
	end

	return grid
end

function to_imagestring(data, res)

	if not data then
		return
	end

	local t,n = {"[combine:", res, "x", res, ":"}, 6

	for y = 0, res - 1 do

		for x = 0, res - 1 do
			t[n] = x .. "," .. y .. "=" .. revcolors[ data[x][y] ] .. ".png:"
			n = n + 1
		end
	end

	return table.concat(t)
end

dirs = {
	[0] = { x = 0, z = 1 },
	[1] = { x = 1, z = 0 },
	[2] = { x = 0, z =-1 },
	[3] = { x =-1, z = 0 }
}

local function dot(v, w)
	return v.x * w.x + v.y * w.y + v.z * w.z
end

function intersect(pos, dir, origin, normal)

	local t = -(dot(vector.subtract(pos, origin), normal)) / dot(dir, normal)

	return vector.add(pos, vector.multiply(dir, t))
end

function clamp(num, res)

	if num < 0 then
		return 0
	end

	return math.min(num, res - 1)
end

-- crafts
minetest.register_craft({
	output = 'painting:easel',
	recipe = {
		{ '', 'default:wood', '' },
		{ '', 'default:wood', '' },
		{ 'default:stick','', 'default:stick' },
	}
})

minetest.register_craft({
	output = 'painting:canvas_16',
	recipe = {
		{ '', '', '' },
		{ '', '', '' },
		{ 'default:paper', '', '' },
	}
})

minetest.register_craft({
	output = 'painting:canvas_32',
	recipe = {
		{ '', '', '' },
		{ 'default:paper', 'default:paper', '' },
		{ 'default:paper', 'default:paper', '' },
	}
})

--[[
minetest.register_craft({
	output = 'painting:canvas_64',
	recipe = {
		{ 'default:paper', 'default:paper', 'default:paper' },
		{ 'default:paper', 'default:paper', 'default:paper' },
		{ 'default:paper', 'default:paper', 'default:paper' },
	}
})
--]]
