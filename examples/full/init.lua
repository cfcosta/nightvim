vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

NV.map("n", "<leader>wv", "<cmd>vsplit<cr>")
NV.map("n", "<leader>ws", "<cmd>split<cr>")
NV.map("n", "<leader>wc", "<cmd>close<cr>")
NV.map("n", "<leader>wo", "<cmd>only<cr>")

NV.after("neogit", function()
	NV.map("n", "<leader>gg", "<cmd>Neogit<cr>")
end)

NV.after("neotree", function()
	NV.map("n", "<leader>op", "<cmd>Neotree toggle<cr>")
end)

NV.after("toggleterm", function()
	NV.map("n", "<leader>ot", "<cmd>ToggleTerm direction=horizontal<cr>")
	NV.map("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>")
end)

NV.after("telescope", function()
	NV.map("n", "<leader><leader>", "<cmd> Telescope find_files hidden=true<CR>")
	NV.map("n", "<leader>/", "<cmd> Telescope live_grep <CR>")
	NV.map("n", "<leader>bb", "<cmd> Telescope buffers <CR>")
	NV.map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
	NV.map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
end)

NV.after("trouble", function()
	NV.map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
	NV.map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
	NV.map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
	NV.map("n", "<leader>xq", "<cmd>TroubleToggle quicklist<cr>")
	NV.map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
	NV.map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
end)

NV.after("nvim-lspconfig", function()
	NV.map("n", "gD", vim.lsp.buf.declaration)
	NV.map("n", "gd", vim.lsp.buf.definition)
	NV.map("n", "K", vim.lsp.buf.hover)
	NV.map("n", "gi", vim.lsp.buf.implementation)
	NV.map("n", "<leader>ls", vim.lsp.buf.signature_help)
	NV.map("n", "<leader>D", vim.lsp.buf.type_definition)
	NV.map("n", "<leader>ca", vim.lsp.buf.code_action)
	NV.map("n", "<leader>f", vim.diagnostic.open_float)
	NV.map("n", "[d", vim.diagnostic.goto_prev)
	NV.map("n", "d]", vim.diagnostic.goto_next)
	NV.map("n", "<leader>q", vim.diagnostic.setloclist)
	NV.map("n", "<leader>cr", vim.lsp.buf.rename)
end)
