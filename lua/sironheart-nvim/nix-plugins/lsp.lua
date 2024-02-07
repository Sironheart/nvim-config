require("neodev").setup({})

local null_ls = require("null-ls")
local lspconfig = require("lspconfig")
local rust_tools = require("rust-tools")
local treesitter = require("nvim-treesitter.configs")
local treesitter_context = require("treesitter-context")

local function autocmd(args)
	local event = args[1]
	local group = args[2]
	local callback = args[3]

	vim.api.nvim_create_autocmd(event, {
		group = group,
		buffer = args[4],
		callback = function()
			callback()
		end,
		once = args.once,
	})
end

local function on_attach(client, buffer)
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

rust_tools.setup({
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
		on_attach = on_attach,
	},
})
local language_servers = {
	html = { filetypes = { "html", "twig", "hbs" } },
	cssls = {},
	jsonls = {},
	gopls = {},
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

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

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
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	border = "rounded",
	sources = {
		-- formatting
		formatting.prettierd,
		formatting.stylua,

		-- diagnostics
		diagnostics.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
			end,
		}),

		-- code actions
		code_actions.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
			end,
		}),
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
