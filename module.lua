local NightVim = {}

NightVim.root = vim.fn.stdpath "config" .. "/night";
NightVim.plugins_root = vim.fn.stdpath "config" .. "/night/plugins";

NightVim.map = function (mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.opt.packpath:prepend(NightVim.plugins_root)

NightVim.setup_plugin = function(name, depends, config)
end

NightVim.finish = function()
end
