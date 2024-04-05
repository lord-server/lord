
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

	generator.add_trunk(pos, height, "lottplants:aldertree")

	generator.add_crown_at(pos, height - 2, radius, "lottplants:alderleaf", { no_leaves_on_corners = true })
	generator.add_crown_at(pos, height,     radius, "lottplants:alderleaf", { no_leaves_on_corners = true })
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
	generator.add_crown_at(pos, height - 2, radius, { "default:apple", "lottplants:appleleaf" })
	generator.add_crown_at(pos, height,     radius, "lottplants:appleleaf")
	generator.add_crown_at(pos, height,     radius, "default:apple")
end

-- Birches / Береза
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_birchtree(pos, generator)
	local height = 7 + math.random(5)

	generator.add_trunk(pos, height, "lottplants:birchtree")

	generator.add_crown_at(pos, math.floor(height * 0.4), {3,2}, "lottplants:birchleaf")
	generator.add_crown_at(pos, math.floor(height * 0.6), {2,3}, "lottplants:birchleaf")
	generator.add_crown_at(pos, math.floor(height * 0.8), {2,2}, "lottplants:birchleaf")
	generator.add_crown_at(pos, height,                   {2,1}, "lottplants:birchleaf")
end

-- Beeches / Бук
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_beechtree(pos, generator)
	local height = 12 + math.random(3)

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 8, 4, "lottplants:beechleaf")
	generator.add_crown_at(pos, height - 8, 4, "lottplants:beechleaf")
	generator.add_crown_at(pos, height - 6, 4, "lottplants:beechleaf")
	generator.add_crown_at(pos, height - 4, 4, "lottplants:beechleaf")
	generator.add_crown_at(pos, height - 2, 3, "lottplants:beechleaf")
	generator.add_crown_at(pos, height,     2, "lottplants:beechleaf")
end

-- Culumalda
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_culumaldatree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 2, radius, { "lottplants:culumaldaleaf", "lottplants:yellowflowers" })
	generator.add_crown_at(pos, height,     radius, { "lottplants:culumaldaleaf", "lottplants:yellowflowers" })
end

-- Elms / Вяз
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_elmtree(pos, generator)
	local height = 20 + math.random(5)
	local radius = 2

	generator.add_trunk(pos, height, "lottplants:elmtree")

	generator.add_crown_at(pos, math.floor(height * 0.4), radius, "lottplants:elmleaf")
	generator.add_crown_at(pos, math.floor(height * 0.7), radius, "lottplants:elmleaf")
	generator.add_crown_at(pos, height,                   radius, "lottplants:elmleaf")
end

-- Firs / Ель
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_firtree(pos, generator)
	local height = 10 + math.random(3)
	local radius = 2

	generator.add_trunk(pos, height, "lottplants:firtree")

	local leaf_node = "lottplants:firleaf"
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

	generator.add_trunk(pos, height, "lottplants:lebethrontree")

	generator.add_crown_at(pos, math.floor(height * 0.7), radius, "lottplants:lebethronleaf")
	generator.add_crown_at(pos, height,                   radius, "lottplants:lebethronleaf")
end

--- @param pos       Position
--- @param generator tree.Generator
function lottplants_mallorntree(pos, generator)
	local height = 25 + math.random(5)

	generator.add_trunk(pos, height, "lottplants:mallorntree", 2)
	if math.random(0, 1) == 1 then
		generator.add_roots(pos, "lottplants:mallorntree", 2)
	end

	for dy = 9 + math.random(3), height - 2, 5 do
		generator.add_branches_at(
			pos, dy, "lottplants:mallorntree", 2, math.random(3), branch_Type.TRUNKED, "lottplants:mallornleaf"
		)
	end

	generator.add_branches_at(pos, height, "lottplants:mallorntree", 2, 2, branch_Type.SHURIKEN, "lottplants:mallornleaf")
end
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_smallmallorntree(pos, generator)
	local height = 15
	local radius = 2

	generator.add_trunk(pos, height, "lottplants:mallorntree")

	generator.add_crown_at(pos, height - 4, radius, "lottplants:mallornleaf")
	generator.add_crown_at(pos, height,     radius, "lottplants:mallornleaf")
end
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_young_mallorn(pos, generator)
	local height = 6 + math.random(1)
	local radius = 1

	generator.add_trunk(pos, height, "lottplants:mallorntree_young")

	generator.add_crown_at(pos, height - 2, radius, "lottplants:mallornleaf")
	generator.add_crown_at(pos, height,     radius, "lottplants:mallornleaf")
end

-- Pines / Сосна
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_pinetree(pos, generator)
	local height = 10 + math.random(3)
	local radius = 2

	generator.add_trunk(pos, height, "lottplants:pinetree")

	generator.add_crown_at(pos, height + 1, radius, "lottplants:pineleaf", { level_type = crown_level_Type.CONE })
	generator.add_crown_at(pos, height - 2, radius, "lottplants:pineleaf", { level_type = crown_level_Type.CONE })
	generator.add_crown_at(pos, height - 5, radius, "lottplants:pineleaf", { level_type = crown_level_Type.CONE })
end

-- Plum Trees / Слива
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_plumtree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 2, radius, { "lottplants:plumleaf", "lottplants:plum" })
	generator.add_crown_at(pos, height,     radius, { "lottplants:plumleaf", "lottplants:plum" })
end

-- Rowans / Рябина
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_rowantree(pos, generator)
	local height = 6 + math.random(2)

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 4, 2, "lottplants:rowanleaf")
	generator.add_crown_at(pos, height - 2, 3, { "lottplants:rowanleaf", "lottplants:rowanberry" })
	generator.add_crown_at(pos, height,     2, "lottplants:rowanleaf")
end

-- White Tree / Белое дерево
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_whitetree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 2, radius, "lottplants:whiteleaf")
	generator.add_crown_at(pos, height,     radius, "lottplants:whiteleaf")
end

-- Yavannamire / Йаванамирэ
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_yavannamiretree(pos, generator)
	local height = 4 + math.random(2)
	local radius = 2

	generator.add_trunk(pos, height, "default:tree")

	generator.add_crown_at(pos, height - 2, radius, { "lottplants:yavannamireleaf", "lottplants:yavannamirefruit" })
	generator.add_crown_at(pos, height,     radius, { "lottplants:yavannamireleaf", "lottplants:yavannamirefruit" })
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

	generator.add_branches_at(pos, height, "default:jungletree", 2, 2, branch_Type.SHURIKEN, "lottplants:mirkleaf")
end
--Mirk Small / Малое дерево Лихолесья
--- @param pos       Position
--- @param generator tree.Generator
function lottplants_smallmirktree(pos, generator)
	local height = 7

	generator.add_trunk(pos, height - 2, "default:jungletree")

	generator.add_branches_at(pos, height - 1, "default:jungletree", 1, 2, branch_Type.DIAGONAL, "lottplants:mirkleaf")
end
