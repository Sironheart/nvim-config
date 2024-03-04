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
		expandable_indicator = true,
		format = lspkind.cmp_format({
			mode = "symbol",
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
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = {
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "luasnip", group_index = 2 },
		{ name = "path", max_item_count = 3, group_index = 2 },
	},
})
-- luasnip.config.setup({})
