require("neo-tree").setup({
	event_handlers = {
		event = "file_opened",
		handler = function(file_path)
			vim.cmd("Neotree close")
		end,
	},
})
