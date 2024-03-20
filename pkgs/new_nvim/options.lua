vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.o.exrc = true
vim.opt.laststatus = 3
vim.opt.tabstop = 4
vim.api.nvim_set_option("clipboard", "unnamedplus")

SIGNS = {
	Error = " ",
	Warn = " ",
	Hint = "󰛨 ",
	Info = " "
}

for type, icon in pairs(SIGNS) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
