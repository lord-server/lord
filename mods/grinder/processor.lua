local SL = lord.require_intllib()
--- @type Grinder
local Grinder = dofile(minetest.get_modpath(minetest.get_current_modname()).."/grinder.lua")

--- @type string
local machine_name = "Grinder"

---
--- @class Processor
---
local Processor = {}

-- -----------------------------------------------------------------------------------------------
-- Private functions:

--- Swaps node if node is not same and return old node name
--- @see minetest.swap_node (https://dev.minetest.net/minetest.swap_node)
---
--- @param pos table {x,y,z}
--- @param name string
--- @return string
local function swapNode(pos, name)
    local node = minetest.get_node(pos)
    if node.name ~= name then
        node.name = name
        minetest.swap_node(pos, node)
    end
    return node.name
end

-- -----------------------------------------------------------------------------------------------
-- Public functions:

--- @static
--- @param pos table {x,y,z}
function Processor.act (pos)

    local g = Grinder:new(pos)
    local meta = g:getMeta()
    local inv  = meta:get_inventory()

    local recipe = nil

    --minetest.chat_send_all("fuel_time="..meta:get_float("fuel_time"))
    --minetest.chat_send_all("fuel_totaltime="..meta:get_float("fuel_totaltime"))
    --print("-------------------------------------")
    local result = grinder.get_grinding_recipe("grinding", inv:get_list("src"))
    local was_active = false
    --print("fuel_time="..meta:get_float("fuel_time"))
    --print("fuel_totaltime="..meta:get_float("fuel_totaltime"))
    if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
        was_active = true
        --print("Дробилка активна")
        meta:set_int("fuel_time", meta:get_int("fuel_time") + 1)
        if result then
            meta:set_int("src_time", meta:get_int("src_time") + 1)
            --print("Name="..result.new_input:get_name())
            --print(dump(result))
            if meta:get_int("src_time") >= result.time then
                meta:set_int("src_time", 0)
                local result_stack = ItemStack(result.output)
                if inv:room_for_item("dst", result_stack) then
                    inv:set_stack("src",1, result.new_input)
                    inv:add_item("dst", result_stack)
                end
            end
        else
            meta:set_int("src_time", 0)
        end
    end

    local cooked = 10
    if result then
        cooked = result.time or 10
    end
    if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
        local percent = math.floor(meta:get_float("fuel_time") / meta:get_float("fuel_totaltime") * 100)
        local item_percent = math.floor(meta:get_float("src_time") / cooked * 100)
        meta:set_string("infotext", SL(("%s Grinding"):format(machine_name)).." ("..percent.."%)")
        swapNode(pos, "grinder:grinder_active")
        meta:set_string("formspec",grinder.get_grinder_active_formspec(pos, percent, item_percent))
        return
    end

    recipe = grinder.get_grinding_recipe("grinding", inv:get_list("src"))
    if not recipe then
        if was_active then
            meta:set_string("infotext", SL(("%s is empty"):format(machine_name)))
            swapNode(pos, "grinder:grinder")
            meta:set_string("formspec", grinder.grinder_inactive_formspec)
        end
        --print("Выход, поскольку нет рецепта")
        return
    end

    local fuel = nil
    local afterfuel
    local fuellist = inv:get_list("fuel")

    if fuellist then
        fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
    end

    if fuel.time <= 0 then
        meta:set_string("infotext", SL(("%s Out Of Heat"):format(machine_name)))
        swap_node(pos, "grinder:grinder")
        meta:set_string("formspec", grinder.grinder_inactive_formspec)
        return
    end

    meta:set_string("fuel_totaltime", fuel.time)
    meta:set_string("fuel_time", 0)

    inv:set_stack("fuel", 1, afterfuel.items[1])
end


return Processor
