return { "mfussenegger/nvim-dap", 
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
  }, 
  config = function() 
    local dap = require("dap")
    local dapui = require("dapui")
    local dapvt = require("nvim-dap-virtual-text")

    require("user.langtools.dap.python")
    require("user.langtools.dap.cpp")
    require("user.langtools.dap.java")

    -- Automatically open/close DAP UI when starting dap
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dapui.setup({
      expand_lines = false, 
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.64 },      -- Variables in current scope
            { id = "watches", size = 0.12 },     -- Watch expressions
            { id = "breakpoints", size = 0.12 }, -- List of breakpoints
            { id = "stacks", size = 0.12 },      -- Call stack
          },
          size = 0.25,  -- Width of the sidebar
          position = "left",
        },
        {
          elements = {
            { id = "console", size = 0.5 },      -- Program output
            { id = "repl", size = 0.5 },     -- REPL
          },
          size = 0.35,  -- Height of bottom panel
          position = "right",
        },
      },
    })

    dapvt.setup({
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

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
    vim.keymap.set("n", "<leader>dc", dap.continue, opts)
    vim.keymap.set("n", "<leader>do", dap.step_over, opts)
    vim.keymap.set("n", "<S-o>", dap.step_over, opts)
    vim.keymap.set("n", "<leader>di", dap.step_into, opts)
    vim.keymap.set("n", "<leader>dO", dap.step_out, opts)
    vim.keymap.set("n", "<leader>dq", dap.terminate, opts)
    vim.keymap.set("n", "<leader>du", dapui.toggle, opts)
    vim.keymap.set("n", "<leader>dU", dap.up, opts)
    vim.keymap.set("n", "<leader>dD", dap.down, opts)
    vim.keymap.set("n", "<leader>dk", function() dapui.eval(nil, { enter = true }) end, opts)
    vim.keymap.set("n", "<leader>de", function() dapui.elements.watches.add(vim.fn.expand('<cword>')) end, { silent = true, desc = "DAP: Add to Watch" })
    vim.keymap.set("n", "<leader>dr", function()
      local index = vim.fn.input('Watch index to remove: ')
      if index ~= '' then
        dapui.elements.watches.remove(tonumber(index))
      end
    end, { silent = true, desc = "DAP: Remove from Watch" })
  end
}
