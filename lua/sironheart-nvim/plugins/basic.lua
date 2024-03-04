-- Comment blocks
require("Comment").setup()

-- auto-session
require("auto-session").setup({
	log_level = "warn",
	auto_session_suppress_dirs = { "~/", "~/projects", "~/privat", "~/Downloads", "/" },
})
