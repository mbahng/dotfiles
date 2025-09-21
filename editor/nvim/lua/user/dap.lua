local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

require("dapui").setup({
  expand_lines = false, 
  layouts = {
    {
      elements = {
        -- You can remove any of these you don't want
        { id = "scopes", size = 0.75 },      -- Variables in current scope
        -- { id = "breakpoints", size = 0.25 }, -- List of breakpoints
        { id = "stacks", size = 0.25 },      -- Call stack
        -- { id = "watches", size = 0.25 },     -- Watch expressions
      },
      size = 80,  -- Width of the sidebar
      position = "left",
    },
    {
      elements = {
        { id = "console", size = 1.0 },      -- Program output
      },
      size = 10,  -- Height of bottom panel
      position = "bottom",
    },
  },
})
require("nvim-dap-virtual-text").setup({
  commented = false,
  -- virt_text_pos = 'eol',  -- Position: 'eol' | 'overlay' | 'right_align'
  virt_lines = true,    
  display_callback = function(variable, buf, stackframe, node, options)
    if #variable.value > 50 then
      local first_part = string.sub(variable.value, 1, 30)
      local last_part = string.sub(variable.value, -20)
      return ' ' .. first_part .. '...' .. last_part
    end
    return ' ' .. variable.value
  end,
})

dap_python.setup("python3")

vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "", -- or "❌"
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "", -- or "→"
  texthl = "DiagnosticSignWarn",
  linehl = "Visual",
  numhl = "DiagnosticSignWarn",
})

-- Automatically open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

local opts = { noremap = true, silent = true }

-- Toggle breakpoint
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, opts)

-- Continue / Start
vim.keymap.set("n", "<leader>dc", function()
  dap.continue()
end, opts)

-- Step Over
vim.keymap.set("n", "<leader>do", function()
  dap.step_over()
end, opts) 
vim.keymap.set("n", "<S-o>", function()
  dap.step_over()
end, opts) 

-- expand variable
vim.keymap.set("n", "<leader>dk", function()
  dapui.eval(nil, { enter = true })
end, opts)

-- Step Into
vim.keymap.set("n", "<leader>di", function()
  dap.step_into()
end, opts)

-- Step Out
vim.keymap.set("n", "<leader>dO", function()
  dap.step_out()
end, opts)

-- Keymap to terminate debugging
vim.keymap.set("n", "<leader>dq", function()
  require("dap").terminate()
end, opts)

-- Toggle DAP UI
vim.keymap.set("n", "<leader>du", function()
  dapui.toggle()
end, opts)

-- Toggle specific element
vim.keymap.set("n", "<leader>dS", function()
  require("dapui").toggle({ element = "scopes" })
end, opts)

vim.keymap.set("n", "<leader>dR", function()
  require("dapui").toggle({ element = "repl" })
end, opts)

vim.keymap.set("n", "<leader>dW", function()
  require("dapui").toggle({ element = "watches" })
end, opts)
