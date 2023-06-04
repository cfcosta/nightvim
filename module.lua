local NightVim = {}

NightVim.root = vim.fn.stdpath("config") .. "/night"
NightVim.plugins_root = vim.fn.stdpath("config") .. "/night/plugins"

NightVim.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.opt.packpath:prepend(NightVim.plugins_root)

NightVim.afterHooks = {}
NightVim.plugins = {}

NightVim.setup_plugin = function(name, depends, config)
	NightVim.plugins[name] = config
end

NightVim.after = function(name, func)
	NightVim.afterHooks[name] = func
end

NightVim.finish = function()
	for name, config in pairs(NightVim.plugins) do
		config()

		if NightVim.afterHooks[name] then
			NightVim.afterHooks[name](NightVim)
		end
	end
end
