
-- Регистрация опадающей листвы и др.

-- Alders / Ольха
default.register_leafdecay({
	trunks = {"lottplants:aldertree"},
	leaves = {"lottplants:alderleaf"},
	radius = 3,
})

default.register_leafdecay({
	trunks = {"default:tree"},
	leaves = {
		"lottplants:appleleaf", "default:leaves", "default:apple", -- Apple Tree / Яблоня
		"lottplants:beechleaf", -- Beeches / Бук
		"lottplants:culumaldaleaf", "lottplants:yellowflowers", -- Culumalda / Кулумальда
		"lottplants:elmleaf", -- Elms / Вяз
		"lottplants:plumleaf", "lottplants:plum", -- Plum Tree / Слива
		"lottplants:rowanleaf", "lottplants:rowanberry", -- Rowans / Рябина
		"lottplants:whiteleaf", -- White Tree / Белое дерево
		"lottplants:yavannamireleaf", "lottplants:yavannamirefruit", -- Yavannamire / Йаванамирэ
	},
	radius = 4, -- только из-за бука, у остальных 3 или 2
})

-- Lebethron / Лебетрон
default.register_leafdecay({
	trunks = {"lottplants:lebethrontree"},
	leaves = {"lottplants:lebethronleaf"},
	radius = 2,
})

-- Birches / Береза
default.register_leafdecay({
	trunks = {"lottplants:birchtree"},
	leaves = {"lottplants:birchleaf"},
	radius = 3,
})

-- Firs / Ель
default.register_leafdecay({
	trunks = {"lottplants:firtree"},
	leaves = {"lottplants:firleaf"},
	radius = 4,
})

-- (Young) Mallorn / (Молодой) маллорн
default.register_leafdecay({
	trunks = {"lottplants:mallorntree", "lottplants:mallorntree_young"},
	leaves = {"lottplants:mallornleaf"},
	radius = 2,
})

-- Pines / Сосна
default.register_leafdecay({
	trunks = {"lottplants:pinetree"},
	leaves = {"lottplants:pineleaf"},
	radius = 2,
})

-- Mirk Large/Small / Большое/Малое дерево Лихолесья
default.register_leafdecay({
	trunks = {"default:jungletree"},
	leaves = {"lottplants:mirkleaf"},
	radius = 2,
})
