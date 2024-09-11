local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

require("copilot").setup({
	suggestions = {
		keymap = {
			accept = "<C-y>",
			next = "<C-]>",
			prev = "<C-[>",
			dismiss = "<C-c>",
		},
	},
	panel = { enabled = false },
})

cmp.setup({
	formatting = {
		fields = { "menu", "abbr", "kind" },
		expandable_indicator = true,
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 100,
			show_labelDetails = true,
			symbol_map = { Copilot = "" },
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
		["<C-c>"] = cmp.mapping.abort(),
		["<C-Space>"] = nil,
		["<CR>"] = nil,
		["<Down>"] = nil,
		["<Up>"] = nil,
		["<Tab>"] = nil,
		["<S-Tab>"] = nil,
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path", max_item_count = 5 },
	},
})
luasnip.config.setup({})
