require("neodev").setup({})

local lspconfig = require("lspconfig")
local treesitter = require("nvim-treesitter.configs")
local treesitter_context = require("treesitter-context")

require("fidget").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = require("sironheart-nvim.keys").lsp_bindings,
})

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP Specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local language_servers = {
	cssls = {},
	elixirls = {},
	gleam = {},
	gopls = {},
	html = { filetypes = { "html" } },
	java_language_server = {},
	jsonls = {},
	kotlin_language_server = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	nil_ls = {
		settings = {
			["nil"] = {
				formatting = {
					command = { "alejandra" },
				},
			},
		},
	},
	terraformls = {},
	tsserver = {},
	yamlls = {},
	zls = {},
}

-- Initialize servers
for server, server_config in pairs(language_servers) do
	local config = {}

	if server_config then
		for k, v in pairs(server_config) do
			config[k] = v
		end
	end

	lspconfig[server].setup(config)
end

treesitter.setup({
	highlight = { enable = true },
	indent = { enable = true },
})

treesitter_context.setup()

-- Configure LSP linting, formatting, diagnostics, and code actions
require("conform").setup({
	formatters_by_ft = {
		cue = { "cuefmt" },
		gleam = { "gleam" },
		go = { "goimports", "gofmt" },
		javascript = { "biome", "prettierd" },
		just = { "just" },
		kotlin = { "ktlint" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		terraform = { "terraform_fmt" },
		zig = { "zigfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- Configure borderd for LspInfo ui
require("lspconfig.ui.windows").default_options.border = "rounded"

-- Configure diagostics border
vim.diagnostic.config({
	float = {
		border = "rounded",
	},
})
