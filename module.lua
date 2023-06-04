local NV = {}

NV.root = vim.fn.stdpath("config") .. "/night"
NV.plugins_root = vim.fn.stdpath("config") .. "/night/plugins"

NV.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.opt.packpath:prepend(NV.plugins_root)

NV.afterHooks = {}
NV.plugins = {}

NV.setup_plugin = function(name, depends, config)
	NV.plugins[name] = { depends = depends, config = config, loaded = false }
end

NV.after = function(name, func)
	NV.afterHooks[name] = func
end

NV.finish = function()
	local function load_plugin(name)
		local plugin = NV.plugins[name]

		if not plugin then
			error("Plugin " .. name .. " not found, internal bug?")
		end

		if not plugin.loaded then
			for _, dep_name in ipairs(plugin.depends) do
				local dep = NV.plugins[dep_name]

				if not dep then
					error("Dependency " .. dep_name .. " not found")
				end

				load_plugin(dep_name)
			end

			plugin.config()

			local hook = NV.afterHooks[name]

			if hook then
				hook()
			end

			plugin.loaded = true
		end
	end

	-- Load all the plugins in the correct order
	for k, _ in pairs(NV.plugins) do
		load_plugin(k)
	end
end
