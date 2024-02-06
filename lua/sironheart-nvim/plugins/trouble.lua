return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local trouble = require("trouble")

			vim.keymap.set("n", "<leader>xx", function()
				trouble.toggle()
			end, { desc = "toggle trouble view" })
		end,
		opts = {},
	},
}
