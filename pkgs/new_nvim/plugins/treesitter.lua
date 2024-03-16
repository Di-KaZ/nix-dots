local add = MiniDeps.add

add({
	source = 'nvim-treesitter/nvim-treesitter',
	-- Use 'master' while monitoring updates in 'main'
	checkout = 'master',
	monitor = 'main',
	-- Perform action after every checkout
	hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'lua', 'vimdoc' },
	highlight = { enable = true },
})
