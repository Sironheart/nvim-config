local telescope = require("telescope")

local telescopeConfig = require("telescope.config")
-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		vimgrep_arguments = vimgrep_arguments,
		file_ignore_patterns = {
			"node_modules",
			"yarn.lock",
			".git",
			".sl",
			"_build",
			".next",
			"^.git",
			"^.idea",
			"^.fleet",
			"^.vscode",
		},
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
	hidden = true,
	extensions = {
		-- ["ui-select"] = {
		-- 	require("telescope.themes").get_dropdown({}),
		-- },
		fzf = {
			fuzzy = true,
			case_mode = "ignore_case",
		},
	},
	pickets = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--trim" },
		},
	},
})

pcall(telescope.load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, { desc = "[F]ind [R]esume" })
