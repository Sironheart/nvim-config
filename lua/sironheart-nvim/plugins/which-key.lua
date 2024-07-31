local wk = require("which-key")

wk.add({
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>d", group = "[D]ebugger" },
	{ "<leader>g", group = "[G]it" },
	{ "<leader>h", group = "[H]arpoon" },
	{ "<leader>r", group = "[R]ename" },
	{ "<leader>s", group = "[S]earch" },
	{
		mode = { "v" },
		{ "<leader>", group = "VISUAL <leader>" },
	},
})
