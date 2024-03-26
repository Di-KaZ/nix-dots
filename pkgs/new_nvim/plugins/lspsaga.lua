MiniDeps.add({
	source = "nvimdev/lspsaga.nvim",
	depends = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons',
	}
})

local lspsaga = require("lspsaga")

lspsaga.setup({
	code_action = {
		extend_gitsigns = true,
	},
	symbol_in_winbar = {
		enable = false,
	},
	lightbulb = {
		enable = false,
		virtual_text = false,
		-- code_action = '',
	}
})
