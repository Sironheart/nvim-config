return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<C-n>", ":Neotree filesystem reveal left<CR>" },
	},
	opts = {
		event_handlers = {
			{
				event = "file_opened",
				handler = function(file_path)
					vim.cmd("Neotree close")
				end,
			},
		},
	},
}
