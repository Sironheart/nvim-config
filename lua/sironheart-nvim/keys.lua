local function init()
	-- Neotree
	vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")

	-- telescope
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

	-- lsp
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
end

local function lsp_bindings(buffer, client)
	local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
	local autocmd_clear = vim.api.nvim_clear_autocmds

	local opts = { buffer = buffer, remap = false }

	-- Enable completion triggered by <c-x><c-o>
	vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	if client.server_capabilities.documentHighlightProvider then
		autocmd_clear({ group = augroup_highlight, buffer = buffer })
		autocmd({ "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, buffer })
		autocmd({ "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, buffer })
	end
end

local function gitsigns(bufnr)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Actions
	-- Toggles
	map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
	map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

	-- Text object
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
end

local function harpoon(harpoon, toggle_telescope)
	vim.keymap.set("n", "<leader>ha", function()
		harpoon:list():append()
	end)
	vim.keymap.set("n", "<leader>hl", function()
		toggle_telescope(harpoon:list())
	end, { desc = "Open harpoon window" })

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<C-S-P>", function()
		harpoon:list():prev()
	end)
	vim.keymap.set("n", "<C-S-N>", function()
		harpoon:list():next()
	end)
end

return {
	gitsigns = gitsigns,
	lsp_bindings = lsp_bindings,
	harpoon = harpoon,
	init = init,
}
