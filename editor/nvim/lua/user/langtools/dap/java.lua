local dap = require("dap")

-- Java DAP configuration
-- Note: Most Java DAP features (like Launch) are typically handled by nvim-jdtls.
-- This file can be used for manual configurations like remote attaching.

dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}
