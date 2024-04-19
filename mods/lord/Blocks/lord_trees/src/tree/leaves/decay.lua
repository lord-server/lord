
-- Регистрация опадающей листвы и др.

-- Alders / Ольха
default.register_leafdecay({
	trunks = {"lord_trees:aldertree"},
	leaves = {"lord_trees:alderleaf"},
	radius = 3,
})

default.register_leafdecay({
	trunks = {"default:tree"},
	leaves = {
		"lord_trees:appleleaf", "default:leaves", "default:apple", -- Apple Tree / Яблоня
		"lord_trees:beechleaf", -- Beeches / Бук.   Оставлено опадание вокруг ствола яблони, т.к. есть уже сгенерированные.
		"lord_trees:culumaldaleaf", "lord_trees:yellowflowers", -- Culumalda / Кулумальда     Оставлено, т.к.  ...
		"lord_trees:elmleaf", -- Elms / Вяз.   Оставлено опадание вокруг ствола яблони, т.к. есть уже сгенерированные.
		"lord_trees:plumleaf", "lord_trees:plum", -- Plum Tree / Слива
		"lord_trees:rowanleaf", "lord_trees:rowanberry", -- Rowans / Рябина
		"lord_trees:whiteleaf", -- White Tree / Белое дерево
		"lord_trees:yavannamireleaf", "lord_trees:yavannamirefruit", -- Yavannamire / Йаванамирэ
	},
	radius = 3,
})

-- Lebethron / Лебетрон
default.register_leafdecay({
	trunks = {"lord_trees:lebethrontree"},
	leaves = {"lord_trees:lebethronleaf"},
	radius = 2,
})

-- Birches / Береза
default.register_leafdecay({
	trunks = {"lord_trees:birchtree"},
	leaves = {"lord_trees:birchleaf"},
	radius = 3,
})

-- Cherry / Сакура
default.register_leafdecay({
	trunks = {"lord_trees:cherrytree"},
	leaves = {"lord_trees:cherryleaf"},
	radius = 2,
})

-- Culumalda / Кулумальда
default.register_leafdecay({
	trunks = {"lord_trees:culumaldatree"},
	leaves = {"lord_trees:culumaldaleaf", "lord_trees:yellowflowers"},
	radius = 2,
})

-- Firs / Ель
default.register_leafdecay({
	trunks = {"lord_trees:firtree"},
	leaves = {"lord_trees:firleaf"},
	radius = 4,
})

-- (Young) Mallorn / (Молодой) маллорн
default.register_leafdecay({
	trunks = {"lord_trees:mallorntree", "lord_trees:mallorn_young_tree"},
	leaves = {"lord_trees:mallornleaf"},
	radius = 2,
})

-- Pines / Сосна
default.register_leafdecay({
	trunks = {"lord_trees:pinetree"},
	leaves = {"lord_trees:pineleaf"},
	radius = 2,
})

-- Mirk Large/Small / Большое/Малое дерево Лихолесья
default.register_leafdecay({
	trunks = {"default:jungletree"},
	leaves = {"lord_trees:mirkleaf"},
	radius = 2,
})

-- Elms / Вяз
default.register_leafdecay({
	trunks = {"lord_trees:elmtree"},
	leaves = {"lord_trees:elmleaf"},
	radius = 2,
})

-- Beeches / Бук
default.register_leafdecay({
	trunks = {"lord_trees:beechtree"},
	leaves = {"lord_trees:beechleaf"},
	radius = 4,
})
