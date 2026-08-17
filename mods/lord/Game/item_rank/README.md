# Item Rank Mod

Модуль для деленя предметов с цветовой подсветкой названий.

## Использование в других модах

```lua

minetest.register_item(':my_mod:my_item', {
    description = 'предмет',
    _rank = item_rank.RARE
    -- ... и далее по списку со всеми
})

А в init самого мода,в котором хотим перекрашивать предметы мы добавляем функцию _rank = itemdef._rank,

пример из tools
local function register_tool(tooltype, material, itemdef)
	minetest.register_tool("tools:" .. tooltype .. "_" .. material, {
		description       = itemdef.description,
		inventory_image   = "tools_" .. tooltype .. "_" .. material .. ".png" ..
			(itemdef.image_transform or ""),
		wield_image       = "tools_" .. tooltype .. "_" .. material .. ".png" ..
			(itemdef.wield_image_transform or ""),
		range             = itemdef.range,
-- Наша функция
		_rank             = itemdef._rank,

		tool_capabilities = {
			full_punch_interval = itemdef.full_punch_interval,
			max_drop_level      = itemdef.max_drop_level,
			groupcaps           = {
				cracky  = get_capability(itemdef, "cracky"),
				choppy  = get_capability(itemdef, "choppy"),
				snappy  = get_capability(itemdef, "snappy"),
				crumbly = get_capability(itemdef, "crumbly")
			},
			damage_groups = itemdef.damage_groups,
		},
		groups = itemdef.groups,
	})
end

Это надо чтобы при загрузке наш мод не потерялся.