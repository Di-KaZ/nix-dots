local add = MiniDeps.add

add("https://git.sr.ht/~whynothugo/lsp_lines.nvim")
require("lsp_lines").setup()

vim.diagnostic.config({
	signs         = false,
	virtual_text  = false,
	virtual_lines = {
		only_current_line = true
	}
})
