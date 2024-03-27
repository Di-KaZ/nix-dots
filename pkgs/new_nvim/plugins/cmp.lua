MiniDeps.add("hrsh7th/nvim-cmp")
MiniDeps.add("dcampos/nvim-snippy")
MiniDeps.add("hrsh7th/cmp-nvim-lsp")
MiniDeps.add("onsails/lspkind.nvim")

local cmp = require("cmp")
local snippy = require("snippy")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local fallback_kind_symbol = {
	["Codeium"] = ''
}

cmp.setup({
	snippet = {
		expand = function(args)
			require('snippy').expand_snippet(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_next_item()
				end
			elseif snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			elseif has_words_before() then
				cmp.complete()
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				end
			else
				fallback()
			end
		end, { "i", "s" }),
		['<S-TAB>'] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{ name = 'codeium' },
		{ name = 'nvim_lsp' },
		{ name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	}),
	---@diagnostic disable-next-line: missing-fields
	formatting = {
		fields = { "kind", "abbr", },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry,
				vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			if #strings == 1 then
				kind.kind = fallback_kind_symbol[strings[1]] or ""
			elseif strings[1]
			then
				kind.kind = strings[1]
			else
				kind.kind = ""
			end
			kind.kind = " " .. kind.kind
			return kind
		end,
	},
})
