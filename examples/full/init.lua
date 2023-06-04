vim.g.mapleader = " "

NightVim.map("n", "<leader>wv", "<cmd>vsplit<cr>")
NightVim.map("n", "<leader>ws", "<cmd>split<cr>")
NightVim.map("n", "<leader>wc", "<cmd>close<cr>")
NightVim.map("n", "<leader>wo", "<cmd>only<cr>")

NightVim.after("neogit", function(nv)
  nv.map("n", "<leader>gg", "<cmd>Neogit<cr>")
end)

NightVim.after("neotree", function(nv)
  nv.map("n", "<leader>op", "<cmd>Neotree toggle<cr>")
end)

NightVim.after("toggleterm", function(nv)
  nv.map("n", "<leader>ot", "<cmd>ToggleTerm direction=horizontal<cr>")
  nv.map("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>")
end)

NightVim.after("telescope", function(nv)
  nv.map("n", "<leader><leader>", "<cmd> Telescope find_files hidden=true<CR>")
  nv.map("n", "<leader>/", "<cmd> Telescope live_grep <CR>")
  nv.map("n", "<leader>bb", "<cmd> Telescope buffers <CR>")
  nv.map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
  nv.map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
end)

NightVim.after("trouble", function(nv)
  nv.map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
  nv.map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
  nv.map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
  nv.map("n", "<leader>xq", "<cmd>TroubleToggle quicklist<cr>")
  nv.map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
  nv.map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
end)