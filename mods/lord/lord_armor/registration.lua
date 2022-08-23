local S = minetest.get_translator(minetest.get_current_modname())

-- Tables set up
lord_armor.types = {}
lord_armor.materials = {}

--
-- Functions
--

-- Function "register_type":
-- Creates the armor type and adds it to the types table.
function lord_armor.register_type(name, def)
	lord_armor.types[name] = {}
	lord_armor.types[name].def = def
	return true
end

-- Function "register_item_in_type":
-- Adds the item of certain type to the items table
-- of certain type.
function lord_armor.register_item_in_type(type, item)
	if not lord_armor.types[type].items then
		lord_armor.types[type].items = {}
	end
	table.insert(lord_armor.types[type].items, item)
	return true
end

-- Function "register_material":
-- Adds the material to the materials table;
-- Args:
-- material		- codename, used to construct item names;
-- item 	   	- craftitem name;
-- description	- untraslated description,
-- 				  used to construct item  descriptions.
function lord_armor.register_material(material, item, description)
	lord_armor.materials[material] = {
		material = material,
		item = item,
		description = description,
	}
	return true
end

-- Function "set_type_recipe":
-- Sets type-recipe (or standard recipe for each type),
-- that used to register a craft with proper material.
function lord_armor.set_type_recipe(type, recipe)
	lord_armor.types[type].recipe = recipe
	return true
end

-- Local function "get_type_def":
-- Returns the types table accessed with armor type.
local function get_type_def(type)
	if not lord_armor.types[type].def then
		return false
	end
	return lord_armor.types[type].def
end

-- Local function "get_material":
-- Returns the material table accessed with material codname.
local function get_material(material)
	if not lord_armor.materials[material] then
		return false
	end
	return lord_armor.materials[material]
end

-- Local function "multiply_table":
-- Multiplies the table values by the given number.
local function multiply_table(t, m)
	local table = false
	for i, k in pairs(t) do
		table[i] = k * m
	end
	return table
end

-- Local function "register_craft":
-- Uses type-recipe to register a craft with proper material.
local function register_craft(type, material, modname)
	if not modname then
		modname = "lord_armor"
	end

	local recipe = lord_armor.types[type].recipe
	local output = lord_armor.types[type].items[string.format("%s:%s_%s", modname, material, type)]

	if not (recipe.output == type and output and get_material(material)) then
		return false
	end

	recipe.output = output
	for _, i in pairs(recipe.recipe) do
		for _, v in pairs(i) do
			if v == "material" then
				recipe.recipe[i[v]] = material
			else
				recipe.recipe[i[v]] = ""
			end
		end
	end

	return minetest.register_craft(recipe)
end

-- Function "register_armor_set":
-- Main armor registration function. Uses the functions
-- above to register items of the specified types made
-- of specified material;
-- Args:
-- types		- table of types in set;
-- materials	- table of codenames, used to construct item names
-- 				  and accessing the materials table;
-- prot_mult 	- protection multiplier; used to alter
-- 				  the basic protection of the type;
-- durab_mult	- durability multiplier; used to alter
-- 				  the basic durability of the type.
function lord_armor.register_armor_set(types, materials, prot_mult, durab_mult)
	if not prot_mult then prot_mult = 1 end
	if not durab_mult then durab_mult = 1 end
	for _, material in pairs(materials) do
		if not get_material(material) then
			minetest.log("error", "Not registering "..material.." armor set: material is not registered.")
			return false
		end
		for _, type in pairs(types) do
			local material_desc = get_material(material).description
			local type_desc = get_type_def(type).description
			local item_name = "lord_armor:%s_%s"
			local groups = {}
			groups[material.."_item"] = 1
			groups[type] = 1
			minetest.register_tool(string.format("lord_armor:%s_%s", material, type), {
				description = S(string.format("%s %s", material_desc, type_desc)),
				inventory_image = string.format("lord_armor_%s_%s.png", material, type),
				protection = multiply_table(get_type_def(type).protection_level, prot_mult),
				durability = get_type_def(type).basic_durability * durab_mult,
				groups = groups,
			})
			lord_armor.register_item_in_type(type, item_name)
			register_craft(type, material)
		end
	end
end

function lord_armor.register_special_armor(name, type, recipe)
	lord_armor.register_type(type.name, type.def)
end
