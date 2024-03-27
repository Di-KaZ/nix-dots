MiniDeps.add({
	source = "NeogitOrg/neogit",
	depends = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim"
	}
})

require("neogit").setup({})
