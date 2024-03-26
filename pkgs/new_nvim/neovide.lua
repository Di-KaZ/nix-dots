if vim.g.neovide == nil then return end

print('hey')
vim.o.guifont = "Monaspace Neon:h14"

vim.cmd("TransparentDisable")

vim.g.neovide_transparency = 0.8
