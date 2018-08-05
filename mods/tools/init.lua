tools = {}
-- Load tables
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/picks.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/shovels.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/axes.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/swords.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/battleaxes.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/warhammers.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/spears.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/daggers.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/special.lua")


-- Source materials
tools.sources = {
	wood = "group:wood",
	stone = "group:stone",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	copper = "default:copper_ingot",
	tin = "lottores:tin_ingot",
	silver = "lottores:silver_ingot",
	gold = "default:gold_ingot",
	galvorn = "lottores:galvorn_ingot",
	mithril = "lottores:mithril_ingot",
}

-- A special item - the hand
minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=4},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
		},
		damage_groups = {fleshy=1},
	}
})

local function get_capability(itemdef, cap)
	if itemdef[cap] == nil then
		return nil
	end
	return {
		times = itemdef[cap].times,
		uses = itemdef[cap].uses,
		maxlevel = itemdef[cap].maxlevel,
		maxwear = itemdef[cap].maxwear,
	}
end

local function register_tool(tooltype, material, itemdef)
	minetest.register_tool("tools:"..tooltype.."_"..material, {
		description = itemdef.description,
		inventory_image = "tools_"..tooltype.."_"..material..".png"..
			(itemdef.image_transform or ""),
		wield_image = "tools_"..tooltype.."_"..material..".png"..
			(itemdef.wield_image_transform or ""),
		range = itemdef.range,
		wield_scale = {x=1.5, y=1.5, z=1},
		tool_capabilities = {
			full_punch_interval = itemdef.full_punch_interval,
			max_drop_level = itemdef.max_drop_level,
			groupcaps = {
				cracky = get_capability(itemdef, "cracky"),
				choppy = get_capability(itemdef, "choppy"),
				snappy = get_capability(itemdef, "snappy"),
				crumbly = get_capability(itemdef, "crumbly")
			},
			damage_groups = itemdef.damage_groups,
		},
		groups = itemdef.groups,
	})
end

local function register_craft(tooltype, material, itemdef)
	if tools.sources[material] == nil then
		minetest.log("error", "Cannot find source material for the craft recipe"..
			" (output='"..material.."')")
	end
	for _, r in pairs(tools[tooltype].get_recipes(tools.sources[material])) do
		minetest.register_craft({
			output = "tools:"..tooltype.."_"..material,
			recipe = r
		})
	end
end

local tooltypes = {
	"pick", "shovel", "axe", "sword", "battleaxe", "warhammer", "spear", "dagger"
}

for _, tooltype in ipairs(tooltypes) do
	for material, _ in pairs(tools[tooltype]) do
		local itemdef = tools[tooltype][material]
		if type(itemdef) == "table" then
			register_tool(tooltype, material, itemdef)
			register_craft(tooltype, material, itemdef)
		end
	end
end

lord.mod_loaded()
