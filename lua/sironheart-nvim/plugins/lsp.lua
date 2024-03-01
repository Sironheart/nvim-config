require("neodev").setup({})

local lspconfig = require("lspconfig")
local treesitter = require("nvim-treesitter.configs")
local treesitter_context = require("treesitter-context")

local function on_attach(client, buffer)
	require("sironheart-nvim.keys").lsp_bindings(buffer, client)
end

local language_servers = {
	cssls = {},
	elixirls = {},
	gopls = {},
	html = { filetypes = { "html", "twig", "hbs" } },
	jsonls = {},
	java_language_server = {},
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
					command = { "nixpkgs-fmt" },
				},
				nix = {
					maxMemoryMB = 2560,
					flake = {
						autoArchive = true,
						autoEvalInputs = true,
					},
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
	local config = { on_attach = on_attach }

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
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})

treesitter_context.setup()

-- Configure LSP linting, formatting, diagnostics, and code actions
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "biome" },
		go = { "gofmt" },
		nix = { "nixpkgs_fmt" },
		just = { "just" },
		kotlin = { "ktlint" },
		terraform = { "terraform_fmt" },
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
