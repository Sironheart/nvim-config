-- indent blank lines
require("ibl").setup({
	scope = {
		enabled = false,
		show_start = false,
		show_end = false,
	},
})

-- Comment blocks
require("Comment").setup()

-- auto-session
require("auto-session").setup({
	log_level = "warn",
	auto_session_suppress_dirs = { "~/", "~/projects", "~/privat", "~/Downloads", "/" },
})
