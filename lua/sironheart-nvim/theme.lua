local colorizer = require("colorizer")
local gitsigns = require("gitsigns")

colorizer.setup({})

gitsigns.setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")
