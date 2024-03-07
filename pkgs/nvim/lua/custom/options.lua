-- add options or override my options in here
vim.g.TeVimTheme = "dracula"
vim.g.transparency = true
vim.opt.spell = false
vim.opt.relativenumber = true
vim.o.exrc = true

if vim.g.neovide then
  vim.o.guifont = "Monaspace Neon:h16"
  vim.g.neovide_transparency = 0.7
  vim.g.neovide_cursor_vfx_mode = "railgun"
end
