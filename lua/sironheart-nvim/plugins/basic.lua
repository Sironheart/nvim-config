return {

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		config = function()
			local wk = require("which-key")
			wk.register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ebugger", _ = "which_key_ignore" },
				["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
				["<leader>h"] = { name = "[H]arpoon", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
				-- ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			})
			-- register which-key VISUAL mode
			require("which-key").register({
				["<leader>"] = { name = "VISUAL <leader>" },
				["g"] = { name = "[G]it" },
			}, { mode = "v" })
		end,
	},

	{ "numToStr/Comment.nvim", opts = {} },

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	{
		"stevearc/dressing.nvim",
		opts = {},
	},

	"jghauser/mkdir.nvim",

	-- Games
	"ThePrimeagen/vim-be-good",
}
