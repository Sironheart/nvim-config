-- Comment blocks
require("Comment").setup()

-- Learn better movement
require("hardtime").setup()

-- auto-session
require("auto-session").setup({
	log_level = "warn",
	auto_session_suppress_dirs = { "~/", "~/projects", "~/privat", "~/Downloads", "/" },
})

-- Rust Crates
require("crates").setup()

-- Trouble
require("trouble").setup()

require("notify").setup({
	background_colour = "#000000",
})
require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
})
