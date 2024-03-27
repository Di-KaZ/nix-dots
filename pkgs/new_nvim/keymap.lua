vim.g.mapleader = " "

local map = vim.keymap.set

--- sets a normal keymap preprending <CMD> and appending <CR> with a description
--- @param keymap string 	
--- @param cmd string 	
--- @param desc string 	
local function nmap(keymap, cmd, desc)
	map("n", keymap, "<CMD>" .. cmd .. "<CR>", { desc = desc })
end

-- Debugger
nmap("<leader>dt", "lua require('dapui').toggle()", "Toggle Debugger")
nmap("<leader>db", "DapToggleBreakpoint", "Toggle Breakpoint")
nmap("<leader>dc", "DapContinue", "Continue")
nmap("<leader>di", "DapStrpInto", "Into")
nmap("<leader>do", "DapStepOver", "Step Over")

-- Files management
nmap("<leader>fe", "lua MiniFiles.open()", "Find files")
nmap("<C-e>", "lua MiniFiles.open()", "Find files")
nmap("<leader>ff", "Pick files", "Find files")
nmap("<leader>fw", "Pick grep_live", "Find match")

-- Lsp
nmap("<S-k>", "Lspsaga hover_doc", "Hover")
nmap("gd", "Lspsaga finder def", "Declaration")
nmap("gr", "Lspsaga finder ref", "References")
nmap("ga", "Lspsaga code_action", "Code Actions")
nmap("gj", "Lspsaga diagnostic_jump_next", "Next diagnostic")
nmap("gk", "Lspsaga diagnostic_jump_prev", "Previous diagnostic")
nmap("<leader>gr", "Lspsaga rename", "Rename")
-- nmap("<leader>gi", "LspUI inlay_hint", "Inlay Hint")
nmap("<leader>gd", "Pick diagnostic", "Diagnostics")
nmap("<leader>gs", "lua MiniExtra.pickers.lsp({ scope = 'document_symbol' })", "Document Symbol")
nmap("<leader>gS", "lua MiniExtra.pickers.lsp({ scope = 'workspace_symbol' })", "Workspace Symbols")

-- Git
nmap('<leader>cn', "Neogit", "Neogit")
nmap('<leader>co', 'GitConflictChooseOurs', "Accept Ours")
nmap('<leader>ct', 'GitConflictChooseTheirs', "Accept Theirs")
nmap('<leader>cb', 'GitConflictChooseBoth', "Accept Both")
nmap('<leader>c0', 'GitConflictChooseNone', "Accept none")
nmap('<leader>cj', 'GitConflictNextConflict', "Next Conflict")
nmap('<leader>ck', 'GitConflictPrevConflict', "Prev Conflict")
nmap('<leader>cl', 'GitConflictListQf', "Conflict List")

-- Buffers
nmap("<leader>bp", "BufferLinePick", "Jump to buffer")
nmap("<S-Tab>", "BufferLineCyclePrev", "Prev buffer")
nmap("<Tab>", "BufferLineCycleNext", "Next buffer")

-- Terminals
nmap("<leader>tv", "Vterm", "Vertical Terminal")
nmap("<leader>ts", "Sterm", "Horizontal Terminal")
nmap("<leader>tf", "Fterm", "Floating Terminal")

-- Theme
nmap("<leader>T", "Themery", "Themes Selector")

-- Completion
-- map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
-- map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
vim.keymap.set('i', '<TAB>', function()
	if vim.fn.pumvisible() == 1 then
		return '<C-n>'
	elseif vim.snippet.jumpable(1) then
		return '<cmd>lua vim.snippet.jump(1)<cr>'
	else
		return '<TAB>'
	end
end, { expr = true })

vim.keymap.set('i', '<S-TAB>', function()
	if vim.fn.pumvisible() == 1 then
		return '<C-p>'
	elseif vim.snippet.jumpable(-1) then
		return '<cmd>lua vim.snippet.jump(-1)<CR>'
	else
		return '<S-TAB>'
	end
end, { expr = true })

vim.keymap.set('i', '<C-e>', function()
	if vim.fn.pumvisible() == 1 then
		require('epo').disable_trigger()
	end
	return '<C-e>'
end, { expr = true })

-- For using enter as completion, may conflict with some autopair plugin
vim.keymap.set("i", "<cr>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	end
	return "<cr>"
end, { expr = true, noremap = true })

-- nvim-autopair compatibility
-- vim.keymap.set("i", "<cr>", function()
--	if vim.fn.pumvisible() == 1 then
--		return "<C-y>"
--	end
--	return require("nvim-autopairs").autopairs_cr()
-- end, { expr = true, noremap = true })
