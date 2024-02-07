local colorizer = require("colorizer")
local gitsigns = require("gitsigns")
local lualine = require("lualine")

colorizer.setup({})

gitsigns.setup({})

lualine.setup({
	options = {
		component_separators = { left = "", right = "" },
		extensions = { "fzf", "quickfix" },
		icons_enabled = false,
		section_separators = { left = "", right = "" },
	},
})

vim.opt.background = "dark"
