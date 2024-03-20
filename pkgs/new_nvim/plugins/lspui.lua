local add = MiniDeps.add

add("jinzhongjia/LspUI.nvim")
require("LspUI").setup({
	lightbulb = {
		enable = false,
		-- whether cache code action, if do, code action will use lightbulb's cache
		-- Sadly, currently this option is invalid, I haven't implemented caching yet
		is_cached = true,
		icon = "",
		-- defalt is 250 milliseconds, this will reduce calculations when you move the cursor frequently, but it will cause the delay of lightbulb, false will disable it
		debounce = 550,
	}

})
