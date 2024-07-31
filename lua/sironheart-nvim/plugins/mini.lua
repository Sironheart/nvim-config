require("mini.basics").setup({
	mappings = {
		basic = true,
		windows = true,
		move_with_alt = true,
	},
})
require("mini.ai").setup({ n_lines = 500 })
require("mini.extra").setup()
require("mini.indentscope").setup()
require("mini.move").setup()
require("mini.pairs").setup({
	modes = { insert = true, command = true, terminal = false },
	mappings = {
		["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
		["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
		["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

		[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
		["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
		["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },

		["<A-9>"] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
		["<A-0>"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
	},
})
require("mini.statusline").setup()
require("mini.surround").setup()
