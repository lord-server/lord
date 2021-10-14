local SL = lord.require_intllib()
local S = minetest.get_translator(roads)

local function register_road(name, mainMaterial, desc, fill) -- функция регистрации всех нодов дороги

  local function table_concat(s,t) -- функция объединение таблиц
    for i, v in pairs(t) do
      s[i] = v
    end
  end

  local mn = "roads:"..name -- имя мода с материалом
  local roadName = mn.."_road" -- дорога
  local borderName = mn.."_border" -- бордюр
  local innerCornerBorderName = mn.."_inner_corner_border" -- бордюр (внутренний угол)
  local outerCornerBorderName = mn.."_outer_corner_border" -- бордюр (внешний угол)
  local stepRoadName = mn.."_step_road" -- ступенька дороги
  local stepBorderName = mn.."_step_border" -- ступнька с бордюром
  local borderItemName = mn.."_border_item" -- бордюр(итем)

  local spGroups = {not_in_creative_inventory = 1} -- специальная группа
  table_concat(spGroups, desc.groups)

  -- textures: border_x, border_z, border_top, step_border_x,
  -- step_border_z, incorn_border_top, outcorn_border_top

  minetest.register_node(roadName, {
    description = S(desc.description.." road"),
    tiles = {fill},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
      type = "fixed",
      fixed = {
      {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5}}
    },
  })

  -- бордюр

  minetest.register_node(borderName, {
    description = S(desc.description.." border"),
    tiles = {fill.."^roads_"..name.."_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-.5, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
      local dir = minetest.dir_to_facedir(placer:get_look_dir())
      if dir == 0 then
        itemstack:set_name(borderName.."D")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 1 then
        itemstack:set_name(borderName.."A")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 2 then
        itemstack:set_name(borderName.."B")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 3 then
        itemstack:set_name(borderName.."C")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name(borderName)
      return itemstack
  end
  })

  minetest.register_node(borderName.."A", {
    description = desc.description.." border A",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR270)",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, 0.5},
        },
    },
    drop = borderName,
  })

  minetest.register_node(borderName.."B", {
    description = desc.description.." border B",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR180)",
             fill,
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_z.png"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, 0.5, 0.5, -0.25},
        },
    },
    drop = borderName,
  })

  minetest.register_node(borderName.."C", {
    description = desc.description.." border C",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR90)",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
        },
    },
    drop = borderName,
  })

    minetest.register_node(borderName.."D", {
    description = desc.description.." border D",
    tiles = {fill.."^roads_"..name.."_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-.5, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    drop = borderName,
  })

  -- внутренний угол

  minetest.register_node(innerCornerBorderName, {
    description = S(desc.description.." inner corner border"),
    tiles = {fill.."^roads_"..name.."_incorn_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, 0.25}
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
      local dir = minetest.dir_to_facedir(placer:get_look_dir())
      if dir == 0 then
        itemstack:set_name(innerCornerBorderName.."D")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 1 then
        itemstack:set_name(innerCornerBorderName.."A")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 2 then
        itemstack:set_name(innerCornerBorderName.."B")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 3 then
        itemstack:set_name(innerCornerBorderName.."C")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name(innerCornerBorderName)
      return itemstack
  end
  })

  minetest.register_node(innerCornerBorderName.."A", {
    description = desc.description.." inner corner border A",
    tiles = {fill.."^(roads_"..name.."_incorn_border_top.png^[transformR270)",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, 0.5},
            {-0.5, 0.25, -0.5, 0.25, 0.5, -0.25}
        },
    },
    drop = innerCornerBorderName,
  })

  minetest.register_node(innerCornerBorderName.."B", {
    description = desc.description.." inner corner border B",
    tiles = {fill.."^(roads_"..name.."_incorn_border_top.png^[transformR180)",
             fill,
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_z.png"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, 0.5, 0.5, -0.25},
            {-0.5, 0.25, -0.25, -0.25, 0.5, 0.5}
        },
    },
    drop = innerCornerBorderName,
  })

  minetest.register_node(innerCornerBorderName.."C", {
    description = desc.description.." inner corner border C",
    tiles = {fill.."^(roads_"..name.."_incorn_border_top.png^[transformR90)",
             fill,
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
            {-0.25, 0.25, 0.25, 0.5, 0.5, 0.5}
        },
    },
    drop = innerCornerBorderName,
  })

  minetest.register_node(innerCornerBorderName.."D", {
    description = desc.description.." inner corner border D",
    tiles = {fill.."^roads_"..name.."_incorn_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, 0.25}
        },
    },
    drop = innerCornerBorderName,
  })

  -- внешний угол

  minetest.register_node(outerCornerBorderName, {
    description = S(desc.description.." outer corner border"),
    tiles = {fill.."^roads_"..name.."_outcorn_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
      local dir = minetest.dir_to_facedir(placer:get_look_dir())
      if dir == 0 then
        itemstack:set_name(outerCornerBorderName.."D")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 1 then
        itemstack:set_name(outerCornerBorderName.."A")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 2 then
        itemstack:set_name(outerCornerBorderName.."B")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 3 then
        itemstack:set_name(outerCornerBorderName.."C")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name(outerCornerBorderName)
      return itemstack
  end
   })

  minetest.register_node(outerCornerBorderName.."A", {
    description = desc.description.." outer corner border A",
    tiles = {fill.."^(roads_"..name.."_outcorn_border_top.png^[transformR270)",
             fill,
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, -0.25},
        },
    },
    drop = outerCornerBorderName,
   })

   minetest.register_node(outerCornerBorderName.."B", {
    description = desc.description.." outer corner border B",
    tiles = {fill.."^(roads_"..name.."_outcorn_border_top.png^[transformR180)",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, -0.25, 0.5, -0.25},
        },
    },
    drop = outerCornerBorderName,
   })

  minetest.register_node(outerCornerBorderName.."C", {
    description = desc.description.." outer corner border C",
    tiles = {fill.."^(roads_"..name.."_outcorn_border_top.png^[transformR90)",
             fill,
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, -0.25, 0.5, 0.5},
        },
    },
    drop = outerCornerBorderName,
   })

   minetest.register_node(outerCornerBorderName.."D", {
    description = desc.description.." outer corner border D",
    tiles = {fill.."^roads_"..name.."_outcorn_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    drop = outerCornerBorderName,
   })

  -- ступенька

  minetest.register_node(stepRoadName, {
    description = S(desc.description.." step road"),
    tiles = {fill},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}
        },
    },
  })

  -- ступенька-бордюр

  minetest.register_node(stepBorderName, {
    description = S(desc.description.." step border"),
    tiles = {fill.."^roads_"..name.."_border_top.png",
             fill,
             fill.."^roads_"..name.."_step_border_x.png",
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_step_border_z.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, 0.25, 0.5, 0, 0.5}
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
      local dir = minetest.dir_to_facedir(placer:get_look_dir())
      if dir == 0 then
        itemstack:set_name(stepBorderName.."D")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 1 then
        itemstack:set_name(stepBorderName.."A")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 2 then
        itemstack:set_name(stepBorderName.."B")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 3 then
        itemstack:set_name(stepBorderName.."C")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name(stepBorderName)
      return itemstack
    end
  })

  minetest.register_node(stepBorderName.."A", {
    description = desc.description.." step border A",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR270)",
             fill,
             fill.."^roads_"..name.."_step_border_z.png",
             fill.."^roads_"..name.."_step_border_z.png",
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_step_border_x.png"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {0.25, -0.25, -0.5, 0.5, 0, 0.5}
        },
    },
    drop = stepBorderName,
  })

  minetest.register_node(stepBorderName.."B", {
    description = desc.description.." step border B",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR180)",
             fill,
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_step_border_x.png",
             fill.."^roads_"..name.."_step_border_z.png"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, -0.5, 0.5, 0, -0.25}
        },
    },
    drop = stepBorderName,
  })

  minetest.register_node(stepBorderName.."C", {
    description = desc.description.." step border C",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR90)",
             fill,
             fill.."^roads_"..name.."_step_border_z.png",
             fill.."^roads_"..name.."_step_border_z.png",
             fill.."^roads_"..name.."_step_border_x.png",
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)"},
    groups = spGroups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, -0.5, -0.25, 0, 0.5}
        },
    },
    drop = stepBorderName,
  })

  minetest.register_node(stepBorderName.."D", {
    description = desc.description.." step border D",
    tiles = {fill.."^roads_"..name.."_border_top.png",
             fill,
             fill.."^roads_"..name.."_step_border_x.png",
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_step_border_z.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, 0.25, 0.5, 0, 0.5}
        },
    },
    drop = stepBorderName,
  })

  -- бордюр(итем)

  minetest.register_craftitem(borderItemName, {
  description = S(desc.description.." border"),
  inventory_image = "roads_"..name.."_border_item.png"
  })

  -- крафты

  minetest.register_craft({
    output = borderItemName.." 8",
    recipe = {{mainMaterial, mainMaterial}},
  })

  minetest.register_craft({
    output = roadName.." 8",
    recipe = {{mainMaterial, mainMaterial,mainMaterial},
              {mainMaterial, mainMaterial,mainMaterial}},
  })

  minetest.register_craft({
    output = borderName,
    recipe = {{borderItemName},
              {roadName}},
  })

  minetest.register_craft({
    output = innerCornerBorderName,
    recipe = {{borderItemName, ""},
              {roadName, borderItemName}},
  })

  minetest.register_craft({
    output = outerCornerBorderName,
    recipe = {{"", borderItemName},
              {roadName, ""}},
  })

  minetest.register_craft({
    output = stepRoadName.." 6",
    recipe = {{roadName, roadName}},
  })

  minetest.register_craft({
    output = stepBorderName,
    recipe = {{borderItemName},
              {stepRoadName}},
  })

  return true
end

register_road("stonebrick", "default:stonebrick", {
  description = "Stonebrick",
  groups = {cracky = 2}
}, "default_stone_brick.png")

register_road("sandstone",  "default:sandstone", {
  description = "Sandstone",
  groups = {crumbly = 3}
}, "default_sandstone.png")
