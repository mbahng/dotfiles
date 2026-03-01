require('lspconfig.ui.windows').default_options.border = 'none'
vim.lsp.set_log_level("OFF") 

local servers = {
  "clangd", 
  "gopls",
	"cssls",
	"ts_ls",
	"pyright", 
  "jdtls"
}

require("mason").setup(
  {
    ui = {
      border = "none",
      icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍",
      },
    },
    log_level = vim.log.levels.WARN,
    max_concurrent_installers = 4,
  }
)


local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

-- type checking in javascript 
lspconfig.ts_ls.setup{
  settings = {
    implicitProjectConfiguration = { 
      checkJs = true
    },
  }
}

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

