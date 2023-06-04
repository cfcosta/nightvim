local NV = {
	root = vim.fn.stdpath("config") .. "/night",
	plugins_root = vim.fn.stdpath("config") .. "/night/plugins",
	afterHooks = {},
	plugins = {},
}

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.opt.packpath:prepend(NV.plugins_root)

local function _nv_setup_plugin(name, depends, config)
	NV.plugins[name] = { depends = depends, config = config, loaded = false }
end

local function after(name, func)
	NV.afterHooks[name] = func
end

local function _nv_finish()
	local function load_plugin(name)
		local plugin = NV.plugins[name]

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
