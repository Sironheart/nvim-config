require("gitsigns").setup({
	on_attach = function(bufnr)
		require("sironheart-nvim.keys").gitsigns(bufnr)
	end,
})
