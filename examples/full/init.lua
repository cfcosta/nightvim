vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

NightVim.map("n", "<leader>wv", "<cmd>vsplit<cr>")
NightVim.map("n", "<leader>ws", "<cmd>split<cr>")
NightVim.map("n", "<leader>wc", "<cmd>close<cr>")
NightVim.map("n", "<leader>wo", "<cmd>only<cr>")

NightVim.after("neogit", function()
	NightVim.map("n", "<leader>gg", "<cmd>Neogit<cr>")
end)

NightVim.after("neotree", function()
	NightVim.map("n", "<leader>op", "<cmd>Neotree toggle<cr>")
end)

NightVim.after("toggleterm", function()
	NightVim.map("n", "<leader>ot", "<cmd>ToggleTerm direction=horizontal<cr>")
	NightVim.map("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>")
end)

NightVim.after("telescope", function()
	NightVim.map("n", "<leader><leader>", "<cmd> Telescope find_files hidden=true<CR>")
	NightVim.map("n", "<leader>/", "<cmd> Telescope live_grep <CR>")
	NightVim.map("n", "<leader>bb", "<cmd> Telescope buffers <CR>")
	NightVim.map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
	NightVim.map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
end)

NightVim.after("trouble", function()
	NightVim.map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
	NightVim.map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
	NightVim.map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
	NightVim.map("n", "<leader>xq", "<cmd>TroubleToggle quicklist<cr>")
	NightVim.map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
	NightVim.map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
end)

NightVim.after("nvim-lspconfig", function()
	NightVim.map("n", "gD", vim.lsp.buf.declaration)
	NightVim.map("n", "gd", vim.lsp.buf.definition)
	NightVim.map("n", "K", vim.lsp.buf.hover)
	NightVim.map("n", "gi", vim.lsp.buf.implementation)
	NightVim.map("n", "<leader>ls", vim.lsp.buf.signature_help)
	NightVim.map("n", "<leader>D", vim.lsp.buf.type_definition)
	NightVim.map("n", "<leader>ca", vim.lsp.buf.code_action)
	NightVim.map("n", "<leader>f", vim.diagnostic.open_float)
	NightVim.map("n", "[d", vim.diagnostic.goto_prev)
	NightVim.map("n", "d]", vim.diagnostic.goto_next)
	NightVim.map("n", "<leader>q", vim.diagnostic.setloclist)
	NightVim.map("n", "<leader>cr", vim.lsp.buf.rename)
end)
