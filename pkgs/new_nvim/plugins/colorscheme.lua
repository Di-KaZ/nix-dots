local add = MiniDeps.add

-- require("mini.base16").setup()
require("mini.colors").setup()

add({ source = "rebelot/kanagawa.nvim" })
require("kanagawa").setup()

vim.cmd 'colorscheme kanagawa'
