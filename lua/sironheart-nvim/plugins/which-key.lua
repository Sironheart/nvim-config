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

wk.register({
	["<leader>"] = { name = "VISUAL <leader>" },
	["g"] = { name = "[G]it" },
}, { mode = "v" })
