local add = MiniDeps.add

add("brenoprata10/nvim-highlight-colors")

require("nvim-highlight-colors").setup({
	render = 'virtual',
	enable_tailwind = true,
})
