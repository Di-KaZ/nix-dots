local add = MiniDeps.add

add("lukas-reineke/indent-blankline.nvim")

require("ibl").setup({
	indent = { char = '╎' },
	scope = {
		show_start = false,
		show_end = false,
	},
})
