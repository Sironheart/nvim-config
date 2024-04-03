-- Comment blocks
require("Comment").setup()

-- auto-session
require("auto-session").setup({
	log_level = "warn",
	auto_session_suppress_dirs = { "~/", "~/projects", "~/privat", "~/Downloads", "/" },
})

-- Trouble
require("trouble").setup()

require("notify").setup({
	background_colour = "#000000",
})
require("noice").setup()
