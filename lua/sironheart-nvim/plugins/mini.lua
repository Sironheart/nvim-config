require("mini.basics").setup({
	mappings = {
		windows = true,
		move_with_alt = true,
	},
})
require("mini.ai").setup({ n_lines = 500 })
require("mini.indentscope").setup()
require("mini.surround").setup()
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.move").setup()
require("mini.extra").setup()
