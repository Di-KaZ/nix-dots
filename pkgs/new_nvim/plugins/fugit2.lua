MiniDeps.add({
	source = 'SuperBo/fugit2.nvim',
	depends = {
		'MunifTanjim/nui.nvim',
		'nvim-tree/nvim-web-devicons',
		'nvim-lua/plenary.nvim',
	}
})

require("fugit2").setup()
