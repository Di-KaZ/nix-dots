local add = MiniDeps.add

add('akinsho/git-conflict.nvim')

require('git-conflict').setup({
	default_mappings = false,
})
