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
	astro = {},
	cssls = {},
	diagnosticls = {},
	emmet_ls = {
		options = {
			["jsx.enabled"] = true,
		},
		filetypes = { "html", "templ", "liquid", "mjml" },
	},
	elixirls = {
		cmd = { "elixir-ls" },
	},
	gopls = {
		completeUnimported = true,
		usePlaceholders = true,
		analyses = {
			unusedparams = true,
		},
	},
	html = {
		filetypes = { "html", "templ", "liquid", "mjml" },
	},
	java_language_server = {},
	jsonls = {},
	kotlin_language_server = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	marksman = {},
	nickel_ls = {},
	nil_ls = {
		settings = {
			["nil"] = {
				formatting = {
					command = { "nixpkgs-fmt" },
				},
			},
		},
	},
	terraformls = {},
	tsserver = {},
	yamlls = {},
}

-- Initialize servers
for server, server_config in pairs(language_servers) do
	server_config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})

	lspconfig[server].setup(server_config)
end

-- Rustacean Nvim Plugin Setup, especially for the LSP
vim.g.rustaceanvim = {
	server = {
		settings = {
			["rust-analyzer"] = {
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				diagnostics = {
					enable = false,
				},
				files = {
					excludeDirs = { ".direnv", ".git" },
					watcherExclude = { ".direnv", ".git" },
				},
			},
		},
	},
}

treesitter.setup({
	highlight = { enable = true },
	indent = { enable = true },
})

treesitter_context.setup()

-- Configure LSP linting, formatting, diagnostics, and code actions
require("conform").setup({
	formatters_by_ft = {
		cue = { "cuefmt" },
		go = { "goimports", "gofmt" },
		javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
		json = { "jq" },
		just = { "just" },
		lua = { "stylua" },
		markdown = { "markdownlint-cli2" },
		nickel = { "nickel" },
		nix = { "alejandra" },
		rust = { "rustfmt" },
		terraform = { "terraform_fmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
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
