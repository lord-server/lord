local function register_candle_lamp(material, desc)
  local upTx = "lamps_candle_lamp_"..material.."_up.png"
  local sideTx = "lamps_candle_lamp_"..material.."_side.png^lamps_light_candle_lamp.png"
  local chainA = "lamps_chain_"..material.."_a.png"
  local chainB = "lamps_chain_"..material.."_b.png"

  minetest.register_craftitem("lamps:"..material.."_item_candle_lamp",
    {
    description = desc.." candle lamp",
    inventory_image = sideTx,
    on_place = function(itemstack, placer, pointed_thing)
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      if pointed_thing.above.y ~= pointed_thing.under.y-1 then
        itemstack:set_name("lamps:"..material.."_candle_lamp")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      else
        itemstack:set_name("lamps:"..material.."_hanging_candle_lamp")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name("lamps:"..material.."_item_candle_lamp")
      return itemstack
    end
  })

  minetest.register_node("lamps:"..material.."_candle_lamp", {
    description = desc.." candle lamp",
    tiles = {upTx,
             upTx,
             sideTx},
    groups = {lamp = 1, cracky = 2},
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},
            {-0.1875, -0.4375, -0.1875, 0.1875, 0.0625, 0.1875},
            {-0.25, 0.0625, -0.25, 0.25, 0.125, 0.25},
            {-0.1875, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
            {-0.0625, 0.1875, -0.0625, 0.0625, 0.25, .0625},
        },
    },
    light_source = 10
  })

  minetest.register_node("lamps:"..material.."_hanging_candle_lamp", {
    description = desc.." hanging candle lamp",
    tiles = {upTx,
             upTx,
             sideTx.."^"..chainA,
             sideTx.."^"..chainA,
             sideTx.."^"..chainB},
    groups = {lamp = 1, cracky = 2},
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},
            {-0.1875, -0.4375, -0.1875, 0.1875, 0.0625, 0.1875},
            {-0.25, 0.0625, -0.25, 0.25, 0.125, 0.25},
            {-0.1875, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
            {-0.0625, 0.1875, -0.0625, 0.0625, 0.25, .0625},
            {-0.125, 0.25, 0, 0.125, 0.5, 0},
            {0, 0.25, -0.125, 0, 0.5, 0.125}
        },
    },
    light_source = 10
  })
end

register_candle_lamp("steel", "Steel")
register_candle_lamp("gold", "Gold")
register_candle_lamp("tin", "Tin")
register_candle_lamp("bronze", "Bronze")
register_candle_lamp("silver", "Silver")