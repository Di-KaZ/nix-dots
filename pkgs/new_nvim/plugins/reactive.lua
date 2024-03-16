local add = MiniDeps.add

add({
	source = "rasulomaroff/reactive.nvim",
	depends = { "MunifTanjim/nui.nvim" },
})

require('reactive').setup({
	builtin = {
		cursorline = true,
		cursor = true,
		modemsg = true
	}
})
