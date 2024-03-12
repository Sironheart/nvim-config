local colorizer = require("colorizer")
local gitsigns = require("gitsigns")
local oxocarbon = require("oxocarbon").oxocarbon

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
vim.cmd("colorscheme oxocarbon")

-- Make background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Some oxocarbon theme fixes
--[[ Editor ]]
vim.api.nvim_set_hl(0, "Normal", { bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "CursorLine", { fg = oxocarbon.none, bg = oxocarbon.base01 })

--[[ Telescope ]]
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = oxocarbon.base03, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = oxocarbon.base14, bg = oxocarbon.none, bold = true, italic = true })
vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = oxocarbon.none, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePreviewLine", { fg = oxocarbon.none, bg = oxocarbon.base01 })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = oxocarbon.base14, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = oxocarbon.base03, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = oxocarbon.base04, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = oxocarbon.base08, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = oxocarbon.base14, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = oxocarbon.base14, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = oxocarbon.none, bg = oxocarbon.base02 })
