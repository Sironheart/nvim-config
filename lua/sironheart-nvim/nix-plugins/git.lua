require("gitsigns").setup({
	on_attach = function(bufnr)
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
	end,
})
