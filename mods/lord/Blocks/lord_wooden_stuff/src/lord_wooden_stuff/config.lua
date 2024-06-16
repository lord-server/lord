---@class LordWoodenStuffDefinition
---@field name string @name postfix. Example: `"alder"`
---@field desc string @description prefix. Example: `"Alder"`
---@field texture string @planks texture. Example: `"lord_planks_alder.png"`
---@field wood_name string @planks nodename. Example: `"lord_planks:alder"`

---@type LordWoodenStuffDefinition[]
local wood_defs = {
--    name postfix, desc prefix,  planks texture,              planks nodename
	{ name="alder",      desc="Alder",      texture="lord_planks_alder.png",     wood_name="lord_planks:alder", },
	{ name="beech",      desc="Beech",      texture="lord_planks_beech.png",     wood_name="lord_planks:beech", },
	{ name="birch",      desc="Birch",      texture="lord_planks_birch.png",     wood_name="lord_planks:birch", },
	{ name="cherry",     desc="Cherry",     texture="lord_planks_cherry.png",    wood_name="lord_planks:cherry", },
	{ name="culumalda",  desc="Culumalda",  texture="lord_planks_culumalda.png", wood_name="lord_planks:culumalda", },
	{ name="elm",        desc="Elm",        texture="lord_planks_elm.png",       wood_name="lord_planks:elm", },
	{ name="fir",        desc="Fir",        texture="lord_planks_fir.png",       wood_name="lord_planks:fir", },
	{ name="hardwood",   desc="Hardwood",   texture="lord_planks_hardwood.png",  wood_name="lord_planks:hardwood", },
	{ name="junglewood", desc="Junglewood", texture="default_junglewood.png",    wood_name="default:junglewood", },
	{ name="lebethron",  desc="Lebethron",  texture="lord_planks_lebethron.png", wood_name="lord_planks:lebethron", },
	{ name="mallorn",    desc="Mallorn",    texture="lord_planks_mallorn.png",   wood_name="lord_planks:mallorn", },
	{ name="pine",       desc="Pine",       texture="lord_planks_pine.png",      wood_name="lord_planks:pine", },
	{ name="plum",       desc="Plum",       texture="lord_planks_plum.png",      wood_name="lord_planks:plum", },
	{ name="wood",       desc="Wooden",     texture="default_wood.png",          wood_name="default:wood", },
}

return { wood_defs = wood_defs, }
