local function init()
	-- Filetree
	vim.keymap.set("n", "<C-n>", ":Oil<CR>")

	-- Telescope
	vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
	vim.keymap.set("n", "<leader>/", function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[/] Fuzzily search in current buffer" })

	vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch using [G]rep" })
	vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

	-- lsp
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

	-- dap
	local dap = require("dap")
	vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
	vim.keymap.set("n", "<leader>ds", dap.continue, {})
	vim.keymap.set("n", "<leader>do", dap.step_over, {})
	vim.keymap.set("n", "<leader>di", dap.step_into, {})
	vim.keymap.set("n", "<leader>da", dap.step_out, {})
	vim.keymap.set("n", "<leader>ds", dap.terminate, {})

	-- [[ Basic Keymaps ]]

	-- TIP: Disable arrow keys in normal mode
	vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
	vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
	vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
	vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

	-- Keymaps for better default experience
	-- See `:help vim.keymap.set()`
	-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

	-- Remap for dealing with word wrap
	vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	-- Auto-Session Keymaps
	vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session, { noremap = true })

	-- Trouble Keymaps
	vim.keymap.set("n", "<leader>xx", function()
		require("trouble").toggle()
	end)
	vim.keymap.set("n", "<leader>xw", function()
		require("trouble").toggle("workspace_diagnostics")
	end)
	vim.keymap.set("n", "<leader>xd", function()
		require("trouble").toggle("document_diagnostics")
	end)
	vim.keymap.set("n", "<leader>xq", function()
		require("trouble").toggle("quickfix")
	end)
	vim.keymap.set("n", "<leader>xl", function()
		require("trouble").toggle("loclist")
	end)
	vim.keymap.set("n", "gR", function()
		require("trouble").toggle("lsp_references")
	end)
end

local function lsp_bindings(event)
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
	end

	-- Jump to the definition of the word under your cursor.
	--  This is where a variable was first declared, or where a function is defined, etc.
	--  To jump back, press <C-T>.
	map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

	map("gvd", function()
		require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
	end, "[G]oto [D]efinition")

	-- Find references for the word under your cursor.
	map("gr", function()
		require("telescope.builtin").lsp_references({ jump_type = true })
	end, "[G]oto [R]eferences")

	-- Jump to the implementation of the word under your cursor.
	--  Useful when your language has ways of declaring types without an actual implementation.
	map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

	map("gvI", function()
		require("telescope.builtin").lsp_implementations({ jump_type = "vsplit" })
	end, "[G]oto [I]mplementation")

	-- Jump to the type of the word under your cursor.
	--  Useful when you're not sure what type a variable is and you want to see
	--  the definition of its *type*, not where it was *defined*.
	map("<leader>D", function()
		require("telescope.builtin").lsp_type_definitions()
	end, "Type [D]efinition")

	-- Rename the variable under your cursor
	--  Most Language Servers support renaming across files, etc.
	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

	-- Execute a code action, usually your cursor needs to be on top of an error
	-- or a suggestion from your LSP for this to activate.
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	-- Opens a popup that displays documentation about the word under your cursor
	--  See `:help K` for why this keymap
	map("K", vim.lsp.buf.hover, "Hover Documentation")

	-- WARN: This is not Goto Definition, this is Goto Declaration.
	--  For example, in C this would take you to the header
	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	-- The following two autocommands are used to highlight references of the
	-- word under your cursor when your cursor rests there for a little while.
	--    See `:help CursorHold` for information about when this is executed
	--
	-- When you move your cursor, the highlights will be cleared (the second autocommand).
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if client and client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = event.buf,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = event.buf,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local function nvim_cmp()
	local cmp = require("cmp")
	local cmp_select = { behaviour = cmp.SelectBehavior.Select }
	local mappings = {
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = nil,
		["<S-Tab>"] = nil,
	}

	return mappings
end

return {
	cmp = nvim_cmp,
	init = init,
	lsp_bindings = lsp_bindings,
}
