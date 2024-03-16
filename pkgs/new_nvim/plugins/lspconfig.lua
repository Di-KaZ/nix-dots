local add = MiniDeps.add

add('nvim-tree/nvim-web-devicons')

add({
	source = 'neovim/nvim-lspconfig',
	-- supply dependencies near target plugin
	depends = {
		"williamboman/mason-lspconfig.nvim",
		'williamboman/mason.nvim'
	},
})

require('nvim-web-devicons').setup()

require("mason").setup()

require("mason-lspconfig").setup({
	-- dartls in managed by flutter-tools
	automatic_installation = { exclude = { "dartls" } }
})

-- auto install lsp when available
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup {}
	end
})
