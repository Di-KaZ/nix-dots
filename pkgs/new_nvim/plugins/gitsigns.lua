MiniDeps.add("lewis6991/gitsigns.nvim")

require('gitsigns').setup({
	on_attach = function()
		local gs = package.loaded.gitsigns
		gs.toggle_current_line_blame()
		gs.toggle_signs()
	end
})
