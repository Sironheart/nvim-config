require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.move").setup()
require("mini.basics").setup({
	mappings = {
		windows = true,
		move_with_alt = true,
	},
})
