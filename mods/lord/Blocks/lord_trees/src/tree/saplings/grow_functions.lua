
--- @type tree.branch.Type
local branch_Type = require('tree.branch.Type')
--- @type tree.crown.level.Type
local crown_level_Type = require("tree.crown.level_Type")


-- TREE GENERATION FUNCTIONS


-- Alders / Ольха
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_aldertree(pos, generator)
	local height = 6 + math.random(2)
	local radius = 3

	generator.add_trunk(pos, height, "lord_trees:alder_tree")

	generator.add_crown_at(pos, height - 2, radius, "lord_trees:alder_leaf", { no_leaves_on_corners = true })
	generator.add_crown_at(pos, height,     radius, "lord_trees:alder_leaf", { no_leaves_on_corners = true })
end

-- Apple tree / Яблоня
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_appletree(pos, generator)
	local height = 3 + math.random(2)
	local radius = 3

	generator.add_trunk(pos, height, "default:tree")
	-- HACK: это адаптированная версия, лучше бы передавать шансы листьев и альтернативной ноды
	--       но в данном варианте выдаёт примерно то же самое кол-во яблок, что и раньше
	generator.add_crown_at(pos, height - 2, radius, { "default:apple", "lord_trees:apple_leaf" })
	generator.add_crown_at(pos, height,     radius, "lord_trees:apple_leaf")
	generator.add_crown_at(pos, height,     radius, "default:apple")
end

-- Birches / Береза
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_birchtree(pos, generator)
	local height = 7 + math.random(5)

	generator.add_trunk(pos, height, "lord_trees:birch_tree")

	generator.add_crown_at(pos, math.floor(height * 0.4), {3,2}, "lord_trees:birch_leaf")
	generator.add_crown_at(pos, math.floor(height * 0.6), {2,3}, "lord_trees:birch_leaf")
	generator.add_crown_at(pos, math.floor(height * 0.8), {2,2}, "lord_trees:birch_leaf")
	generator.add_crown_at(pos, height,                   {2,1}, "lord_trees:birch_leaf")
end

-- Beeches / Бук
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_beechtree(pos, generator)
	local height = 12 + math.random(3)

	generator.add_trunk(pos, height, "lord_trees:beech_tree")

	generator.add_crown_at(pos, height - 8, 4, "lord_trees:beech_leaf")
	generator.add_crown_at(pos, height - 8, 4, "lord_trees:beech_leaf")
	generator.add_crown_at(pos, height - 6, 4, "lord_trees:beech_leaf")
	generator.add_crown_at(pos, height - 4, 4, "lord_trees:beech_leaf")
	generator.add_crown_at(pos, height - 2, 3, "lord_trees:beech_leaf")
	generator.add_crown_at(pos, height,     2, "lord_trees:beech_leaf")
end

-- Cherry / Сакура
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_cherrytree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "lord_trees:cherry_tree")

	generator.add_crown_at(pos, height - 2, radius, "lord_trees:cherry_leaf" )
	generator.add_crown_at(pos, height,     radius, "lord_trees:cherry_leaf" )
end

-- Culumalda
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_culumaldatree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "lord_trees:culumalda_tree")

	generator.add_crown_at(pos, height - 2, radius, { "lord_trees:culumalda_leaf", "lord_trees:yellow_flowers" })
	generator.add_crown_at(pos, height,     radius, { "lord_trees:culumalda_leaf", "lord_trees:yellow_flowers" })
end

-- Elms / Вяз
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_elmtree(pos, generator)
	local height = 20 + math.random(5)
	local radius = 2

	generator.add_trunk(pos, height, "lord_trees:elm_tree")

	generator.add_crown_at(pos, math.floor(height * 0.4), radius, "lord_trees:elm_leaf")
	generator.add_crown_at(pos, math.floor(height * 0.7), radius, "lord_trees:elm_leaf")
	generator.add_crown_at(pos, height,                   radius, "lord_trees:elm_leaf")
end

-- Firs / Ель
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_firtree(pos, generator)
	local height = 10 + math.random(3)
	local radius = 2

	generator.add_trunk(pos, height, "lord_trees:fir_tree")

	local leaf_node = "lord_trees:fir_leaf"
	generator.add_crown_at(pos, height + 1, radius, leaf_node, { level_type = crown_level_Type.CONE })
	generator.add_crown_at(pos, height - 2, radius, leaf_node, { level_type = crown_level_Type.CONE, cone_solid = true })
	generator.add_crown_at(pos, height - 5, radius, leaf_node, { level_type = crown_level_Type.CONE, cone_solid = true })
	generator.add_crown_at(pos, height - 8, radius, leaf_node, { level_type = crown_level_Type.CONE, cone_solid = true })
