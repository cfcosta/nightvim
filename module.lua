local NightVim = {}

NightVim.root = vim.fn.stdpath("config") .. "/night"
NightVim.plugins_root = vim.fn.stdpath("config") .. "/night/plugins"

NightVim.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.opt.packpath:prepend(NightVim.plugins_root)

NightVim.afterHooks = {}
NightVim.plugins = {}

NightVim.setup_plugin = function(name, depends, config)
	NightVim.plugins[name] = { depends = depends, config = config, loaded = false }
end

NightVim.after = function(name, func)
	NightVim.afterHooks[name] = func
end

NightVim.finish = function()
	local function load_plugin(name)
		local plugin = NightVim.plugins[name]

		if not plugin then
			error("Plugin " .. name .. " not found, internal bug?")
		end

		if not plugin.loaded then
			for _, dep_name in ipairs(plugin.depends) do
				local dep = NightVim.plugins[dep_name]

				if not dep then
					error("Dependency " .. dep_name .. " not found")
				end

				load_plugin(dep_name)
			end

			plugin.config()

			local hook = NightVim.afterHooks[name]

			if hook then
				hook()
			end

			plugin.loaded = true
		end
	end

	-- Load all the plugins in the correct order
	for k, _ in pairs(NightVim.plugins) do
		load_plugin(k)
	end
end
