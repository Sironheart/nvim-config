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
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