end

-- Lebethron
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_lebethrontree(pos, generator)
	local height = 3 + math.random(1)
	local radius = 2

	generator.add_trunk(pos, height, "lord_trees:lebethron_tree")

	generator.add_crown_at(pos, math.floor(height * 0.7), radius, "lord_trees:lebethron_leaf")
	generator.add_crown_at(pos, height,                   radius, "lord_trees:lebethron_leaf")
end

--- @param pos       Position
--- @param generator tree.Generator
function lottplants_mallorntree(pos, generator)
	local height = 25 + math.random(5)

	generator.add_trunk(pos, height, "lord_trees:mallorn_tree", 2)
	if math.random(0, 1) == 1 then
		generator.add_roots(pos, "lord_trees:mallorn_tree", 2)
	end

	for dy = 9 + math.random(3), height - 2, 5 do
		generator.add_branches_at(
			pos, dy, "lord_trees:mallorn_tree", 2, math.random(3), branch_Type.TRUNKED, "lord_trees:mallorn_leaf"
		)
	end

	generator.add_branches_at(
		pos, height, "lord_trees:mallorn_tree", 2, 2, branch_Type.SHURIKEN, "lord_trees:mallorn_leaf"
	)
end
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_smallmallorntree(pos, generator)
	local height = 15
	local radius = 2

	generator.add_trunk(pos, height, "lord_trees:mallorn_tree")

	generator.add_crown_at(pos, height - 4, radius, "lord_trees:mallorn_leaf")
	generator.add_crown_at(pos, height,     radius, "lord_trees:mallorn_leaf")
end
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_young_mallorn(pos, generator)
	local height = 6 + math.random(1)
	local radius = 1

	generator.add_trunk(pos, height, "lord_trees:mallorn_young_tree")

	generator.add_crown_at(pos, height - 2, radius, "lord_trees:mallorn_leaf")
	generator.add_crown_at(pos, height,     radius, "lord_trees:mallorn_leaf")
end

-- Pines / Сосна
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_pinetree(pos, generator)
	local height = 10 + math.random(3)
	local radius = 2

	generator.add_trunk(pos, height, "lord_trees:pine_tree")

	generator.add_crown_at(pos, height + 1, radius, "lord_trees:pine_leaf", { level_type = crown_level_Type.CONE })
	generator.add_crown_at(pos, height - 2, radius, "lord_trees:pine_leaf", { level_type = crown_level_Type.CONE })
	generator.add_crown_at(pos, height - 5, radius, "lord_trees:pine_leaf", { level_type = crown_level_Type.CONE })
end

-- Plum Trees / Слива
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_plumtree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 2, radius, { "lord_trees:plum_leaf", "lord_trees:plum" })
	generator.add_crown_at(pos, height,     radius, { "lord_trees:plum_leaf", "lord_trees:plum" })
end

-- Rowans / Рябина
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_rowantree(pos, generator)
	local height = 6 + math.random(2)

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 4, 2, "lord_trees:rowan_leaf")
	generator.add_crown_at(pos, height - 2, 3, { "lord_trees:rowan_leaf", "lord_trees:rowan_berry" })
	generator.add_crown_at(pos, height,     2, "lord_trees:rowan_leaf")
end

-- White Tree / Белое дерево
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_whitetree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 2, radius, "lord_trees:white_leaf")
	generator.add_crown_at(pos, height,     radius, "lord_trees:white_leaf")
end

-- Yavannamire / Йаванамирэ
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_yavannamiretree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 2, radius, { "lord_trees:yavannamire_leaf", "lord_trees:yavannamire_fruit" })
	generator.add_crown_at(pos, height,     radius, { "lord_trees:yavannamire_leaf", "lord_trees:yavannamire_fruit" })
end

--Mirk large / Большое дерево Лихолесья
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_mirktree(pos, generator)
	local height = 5 + math.random(1)

	generator.add_trunk(pos, height, "default:jungletree", 2)
	if math.random(0, 1) == 1 then
		generator.add_roots(pos, "default:jungletree", 2)
	end

	generator.add_branches_at(pos, height, "default:jungletree", 2, 2, branch_Type.SHURIKEN, "lord_trees:mirk_leaf")
end
--Mirk Small / Малое дерево Лихолесья
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_smallmirktree(pos, generator)
	local height = 7

	generator.add_trunk(pos, height - 2, "default:jungletree")

	generator.add_branches_at(pos, height - 1, "default:jungletree", 1, 2, branch_Type.DIAGONAL, "lord_trees:mirk_leaf")
end
