local dap = require("dap")

-- Adapter provided by OSV (one-small-step-for-vimkind)                                                                                                                
dap.adapters.nlua = function(callback, config)
  callback({
    type = "server",
    host = config.host or "127.0.0.1",
    port = config.port or 8086,
  })
end

dap.configurations.lua = {
  {
    name = "Attach to Neovim (OSV)",
    type = "nlua",
    request = "attach",
    host = "127.0.0.1",
    port = 8086,
  },
}
