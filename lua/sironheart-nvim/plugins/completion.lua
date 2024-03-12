local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("copilot_cmp").setup()
require("luasnip.loaders.from_vscode").lazy_load()
lspkind.init({
	symbol_map = {
		Copilot = "",
	},
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

cmp.setup({
	experimental = {
		ghost_text = true,
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		expandable_indicator = true,
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 100,
			show_labelDetails = true,
		}),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = nil,
		["<Down>"] = nil,
		["<Up>"] = nil,
		["<Tab>"] = nil,
		["<S-Tab>"] = nil,
	}),
	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path", max_item_count = 3 },
	},
})
-- luasnip.config.setup({})
