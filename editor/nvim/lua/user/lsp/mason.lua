-- Pre-define servers to avoid repeated table creation
local servers = { "pyright" }

-- Create capabilities once, outside of the loop
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Cache the handlers
local handlers = require("user.lsp.handlers")
local on_attach = handlers.on_attach
local base_capabilities = handlers.capabilities

-- Single setup for mason with optimized settings
require("mason").setup({
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.WARN, -- Reduce logging
    max_concurrent_installers = 4,
})

-- Mason-lspconfig setup
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

-- Get lspconfig once
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

-- Add this configuration for pyright
lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                exclude = {
                    "**/node_modules",
                    "**/__pycache__",
                    "**/venv",
                    "**/env",
                    "**/build",
                    "**/dist",
                    "**/migrations",
                    "**/data",  -- large data directories
                    "**/test", -- test directories if they're large
                    "**/backbones", 
                    "**/logs", 
                    "**/pre_existing_datasets", 
                }
            }
        }
    }
})

-- TypeScript setup
lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        implicitProjectConfiguration = { 
            checkJs = true
        },
    }
})

-- Setup for other servers
for _, server in pairs(servers) do
    local server_name = vim.split(server, "@")[1]
    local opts = {
        on_attach = on_attach,
        capabilities = vim.tbl_deep_extend("force", base_capabilities, capabilities)
    }
    
    -- Try to load server-specific settings
    local ok, conf_opts = pcall(require, "user.lsp.settings." .. server_name)
    if ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end
    
    lspconfig[server_name].setup(opts)
end
