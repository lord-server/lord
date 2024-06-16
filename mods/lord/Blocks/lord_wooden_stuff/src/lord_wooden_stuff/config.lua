---@class LordWoodenStuffDefinition
---@field name string @name postfix. Example: `"alder"`
---@field desc string @description prefix. Example: `"Alder"`
---@field texture string @planks texture. Example: `"lord_planks_alder.png"`
---@field wood_name string @planks nodename. Example: `"lord_planks:alder"`

---@type string[][]
local wood_types = {
--    name postfix, desc prefix,  planks texture,              planks nodename
	{ "alder",      "Alder",      "lord_planks_alder.png",     "lord_planks:alder", },
	{ "beech",      "Beech",      "lord_planks_beech.png",     "lord_planks:beech", },
	{ "birch",      "Birch",      "lord_planks_birch.png",     "lord_planks:birch", },
	{ "cherry",     "Cherry",     "lord_planks_cherry.png",    "lord_planks:cherry", },
	{ "culumalda",  "Culumalda",  "lord_planks_culumalda.png", "lord_planks:culumalda", },
	{ "elm",        "Elm",        "lord_planks_elm.png",       "lord_planks:elm", },
	{ "fir",        "Fir",        "lord_planks_fir.png",       "lord_planks:fir", },
	{ "hardwood",   "Hardwood",   "lord_planks_hardwood.png",  "lord_planks:hardwood", },
	{ "junglewood", "Junglewood", "default_junglewood.png",    "default:junglewood", },
	{ "lebethron",  "Lebethron",  "lord_planks_lebethron.png", "lord_planks:lebethron", },
	{ "mallorn",    "Mallorn",    "lord_planks_mallorn.png",   "lord_planks:mallorn", },
	{ "pine",       "Pine",       "lord_planks_pine.png",      "lord_planks:pine", },
	{ "plum",       "Plum",       "lord_planks_plum.png",      "lord_planks:plum", },
	{ "wood",       "Wooden",     "default_wood.png",          "default:wood", },
}

---@type LordWoodenStuffDefinition[]
local wood_defs = {}

for i = 1,#wood_types do
	local wood = wood_types[i]
	wood_defs[i].name = wood[1]
	wood_defs[i].desc = wood[2]
	wood_defs[i].texture = wood[3]
	wood_defs[i].wood_name = wood[4]
end

return { wood_defs = wood_defs, }
