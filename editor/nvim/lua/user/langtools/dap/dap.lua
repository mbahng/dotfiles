return { "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-jdtls",
    "jbyuki/one-small-step-for-vimkind",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dapvt = require("nvim-dap-virtual-text")

    require("user.langtools.dap.python")
    require("user.langtools.dap.cpp")
    require("user.langtools.dap.java")
    require("user.langtools.dap.lua")

    -- Automatically open/close DAP UI when starting dap
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    dapui.setup({
      icons = {
        expanded = "▾",
        collapsed = "▸",
        current_frame = "▸",
      },

      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },

      element_mappings = {},

      expand_lines = false,

      force_buffers = true,

      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.8 },
            { id = "stacks", size = 0.2 },
            -- { id = "watches", size = 0.2 },
            -- { id = "breakpoints", size = 0.12 },
          },
          size = 0.25,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.8 },
            { id = "console", size = 0.2 },
          },
          size = 0.35,
          position = "right",
        },
      },

      floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },

      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "󰆹",
          step_over = "󰆷",
          step_out = "󰆸",
          step_back = "",
          run_last = "↻",
          terminate = "□",
          disconnect = "⏏",
        },
      },

      render = {
        max_type_length = nil,
        max_value_lines = 100,
        indent = 1,
      },

      wrap = false,
    })

    dapvt.setup({
      commented = false,
      virt_lines = true,
      display_callback = function(variable, _, _, _, _)
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
    vim.keymap.set("n", "<leader>dk", function()
      dapui.eval(nil, {
        enter = true,
        context = "hover",
        width = 80,
        height = 20,
      })
    end, opts)
    vim.keymap.set("n", "<leader>de", function() dapui.elements.watches.add(vim.fn.expand('<cword>')) end, { silent = true, desc = "DAP: Add to Watch" })
    vim.keymap.set("n", "<leader>dr", function()
      local index = vim.fn.input('Watch index to remove: ')
      if index ~= '' then
        dapui.elements.watches.remove(tonumber(index))
      end
    end, { silent = true, desc = "DAP: Remove from Watch" })

    -- OSV server (debuggee-side). Use with the "Attach to Neovim (OSV)" config.
    vim.keymap.set("n", "<leader>dl", function()
      local ok, osv = pcall(require, "osv")
      if ok and osv and osv.launch then
        osv.launch({ port = 8086 })
      else
        vim.notify("osv not available (one-small-step-for-vimkind)", vim.log.levels.WARN)
      end
    end, { silent = true, desc = "OSV: Launch server (8086)" })

    vim.keymap.set("n", "<leader>dL", function()
      local ok, osv = pcall(require, "osv")
      if ok and osv and osv.stop then
        osv.stop()
      end
    end, { silent = true, desc = "OSV: Stop server" })
  end
}
